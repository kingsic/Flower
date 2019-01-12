//
//  SGRichViewConfigure.h
//  SGRichViewExample
//
//  Created by kingsic on 2019/1/10.
//  Copyright © 2019年 kingsic. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    /** 水平样式，默认 */
    SGRichViewTypeHorizontal,
    /** 垂直样式 */
    SGRichViewTypeVertical,
    /** 水平样式下均分布局 */
    SGRichViewTypeHorizontalEquable,
} SGRichViewType;

@interface SGRichViewConfigure : NSObject
/** 类方法 */
+ (instancetype)richViewConfigure;

/** SGRichView 样式 */
@property (nonatomic, assign) SGRichViewType richViewType;
/** SGRichView 标题是否能够点击，默认为 YES */
@property (nonatomic, assign) BOOL click;
/** 标题文字字号大小，默认 15 号字体 */
@property (nonatomic, strong) UIFont *font;
/** 普通状态下标题文字颜色，默认为黑色 */
@property (nonatomic, strong) UIColor *titleColor;
/** 点击状态下标题文字颜色，默认为黑色 */
@property (nonatomic, strong) UIColor *clickTitleColor;
/** 普通状态下标题背景颜色，默认为 clearColor */
@property (nonatomic, strong) UIColor *backgroundColor;
/** 点击状态下标题背景颜色，默认为 clearColor */
@property (nonatomic, strong) UIColor *clickBackgroundColor;
/** 标题圆角大小，默认为 0.0f */
@property (nonatomic, assign) CGFloat cornerRadius;
/** 标题边框宽度，默认为 0.0f */
@property (nonatomic, assign) CGFloat borderWidth;
/** 标题边框颜色，默认为 clearColor */
@property (nonatomic, strong) UIColor *borderColor;
/** SGRichViewTypeVertical 样式下标题的高度，默认为 44.0f */
@property (nonatomic, assign) CGFloat titleHeight;

#pragma mark - - 标题间间距属性
/** 标题距离父视图左右边的间距，默认为 20.0f */
@property (nonatomic, assign) CGFloat spacing;
/** 标题水平之间的间距，默认为 20.0f */
@property (nonatomic, assign) CGFloat horizontalSpacing;
/** 标题垂直之间的间距，默认为 20.0f */
@property (nonatomic, assign) CGFloat verticalSpacing;
/** 标题额外增加的宽度，默认为 40.0f */
@property (nonatomic, assign) CGFloat additionalWidth;

#pragma mark - - 标题间分割线属性(仅在 SGRichViewTypeHorizontalEquable 样式下支持)
/** 是否显示标题间分割线，默认为 NO */
@property (nonatomic, assign) BOOL showVerticalSeparator;
/** 标题间分割线颜色，默认为红色 */
@property (nonatomic, strong) UIColor *verticalSeparatorColor;
/** 标题间分割线额外减少的高度，默认为 0.0f */
@property (nonatomic, assign) CGFloat verticalSeparatorReduceHeight;

@end

NS_ASSUME_NONNULL_END
