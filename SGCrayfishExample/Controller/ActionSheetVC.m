//
//  ActionSheetVC.m
//  SGCrayfishExample
//
//  Created by kingsic on 2019/7/13.
//  Copyright © 2019年 kingsic. All rights reserved.
//

#import "ActionSheetVC.h"
#import "SGCrayfish.h"

@interface ActionSheetVC ()

@end

@implementation ActionSheetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
    
    SGTagsViewConfigure *configure = [SGTagsViewConfigure configure];
    configure.tagsStyle = SGTagsStyleVertical;
    NSArray *tags = @[@"标题样式", @"不带标题样式"];
    SGTagsView *tagsView = [SGTagsView tagsViewWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 50) configure:configure];
    tagsView.tags = tags;
    [self.view addSubview:tagsView];
    tagsView.singleSelectBlock = ^(SGTagsView * _Nonnull tagsView, NSString *tag, NSInteger index) {
        if (index == 0) {
            SGActionSheetConfigure *asc = [SGActionSheetConfigure configure];
            asc.cellHeight = 50;
            SGActionSheet *as = [[SGActionSheet alloc] initWithTitle:@"退出后不会删除任何历史数据，下次登录依然可以使用本账号" cancelTitle:@"取消" otherTitles:@[@"退出登录"] configure:asc];
            as.otherTitleClickBlock = ^(NSInteger index) {
                NSLog(@"index  - - %ld", index);
            };
            [as resetOtherTitleColor:[UIColor redColor] forIndex:0];
            [as popupActionSheet];
        } else {
            SGActionSheetConfigure *asc = [SGActionSheetConfigure configure];
            asc.penetrationEffect = NO;
            SGActionSheet *as = [[SGActionSheet alloc] initWithOtherTitles:@[@"微信", @"支付宝"] configure:asc];
            as.otherTitleClickBlock = ^(NSInteger index) {
                NSLog(@"index  - - %ld", index);
            };
            [as popupActionSheet];
        }
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
