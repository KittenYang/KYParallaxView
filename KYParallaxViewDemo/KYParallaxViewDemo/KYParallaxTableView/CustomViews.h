//
//  CustomViews.h
//  KYParallaxViewDemo
//
//  Created by Kitten Yang on 5/9/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomViews : UIView

@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UIView *box1;
@property (strong, nonatomic) IBOutlet UIView *box2;
@property (strong, nonatomic) IBOutlet UIView *box3;


-(id)initWithUseNib:(BOOL)useNib;
@end
