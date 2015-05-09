//
//  KYParallaxHorizontalView.m
//  KYParallaxViewDemo
//
//  Created by Kitten Yang on 5/9/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import "KYParallaxHorizontalView.h"
#import "KYParallaxCollectionLayout.h"


@interface KYParallaxHorizontalView()<UIScrollViewDelegate>

@end

@implementation KYParallaxHorizontalView{
    KYParallaxCollectionLayout *layout;
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
    [parallaxCollection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"collectionCell"];
    parallaxCollection.delegate = delegate;
    parallaxCollection.dataSource = delegate;
    parallaxCollection.pagingEnabled = YES;
    
    [self addSubview:parallaxCollection];
    
}

-(void)parallax:(UIScrollView *)horizontalView{
    NSLog(@"parallax");
    
    UICollectionView *cv = (UICollectionView *)horizontalView;
    
}

@end
