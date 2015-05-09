//
//  CustomViews.m
//  KYParallaxViewDemo
//
//  Created by Kitten Yang on 5/9/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import "CustomViews.h"

@interface CustomViews()



@end

@implementation CustomViews


-(id)initWithUseNib:(BOOL)useNib{
    self = [super init];
    if (self) {
        if (useNib) {
            self = [[[NSBundle mainBundle]loadNibNamed:@"CustomViews" owner:self options:nil]firstObject];
            self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.bounds.size.height);
            [self layoutIfNeeded];
        }
        [self customViews:(BOOL)useNib];
    }
    return self;
}

-(void)customViews:(BOOL)useNib{

    
    if (!useNib) {
        self.frame = CGRectMake(0, 0, 320, 705+300);
        
        UIView *box0 = [[UIView alloc] initWithFrame:CGRectMake(5, 5, 310, 300)];
        box0.layer.cornerRadius = 3;
        box0.backgroundColor = [UIColor colorWithWhite:0 alpha:.0];
        [self addSubview:box0];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5+300, 310, 120)];
        [label setText:[NSString stringWithFormat:@"%i℉",arc4random_uniform(20) + 60]];
        [label setTextColor:[UIColor whiteColor]];
        [label setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:120]];
        [label setShadowColor:[UIColor blackColor]];
        [label setShadowOffset:CGSizeMake(1, 1)];
        [self addSubview:label];
        
        UIView *box1 = [[UIView alloc] initWithFrame:CGRectMake(5, 140+300, 310, 125)];
        box1.layer.cornerRadius = 3;
        box1.backgroundColor = [UIColor colorWithWhite:0 alpha:.15];
        [self addSubview:box1];
        
        UIView *box2 = [[UIView alloc] initWithFrame:CGRectMake(5, 270+300, 310, 300)];
        box2.layer.cornerRadius = 3;
        box2.backgroundColor = [UIColor colorWithWhite:0 alpha:.15];
        [self addSubview:box2];
        
        UIView *box3 = [[UIView alloc] initWithFrame:CGRectMake(5, 575+300, 310, 125)];
        box3.layer.cornerRadius = 3;
        box3.backgroundColor = [UIColor colorWithWhite:0 alpha:.15];
        [self addSubview:box3];
        
    }else{
    
        
        [self.label setTextColor:[UIColor whiteColor]];
        [self.label setShadowColor:[UIColor blackColor]];
        [self.label setShadowOffset:CGSizeMake(1, 1)];
        
        self.box1.layer.cornerRadius = 3;
        self.box1.backgroundColor = [UIColor colorWithWhite:0 alpha:.15];
        
        self.box2.layer.cornerRadius = 3;
        self.box2.backgroundColor = [UIColor colorWithWhite:0 alpha:.15];
        
        self.box3.layer.cornerRadius = 3;
        self.box3.backgroundColor = [UIColor colorWithWhite:0 alpha:.15];
    
    }
    
    

    
}

@end
