# Flower


* 本框架中的 SGTagsView 设计来源于 [SGPagingView](https://github.com/kingsic/SGPagingView) 框架中的 SGPageTitleView


## Flower
|视图|注释|
|----|-----|
|SGBaseItemsView|baseItems视图
|SGEdgeLabel|内边距的UILabel
|SGItemsView|item视图
|SGTagsView|标签视图
|SGTextView|placeholder、placeholderColor、limitNumber


## FlowerObjc
|视图|注释|
|----|-----|
|SGLabel|文字从左上方开始布局
|SGTextView|placeholder、placeholderColor、limitNumber
|SGTagsView|标签视图
|SGItemsView|item视图
|SGActionSheet|底部弹窗视图（微信、微博样式）
|SGGuidePageView|引导页


## 代码介绍（详细使用，请参考 API）
#### SGTagsView 的使用
``` 
    SGTagsViewConfigure *configure = [SGTagsViewConfigure configure];

    NSArray *tags = @[@"iPhone 8", @"iPhone 8P", @"iPhone X", @"iPhone XR", @"iPhone XS", @"iPhone XS Max"];
    SGTagsView *tagsView = [SGTagsView tagsViewWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 50) configure:configure];
    tagsView.tags = tags;
    [self.view addSubview:tagsView];
    tagsView.singleSelectBlock = ^(SGTagsView * _Nonnull tagsView, NSString *tag, NSInteger index) {
        NSLog(@"%@ - - %ld", tag, index);
    };
```

#### SGActionSheet 的使用
``` 
    SGActionSheetConfigure *asc = [SGActionSheetConfigure configure];
    SGActionSheet *as = [[SGActionSheet alloc] initWithOtherTitles:@[@"确定"] configure:asc];
    as.otherTitleClickBlock = ^(NSInteger index) {
        NSLog(@"index  - - %ld", index);
    };
    [as actionSheet];
```


### QQ音乐、美团、天猫以及SGTagsView标签效果图展示<br>
![](https://github.com/kingsic/Useless/blob/master/SGRichView/SGTagsView_QQ.png)      ![](https://github.com/kingsic/Useless/blob/master/SGRichView/SGTagsView_MT.png)

![](https://github.com/kingsic/Useless/blob/master/SGRichView/SGTagsView_Tmall.png)      ![](https://github.com/kingsic/Useless/blob/master/SGRichView/SGTagsView_mine.png)
