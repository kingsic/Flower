//
//  SGTagsView.m
//  SGRichViewExample
//
//  Created by kingsic on 2019/6/18.
//  Copyright © 2019年 kingsic. All rights reserved.
//

#import "SGTagsView.h"

@implementation SGTagsViewConfigure
/** 类方法 */
+ (instancetype)tagsViewConfigure {
    return [[self alloc] init];
}
- (instancetype)init {
    if (self = [super init]) {
        [self initialization];
    }
    return self;
}
- (void)initialization {
    _selected = YES;
}

- (UIFont *)font {
    if (!_font) {
        _font = [UIFont systemFontOfSize:15];
    }
    return _font;
}
- (UIColor *)color {
    if (!_color) {
        _color = [UIColor blackColor];
    }
    return _color;
}
- (UIColor *)selectedColor {
    if (!_selectedColor) {
        _selectedColor = [UIColor redColor];
    }
    return _selectedColor;
}
- (UIColor *)backgroundColor {
    if (!_backgroundColor) {
        _backgroundColor = [UIColor colorWithWhite:0.92 alpha:1.0];
    }
    return _backgroundColor;
}
- (UIColor *)selectedBackgroundColor {
    if (!_selectedBackgroundColor) {
        _selectedBackgroundColor = [UIColor whiteColor];
    }
    return _selectedBackgroundColor;
}
- (CGFloat)borderWidth {
    if (!_borderWidth) {
        _borderWidth = 0.0f;
    }
    return _borderWidth;
}
- (UIColor *)borderColor {
    if (!_borderColor) {
        _borderColor = [UIColor whiteColor];
    }
    return _borderColor;
}
- (UIColor *)selectedBorderColor {
    if (!_selectedBorderColor) {
        _selectedBorderColor = [UIColor redColor];
    }
    return _selectedBorderColor;
}
- (CGFloat)cornerRadius {
    if (!_cornerRadius) {
        _cornerRadius = 0.0;
    }
    return _cornerRadius;
}

- (CGFloat)horizontalSpacing {
    if (_horizontalSpacing <= 0) {
        _horizontalSpacing = 20.0f;
    }
    return _horizontalSpacing;
}
- (CGFloat)verticalSpacing {
    if (_verticalSpacing <= 0) {
        _verticalSpacing = 20.0f;
    }
    return _verticalSpacing;
}
- (CGFloat)additionalWidth {
    if (_additionalWidth <= 0) {
        _additionalWidth = 40.0f;
    }
    return _additionalWidth;
}
- (CGFloat)height {
    if (_height <= 0) {
        _height = 30;
    }
    return _height;
}
- (NSInteger)column {
    if (_column <= 0) {
        _column = 2;
    }
    return _column;
}

- (CGFloat)contentSpacingLR {
    if (_contentSpacingLR <= 0) {
        _contentSpacingLR = 10.0f;
    }
    return _contentSpacingLR;
}
- (CGFloat)contentSpacingTB {
    if (_contentSpacingTB <= 0) {
        _contentSpacingTB = 10.0f;
    }
    return _contentSpacingTB;
}
- (CGFloat)contentHorizontalAlignmentSpacing {
    if (_contentHorizontalAlignmentSpacing <= 0) {
        _contentHorizontalAlignmentSpacing = 5.0f;
    }
    return _contentHorizontalAlignmentSpacing;
}
@end

@interface SGTagsButton : UIButton
@end
@implementation SGTagsButton
- (void)setHighlighted:(BOOL)highlighted{}
@end

@interface SGTagsView ()
@property (nonatomic, strong) SGTagsViewConfigure *configure;
@property (nonatomic, strong) UIScrollView *contentScrollView;
@property (nonatomic, strong) NSArray *tag_array;
@property (nonatomic, assign) NSInteger tag_rown;
@property (nonatomic, strong) NSArray *btn_array;
/// 临时可变数组用于处理 SGTagsViewStyleVertical 样式下标签的 frame
@property (nonatomic, strong) NSMutableArray *tempMArr;
@property (nonatomic, strong) UIButton *tempBtn;
@property (nonatomic, strong) UIButton *previousBtn;
/// 记录多选标签选择文字数组
@property (nonatomic, strong) NSMutableArray *mArrayTag;
/// 记录多选标签选择下标数组
@property (nonatomic, strong) NSMutableArray *mArrayIndex;
@end

