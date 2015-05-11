//
//  KYParallaxHorizontalView.h
//  KYParallaxViewDemo
//
//  Created by Kitten Yang on 5/9/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KYParallaxCollectionCell.h"

@interface KYParallaxHorizontalView : UIView

-(id)initWithFrame:(CGRect)frame andCollectionDelegate:(id<UICollectionViewDataSource,UICollectionViewDelegate>)delegate;

-(void)parallax:(UIScrollView *)horizontalView;

@end
