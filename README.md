
<p align="left" >
  <img src="logo.png" alt="KYParallaxView" title="KYParallaxView">
</p>


![CocoaPods Version](https://img.shields.io/badge/pod-v1.0.2-brightgreen.svg)
![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Platform](https://img.shields.io/badge/platform-iOS-red.svg)




一个

**1.使用简单** 

**2.高度自定义**

**3.两种使用方法** 

的视差滚动框架 

it's a easy-to-use / highly customize / two way to use parallax effects framework.

![](parallax.gif)


##安装 Installation
---
`pod 'KYParallaxView', '~> 1.0.2'`

---


##本框架有两种使用场景：

Two situations to use this framework：

##1、如果你不需要使用水平滚动的框架，只需要使用效果图中单页垂直滚动效果，那么你只需在你的ViewController中。 


  If you just wanna use the single vertical scroll view,you should:

```objective-c
    KYParallaxVerticalView *parallaxVerticalView= [[KYParallaxVerticalView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:parallaxVerticalView];
    [parallaxVerticalView bkgImageViewSetImage: [UIImage imageNamed:@"bkgImg@2x.jpg"]];// 指定背景图

```
    就可以了。

    That's it!



##2、如果你需要使用整个框架，那么你需要在你的ViewController中：

     If you wanna use the whole framework.

```objective-c
  KYParallaxHorizontalView *parallaxHorizontalView = [[KYParallaxHorizontalView alloc]initWithFrame:self.view.frame andCollectionDelegate:self];
  [self.view addSubview:self.parallaxHorizontalView];

```


- 然后实现UICollectionDataSource的协议方法： 

    Then implement the UICollectionDataSource's protocol method:

```objective-c
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

```


- 最后你还需要实现UIScrollViewDelegate中的scrollViewDidScroll方法： 

    Lastly,you should mplement the UIScrollViewDelegate's protocol method
```objective-c
#pragma mark -- UITableViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.parallaxHorizontalView parallax:scrollView];
}
```

##3.如何自定义单页滚动视图内容？

    How to customize the vertical scroll view's  content?

- 你会发现有三个文件. there are three files.

![](customView.png)

- 你会发现CustomViewXib是这样的：

  So you can customize your content in the xib.

![](customViewXib.png)


- 是的，你可以在这里可视化布局你想要的滚动界面的内容。当然，为了方便自定义内容你还需要把这些视图拖到代码中来：

  Also you can use IBOutlet to connect the xib and the code.

```objective-c
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UIView *box1;
@property (strong, nonatomic) IBOutlet UIView *box2;
@property (strong, nonatomic) IBOutlet UIView *box3;
@property (strong, nonatomic) IBOutlet UIImageView *avatar;
@property (strong, nonatomic) IBOutlet UIImageView *pic;

```


