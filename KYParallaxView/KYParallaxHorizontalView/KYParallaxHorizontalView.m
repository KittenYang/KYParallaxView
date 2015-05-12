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
    CGRect collectionFrame = frame;
    collectionFrame.size.width = collectionFrame.size.width + 6.0;
    self = [super initWithFrame:frame];
    if (self) {
        UIViewController *vc = (UIViewController *)delegate;
        vc.automaticallyAdjustsScrollViewInsets = NO; //避免放入Navigation之后产生奇怪的偏移
        [self initViews:collectionFrame delegate:delegate];
    }
    return self;
}


-(void)initViews:(CGRect)frame delegate:(id<UICollectionViewDataSource,UICollectionViewDelegate>)delegate{

    UICollectionViewFlowLayout *l = [[UICollectionViewFlowLayout alloc]init];
    l.itemSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height);
    l.minimumLineSpacing = 6.0f;
    l.sectionInset = UIEdgeInsetsMake(0, 0, 0, 6.0);
    l.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *parallaxCollection = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:l];
    [parallaxCollection registerClass:[KYParallaxCollectionCell class] forCellWithReuseIdentifier:@"HorizontalParallexCell"];
    parallaxCollection.delegate = delegate;
    parallaxCollection.dataSource = delegate;
    parallaxCollection.pagingEnabled = YES;
    
    [self addSubview:parallaxCollection];
}

-(void)parallax:(UIScrollView *)horizontalView{
    
    UICollectionView *cv = (UICollectionView *)horizontalView;

    item = cv.contentOffset.x / cv.frame.size.width;
    NSLog(@"item:%ld",(long)item);

    KYParallaxCollectionCell *leftCell = (KYParallaxCollectionCell *)[cv cellForItemAtIndexPath:[NSIndexPath indexPathForItem:item inSection:0]];
    KYParallaxCollectionCell *rightCell = (KYParallaxCollectionCell *)[cv cellForItemAtIndexPath:[NSIndexPath indexPathForItem:item+1 inSection:0]];

    NSLog(@"%@",NSStringFromCGRect(leftCell.frame));
    
    //获得左边cell的图片
    KYParallaxVerticalView *leftPvv = [leftCell.contentView.subviews firstObject];
    leftParallaxImageView =  leftPvv.bkgImageView;
    //获得右边cell的图片
    KYParallaxVerticalView *rightPvv = [rightCell.contentView.subviews firstObject];
    rightParallaxImageView = rightPvv.bkgImageView;
    
    leftParallaxImageView.frame = CGRectMake(cv.contentOffset.x - cv.frame.size.width*item, 0, leftCell.frame.size.width - (cv.contentOffset.x - cv.frame.size.width*item), leftCell.frame.size.height);
    rightParallaxImageView.frame = CGRectMake(0, 0, cv.contentOffset.x - cv.frame.size.width*item - 6, rightCell.frame.size.height);

}





@end
