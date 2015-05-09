//
//  KYParallaxCollectionLayout.m
//  KYParallaxViewDemo
//
//  Created by Kitten Yang on 5/9/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import "KYParallaxCollectionLayout.h"

@implementation KYParallaxCollectionLayout{
    CGSize _itemSize;
}

- (id) init{
    self = [super init];
    if(self) {
        _separatorWidth = 0;
    }
    return self;
}
- (void) prepareLayout {
    CGSize boundSize = self.collectionView.bounds.size;
    boundSize.width = boundSize.width - _separatorWidth;
    _itemSize = boundSize;
    
}

- (CGSize) collectionViewContentSize {
    NSInteger numberOfItems = [[self collectionView]numberOfItemsInSection:0];
    CGSize cvSize = CGSizeMake((self.collectionView.bounds.size.width * numberOfItems) ,self.collectionView.bounds.size.height);
    return cvSize;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes * attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.size = _itemSize;
    attributes.center =CGPointMake((_separatorWidth * indexPath.row) + (indexPath.row * (self.collectionView.bounds.size.width - _separatorWidth)) + (self.collectionView.bounds.size.width - _separatorWidth)/2, self.collectionView.bounds.size.height/2);
    return attributes;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray * attributes = [NSMutableArray array];
    for (NSInteger i = 0,j = [[self collectionView]numberOfItemsInSection:0]; i < j;i ++){
        NSIndexPath * indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    return attributes;
}

@end
