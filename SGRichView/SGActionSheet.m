//
//  SGActionSheet.m
//  SGRichViewExample
//
//  Created by kingsic on 2019/6/27.
//  Copyright © 2019年 kingsic. All rights reserved.
//

#import "SGActionSheet.h"

@implementation SGActionSheetConfigure
/** 类方法 */
+ (instancetype)configure {
    return [[self alloc] init];
}
- (instancetype)init {
    if (self = [super init]) {
        self.cover = YES;
    }
    return self;
}

- (UIFont *)titleFont {
    if (!_titleFont) {
        _titleFont = [UIFont systemFontOfSize:15];
    }
    return _titleFont;
}
- (UIColor *)titleColor {
    if (!_titleColor) {
        _titleColor = [UIColor colorWithWhite:0.2 alpha:1.0];
    }
    return _titleColor;
}

- (UIFont *)otherFont {
    if (!_otherFont) {
        _otherFont = [UIFont systemFontOfSize:17];
    }
    return _otherFont;
}
- (UIColor *)otherColor {
    if (!_otherColor) {
        _otherColor = [UIColor blackColor];
    }
    return _otherColor;
}

- (UIFont *)cancelFont {
    if (!_cancelFont) {
        _cancelFont = [UIFont systemFontOfSize:17];
    }
    return _cancelFont;
}
- (UIColor *)cancelColor {
    if (!_cancelColor) {
        _cancelColor = [UIColor blackColor];
    }
    return _cancelColor;
}

- (CGFloat)cellHeight {
    if (_cellHeight < 44) {
        _cellHeight = 44;
    }
    return _cellHeight;
}
@end

@interface SGActionSheet ()
@property (nonatomic, strong) SGActionSheetConfigure *configure;
@property (nonatomic, strong) UIButton *coverBtn;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *topContentView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, strong) NSArray *title_array;
@property (nonatomic, strong) UIButton *bottomContentButton;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, copy) NSString *cancelStr;
@property (nonatomic, strong) NSMutableArray *btn_mArray;
@end

@implementation SGActionSheet

static CGFloat const animationDuration = 0.25;
static CGFloat const titleMargin_X = 20;
static CGFloat const titleMargin_Y = 20;
static CGFloat const topBottomMargin = 7;

- (instancetype)initWithTitle:(NSString *)title cancelTitle:(NSString *)cancelTitle otherTitles:(NSArray *)otherTitles configure:(nonnull SGActionSheetConfigure *)configure {
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        [[[UIApplication sharedApplication] keyWindow] addSubview:self];
        self.titleStr = title;
        self.cancelStr = cancelTitle;
        self.title_array = otherTitles;
        self.configure = configure;
        [self addSubviews];
    }
    return self;
}
+ (instancetype)actionSheetWithTitle:(NSString *)title cancelTitle:(NSString *)cancelTitle otherTitles:(NSArray *)otherTitles configure:(nonnull SGActionSheetConfigure *)configure{
    return [[self alloc] initWithTitle:title cancelTitle:cancelTitle otherTitles:otherTitles configure:configure];
}

- (void)addSubviews {
    [self addSubview:self.coverBtn];
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.topContentView];
    [self.contentView addSubview:self.bottomContentButton];
    if (self.titleStr != nil && ![self.titleStr isEqualToString:@""]) {
        [self.topContentView addSubview:self.titleLabel];
    }
    [self addOtherTitle];
    
}

- (UIButton *)coverBtn {
    if (!_coverBtn) {
        _coverBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _coverBtn.frame = self.frame;
        if (self.configure.cover == YES) {
            _coverBtn.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
        } else {
            _coverBtn.backgroundColor = [UIColor clearColor];
        }
        [_coverBtn addTarget:self action:@selector(dismiss) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _coverBtn;
}
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    }
    return _contentView;
}
- (UIView *)topContentView {
    if (!_topContentView) {
        _topContentView = [[UIView alloc] init];
        _topContentView.backgroundColor = [UIColor whiteColor];
    }
    return _topContentView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = self.titleStr;
        _titleLabel.textColor = self.configure.titleColor;
        _titleLabel.font = self.configure.titleFont;
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        CGFloat width = self.frame.size.width - 2 * titleMargin_X;
        CGFloat height = [self P_sizeWithString:self.titleStr font:self.configure.titleFont maxSize:CGSizeMake(width, MAXFLOAT)].height;
        _titleLabel.frame = CGRectMake(titleMargin_X, titleMargin_Y, width, height);
    }
    return _titleLabel;
}

- (NSMutableArray *)btn_mArray {
    if (!_btn_mArray) {
        _btn_mArray = [NSMutableArray array];
    }
    return _btn_mArray;
}

