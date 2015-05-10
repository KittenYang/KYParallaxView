//
//  KYParallaxHorizontalView.m
//  KYParallaxViewDemo
//
//  Created by Kitten Yang on 5/9/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//


#import "KYParallaxHorizontalView.h"
#import "KYParallaxCollectionLayout.h"
#import "KYParallaxVerticalView.h"
#import "KYParallaxCollectionCell.h"


@interface KYParallaxHorizontalView()<UIScrollViewDelegate>

@end

@implementation KYParallaxHorizontalView{
    KYParallaxCollectionLayout *layout;
    KYParallaxCollectionCell *currentCell;
    UIImageView *leftParallaxImageView;
    UIImageView *rightParallaxImageView;
    NSInteger item;
    
    NSInteger currentIndex;
}



-(id)initWithFrame:(CGRect)frame andCollectionDelegate:(id<UICollectionViewDataSource,UICollectionViewDelegate>)delegate{
    layout = [[KYParallaxCollectionLayout alloc]init];

    layout.separatorWidth = 5;
    CGRect collectionFrame = frame;
    collectionFrame.size.width = collectionFrame.size.width + layout.separatorWidth;
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews:collectionFrame delegate:delegate];
    }
    return self;
}


-(void)initViews:(CGRect)frame delegate:(id<UICollectionViewDataSource,UICollectionViewDelegate>)delegate{

    
    UICollectionView *parallaxCollection = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:layout];
    [parallaxCollection registerClass:[KYParallaxCollectionCell class] forCellWithReuseIdentifier:@"HorizontalParallexCell"];
    parallaxCollection.delegate = delegate;
    parallaxCollection.dataSource = delegate;
    parallaxCollection.pagingEnabled = YES;
    
    [self addSubview:parallaxCollection];
}

-(void)parallax:(UIScrollView *)horizontalView{
    
    UICollectionView *cv = (UICollectionView *)horizontalView;
    KYParallaxCollectionLayout*lat = (KYParallaxCollectionLayout *)cv.collectionViewLayout;

    item = cv.contentOffset.x / cv.frame.size.width;
    NSLog(@"item:%ld",(long)item);

    KYParallaxCollectionCell *leftCell = (KYParallaxCollectionCell *)[cv cellForItemAtIndexPath:[NSIndexPath indexPathForItem:item inSection:0]];
    KYParallaxCollectionCell *rightCell = (KYParallaxCollectionCell *)[cv cellForItemAtIndexPath:[NSIndexPath indexPathForItem:item+1 inSection:0]];

    //获得左边cell的图片
    KYParallaxVerticalView *leftPvv = [leftCell.contentView.subviews firstObject];
    leftParallaxImageView =  leftPvv.bkgImageView;
    //获得右边cell的图片
    KYParallaxVerticalView *rightPvv = [rightCell.contentView.subviews firstObject];
    rightParallaxImageView = rightPvv.bkgImageView;
    
    leftParallaxImageView.frame = CGRectMake(cv.contentOffset.x - cv.frame.size.width*item, 0, leftCell.frame.size.width - (cv.contentOffset.x - cv.frame.size.width*item), leftCell.frame.size.height);
    rightParallaxImageView.frame = CGRectMake(0, 0, cv.contentOffset.x - cv.frame.size.width*item - lat.separatorWidth, rightCell.frame.size.height);

}





@end
