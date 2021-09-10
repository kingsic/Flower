//
//  ViewController.m
//  FlowerObjc
//
//  Created by kingsic on 2021/9/7.
//

#import "ViewController.h"
#import "LabelVC.h"
#import "TextViewVC.h"
#import "TagsViewVC.h"
#import "ItemsViewVC.h"
#import "SGActionSheet.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSArray *dataSourceVC;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataSource = @[@"SGLabel", @"SGTextView", @"SGTagsView", @"SGItemsView", @"SGActionSheet"];
    
    LabelVC *labVC = [[LabelVC alloc] init];
    TextViewVC *textVC = [[TextViewVC alloc] init];
    TagsViewVC *tagsVC = [[TagsViewVC alloc] init];
    ItemsViewVC *itemsVC = [[ItemsViewVC alloc] init];
    self.dataSourceVC = @[labVC, textVC, tagsVC, itemsVC];
    
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
    
    if (self.dataSource.count - 1 == indexPath.row) {
        [self sheetView];
        return;
    }
    
    [self.navigationController pushViewController:self.dataSourceVC[indexPath.row] animated:YES];
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
