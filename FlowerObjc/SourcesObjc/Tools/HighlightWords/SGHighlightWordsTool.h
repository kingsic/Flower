//
//  SGHighlightWordsTool.h
//  FlowerObjc
//
//  Created by kingsic on 2021/11/3.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SGHighlightWordsTool : NSObject
/**
 *  高亮词处理
 *
 *  @param string         字符串
 *  @param highlightWords         高亮词
 *  @param highlightWordsColor         高亮词颜色
 */
- (NSMutableAttributedString *)highlightWithString:(NSString *)string highlightWords:(NSString *)highlightWords highlightWordsColor:(UIColor *)highlightWordsColor;

@end

NS_ASSUME_NONNULL_END
