//
//  SGRichView.m
//  SGRichViewExample
//
//  Created by kingsic on 2019/1/10.
//  Copyright © 2019年 kingsic. All rights reserved.
//

#import "SGRichView.h"
#import "UIButton+SGRichView.h"

@interface SGRichButton : UIButton
@end
@implementation SGRichButton
- (void)setHighlighted:(BOOL)highlighted{}
@end

@interface SGRichView ()
@property (nonatomic, strong) SGRichViewConfigure *configure;
@property (nonatomic, strong) UIScrollView *contentScrollView;
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSArray *btnArr;
/// 存储标题按钮间分割线的数组
@property (nonatomic, strong) NSMutableArray *VSeparatorMArr;
/// tempBtn
@property (nonatomic, strong) UIButton *tempBtn;
/// 标记是否重置
@property (nonatomic, assign) BOOL signReset;
/// 上一个b按钮
@property (nonatomic, strong) UIButton *previousBtn;
/// 标记 SGRichViewTypeVertical 样式下标题行数
@property (nonatomic, assign) NSInteger titleRow;
/// 临时数组用于处理 SGRichViewTypeVertical 样式下标题的 frame
@property (nonatomic, strong) NSMutableArray *tempMArr;
@end

@implementation SGRichView
/** 对象方法 */
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles configure:(SGRichViewConfigure *)configure {
    if (self = [super initWithFrame:frame]) {
        self.titleArr = titles;
        self.configure = configure;
        
        [self initialization];
        [self setupSubviews];
    }
    return self;
}
/** 类方法 */
+ (instancetype)richViewWithFrame:(CGRect)frame titles:(NSArray *)titles configure:(SGRichViewConfigure *)configure {
    return [[self alloc] initWithFrame:frame titles:titles configure:configure];
}

- (void)initialization {
    self.backgroundColor = [UIColor whiteColor];
    if (self.configure.richViewType == SGRichViewTypeVertical) {
        self.titleRow = 1;
    }
}
- (void)setupSubviews {
    UIView *tempView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:tempView];
    [self addSubview:self.contentScrollView];
    [self addTitles];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self P_layoutSubviews];
}

#pragma mark - - - 布局子控制器的 frame
- (void)P_layoutSubviews {
    _contentScrollView.frame = self.bounds;
    
    if (self.configure.richViewType == SGRichViewTypeHorizontal) {
        [self P_richViewTypeHorizontalFrame];

    } else if (self.configure.richViewType == SGRichViewTypeVertical) {
        self.tempMArr = [NSMutableArray arrayWithArray:self.btnArr];
        [self P_richViewTypeVerticalFrame];
        
    } else if (self.configure.richViewType == SGRichViewTypeHorizontalEquable) {
        [self P_richViewTypeHorizontalEquableFrame];
    }
}
#pragma mark - - SGRichViewTypeHorizontal 样式下 frame 计算
- (void)P_richViewTypeHorizontalFrame {
    __block CGFloat btnX = self.configure.spacing;
    CGFloat btnY = 0;
    CGFloat btnH = _contentScrollView.frame.size.height;
    [self.btnArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
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
    UIButton *lastBtn = self.btnArr.lastObject;
    CGFloat lastBtnMaxX = CGRectGetMaxX(lastBtn.frame);
    CGFloat allWidth = lastBtnMaxX + self.configure.spacing;
    if (allWidth < _contentScrollView.frame.size.width) {
        _contentScrollView.contentSize = CGSizeMake(_contentScrollView.frame.size.width, btnH);
    } else {
        _contentScrollView.contentSize = CGSizeMake(allWidth, btnH);
    }
}
#pragma mark - - SGRichViewTypeVertical 样式下 frame 计算
- (void)P_richViewTypeVerticalFrame {
    [self P_layoutVerticalFrame];
    UIButton *lastBtn = self.btnArr.lastObject;
    CGFloat contentScrollViewH = CGRectGetMaxY(lastBtn.frame);
    CGRect contentScrollViewFrame = _contentScrollView.frame;
    contentScrollViewFrame.size.height = contentScrollViewH;
    _contentScrollView.frame = contentScrollViewFrame;
    CGRect selfFrame = self.frame;
    selfFrame.size.height = contentScrollViewH;
    self.frame = selfFrame;
}

- (void)P_layoutVerticalFrame {
    __block CGFloat btnX = self.configure.spacing;
    CGFloat btnY = (self.titleRow - 1) * (self.configure.verticalSpacing + self.configure.titleHeight);
    CGFloat btnH = self.configure.titleHeight;
    CGFloat contentScrollViewWidth = _contentScrollView.frame.size.width;

    [self.tempMArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = obj;
        CGSize tempSize = [self P_sizeWithString:btn.currentTitle font:self.configure.font];
        CGFloat btnW = tempSize.width + self.configure.additionalWidth;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        btnX = CGRectGetMaxX(btn.frame) + self.configure.horizontalSpacing;
        if ((btnX + self.configure.spacing) > contentScrollViewWidth) {
            *stop = YES;
            self.titleRow += 1;
            for (NSInteger index = 0; index < idx; index++) {
                [self.tempMArr removeObjectAtIndex:0];
            }
            [self P_layoutVerticalFrame];
        }
    }];
}

