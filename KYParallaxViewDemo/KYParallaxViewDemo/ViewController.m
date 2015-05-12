//
//  ViewController.m
//  KYParallaxViewDemo
//
//  Created by Kitten Yang on 5/9/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import "ViewController.h"
#import "KYParallaxHorizontalView.h"


@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong)KYParallaxVerticalView *parallaxVerticalView;
@property(nonatomic,strong)KYParallaxHorizontalView *parallaxHorizontalView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //如果只是需要加单页效果
    //If you only wanna use the vertical scroll view
//    KYParallaxVerticalView *parallaxVerticalView= [[KYParallaxVerticalView alloc]initWithFrame:self.view.frame];
//    [self.view addSubview:parallaxVerticalView];
//    [parallaxVerticalView bkgImageViewSetImage: [UIImage imageNamed:@"bkgImg@2x.jpg"]];
    
    
    //如果是要加视差滚动的collectionView
    //If you only wanna both the vertical scroll view and the horizontal view
    self.parallaxHorizontalView = [[KYParallaxHorizontalView alloc]initWithFrame:self.view.frame andCollectionDelegate:self];
    [self.view addSubview:self.parallaxHorizontalView];

}



#pragma mark -- UICollectionDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 5;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    KYParallaxCollectionCell *cell = (KYParallaxCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"HorizontalParallexCell" forIndexPath:indexPath];

    /*****自定义cell视图*****/
    /*****Custom the vertical scrollview content******/
    //设置每个单页的背景图片 Set the background img of every vertical scrollview
    [cell.verticalView bkgImageViewSetImage:[UIImage imageNamed:[NSString stringWithFormat:@"bkgImg_%ld.jpg",(long)indexPath.item+1]]];
    cell.verticalView.customView.label.text = [NSString stringWithFormat:@"第%ld页",(long)indexPath.item+1];
    cell.verticalView.customView.avatar.image = [UIImage imageNamed:[NSString stringWithFormat:@"kitten_%ld",(long)indexPath.item+1]];
    cell.verticalView.customView.pic.image = [UIImage imageNamed:[NSString stringWithFormat:@"l%ld.jpg",indexPath.item+1]];
    cell.verticalView.scroller.contentOffset = CGPointMake(0, 0); //解决cell同时复用scrollview位置的bug  Fix resuing the contentOffset of cell
    
    //...
    
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
