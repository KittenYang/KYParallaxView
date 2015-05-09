//
//  KYParallaxTableView.h
//  KYParallaxViewDemo
//
//  Created by Kitten Yang on 5/9/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface KYParallaxView : UIView

@property (nonatomic,strong)UIScrollView *scroller;
@property (nonatomic,strong)NSString *CellReuseIdentifier;

-(void)bkgImageViewSetImage:(UIImage *)image;

@end