#pragma mark - - SGRichViewTypeHorizontalEquable 样式下 frame 计算
- (void)P_richViewTypeHorizontalEquableFrame {
    __block CGFloat btnX = self.configure.spacing;
    NSInteger titleCount = self.titleArr.count;
    
    CGFloat btnY = 0;
    CGFloat btnW = (self.contentScrollView.frame.size.width - self.configure.spacing - self.configure.spacing - (titleCount - 1) * self.configure.horizontalSpacing) / titleCount;
    CGFloat btnH = _contentScrollView.frame.size.height;
    [self.btnArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = obj;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        btnX = CGRectGetMaxX(btn.frame) + self.configure.horizontalSpacing;
        
        // 设置按钮圆角
        if (self.configure.cornerRadius > 0.5 * btnH) {
            btn.layer.cornerRadius = 0.5 * btnH;
        } else {
            btn.layer.cornerRadius = self.configure.cornerRadius;
        }
    }];
    UIButton *lastBtn = self.btnArr.lastObject;
    CGFloat lastBtnMaxX = CGRectGetMaxX(lastBtn.frame);
    CGFloat allWidth = lastBtnMaxX + self.configure.spacing;
    if (allWidth < _contentScrollView.frame.size.width) {
        self.contentScrollView.contentSize = CGSizeMake(_contentScrollView.frame.size.width, btnH);
    } else {
        self.contentScrollView.contentSize = CGSizeMake(allWidth, btnH);
    }
    
    // 2、布局标题间分割线的 frame
    if (self.configure.showVerticalSeparator) {
        CGFloat VSeparatorW = 0.5;
        CGFloat VSeparatorH = _contentScrollView.frame.size.height - self.configure.verticalSeparatorReduceHeight;
        if (VSeparatorH <= 0) {
            VSeparatorH = _contentScrollView.frame.size.height;
        }
        CGFloat VSeparatorY = 0.5 * (_contentScrollView.frame.size.height - VSeparatorH);
        [self.VSeparatorMArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGFloat VSeparatorX = btnW * (idx + 1) - 0.5 * VSeparatorW;
            UIView *VSeparator = obj;
            VSeparator.frame = CGRectMake(VSeparatorX, VSeparatorY, VSeparatorW, VSeparatorH);
        }];
    }
}

