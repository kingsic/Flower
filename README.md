# SGRichView


* 本项目中的 SGTagsView 来源于对 [SGPagingView](https://github.com/kingsic/SGPagingView) 框架中的 SGPageTitleView 的衍生


## 内容介绍
* SGTagsView（标签）
* SGGuidePageView（引导页)
* SGActionSheet（微信、微博样式）


## Installation
* 1、CocoaPods 导入 pod 'SGRichView', '~> 0.0.6'
* 2、下载、拖拽 “SGRichView” 文件夹到工程中

## 代码介绍
#### SGTagsView 的使用（详细使用, 请参考 Demo）
``` 
    SGTagsViewConfigure *configure = [SGTagsViewConfigure configure];

    NSArray *tags = @[@"iPhone 8", @"iPhone 8P", @"iPhone X", @"iPhone XR", @"iPhone XS", @"iPhone XS Max"];
    SGTagsView *tagsView = [SGTagsView tagsViewWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 50) configure:configure];
    tagsView.tags = tags;
    [self.view addSubview:tagsView];
    tagsView.singleSelectedBlock = ^(SGTagsView * _Nonnull tagsView, NSString *tag, NSInteger index) {
        NSLog(@"%@ - - %ld", tag, index);
    };
```

#### SGActionSheet 的使用（详细使用, 请参考 Demo）
``` 
    SGActionSheetConfigure *asc = [SGActionSheetConfigure configure];
    SGActionSheet *as = [[SGActionSheet alloc] initWithOtherTitles:@[@"确定"] configure:asc];
    as.otherTitleClickBlock = ^(NSInteger index) {
        NSLog(@"index  - - %ld", index);
    };
    [as show];
```


### QQ音乐、美团、天猫部分标签效果图展示<br>
![](https://github.com/kingsic/Useless/blob/master/SGRichView/SGTagsView_QQ.png)      ![](https://github.com/kingsic/Useless/blob/master/SGRichView/SGTagsView_MT.png)

![](https://github.com/kingsic/Useless/blob/master/SGRichView/SGTagsView_Tmall.png)      ![](https://github.com/kingsic/Useless/blob/master/SGRichView/SGTagsView_mine.png)
