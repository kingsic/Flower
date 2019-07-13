//
//  SGGuidePageView.m
//  SGCrayfishExample
//
//  Created by kingsic on 2017/8/7.
//  Copyright © 2017 kingsic. All rights reserved.
//

#import "SGGuidePageView.h"

@interface SGGuidePageView () <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *contentScrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSArray *image_array;
@end

@implementation SGGuidePageView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialization];
        [self addSubviews];
    }
    return self;
}

- (void)initialization {
    _durationTime = 0.25;
    _pageControlOffsetY = 0.87;
    _pageControlType = SGPageControlTypeNone;
    _pageIndicatorTintColor = [UIColor grayColor];
    _currentPageIndicatorTintColor = [UIColor whiteColor];
}

- (void)addSubviews {
    [self addSubview:self.contentScrollView];
}

- (UIScrollView *)contentScrollView {
    if (!_contentScrollView) {
        _contentScrollView = [[UIScrollView alloc] init];
        _contentScrollView.delegate = self;
        _contentScrollView.bounces = NO;
        _contentScrollView.pagingEnabled = YES;
        _contentScrollView.showsVerticalScrollIndicator = NO;
        _contentScrollView.showsHorizontalScrollIndicator = NO;
        _contentScrollView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    }
    return _contentScrollView;
}

- (void)setImages:(NSArray *)images {
    _images = images;
    self.image_array = [NSArray arrayWithArray:images];
    
    CGFloat selfWidth = self.frame.size.width;
    CGFloat selfHeight = self.frame.size.height;
    self.contentScrollView.contentSize = CGSizeMake(selfWidth * images.count, selfHeight);

    for (NSInteger i = 0; i < images.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(selfWidth * i, 0, selfWidth, selfHeight);
        imageView.image = [UIImage imageNamed:images[i]];
        [self.contentScrollView addSubview:imageView];
        
        if (i == images.count - 1) {
            imageView.userInteractionEnabled = YES;
            [imageView addSubview:self.enterBtn];
        }
    }
}

- (UIButton *)enterBtn {
    if (!_enterBtn) {
        _enterBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        CGFloat width = 100;
        CGFloat height = 50;
        CGFloat x = 0.5 * (self.frame.size.width - width);
        CGFloat y = self.frame.size.height * 0.87 - 15;
        _enterBtn.frame = CGRectMake(x, y, width, height);
        [_enterBtn setTitle:@"立即体验" forState:(UIControlStateNormal)];
        [_enterBtn addTarget:self action:@selector(enterBtn_action) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _enterBtn;
}

- (void)enterBtn_action {
    [UIView animateWithDuration:self.durationTime animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)setDurationTime:(CGFloat)durationTime {
    _durationTime = durationTime;
}

- (void)setPageControlType:(SGPageControlType)pageControlType {
    _pageControlType = pageControlType;
    if (pageControlType == SGPageControlTypeAlways) {
        [self addSubview:self.pageControl];
    } else if (pageControlType == SGPageControlTypeDisappear) {
        [self addSubview:self.pageControl];
    }
}

- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor {
    _pageIndicatorTintColor = pageIndicatorTintColor;
    if (_pageControl != nil) {
        _pageControl.pageIndicatorTintColor = pageIndicatorTintColor;
    }
}
- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor {
    _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    if (_pageControl != nil) {
        _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    }
}

- (void)setLastPageDisapper:(BOOL)lastPageDisapper {
    _lastPageDisapper = lastPageDisapper;
}

- (void)setPageControlOffsetY:(CGFloat)pageControlOffsetY {
    _pageControlOffsetY = pageControlOffsetY;
    if (_pageControl != nil) {
        CGRect frame = _pageControl.frame;
        frame.origin.y = pageControlOffsetY * self.frame.size.height;
        _pageControl.frame = frame;
    }
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.frame = CGRectMake(0, self.frame.size.height * _pageControlOffsetY, self.frame.size.width, 30);
        _pageControl.currentPage = 0;
        _pageControl.userInteractionEnabled = NO;
        _pageControl.numberOfPages = self.image_array.count;
        _pageControl.pageIndicatorTintColor = _pageIndicatorTintColor;
        _pageControl.currentPageIndicatorTintColor = _currentPageIndicatorTintColor;
    }
    return _pageControl;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_pageControlType == SGPageControlTypeAlways) {
        self.pageControl.currentPage = ((scrollView.contentOffset.x / scrollView.frame.size.width) + 0.5f);
    } else if (_pageControlType == SGPageControlTypeDisappear) {
        CGFloat offsetX = scrollView.contentOffset.x / scrollView.frame.size.width;
        NSInteger index = offsetX + 0.5f;
        self.pageControl.currentPage = index;
        
        if (self.image_array.count - 2 < offsetX < self.image_array.count - 1 ) {
            CGFloat alpha = 1 - 2 * (offsetX - (self.image_array.count - 2));
            self.pageControl.alpha = alpha;
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (_lastPageDisapper == YES) {
        int cuttentIndex = (int)(scrollView.contentOffset.x + 0.5 * self.frame.size.width)/self.frame.size.width;
        if (cuttentIndex == self.image_array.count - 1) {
            if ([self isScrolltoLeft:scrollView]) {
                [self enterBtn_action];
            }
        }
    }
}
- (BOOL )isScrolltoLeft:(UIScrollView *)scrollView {
    if ([scrollView.panGestureRecognizer translationInView:scrollView.superview].x < 0) {
        return YES;
    } else {
        return NO;
    }
}

@end