- (void)addOtherTitle {
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = self.frame.size.width;
    CGFloat btnH = self.configure.cellHeight;
    if (_titleLabel == nil) {
        btnY = 0;
    } else {
        btnY = CGRectGetMaxY(self.titleLabel.frame) + titleMargin_Y;
    }
    for (NSInteger i = 0; i < self.title_array.count; i++) {
        UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        btnY += btnH;
        [btn setTitle:self.title_array[i] forState:(UIControlStateNormal)];
        btn.titleLabel.font = self.configure.otherFont;
        [btn setTitleColor:self.configure.otherColor forState:(UIControlStateNormal)];
        [btn addTarget:self action:@selector(btn_action:) forControlEvents:(UIControlEventTouchUpInside)];
        btn.tag = i;
        [btn setBackgroundImage:[self imageWithColor:[UIColor colorWithWhite:0.9 alpha:1.0]] forState:(UIControlStateHighlighted)];
        [_topContentView addSubview:btn];
        [self.btn_mArray addObject:btn];
        
        if (_titleLabel == nil) {
            if (i != 0) {
                UIView *separator = [[UIView alloc] init];
                separator.frame = CGRectMake(0, 0, self.frame.size.width, 0.5);
                separator.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
                [btn addSubview:separator];
            }
        } else {
            UIView *separator = [[UIView alloc] init];
            separator.frame = CGRectMake(0, 0, self.frame.size.width, 0.5);
            separator.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
            [btn addSubview:separator];
        }
    }
    
    CGFloat statusHeight = CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
    CGFloat bottomContentButtonHeight = 0;
    CGFloat cancelButtonHeight = 0;
    if (statusHeight == 20.0) {
        bottomContentButtonHeight = self.configure.cellHeight;
        cancelButtonHeight = bottomContentButtonHeight;
    } else {
        bottomContentButtonHeight = 78;
        cancelButtonHeight = 64;
    }
    
    CGFloat width = self.frame.size.width;
    CGFloat contentViewY = self.frame.size.height;

    // topContentView
    UIButton *lastBtn = self.btn_mArray.lastObject;
    CGFloat topContentViewHeight = CGRectGetMaxY(lastBtn.frame);
    _topContentView.frame = CGRectMake(0, 0, width, topContentViewHeight);

    // bottomContentButton
    CGFloat bottomContentButtonY = topContentViewHeight + topBottomMargin;
    _bottomContentButton.frame = CGRectMake(0, bottomContentButtonY, width, bottomContentButtonHeight);
    [_bottomContentButton addSubview:self.cancelButton];
    _cancelButton.frame = CGRectMake(0, 0, width, cancelButtonHeight);
    
    // contentView
    CGFloat contentViewHeight = topContentViewHeight + bottomContentButtonHeight + topBottomMargin;
    _contentView.frame = CGRectMake(0, contentViewY, width, contentViewHeight);
}

- (void)btn_action:(UIButton *)button {
    if (self.otherTitleClickBlock) {
        self.otherTitleClickBlock(button.tag);
    }
    [self dismiss];
}

- (void)resetOtherTitleColor:(UIColor *)color forIndex:(NSInteger)index {
    UIButton *btn = self.btn_mArray[index];
    [btn setTitleColor:color forState:(UIControlStateNormal)];
}
- (void)addOtherTitleWithImage:(NSString *)imageName spacing:(CGFloat)spacing forIndex:(NSInteger)index {
    UIButton *btn = self.btn_mArray[index];
    [btn setImage:[UIImage imageNamed:imageName] forState:(UIControlStateNormal)];
    if (spacing < 0) {
        return;
    }
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, - 0.5 * spacing, 0, 0.5 * spacing);
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0.5 * spacing, 0, - 0.5 * spacing);
}

- (UIButton *)bottomContentButton {
    if (!_bottomContentButton) {
        _bottomContentButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _bottomContentButton.backgroundColor = [UIColor whiteColor];
        [_bottomContentButton setBackgroundImage:[self imageWithColor:[UIColor colorWithWhite:0.9 alpha:1.0]] forState:(UIControlStateHighlighted)];
        [_bottomContentButton addTarget:self action:@selector(bottomContentButton_action) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _bottomContentButton;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_cancelButton setTitle:self.cancelStr forState:(UIControlStateNormal)];
        _cancelButton.titleLabel.font = self.configure.cancelFont;
        [_cancelButton setTitleColor:self.configure.cancelColor forState:(UIControlStateNormal)];
        _cancelButton.userInteractionEnabled = NO;
    }
    return _cancelButton;
}

- (void)bottomContentButton_action {
    [self dismiss];
}

- (void)show {
    [UIView animateWithDuration:animationDuration animations:^{
        if (self.configure.cover) {
            self.coverBtn.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        }
        self.contentView.transform = CGAffineTransformMakeTranslation(0, - CGRectGetHeight(self.contentView.frame));
    }];
}
- (void)dismiss {
    [UIView animateWithDuration:animationDuration animations:^{
        if (self.configure.cover) {
            self.coverBtn.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
        }
        self.contentView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self.coverBtn removeFromSuperview];
        [self.contentView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

#pragma mark - - 颜色转换为背景图片
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0, 0.0, 1.0, 1.0);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - - - 计算字符串尺寸
- (CGSize)P_sizeWithString:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

@end
