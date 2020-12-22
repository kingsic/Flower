//
//  SGGuidePageView.h
//  SGFastfishExample
//
//  Created by kingsic on 2017/8/7.
//  Copyright © 2017 kingsic. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    /// 不存在，默认
    SGPageControlTypeNone,
    /// 一直存在
    SGPageControlTypeAlways,
    /// 存在，但最后一个页面会消失
    SGPageControlTypeDisappear,
} SGPageControlType;

@interface SGGuidePageView : UIView
/** 引导页数据 */
@property (nonatomic, strong) NSArray *images;
/** SGPageControl 类型 */
@property (nonatomic, assign) SGPageControlType pageControlType;
/** PageControl 相对父视图的偏移量，默认为 0.87 */
@property (nonatomic, assign) CGFloat pageControlOffsetY;
/** SGPageControlTypeNone 类型外，pageControl 默认时颜色 */
@property (nonatomic, strong) UIColor *pageIndicatorTintColor;
/** SGPageControlTypeNone 类型外，pageControl 选中时颜色 */
@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor;
/** 进入按钮 */
@property (nonatomic, strong) UIButton *enterBtn;
/** SGGuidePageView 消失时间，默认为 0.25s */
@property (nonatomic, assign) CGFloat durationTime;
/** 最后一页往左滑时是否消失，默认为 NO */
@property (nonatomic, assign) BOOL lastPageDisapper;

@end
