//
//  SGHighlightWordsTool.m
//  FlowerObjc
//
//  Created by kingsic on 2021/11/3.
//

#import "SGHighlightWordsTool.h"

@implementation SGHighlightWordsTool
- (NSMutableAttributedString *)highlightWithString:(NSString *)string highlightWords:(NSString *)highlightWords highlightWordsColor:(UIColor *)highlightWordsColor {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSString *copyTotalString = string;
    NSMutableString *replaceString = [NSMutableString stringWithCapacity:0];
    for (int i = 0; i < highlightWords.length; i ++) {
        [replaceString appendString:@" "];
    }
    while ([copyTotalString rangeOfString:highlightWords].location != NSNotFound) {
        NSRange range = [copyTotalString rangeOfString:highlightWords];
        [attributedString addAttribute:NSForegroundColorAttributeName value:highlightWordsColor range:range];
        copyTotalString = [copyTotalString stringByReplacingCharactersInRange:range withString:replaceString];
    }
    return attributedString;
}

@end