@implementation SGTagsView
/** 对象方法 */
- (instancetype)initWithFrame:(CGRect)frame configure:(SGTagsViewConfigure *)configure {
    if (self = [super initWithFrame:frame]) {
        self.configure = configure;
        [self initialization];
        [self setupSubviews];
    }
    return self;
}
/** 类方法 */
+ (instancetype)tagsViewWithFrame:(CGRect)frame configure:(SGTagsViewConfigure *)configure {
    return [[self alloc] initWithFrame:frame configure:configure];
}

- (void)initialization {
    self.backgroundColor = [UIColor whiteColor];
    if (self.configure.tagsViewStyle == SGTagsViewStyleVertical) {
        self.tag_rown = 1;
    }
}
- (void)setupSubviews {
    UIView *tempView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:tempView];
    [self addSubview:self.contentScrollView];
}

- (UIScrollView *)contentScrollView {
    if (!_contentScrollView) {
        _contentScrollView = [[UIScrollView alloc] init];
        _contentScrollView.showsVerticalScrollIndicator = NO;
        _contentScrollView.showsHorizontalScrollIndicator = NO;
        if (self.configure.bounces == NO) {
            _contentScrollView.bounces = NO;
        }
    }
    return _contentScrollView;
}
- (NSMutableArray *)mArrayTag {
    if (!_mArrayTag) {
        _mArrayTag = [NSMutableArray array];
    }
    return _mArrayTag;
}
- (NSMutableArray *)mArrayIndex {
    if (!_mArrayIndex) {
        _mArrayIndex = [NSMutableArray array];
    }
    return _mArrayIndex;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat contentScrollViewXX = self.configure.contentSpacingLR;
    CGFloat contentScrollViewXY = self.configure.contentSpacingTB;
    CGFloat contentScrollViewXW = self.frame.size.width - 2 * contentScrollViewXX;
    CGFloat contentScrollViewXH = self.frame.size.height - 2 * contentScrollViewXY;
    self.contentScrollView.frame = CGRectMake(contentScrollViewXX, contentScrollViewXY, contentScrollViewXW, contentScrollViewXH);
    
//    if (self.configure.tagsViewStyle == SGTagsViewStyleEquable) {
    if (self.configure.tagsViewStyle == SGTagsViewStyleVertical) {
        self.tempMArr = [NSMutableArray arrayWithArray:self.btn_array];
        [self P_layoutTagsViewTypeVertical];
    } else if (self.configure.tagsViewStyle == SGTagsViewStyleHorizontal) {
        [self P_layoutTagsViewStyleHorizontal];
    } else {
        [self P_layoutTagsViewTypeEquable];
    }
}
#pragma mark - - SGTagsViewStyleEquable 样式下 frame 计算
- (void)P_layoutTagsViewTypeEquable {
    __block CGFloat btnX = 0;
    __block CGFloat btnY = 0;
    CGFloat btnW = (CGRectGetWidth(self.contentScrollView.frame) - (self.configure.column - 1) * self.configure.horizontalSpacing) / self.configure.column;
    CGFloat btnH = self.configure.height;
    [self.btn_array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = obj;
        btnX = (idx % self.configure.column) * (btnW + self.configure.horizontalSpacing);
        btnY = (idx / self.configure.column) * (btnH + self.configure.verticalSpacing);
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }];
    UIButton *lastBtn = self.btn_array.lastObject;
    CGFloat contentScrollViewH = CGRectGetMaxY(lastBtn.frame);
    CGRect contentScrollViewFrame = self.contentScrollView.frame;
    contentScrollViewFrame.size.height = contentScrollViewH;
    self.contentScrollView.frame = contentScrollViewFrame;
    CGRect selfFrame = self.frame;
    selfFrame.size.height = contentScrollViewH + 2 * self.configure.contentSpacingTB;
    self.frame = selfFrame;
}
#pragma mark - - SGTagsViewStyleVertical 样式下 frame 计算
- (void)P_layoutTagsViewTypeVertical {
    [self P_layoutVerticalStyle];
    UIButton *lastBtn = self.btn_array.lastObject;
    CGFloat contentScrollViewH = CGRectGetMaxY(lastBtn.frame);
    CGRect contentScrollViewFrame = self.contentScrollView.frame;
    contentScrollViewFrame.size.height = contentScrollViewH;
    self.contentScrollView.frame = contentScrollViewFrame;
    CGRect selfFrame = self.frame;
    selfFrame.size.height = contentScrollViewH + 2 * self.configure.contentSpacingTB;
    self.frame = selfFrame;
}
- (void)P_layoutVerticalStyle {
    __block CGFloat btnX = 0;
    CGFloat btnY = (self.tag_rown - 1) * (self.configure.verticalSpacing + self.configure.height);
    CGFloat btnH = self.configure.height;
    CGFloat contentScrollViewWidth = self.contentScrollView.frame.size.width;
    [self.tempMArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = obj;
        CGSize tempSize = [self P_sizeWithString:btn.currentTitle font:self.configure.font];
        CGFloat btnW = tempSize.width + self.configure.additionalWidth;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        btnX = CGRectGetMaxX(btn.frame) + self.configure.horizontalSpacing;
        if (btnX > contentScrollViewWidth) {
            *stop = YES;
            self.tag_rown += 1;
            for (NSInteger index = 0; index < idx; index++) {
                [self.tempMArr removeObjectAtIndex:0];
            }
            [self P_layoutVerticalStyle];
        }
    }];
}
#pragma mark - - SGTagsViewStyleHorizontal 样式下 frame 计算
- (void)P_layoutTagsViewStyleHorizontal {
    __block CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnH = self.contentScrollView.frame.size.height;
    [self.btn_array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = obj;
        CGSize tempSize = [self P_sizeWithString:btn.currentTitle font:self.configure.font];
        CGFloat btnW = tempSize.width + self.configure.additionalWidth;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        btnX = CGRectGetMaxX(btn.frame) + self.configure.horizontalSpacing;
        // 设置按钮圆角
        if (self.configure.cornerRadius > 0.5 * btnH) {
            btn.layer.cornerRadius = 0.5 * btnH;
        } else {
            btn.layer.cornerRadius = self.configure.cornerRadius;
        }
    }];
    UIButton *lastBtn = self.btn_array.lastObject;
    CGFloat lastBtnMaxX = CGRectGetMaxX(lastBtn.frame);
    CGFloat allWidth = lastBtnMaxX;
    if (allWidth < _contentScrollView.frame.size.width) {
        _contentScrollView.contentSize = CGSizeMake(_contentScrollView.frame.size.width, btnH);
    } else {
        _contentScrollView.contentSize = CGSizeMake(allWidth, btnH);
    }
}

