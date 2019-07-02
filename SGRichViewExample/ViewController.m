//
//  ViewController.m
//  SGRichViewExample
//
//  Created by kingsic on 2019/1/12.
//  Copyright © 2019年 kingsic. All rights reserved.
//

#import "ViewController.h"
#import "TagsVC.h"
#import "ActionSheetVC.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *titleDataList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.titleDataList = @[@"SGTagsView", @"SGActionSheet"];
    [self foundTableView];
}

- (void)foundTableView {
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleDataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.titleDataList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        TagsVC *tvc = [[TagsVC alloc] init];
        [self.navigationController pushViewController:tvc animated:YES];
    } else {
        ActionSheetVC *asvc = [[ActionSheetVC alloc] init];
        [self.navigationController pushViewController:asvc animated:YES];
    }
}


@end
