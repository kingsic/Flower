//
//  SGRichView.h
//  GitHub：https://github.com/kingsic/SGRichView
//
//  Created by kingsic on 2019/1/10.
//  Copyright © 2019年 kingsic. All rights reserved.
//

#import "SGRichViewConfigure.h"
@class SGRichView;

NS_ASSUME_NONNULL_BEGIN
typedef void(^SGRichViewClickedBlock)(SGRichView *richView, NSInteger index);

@interface SGRichView : UIView
/** 对象方法 */
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles configure:(SGRichViewConfigure *)configure;
/** 类方法 */
+ (instancetype)richViewWithFrame:(CGRect)frame titles:(NSArray *)titles configure:(SGRichViewConfigure *)configure;

/** 默认点击标题下标 */
@property (nonatomic, assign) NSInteger index;
/** 点击标题回调方法 */
@property (nonatomic, copy) SGRichViewClickedBlock clickedBlock;

/** 根据标题下标设置选中标题边框宽度及边框颜色 */
- (void)clickTitleBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor forIndex:(NSInteger)index;

/** 根据标题下标重置标题文字颜色及背景颜色（仅用于标题固定样式）*/
- (void)resetTitleColor:(UIColor *)color backgroundColor:(UIColor *)backgroundColor forIndex:(NSInteger)index;
/** 根据标题下标重置标题文字颜色及边框颜色（仅用于标题固定样式）*/
- (void)resetTitleColor:(UIColor *)color borderColor:(UIColor *)borderColor forIndex:(NSInteger)index;
/** 根据标题下标重置标题文字颜色、边框宽度及边框颜色（仅用于标题固定样式）*/
- (void)resetTitleColor:(UIColor *)color borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor forIndex:(NSInteger)index;
/**  根据标题下标设置标题图标（仅用于标题固定样式）*/
- (void)setTitleImage:(NSString *)image clickImage:(NSString *)clickImage spacing:(CGFloat)spacing forIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
