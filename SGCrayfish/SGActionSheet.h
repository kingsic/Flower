//
//  SGActionSheet.h
//  SGCrayfishExample
//
//  Created by kingsic on 2019/6/27.
//  Copyright © 2019年 kingsic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGActionSheetConfigure : NSObject
/** 类方法 */
+ (instancetype)configure;
/** 标题文字字号大小，默认 15 号字体 */
@property (nonatomic, strong) UIFont *titleFont;
/** 标题文字颜色，默认为浅灰色 */
@property (nonatomic, strong) UIColor *titleColor;
/** 其他文字字号大小，默认 17 号字体 */
@property (nonatomic, strong) UIFont *otherFont;
/** 其他文字颜色，默认为黑色 */
@property (nonatomic, strong) UIColor *otherColor;
/** 取消文字字号大小，默认 17 号字体 */
@property (nonatomic, strong) UIFont *cancelFont;
/** 取消文字颜色，默认为黑色 */
@property (nonatomic, strong) UIColor *cancelColor;
/** cell height, default 44.0f */
@property (nonatomic, assign) CGFloat cellHeight;
/** 是否需要遮盖背景色，默认为 YES */
@property (nonatomic, assign) BOOL cover;
@end


typedef void(^SGActionSheetOhterTitleClickBlock)(NSInteger index);

@interface SGActionSheet : UIView
/** 不带标题、内有取消按钮的对象创建方法 */
- (instancetype)initWithOtherTitles:(NSArray *)otherTitles configure:(SGActionSheetConfigure *)configure;
/** 不带标题、内有取消按钮的类方法 */
+ (instancetype)actionSheetWithOtherTitles:(NSArray *)otherTitles configure:(SGActionSheetConfigure *)configure;
/** 带标题、内有取消按钮的对象方法 */
- (instancetype)initWithTitle:(NSString *)title otherTitles:(NSArray *)otherTitles configure:(SGActionSheetConfigure *)configure;
/** 带标题、内有取消按钮的类方法 */
+ (instancetype)actionSheetWithTitle:(NSString *)title otherTitles:(NSArray *)otherTitles configure:(SGActionSheetConfigure *)configure;
/** 对象方法 */
- (instancetype)initWithTitle:(NSString *)title cancelTitle:(NSString *)cancelTitle otherTitles:(NSArray *)otherTitles configure:(SGActionSheetConfigure *)configure;
/** 类方法 */
+ (instancetype)actionSheetWithTitle:(NSString *)title cancelTitle:(NSString *)cancelTitle otherTitles:(NSArray *)otherTitles configure:(SGActionSheetConfigure *)configure;
/** 调出 SGActionSheet */
- (void)show;

/** 其他按钮点击回调函数 */
@property (nonatomic, copy) SGActionSheetOhterTitleClickBlock otherTitleClickBlock;

/** 根据下标重置其他标题颜色 */
- (void)resetOtherTitleColor:(UIColor *)color forIndex:(NSInteger)index;
/** 根据下标为其他标题添加图片 */
- (void)addOtherTitleWithImageName:(NSString *)imageName spacing:(CGFloat)spacing forIndex:(NSInteger)index;

@end
