//
//  TextViewVC.m
//  SGFastfishExample
//
//  Created by kingsic on 2020/12/22.
//  Copyright © 2020 kingsic. All rights reserved.
//

#import "TextViewVC.h"
#import "SGTextView.h"

@interface TextViewVC ()

@end

@implementation TextViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"SGTextView";
    self.view.backgroundColor = [UIColor whiteColor];

    SGTextView *tv = [[SGTextView alloc] init];
    tv.frame = CGRectMake(50, 100, self.view.frame.size.width - 100, 100);
    tv.backgroundColor = [UIColor greenColor];
    tv.layer.cornerRadius = 10;
    tv.layer.borderWidth = 1;
    tv.layer.borderColor = [UIColor blackColor].CGColor;
    tv.placeholder = @"分享美好事物……";
    tv.placeholderColor = [UIColor redColor];
    [self.view addSubview:tv];
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
