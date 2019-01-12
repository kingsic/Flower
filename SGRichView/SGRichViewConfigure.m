//
//  SGRichViewConfigure.m
//  SGRichViewExample
//
//  Created by kingsic on 2019/1/10.
//  Copyright © 2019年 kingsic. All rights reserved.
//

#import "SGRichViewConfigure.h"

@implementation SGRichViewConfigure
/** 类方法 */
+ (instancetype)richViewConfigure {
    return [[self alloc] init];
}

- (instancetype)init {
    if (self = [super init]) {
        [self initialization];
    }
    return self;
}

- (void)initialization {
    _click = YES;
}

- (SGRichViewType)richViewType {
    if (!_richViewType) {
        _richViewType = SGRichViewTypeHorizontal;
    }
    return _richViewType;
}

- (UIFont *)font {
    if (!_font) {
        _font = [UIFont systemFontOfSize:15];
    }
    return _font;
}
- (UIColor *)titleColor {
    if (!_titleColor) {
        _titleColor = [UIColor blackColor];
    }
    return _titleColor;
}
- (UIColor *)clickTitleColor {
    if (!_clickTitleColor) {
        _clickTitleColor = [UIColor blackColor];
    }
    return _clickTitleColor;
}
- (UIColor *)backgroundColor {
    if (!_backgroundColor) {
        _backgroundColor = [UIColor clearColor];
    }
    return _backgroundColor;
}
- (UIColor *)clickBackgroundColor {
    if (!_clickBackgroundColor) {
        _clickBackgroundColor = [UIColor clearColor];
    }
    return _clickBackgroundColor;
}
- (CGFloat)cornerRadius {
    if (!_cornerRadius) {
        _cornerRadius = 0.0;
    }
    return _cornerRadius;
}
- (CGFloat)borderWidth {
    if (!_borderWidth) {
        _borderWidth = 0.0f;
    }
    return _borderWidth;
}
- (UIColor *)borderColor {
    if (!_borderColor) {
        _borderColor = [UIColor clearColor];
    }
    return _borderColor;
}
- (CGFloat)titleHeight {
    if (_titleHeight <= 0) {
        _titleHeight = 44;
    }
    return _titleHeight;
}

#pragma mark - - 标题间间距属性
- (CGFloat)spacing {
    if (_spacing <= 0) {
        _spacing = 20.0f;
    }
    return _spacing;
}
- (CGFloat)horizontalSpacing {
    if (_horizontalSpacing <= 0) {
        _horizontalSpacing = 20.0f;
    }
    return _horizontalSpacing;
}
- (CGFloat)verticalSpacing {
    if (_verticalSpacing <= 0) {
        _verticalSpacing = 20.0f;
    }
    return _verticalSpacing;
}
- (CGFloat)additionalWidth {
    if (_additionalWidth <= 0) {
        _additionalWidth = 40.0f;
    }
    return _additionalWidth;
}

#pragma mark - - 标题间分割线属性
- (UIColor *)verticalSeparatorColor {
    if (!_verticalSeparatorColor) {
        _verticalSeparatorColor = [UIColor redColor];
    }
    return _verticalSeparatorColor;
}
- (CGFloat)verticalSeparatorReduceHeight {
    if (_verticalSeparatorReduceHeight <= 0) {
        _verticalSeparatorReduceHeight = 0;
    }
    return _verticalSeparatorReduceHeight;
}

@end
