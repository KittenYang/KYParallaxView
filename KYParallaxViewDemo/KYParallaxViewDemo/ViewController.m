//
//  ViewController.m
//  KYParallaxViewDemo
//
//  Created by Kitten Yang on 5/9/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import "ViewController.h"
#import "KYParallaxView.h"

@interface ViewController ()

@property(nonatomic,strong)KYParallaxView *parallaxView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.parallaxView= [[KYParallaxView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.parallaxView];
    self.parallaxView.bkgImageView.image = [UIImage imageNamed:@"bkgImg@2x.jpg"];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
