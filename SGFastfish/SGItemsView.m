//
//  SGItemsView.m
//  SGFastfishExample
//
//  Created by kingsic on 2020/10/15.
//  Copyright © 2020 kingsic. All rights reserved.
//

#import "SGItemsView.h"

@interface SGItemCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titleLab;
@end
@implementation SGItemCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.imgView];
        [self addSubview:self.titleLab];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat iv_y = 5;
    CGFloat iv_height = self.frame.size.height / 3 * 2 - iv_y;
    CGFloat iv_width = iv_height;
    CGFloat iv_x = 0.5 * (self.frame.size.width - iv_width);
    _imgView.frame = CGRectMake(iv_x, iv_y, iv_width, iv_height);
    
    CGFloat tl_x = 0;
    CGFloat tl_y = self.frame.size.height / 3 * 2;
    CGFloat tl_width = self.frame.size.width;
    CGFloat tl_height = self.frame.size.height / 3;
    _titleLab.frame = CGRectMake(tl_x, tl_y, tl_width, tl_height);
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
    }
    return _imgView;
}
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}
@end


@interface SGItemsView () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionViewFlowLayout *CVFlowLayout;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableDictionary *itemTitleColorMDict;
@end

@implementation SGItemsView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configure];
        [self addSubview:self.collectionView];
    }
    return self;
}
- (void)configure {
    _titleFont = [UIFont systemFontOfSize:12];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _CVFlowLayout.itemSize = CGSizeMake(_itemSize.width, _itemSize.height);
    
    CGFloat cv_y = 0;
    CGFloat cv_width = self.frame.size.width;
    CGFloat cv_height = self.frame.size.height;
    _collectionView.frame = CGRectMake(0, cv_y, cv_width, cv_height);
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _CVFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        _CVFlowLayout.minimumInteritemSpacing = 0;
        _CVFlowLayout.minimumLineSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_CVFlowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[SGItemCell class] forCellWithReuseIdentifier:@"cellID"];
        _collectionView.backgroundColor = self.backgroundColor;
        _collectionView.showsHorizontalScrollIndicator = _showsHorizontalScrollIndicator;
    }
    return _collectionView;
}
#pragma mark - - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _titles.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SGItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    if (self.configureImgViewBlock) {
        self.configureImgViewBlock(cell.imgView, indexPath.row);
    }
    
    cell.titleLab.text = _titles[indexPath.item];
    if (_titleFont) {
        cell.titleLab.font = _titleFont;
    }
    if (_titleColor) {
        cell.titleLab.textColor = _titleColor;
    }

    if (_itemTitleColorMDict) {
        [self.itemTitleColorMDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSInteger index = [key integerValue];
            if (index == indexPath.row) {
                cell.titleLab.textColor = obj;
            }
        }];
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.itemClickBlock) {
        self.itemClickBlock(indexPath.row);
    }
}

#pragma mark - - set
- (void)setTitles:(NSArray *)titles {
    _titles = titles;
    [_collectionView reloadData];
}
- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
}
- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
}

- (void)setItemSize:(CGSize)itemSize {
    _itemSize = itemSize;
}
- (void)setContentInset:(UIEdgeInsets)contentInset {
    _collectionView.contentInset = UIEdgeInsetsMake(contentInset.top, contentInset.left, contentInset.bottom, contentInset.right);
}
- (void)setPagingEnabled:(BOOL)pagingEnabled {
    _collectionView.pagingEnabled = pagingEnabled;
}
- (void)setScrollDirectionHorizontal:(BOOL)scrollDirectionHorizontal {
    if (scrollDirectionHorizontal == YES) {
        _CVFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
}
- (void)setShowsHorizontalScrollIndicator:(BOOL)showsHorizontalScrollIndicator {
    _collectionView.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator;
}
- (void)setShowsVerticalScrollIndicator:(BOOL)showsVerticalScrollIndicator {
    _collectionView.showsVerticalScrollIndicator = showsVerticalScrollIndicator;
}

- (void)setItemTitleColor:(UIColor *)titleColor forIndex:(NSInteger)index {
    [self.itemTitleColorMDict setObject:titleColor forKey:@(index)];
}
- (NSMutableDictionary *)itemTitleColorMDict {
    if (!_itemTitleColorMDict) {
        _itemTitleColorMDict = [NSMutableDictionary dictionary];
    }
    return _itemTitleColorMDict;
}

@end
