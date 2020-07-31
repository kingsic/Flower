//
//  TagsVC.m
//  SGCrayfishExample
//
//  Created by kingsic on 2019/7/13.
//  Copyright © 2019年 kingsic. All rights reserved.
//

#import "TagsVC.h"
#import "SGCrayfish.h"

@interface TagsVC ()

@end

@implementation TagsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
    
    SGTagsViewConfigure *configure = [SGTagsViewConfigure configure];
    configure.tagsViewStyle = SGTagsViewStyleVertical;
    configure.cornerRadius = 15;
    configure.borderWidth = 2;
    configure.selectedColor = [UIColor whiteColor];
    configure.borderColor = [UIColor redColor];
    configure.selectedBorderColor = [UIColor greenColor];
    configure.selectedBackgroundColor = [UIColor redColor];

    NSArray *tags = @[@"这是单选标签", @"iPhone 8", @"iPhone 8P", @"iPhone X", @"iPhone XR", @"iPhone XS", @"iPhone XS Max"];
    SGTagsView *tagsView = [SGTagsView tagsViewWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 50) configure:configure];
    tagsView.tags = tags;
    [self.view addSubview:tagsView];
    tagsView.singleSelectedBlock = ^(SGTagsView * _Nonnull tagsView, NSString *tag, NSInteger index) {
        NSLog(@"%@ - - %ld", tag, index);
    };
    tagsView.contentHeightBlock = ^(SGTagsView *tagsView, CGFloat height) {
        NSLog(@"%.2f", height);
        
        SGTagsViewConfigure *mconfigure = [SGTagsViewConfigure configure];
        mconfigure.multipleSelected = YES;
        mconfigure.borderWidth = 1.0;
        mconfigure.column = 2;
        NSArray *mtags = @[@"多选且可以滚动", @"iPhone 8", @"iPhone 8P", @"iPhone X", @"iPhone XR", @"iPhone XS", @"iPhone XS Max", @"iPhone 8", @"iPhone 8P", @"iPhone X", @"iPhone XR", @"iPhone XS", @"iPhone XS Max"];
        SGTagsView *mtagsView = [SGTagsView tagsViewWithFrame:CGRectMake(0, CGRectGetMaxY(tagsView.frame) + 50, self.view.frame.size.width, 200) configure:mconfigure];
        mtagsView.tags = mtags;
        mtagsView.tagIndexs = @[@"1", @"2", @"3"];
        mtagsView.isFixedHeight = YES;
        [self.view addSubview:mtagsView];
        mtagsView.multipleSelectedBlock = ^(SGTagsView * _Nonnull tagsView, NSArray * _Nonnull tags, NSArray * _Nonnull indexs) {
            NSLog(@"%@ - - %@", tags, indexs);
        };
        [mtagsView setImageName:@"luckdraw_icon" imagePositionStyle:(SGImagePositionStyleDefault) spacing:5 forIndex:0];
        mtagsView.contentHeightBlock = ^(SGTagsView *tagsView, CGFloat height) {
            SGTagsViewConfigure *c = [SGTagsViewConfigure configure];
            c.contentSpacingLR = 0.01;
            c.contentSpacingTB = 0.01;
            c.horizontalSpacing = 0.01;
            c.verticalSpacing = 0.01;
            c.height = 80;
            c.column = 5;
            NSArray *ta = @[@"美食", @"卖场便利", @"水果", @"跑腿代购", @"甜品饮品", @"星选好店", @"送药上门", @"大牌会吃", @"取送件", @"签到领红包"];
            SGTagsView *t = [SGTagsView tagsViewWithFrame:CGRectMake(0, CGRectGetMaxY(mtagsView.frame) + 50, self.view.frame.size.width, 50) configure:c];
            t.tags = ta;
            NSArray *tia = @[@"luckdraw_icon", @"luckdraw_icon", @"luckdraw_icon", @"luckdraw_icon", @"luckdraw_icon", @"luckdraw_icon", @"luckdraw_icon", @"luckdraw_icon", @"luckdraw_icon", @"luckdraw_icon"];
            [t setImageNames:tia imagePositionStyle:(SGImagePositionStyleTop) spacing:5];
            [self.view addSubview:t];
        };
    };
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
