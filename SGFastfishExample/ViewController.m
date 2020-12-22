//
//  ViewController.m
//  SGFastfishExample
//
//  Created by kingsic on 2020/12/16.
//  Copyright © 2020 kingsic. All rights reserved.
//

#import "ViewController.h"
#import "SGFastfish.h"
#import "LabelVC.h"
#import "TextViewVC.h"
#import "TagsViewVC.h"
#import "ItemsViewVC.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataSource = @[@"SGLabel", @"SGTextView", @"SGTagsView", @"SGItemsView", @"SGActionSheet"];
    [self configureTableView];
}
- (void)configureTableView {
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        LabelVC *lVC = [[LabelVC alloc] init];
        [self.navigationController pushViewController:lVC animated:YES];
    } else if (indexPath.row == 1) {
        TextViewVC *tVC = [[TextViewVC alloc] init];
        [self.navigationController pushViewController:tVC animated:YES];
    } else if (indexPath.row == 2) {
        TagsViewVC *tVC = [[TagsViewVC alloc] init];
        [self.navigationController pushViewController:tVC animated:YES];
    } else if (indexPath.row == 3) {
        ItemsViewVC *iVC = [[ItemsViewVC alloc] init];
        [self.navigationController pushViewController:iVC animated:YES];
    } else {
        [self sheetView];
    }
}

- (void)sheetView {
    SGActionSheetConfigure *asc = [SGActionSheetConfigure configure];
    asc.cellHeight = 50;
    SGActionSheet *as = [[SGActionSheet alloc] initWithTitle:@"退出后不会删除任何历史数据，下次登录依然可以使用本账号" cancelTitle:@"取消" otherTitles:@[@"退出登录"] configure:asc];
    as.otherTitleClickBlock = ^(NSInteger index) {
        NSLog(@"index  - - %ld", index);
    };
    [as resetOtherTitleColor:[UIColor redColor] forIndex:0];
    [as actionSheet];
}

@end
