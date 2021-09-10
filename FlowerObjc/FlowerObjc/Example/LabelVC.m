//
//  LabelVC.m
//  SGFastfishExample
//
//  Created by kingsic on 2020/12/22.
//  Copyright © 2020 kingsic. All rights reserved.
//

#import "LabelVC.h"
#import "SGLabel.h"

@interface LabelVC ()

@end

@implementation LabelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"SGLabel";
    self.view.backgroundColor = [UIColor whiteColor];

    NSString *tempStr = @"曾经沧海难为水，除却巫山不是云\n取次花丛懒回顾，半缘修道半缘君";
    SGLabel *lab = [[SGLabel alloc] init];
    lab.frame = CGRectMake(50, 100, self.view.frame.size.width - 100, 100);
    lab.backgroundColor = [UIColor greenColor];
    lab.numberOfLines = 0;
    lab.text = tempStr;
    [self.view addSubview:lab];
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
