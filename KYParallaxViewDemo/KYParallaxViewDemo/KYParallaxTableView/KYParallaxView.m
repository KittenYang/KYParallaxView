//
//  KYParallaxView.m
//  KYParallaxViewDemo
//
//  Created by Kitten Yang on 5/9/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import "KYParallaxView.h"
#import "CustomViews.h"

@interface KYParallaxView()


@end

@implementation KYParallaxView

-(id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        [self initViews:(CGRect)frame];
    }
    return self;
    
}

-(void)initViews:(CGRect)frame{
    UIScrollView *backgroundScrollView = [[UIScrollView alloc]initWithFrame:frame];
    backgroundScrollView.backgroundColor = [UIColor blueColor];
    [self addSubview:backgroundScrollView];
    
    
    self.bkgImageView = [[UIImageView alloc]initWithFrame:backgroundScrollView.frame];
    [backgroundScrollView addSubview:self.bkgImageView];
    
    //添加黑色渐变阴影
    UIColor *topColor = [UIColor clearColor];
    UIColor *bottomColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    NSArray *gradientColors = [NSArray arrayWithObjects:(id)topColor.CGColor, (id)bottomColor.CGColor, nil];
    NSArray *gradientLocations = [NSArray arrayWithObjects:[NSNumber numberWithInt:0.0],[NSNumber numberWithInt:1.0], nil];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = gradientColors;
    gradientLayer.locations = gradientLocations;
    gradientLayer.frame = frame;
    [self.bkgImageView.layer insertSublayer:gradientLayer atIndex:0];
    
    self.scroller = [[UIScrollView alloc]initWithFrame:frame];
    [self insertSubview:self.scroller aboveSubview:backgroundScrollView];
    
    //添加自定义视图
    CustomViews *customView = [[CustomViews alloc]initWithUseNib:YES];
    self.scroller.contentSize = customView.bounds.size;
    [self.scroller addSubview:customView];
    
    
}





@end
