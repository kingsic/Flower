//
//  TagsVC.m
//  SGRichViewExample
//
//  Created by kingsic on 2019/7/2.
//  Copyright © 2019年 kingsic. All rights reserved.
//

#import "TagsVC.h"
#import "SGRichView.h"

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
    
    NSArray *tags = @[@"这是单选标签", @"iPhone XS", @"iPhone XS Max", @"iPhone X", @"iPhone XR", @"iPhone 8", @"iPhone 8P"];
    SGTagsView *tagsView = [SGTagsView tagsViewWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 50) configure:configure];
    tagsView.tags = tags;
    [self.view addSubview:tagsView];
    tagsView.selectedBlock = ^(SGTagsView * _Nonnull tagsView, NSString *tag, NSInteger index) {
        NSLog(@"%@ - - %ld", tag, index);
    };
    tagsView.heightBlock = ^(SGTagsView *tagsView, CGFloat height) {
        NSLog(@"%.2f", height);
        
        SGTagsViewConfigure *mconfigure = [SGTagsViewConfigure configure];
        mconfigure.tagsViewStyle = SGTagsViewStyleEquable;
        mconfigure.multipleSelected = YES;
        mconfigure.borderWidth = 1.0;
        NSArray *mtags = @[@"这是多选标签", @"iPhone XS", @"iPhone XS Max", @"iPhone X", @"iPhone XR", @"iPhone 8", @"iPhone 8P"];
        SGTagsView *mtagsView = [SGTagsView tagsViewWithFrame:CGRectMake(0, CGRectGetMaxY(tagsView.frame) + 50, self.view.frame.size.width, 50) configure:mconfigure];
        mtagsView.tags = mtags;
        [self.view addSubview:mtagsView];
        mtagsView.multipleSelectedBlock = ^(SGTagsView * _Nonnull tagsView, NSArray * _Nonnull tags, NSArray * _Nonnull indexs) {
            NSLog(@"%@ - - %@", tags, indexs);
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