#pragma mark - - 标签数据源
- (void)setTags:(NSArray *)tags {
    _tags = tags;
    
    NSMutableArray *tempBtnMArr = [NSMutableArray array];
    NSInteger tagsCount = tags.count;
    for (NSInteger index = 0; index < tagsCount; index++) {
        SGTagsButton *btn = [[SGTagsButton alloc] init];
        btn.tag = index;
        [btn setTitle:tags[index] forState:(UIControlStateNormal)];
        [btn setTitleColor:self.configure.color forState:UIControlStateNormal];
        [btn setTitleColor:self.configure.selectedColor forState:(UIControlStateSelected)];
        btn.backgroundColor = self.configure.backgroundColor;
        if (self.configure.selected) {
            [btn addTarget:self action:@selector(P_btn_action:) forControlEvents:(UIControlEventTouchUpInside)];
        }
        if (self.configure.borderWidth < 0 || self.configure.borderWidth > 2) {
            btn.layer.borderWidth = 2;
        } else {
            btn.layer.borderWidth = self.configure.borderWidth;
        }
        if (self.configure.tagsViewStyle == SGTagsViewStyleVertical || self.configure.tagsViewStyle == SGTagsViewStyleEquable) {
            if (self.configure.cornerRadius > 0.5 * self.configure.height) {
                btn.layer.cornerRadius = 0.5 * self.configure.height;
            } else {
                btn.layer.cornerRadius = self.configure.cornerRadius;
            }
        }
        if (self.configure.contentHorizontalAlignment == SGControlContentHorizontalAlignmentLeft) {
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            btn.contentEdgeInsets = UIEdgeInsetsMake(0, self.configure.contentHorizontalAlignmentSpacing, 0, 0);
        } else if (self.configure.contentHorizontalAlignment == SGControlContentHorizontalAlignmentRight) {
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            btn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, self.configure.contentHorizontalAlignmentSpacing);
        }
        btn.layer.borderColor = self.configure.borderColor.CGColor;
        [tempBtnMArr addObject:btn];
        [self.contentScrollView addSubview:btn];
    }
    self.btn_array = [NSArray arrayWithArray:tempBtnMArr];
}
#pragma mark - - - 标题按钮的点击事件
- (void)P_btn_action:(UIButton *)button {
    if (self.configure.multipleSelected) {
        button.selected = !(button.selected);
        if (button.isSelected) {
            [self.mArrayTag addObject:button.titleLabel.text];
            [self.mArrayIndex addObject:@(button.tag)];
            button.backgroundColor = self.configure.selectedBackgroundColor;
            button.layer.borderColor = self.configure.selectedBorderColor.CGColor;
            [button setTitleColor:self.configure.selectedColor forState:(UIControlStateNormal)];
        } else {
            [self.mArrayTag removeObject:button.titleLabel.text];
            [self.mArrayIndex removeObject:@(button.tag)];
            button.backgroundColor = self.configure.backgroundColor;
            button.layer.borderColor = self.configure.borderColor.CGColor;
            [button setTitleColor:self.configure.color forState:(UIControlStateNormal)];
        }
        if (self.multipleSelectedBlock) {
            self.multipleSelectedBlock(self, self.mArrayTag, self.mArrayIndex);
        }
        if (self.contentScrollView.contentSize.width > self.contentScrollView.frame.size.width) {
            [self P_selectedBtnCenter:button];
        }
    } else {
        [self changeSelectedButton:button];
        if (self.selectedBlock) {
            self.selectedBlock(self, button.titleLabel.text, button.tag);
        }
        if (self.contentScrollView.contentSize.width > self.contentScrollView.frame.size.width) {
            [self P_selectedBtnCenter:button];
        }
    }
}
- (void)changeSelectedButton:(UIButton *)button {
    if (self.tempBtn == nil) {
        button.selected = YES;
        self.tempBtn = button;
    } else if (self.tempBtn != nil && self.tempBtn == button){
        button.selected = YES;
    } else if (self.tempBtn != button && self.tempBtn != nil){
        self.tempBtn.selected = NO;
        button.selected = YES;
        self.tempBtn = button;
    }
    if (self.previousBtn) {
        self.previousBtn.backgroundColor = self.configure.backgroundColor;
        self.previousBtn.layer.borderColor = self.configure.borderColor.CGColor;
        [self.previousBtn setTitleColor:self.configure.color forState:(UIControlStateNormal)];
    }
    button.backgroundColor = self.configure.selectedBackgroundColor;
    button.layer.borderColor = self.configure.selectedBorderColor.CGColor;
    [button setTitleColor:self.configure.selectedColor forState:(UIControlStateNormal)];
    self.previousBtn = button;
}
- (void)P_selectedBtnCenter:(UIButton *)button {
    // 计算偏移量
    CGFloat offsetX = button.center.x - self.contentScrollView.frame.size.width * 0.5;
    if (offsetX < 0) offsetX = 0;
    // 获取最大滚动范围
    CGFloat maxOffsetX = self.contentScrollView.contentSize.width - self.contentScrollView.frame.size.width;
    if (offsetX > maxOffsetX) offsetX = maxOffsetX;
    // 滚动标题滚动条
    [self.contentScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

#pragma mark - - - 计算字符串尺寸
- (CGSize)P_sizeWithString:(NSString *)string font:(UIFont *)font {
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [string boundingRectWithSize:CGSizeMake(0, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

@end