- (UIScrollView *)contentScrollView {
    if (!_contentScrollView) {
        _contentScrollView = [[UIScrollView alloc] init];
        _contentScrollView.showsVerticalScrollIndicator = NO;
        _contentScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _contentScrollView;
}

- (NSMutableArray *)VSeparatorMArr {
    if (!_VSeparatorMArr) {
        _VSeparatorMArr = [[NSMutableArray alloc] init];
    }
    return _VSeparatorMArr;
}

#pragma mark - - - 添加标题及标题间分割线
- (void)addTitles {
    NSMutableArray *tempBtnMArr = [NSMutableArray array];
    NSInteger titleCount = self.titleArr.count;
    for (NSInteger index = 0; index < titleCount; index++) {
        SGRichButton *btn = [[SGRichButton alloc] init];
        btn.tag = index;
        [btn setTitle:self.titleArr[index] forState:(UIControlStateNormal)];
        [btn setTitleColor:self.configure.titleColor forState:(UIControlStateNormal)];
        [btn setTitleColor:self.configure.clickTitleColor forState:(UIControlStateSelected)];
        if (self.configure.click) {
            [btn addTarget:self action:@selector(P_btn_action:) forControlEvents:(UIControlEventTouchUpInside)];
        }
        btn.backgroundColor = self.configure.backgroundColor;
        if (self.configure.borderWidth < 0 || self.configure.borderWidth > 2) {
            btn.layer.borderWidth = 2;
        } else {
            btn.layer.borderWidth = self.configure.borderWidth;
        }
        if (self.configure.richViewType == SGRichViewTypeVertical) {
            // 设置按钮圆角
            if (self.configure.cornerRadius > 0.5 * self.configure.titleHeight) {
                btn.layer.cornerRadius = 0.5 * self.configure.titleHeight;
            } else {
                btn.layer.cornerRadius = self.configure.cornerRadius;
            }
        }
        btn.layer.borderColor = self.configure.borderColor.CGColor;
        [tempBtnMArr addObject:btn];
        [self.contentScrollView addSubview:btn];
    }
    self.btnArr = [NSArray arrayWithArray:tempBtnMArr];
    
    // 添加按钮之间分割线
    if (self.configure.showVerticalSeparator) {
        for (NSInteger index = 0; index < titleCount - 1; index++) {
            UIView *VSeparator = [[UIView alloc] init];
            VSeparator.backgroundColor = self.configure.verticalSeparatorColor;
            [self.VSeparatorMArr addObject:VSeparator];
            [self.contentScrollView addSubview:VSeparator];
        }
    }
}

#pragma mark - - - 标题按钮的点击事件
- (void)P_btn_action:(UIButton *)btn {
    // 1、改变按钮的选择状态
    if (self.signReset == NO) {
        [self P_changeSelectedButton:btn];
    }
    // 2、标题点击回调方法
    if (self.clickedBlock) {
        self.clickedBlock(self, btn.tag);
    }
    
    if (self.contentScrollView.contentSize.width > self.frame.size.width) {
        [self P_clickBtnCenter:btn];
    }
}

#pragma mark - - - 标题滚动样式下选中标题居中处理
- (void)P_clickBtnCenter:(UIButton *)centerBtn {
    // 计算偏移量
    CGFloat offsetX = centerBtn.center.x - self.frame.size.width * 0.5;
    if (offsetX < 0) offsetX = 0;
    // 获取最大滚动范围
    CGFloat maxOffsetX = self.contentScrollView.contentSize.width - self.frame.size.width;
    if (offsetX > maxOffsetX) offsetX = maxOffsetX;
    // 滚动标题滚动条
    [self.contentScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

#pragma mark - - - 改变按钮的选择状态
- (void)P_changeSelectedButton:(UIButton *)button {
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
    [self.btnArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = obj;
        btn.backgroundColor = self.configure.backgroundColor;
    }];
    button.backgroundColor = self.configure.clickBackgroundColor;
}

- (void)setIndex:(NSInteger)index {
    _index = index;
    [self P_btn_action:self.btnArr[index]];
}

/** 根据标题下标设置选中标题边框宽度及边框颜色 */
- (void)clickTitleBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor forIndex:(NSInteger)index {
    if (self.previousBtn) {
        self.previousBtn.layer.borderWidth = 0;
    }
    // 点击按钮属性设置
    UIButton *clickBtn = self.btnArr[index];
    if (borderWidth < 0 || borderWidth > 2) {
        clickBtn.layer.borderWidth = 2;
    } else {
        clickBtn.layer.borderWidth = borderWidth;
    }
    clickBtn.layer.borderColor = borderColor.CGColor;
    // 存储上个点击的按钮
    self.previousBtn = clickBtn;
}

/** 根据标题下标重置标题文字颜色及背景颜色（仅用于标题固定样式）*/
- (void)resetTitleColor:(UIColor *)color backgroundColor:(UIColor *)backgroundColor forIndex:(NSInteger)index {
    self.signReset = YES;
    
    UIButton *btn = self.btnArr[index];
    btn.layer.borderColor = [UIColor clearColor].CGColor;
    [btn setTitleColor:color forState:(UIControlStateNormal)];
    btn.backgroundColor = backgroundColor;
}
/** 根据标题下标重置标题文字颜色及边框颜色（仅用于标题固定样式） */
- (void)resetTitleColor:(UIColor *)color borderColor:(UIColor *)borderColor forIndex:(NSInteger)index {
    self.signReset = YES;
    
    UIButton *btn = self.btnArr[index];
    [btn setTitleColor:color forState:(UIControlStateNormal)];
    btn.layer.borderColor = borderColor.CGColor;
}
/** 根据标题下标重置标题文字颜色、边框宽度及边框颜色（仅用于标题固定样式） */
- (void)resetTitleColor:(UIColor *)color borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor forIndex:(NSInteger)index {
    UIButton *btn = self.btnArr[index];
    if (borderWidth < 0 || borderWidth > 2) {
        btn.layer.borderWidth = 2;
    } else {
        btn.layer.borderWidth = borderWidth;
    }
    [self resetTitleColor:color borderColor:borderColor forIndex:index];
}
/**  根据标题下标设置标题图标（仅用于标题固定样式） */
- (void)setTitleImage:(NSString *)image clickImage:(NSString *)clickImage spacing:(CGFloat)spacing forIndex:(NSInteger)index {
    UIButton *btn = self.btnArr[index];
    [btn SG_imagePositionStyle:(SGImagePositionStyleLeft) spacing:spacing imagePositionBlock:^(UIButton * _Nonnull button) {
        [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:clickImage] forState:UIControlStateSelected];
    }];
}

#pragma mark - - - 计算字符串尺寸
- (CGSize)P_sizeWithString:(NSString *)string font:(UIFont *)font {
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [string boundingRectWithSize:CGSizeMake(0, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

@end
