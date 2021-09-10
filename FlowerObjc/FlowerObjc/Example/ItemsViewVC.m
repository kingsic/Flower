//
//  ItemsViewVC.m
//  SGFastfishExample
//
//  Created by kingsic on 2020/12/22.
//  Copyright © 2020 kingsic. All rights reserved.
//

#import "ItemsViewVC.h"
#import "SGItemsView.h"

@interface ItemsViewVC ()

@end

@implementation ItemsViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"SGItemsView";
    self.view.backgroundColor = [UIColor whiteColor];

    NSArray *images = @[@"luckdraw_icon", @"luckdraw_icon", @"luckdraw_icon", @"luckdraw_icon", @"luckdraw_icon", @"luckdraw_icon", @"luckdraw_icon", @"luckdraw_icon"];
    SGItemsView *items = [[SGItemsView alloc] init];
    items.frame = CGRectMake(0, 100, self.view.frame.size.width, 70);
    items.backgroundColor = [UIColor greenColor];
    items.titles = @[@"粉丝", @"喜欢", @"我的", @"评论", @"粉丝", @"喜欢", @"我的", @"评论"];
    items.itemSize = CGSizeMake(90, 70);
    [self.view addSubview:items];
    items.scrollDirectionHorizontal = YES;
    items.configureImgViewBlock = ^(UIImageView * _Nonnull imageView, NSInteger index) {
        imageView.image = [UIImage imageNamed:images[index]];
    };
    
    NSArray *images2 = @[@"luckdraw_icon", @"luckdraw_icon", @"luckdraw_icon", @"luckdraw_icon", @"luckdraw_icon", @"luckdraw_icon", @"luckdraw_icon", @"luckdraw_icon"];
    SGItemsView *items2 = [[SGItemsView alloc] init];
    items2.frame = CGRectMake(0, CGRectGetMaxY(items.frame) + 50, self.view.frame.size.width, 170);
    items2.backgroundColor = [UIColor greenColor];
    items2.titles = @[@"粉丝", @"喜欢", @"我的", @"评论", @"粉丝", @"喜欢", @"我的", @"评论"];
    items2.itemSize = CGSizeMake((self.view.frame.size.width - 40) / 4, 65);
    [self.view addSubview:items2];
    items2.configureImgViewBlock = ^(UIImageView * _Nonnull imageView, NSInteger index) {
        imageView.image = [UIImage imageNamed:images2[index]];
    };
    items2.itemClickBlock = ^(NSInteger index) {
        NSLog(@"index - - %ld", index);
    };
    items2.contentInset = UIEdgeInsetsMake(20, 20, 20, 20);
    [items2 setItemTitleColor:[UIColor redColor] forIndex:1];
    [items2 setItemTitleColor:[UIColor redColor] forIndex:5];
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
