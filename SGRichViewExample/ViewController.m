//
//  ViewController.m
//  SGRichViewExample
//
//  Created by kingsic on 2019/1/12.
//  Copyright © 2019年 kingsic. All rights reserved.
//

#import "ViewController.h"
#import "SGRichView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self richView];
    [self richView2];
    [self richView3];
    [self richView4];
    [self richView5];
}

- (void)richView {
    SGRichViewConfigure *configure = [SGRichViewConfigure richViewConfigure];
    configure.richViewType = SGRichViewTypeVertical;
    configure.backgroundColor = [UIColor colorWithWhite:0.92 alpha:1.0];
    configure.cornerRadius = 5;
    configure.titleHeight = 30;
    configure.clickTitleColor = [UIColor redColor];
    
    SGRichView *richView = [SGRichView richViewWithFrame:CGRectMake(0, 122, self.view.frame.size.width, 20) titles:@[@"iPhone XS", @"iPhone XS Max", @"iPhone X", @"iPhone XR", @"iPhone 8", @"iPhone 8P"] configure:configure];
    [self.view addSubview:richView];
    richView.clickedBlock = ^(SGRichView * _Nonnull richView, NSInteger index) {
        [richView clickTitleBorderWidth:1 borderColor:[UIColor redColor] forIndex:index];
    };
}

- (void)richView2 {
    SGRichViewConfigure *configure = [SGRichViewConfigure richViewConfigure];
    configure.richViewType = SGRichViewTypeHorizontalEquable;
    configure.borderWidth = 1;
    configure.borderColor = [UIColor grayColor];
    configure.cornerRadius = 22;
    configure.spacing = 35;
    configure.horizontalSpacing = 30;
    
    SGRichView *richView = [SGRichView richViewWithFrame:CGRectMake(0, 282, self.view.frame.size.width, 44) titles:@[@"购买抽奖", @"点击抽奖"] configure:configure];
    [self.view addSubview:richView];
    [richView resetTitleColor:[UIColor redColor] borderColor:[UIColor redColor] forIndex:1];
    [richView setTitleImage:@"luckdraw_icon" clickImage:@"temp" spacing:5 forIndex:1];
    richView.clickedBlock = ^(SGRichView * _Nonnull richView, NSInteger index) {
        NSLog(@"index - - %ld", index);
    };
}

- (void)richView3 {
    SGRichViewConfigure *configure = [SGRichViewConfigure richViewConfigure];
    configure.borderWidth = 1;
    configure.borderColor = [UIColor redColor];
    configure.cornerRadius = 22;
    configure.titleColor = [UIColor redColor];
    configure.click = NO;
    configure.horizontalSpacing = 10;

    SGRichView *richView = [SGRichView richViewWithFrame:CGRectMake(0, 356, self.view.frame.size.width, 30) titles:@[@"假一赔十", @"支持7天无理由退货"] configure:configure];
    [self.view addSubview:richView];
}

- (void)richView4 {
    SGRichViewConfigure *configure = [SGRichViewConfigure richViewConfigure];
//    configure.richViewType = SGRichViewTypeVertical;
    configure.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0];
    configure.clickBackgroundColor = [UIColor redColor];
    configure.clickTitleColor = [UIColor whiteColor];
    configure.cornerRadius = 22;
    
    SGRichView *richView = [SGRichView richViewWithFrame:CGRectMake(0, 416, self.view.frame.size.width, 30) titles:@[@"全部", @"刺激战场", @"英雄联盟", @"欢乐斗地主", @"王者荣耀"] configure:configure];
    [self.view addSubview:richView];
    richView.index = 0;
}

- (void)richView5 {
    SGRichViewConfigure *configure = [SGRichViewConfigure richViewConfigure];
    configure.richViewType = SGRichViewTypeHorizontalEquable;
    configure.cornerRadius = 22;
    configure.spacing = 0.01;
    configure.horizontalSpacing = 0.01;
    configure.showVerticalSeparator = YES;
    configure.verticalSeparatorColor = [UIColor grayColor];
    configure.verticalSeparatorReduceHeight = 12;
    
    SGRichView *richView = [SGRichView richViewWithFrame:CGRectMake(0, self.view.frame.size.height - 44, self.view.frame.size.width, 44) titles:@[@"联系卖家", @"拨打电话"] configure:configure];
    [self.view addSubview:richView];
}

@end
