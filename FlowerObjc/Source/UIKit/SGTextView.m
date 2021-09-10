//
//  SGTextView.m
//  SGTextView
//
//  Created by kingsic on 2020/12/11.
//  Copyright © 2020 kingsic. All rights reserved.
//

#import "SGTextView.h"

@interface SGTextView ()
@property (nonatomic, strong) UILabel *placeholderLabel;
@property (nonatomic, assign) BOOL addPlaceholderNotification;
@property (nonatomic, assign) BOOL addLimitNumberNotification;
@end

@implementation SGTextView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x = 6;
    CGFloat y = 0;
    CGFloat w = self.frame.size.width - 2 * x;
    CGFloat h = 0;
    if (self.addPlaceholderNotification) {
        if (self.font == nil) {
            y = 6.5;
            h = [self P_calculateHeightWithString:_placeholder font:_placeholderLabel.font width:w];
        } else {
            y = 8;
            h = [self P_calculateHeightWithString:_placeholder font:self.font width:w];
        }
        _placeholderLabel.frame = CGRectMake(x, y, w, h);
    }
}

- (UILabel *)placeholderLabel {
    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc] init];
        _placeholderLabel.text = _placeholder;
        _placeholderLabel.numberOfLines = 0;
        _placeholderLabel.textColor = [UIColor lightGrayColor];
        if (self.font == nil) {
            _placeholderLabel.font = [UIFont systemFontOfSize:13];
        } else {
            _placeholderLabel.font = self.font;
        }
    }
    return _placeholderLabel;
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    
    [self addSubview:self.placeholderLabel];
    if (self.addPlaceholderNotification == NO && self.addLimitNumberNotification == NO) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChangeNotification) name:UITextViewTextDidChangeNotification object:self];
        self.addPlaceholderNotification = YES;
    } else if (self.addPlaceholderNotification == NO && self.addLimitNumberNotification) {
        self.addPlaceholderNotification = YES;
    }
}
- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    _placeholderLabel.textColor = placeholderColor;
}

- (void)setLimitNumber:(NSInteger)limitNumber {
    _limitNumber = limitNumber;
    if (limitNumber <= 0) {
        @throw [NSException exceptionWithName:@"SGTextView" reason:@"【limitNumber属性值必须大于等于0】" userInfo:nil];;
    }
    if (self.addLimitNumberNotification == NO && self.addPlaceholderNotification == NO) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChangeNotification) name:UITextViewTextDidChangeNotification object:self];
        self.addLimitNumberNotification = YES;
    } else if (self.addLimitNumberNotification == NO && self.addPlaceholderNotification) {
        self.addLimitNumberNotification = YES;
    }
}

- (void)textDidChangeNotification {
    if (self.addPlaceholderNotification) {
        _placeholderLabel.hidden = self.hasText;
    }
    if (self.addLimitNumberNotification) {
        if (_limitNumber > 0) {
            if (self.text.length > _limitNumber) {
                self.text = [self.text substringToIndex:_limitNumber];
            }
        }
    }
}

- (void)dealloc {
    if (self.addPlaceholderNotification || self.addLimitNumberNotification) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}


/**
 *  根据字号大小、宽度及字符串上下间的间距计算出字符串的高
 */
- (CGFloat)P_calculateHeightWithString:(NSString *)string font:(UIFont *)font width:(CGFloat)width {
    NSDictionary *attributes = @{NSFontAttributeName : font};
    return [string boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.height;
}

@end
