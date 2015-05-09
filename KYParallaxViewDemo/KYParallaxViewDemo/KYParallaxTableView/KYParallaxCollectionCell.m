//
//  KYParallaxCollectionCell.m
//  KYParallaxViewDemo
//
//  Created by Kitten Yang on 5/10/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import "KYParallaxCollectionCell.h"


@implementation KYParallaxCollectionCell


-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.verticalView = [[KYParallaxVerticalView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self.verticalView bkgImageViewSetImage: [UIImage imageNamed:@"bkgImg.jpg"]];
        [self.contentView addSubview:self.verticalView];
    }
    return self;
}


@end
