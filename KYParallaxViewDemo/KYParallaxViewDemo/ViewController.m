//
//  ViewController.m
//  KYParallaxViewDemo
//
//  Created by Kitten Yang on 5/9/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import "ViewController.h"
#import "KYParallaxVerticalView.h"
#import "KYParallaxHorizontalView.h"
#import "KYParallaxCollectionLayout.h"
#import "KYParallaxCollectionCell.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong)KYParallaxVerticalView *parallaxVerticalView;
@property(nonatomic,strong)KYParallaxHorizontalView *parallaxHorizontalView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //如果只是需要加单页效果
    /*
    self.parallaxView= [[KYParallaxView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.parallaxView];
    [self.parallaxView bkgImageViewSetImage: [UIImage imageNamed:@"bkgImg@2x.jpg"]];
     */
    
    //如果是要加视差滚动的collectionView
    self.parallaxHorizontalView = [[KYParallaxHorizontalView alloc]initWithFrame:self.view.frame andCollectionDelegate:self];
    [self.view addSubview:self.parallaxHorizontalView];

}



#pragma mark -- UICollectionDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 5;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    KYParallaxCollectionCell *cell = (KYParallaxCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"HorizontalParallexCell" forIndexPath:indexPath];
    cell.verticalView.customView.label.text = [NSString stringWithFormat:@"第%ld页",(long)indexPath.item+1];
    cell.verticalView.customView.avatar.image = [UIImage imageNamed:[NSString stringWithFormat:@"kitten_%ld",(long)indexPath.item+1]];
    cell.verticalView.customView.pic.image = [UIImage imageNamed:[NSString stringWithFormat:@"l%ld.jpg",indexPath.item+1]];
    cell.verticalView.scroller.contentOffset = CGPointMake(0, 0); //解决cell同时复用scrollview位置的bug
    
    //...自定义cell视图
    
    return cell;
    
}

#pragma mark -- UITableViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.parallaxHorizontalView parallax:scrollView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
