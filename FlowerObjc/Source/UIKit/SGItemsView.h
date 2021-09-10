//
//  SGItemsView.h
//  SGItemsView
//
//  Created by kingsic on 2020/10/15.
//  Copyright © 2020 kingsic. All rights reserved.
//
//  这里需要说明一点的是：SGItemsView 内部的 titleLabel 的高占据 itemSize 高的 1/3，且距离底部边距为 0；而内部的 imageView 的高为 itemSize 高的（2/3 - 5），这里的 5 指的是 imageView 距离顶部的距离
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** 根据下标配置 UIImageView 的回调 Block */
typedef void(^SGItemsViewConfigureImgViewBlock)(UIImageView *imageView, NSInteger index);
/** 点击 item 的回调 Block */
typedef void(^SGItemsViewItemClickBlock)(NSInteger index);

@interface SGItemsView : UIView
/** Item 标题数组 */
@property (nonatomic, strong) NSArray *titles;
/** Item 标题字号大小，默认 [UIFont systemFontOfSize:12] */
@property (nonatomic, strong) UIFont *titleFont;
/** Item 标题颜色，默认为黑色 */
@property (nonatomic, strong) UIColor *titleColor;
/** 配置 imageView 回调函数，将 imageView 留给外部处理：如网络或本地 image 的加载图像 */
@property (nonatomic, copy) SGItemsViewConfigureImgViewBlock configureImgViewBlock;
/** Item 大小，设置高度时，请考虑 contentinset 属性的顶部和底部值 */
@property (nonatomic, assign) CGSize itemSize;
/** Item 的内边距 */
@property (nonatomic, assign) UIEdgeInsets contentInset;
/** 是否支持分页滚动，默认为 NO */
@property (nonatomic, assign) BOOL pagingEnabled;
/** 是否支持水平滚动，默认为 NO */
@property (nonatomic, assign) BOOL scrollDirectionHorizontal;
/** 是否显示水平滚动条，默认为 NO */
@property (nonatomic, assign) BOOL showsHorizontalScrollIndicator;
/** Item 点击回调 block */
@property (nonatomic, copy) SGItemsViewItemClickBlock itemClickBlock;
/** 根据对应的下标设置标题颜色 */
- (void)setItemTitleColor:(UIColor *)titleColor forIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
