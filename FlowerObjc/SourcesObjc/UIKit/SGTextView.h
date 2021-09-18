//
//  SGTextView.h
//  SGTextView
//
//  Created by kingsic on 2020/12/11.
//  Copyright © 2020 kingsic. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SGTextView : UITextView
/** 占位文字 */
@property (nonatomic, copy) NSString *placeholder;
/** 占位文字颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;
/** 限制输入字数 */
@property (nonatomic, assign) NSInteger limitNumber;

@end

NS_ASSUME_NONNULL_END
