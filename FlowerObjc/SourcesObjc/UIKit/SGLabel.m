//
//  SGLabel.m
//  SGLabel
//
//  Created by kingsic on 2020/12/19.
//  Copyright © 2020 kingsic. All rights reserved.
//

#import "SGLabel.h"

@implementation SGLabel

- (void)drawTextInRect:(CGRect)rect {
    CGRect tempRect = [self textRectForBounds:rect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:tempRect];
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    textRect.origin.y = bounds.origin.y;
    return textRect;
}

@end
