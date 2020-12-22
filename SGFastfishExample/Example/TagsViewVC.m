//
//  TagsViewVC.m
//  SGFastfishExample
//
//  Created by kingsic on 2020/12/22.
//  Copyright © 2020 kingsic. All rights reserved.
//

#import "TagsViewVC.h"
#import "SGFastfish.h"

@interface TagsViewVC ()

@end

@implementation TagsViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
        
    SGTagsViewConfigure *configure = [SGTagsViewConfigure configure];
    configure.tagsStyle = SGTagsStyleVertical;
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
    tagsView.singleSelectBlock = ^(SGTagsView * _Nonnull tagsView, NSString *tag, NSInteger index) {
        NSLog(@"%@ - - %ld", tag, index);
    };
    tagsView.heightBlock = ^(SGTagsView *tagsView, CGFloat height) {
        NSLog(@"%.2f", height);
        
        SGTagsViewConfigure *mconfigure = [SGTagsViewConfigure configure];
        mconfigure.multipleSelect = YES;
        mconfigure.borderWidth = 1.0;
        mconfigure.column = 2;
        mconfigure.bounces = YES;
        NSArray *mtags = @[@"多选且可滚动", @"iPhone 8", @"iPhone 8P", @"iPhone X", @"iPhone XR", @"iPhone XS", @"iPhone XS Max", @"iPhone 8", @"iPhone 8P", @"iPhone X", @"iPhone XR", @"iPhone XS", @"iPhone XS Max"];
        SGTagsView *mtagsView = [SGTagsView tagsViewWithFrame:CGRectMake(0, CGRectGetMaxY(tagsView.frame) + 20, self.view.frame.size.width, 200) configure:mconfigure];
        mtagsView.tags = mtags;
        mtagsView.tagIndexs = @[@"0", @"1"];
        mtagsView.isFixedHeight = YES;
        [self.view addSubview:mtagsView];
        mtagsView.multipleSelectBlock = ^(SGTagsView * _Nonnull tagsView, NSArray * _Nonnull tags, NSArray * _Nonnull indexs) {
            NSLog(@"%@ - - %@", tags, indexs);
        };
        [mtagsView setImageName:@"luckdraw_icon" imagePositionStyle:(SGImagePositionStyleDefault) spacing:5 forIndex:0];
        mtagsView.heightBlock = ^(SGTagsView *tagsView, CGFloat height) {
            SGTagsViewConfigure *otherConfigure = [SGTagsViewConfigure configure];
            otherConfigure.contentInset = UIEdgeInsetsMake(0.01, 0.01, 0.01, 0.01);
            otherConfigure.horizontalSpacing = 0.01;
            otherConfigure.verticalSpacing = 0.01;
            otherConfigure.height = 80;
            otherConfigure.column = 5;
            NSArray *otherDataSource = @[@"美食", @"卖场便利", @"水果", @"跑腿代购", @"甜品饮品", @"星选好店", @"送药上门", @"大牌会吃", @"取送件", @"签到领红包"];
            SGTagsView *otherTageView = [SGTagsView tagsViewWithFrame:CGRectMake(0, CGRectGetMaxY(mtagsView.frame) + 20, self.view.frame.size.width, 50) configure:otherConfigure];
            otherTageView.tags = otherDataSource;
            NSArray *tia = @[@"luckdraw_icon", @"luckdraw_icon", @"luckdraw_icon", @"luckdraw_icon", @"luckdraw_icon", @"luckdraw_icon", @"luckdraw_icon", @"luckdraw_icon", @"luckdraw_icon", @"luckdraw_icon"];
            [otherTageView setImageNames:tia imagePositionStyle:(SGImagePositionStyleTop) spacing:5];
            [self.view addSubview:otherTageView];
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
