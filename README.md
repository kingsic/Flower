# SGRichView


* 本项目中的 SGTagsView 来源于对 [SGPagingView](https://github.com/kingsic/SGPagingView) 框架中的 SGPageTitleView 的衍生


## Installation
* 1、CocoaPods 导入 pod 'SGRichView', '~> 0.0.1'
* 2、下载、拖拽 “SGRichView” 文件夹到工程中

## 代码介绍
#### SGPagingView 的使用（详细使用, 请参考 Demo）
``` 
    SGTagsViewConfigure *configure = [SGTagsViewConfigure tagsViewConfigure];

    NSArray *tags = @[@"iPhone XS", @"iPhone XS Max", @"iPhone X", @"iPhone XR", @"iPhone 8", @"iPhone 8P"];
    SGTagsView *tagsView = [SGTagsView tagsViewWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 50) configure:configure];
    tagsView.tags = tags;
    [self.view addSubview:tagsView];
    tagsView.selectedBlock = ^(SGTagsView * _Nonnull tagsView, NSString *tag, NSInteger index) {
        NSLog(@"%@ - - %ld", tag, index);
    };
```


### SGRichView 实现的界面效果图<br>
![](https://github.com/kingsic/Useless/blob/master/SGRichView/SGRichView.png)

### 普通电商及天猫部分界面效果图<br>
![](https://github.com/kingsic/Useless/blob/master/SGRichView/SGRichView1.png)      ![](https://github.com/kingsic/Useless/blob/master/SGRichView/SGRichView2.png)
