//
//  AppTools.m
//  AppTools
//
//  Created by kingsic on 2021/9/7.
//

#import "AppTools.h"

@implementation AppTools

/// 拨打电话号码
+ (void)callPhoneNumber:(NSString *)phoneNumber {
    NSURL *tempUrl = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",phoneNumber]];
    [[UIApplication sharedApplication] openURL:tempUrl options:@{} completionHandler:nil];
}

@end
