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
    UICollectionViewCell *currentCell;
    UIImageView *parallaxImageView;
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
    NSInteger item = cv.contentOffset.x / cv.frame.size.width;
//    NSLog(@"%ld",(long)item);
//    NSLog(@"%@",[NSIndexPath indexPathForItem:item inSection:0]);
    UICollectionViewCell *cell = [cv cellForItemAtIndexPath:[NSIndexPath indexPathForItem:item inSection:0]];

    if (cell != nil && cell != currentCell ) {
        currentCell = cell;
        KYParallaxVerticalView *pvv = [currentCell.contentView.subviews firstObject];
        parallaxImageView =  pvv.bkgImageView; //获得左边cell的图片
        NSLog(@"%@",parallaxImageView);
    }
    
//    parallaxImageView.frame = CGRectMake(cv.contentOffset.x - cv.frame.size.width*item, 0, parallaxImageView.frame.size.width - (cv.contentOffset.x - cv.frame.size.width*item), parallaxImageView.frame.size.height);
}





@end
