//
//  KYParallaxVerticalView .m
//  KYParallaxViewDemo
//
//  Created by Kitten Yang on 5/9/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//
#define TAG_BKGSCROLLVIEW  10086
#define TAG_BLUR_IMAGEVIEW 10000
#define TAG_GRADIENTVIEW   12580


#define DEFAULT_BLUR_RADIUS 14
#define DEFAULT_BLUR_TINT_COLOR [UIColor colorWithWhite:0 alpha:.3]
#define DEFAULT_BLUR_DELTA_FACTOR 1.4


#import "KYParallaxVerticalView.h"
#import <Accelerate/Accelerate.h>

@interface KYParallaxVerticalView()<UIScrollViewDelegate>

@property (nonatomic,strong)UIImageView *bkgImageView;

@end

@implementation KYParallaxVerticalView{
    UIImageView *blurBkgImgView;
}

-(id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        [self initViews:(CGRect)frame];
    }
    return self;
    
}

-(void)initViews:(CGRect)frame{
    UIScrollView *bkgScrollView = [[UIScrollView alloc]initWithFrame:frame];
    bkgScrollView.tag = TAG_BKGSCROLLVIEW;
    bkgScrollView.delegate = self;
    bkgScrollView.minimumZoomScale = 1.0f;
    bkgScrollView.maximumZoomScale = 2.0f;
    [self addSubview:bkgScrollView];
    
    
    //添加显现内容的滚动视图  Add a scroll view
    self.scroller = [[UIScrollView alloc]initWithFrame:frame];
    self.scroller.delegate = self;
    [self insertSubview:self.scroller aboveSubview:bkgScrollView];
    
    //添加自定义视图 Add custom view which show the vertical scroll view's content
    self.customView = [[CustomViews alloc]initWithUseNib:YES withSuperViewFrame:frame];
    self.scroller.contentSize = self.customView.bounds.size;
    [self.scroller addSubview:self.customView];
    
    
    //添加背景图片视图 Add backgroundImage view
    self.bkgImageView = [[UIImageView alloc]initWithFrame:bkgScrollView.frame];
    self.bkgImageView.contentMode = UIViewContentModeCenter;
    [bkgScrollView addSubview:self.bkgImageView];
    
    //添加模糊视图 Add blured image view
    blurBkgImgView = [[UIImageView alloc]initWithFrame:self.bkgImageView.frame];
    [self.bkgImageView addSubview:blurBkgImgView];
    blurBkgImgView.alpha = 0.0f;
    blurBkgImgView.tag = TAG_BLUR_IMAGEVIEW;
    
    //添加黑色渐变阴影到模糊之后的图像上  Add gradientLayer to the blured image
    UIColor *topColor = [UIColor clearColor];
    UIColor *bottomColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    NSArray *gradientColors = [NSArray arrayWithObjects:(id)topColor.CGColor, (id)bottomColor.CGColor, nil];
    NSArray *gradientLocations = [NSArray arrayWithObjects:[NSNumber numberWithInt:0.0],[NSNumber numberWithInt:1.0], nil];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = gradientColors;
    gradientLayer.locations = gradientLocations;
    gradientLayer.frame = blurBkgImgView.frame;
    UIView *gradientView = [[UIView alloc]initWithFrame:blurBkgImgView.frame];
    gradientView.alpha = 0.0f;
    gradientView.tag = TAG_GRADIENTVIEW;
    [gradientView.layer addSublayer:gradientLayer];
    [self insertSubview:gradientView belowSubview:self.scroller];

}

-(void)bkgImageViewSetImage:(UIImage *)image{

    //set background image
    self.bkgImageView.image = image;

    //set blur background image
    UIImage *blurImage  = [self blurImage:image WithRadius:0.5];
    blurBkgImgView.image = blurImage;

}

//模糊算法
- (UIImage *)blurImage:(UIImage *)image WithRadius:(CGFloat)blurRadius
{
    if ((blurRadius < 0.0f) || (blurRadius > 1.0f)) {
        blurRadius = 0.5f;
    }
    int boxSize = (int)(blurRadius * 100);
    boxSize    -= (boxSize % 2) + 1;
    
    CGImageRef rawImage = image.CGImage;
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error  error;
    void *pixelBuffer;
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(rawImage);
    CFDataRef inBitmapData       = CGDataProviderCopyData(inProvider);
    
    inBuffer.width     = CGImageGetWidth(rawImage);
    inBuffer.height    = CGImageGetHeight(rawImage);
    inBuffer.rowBytes  = CGImageGetBytesPerRow(rawImage);
    inBuffer.data      = (void *)CFDataGetBytePtr(inBitmapData);
    pixelBuffer        = malloc(CGImageGetBytesPerRow(rawImage) * CGImageGetHeight(rawImage));
    
    outBuffer.data     = pixelBuffer;
    outBuffer.width    = CGImageGetWidth(rawImage);
    outBuffer.height   = CGImageGetHeight(rawImage);
    outBuffer.rowBytes = CGImageGetBytesPerRow(rawImage);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    if (error) {
        NSLog(@"error for convolution %ld",error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx           = CGBitmapContextCreate(outBuffer.data, outBuffer.width, outBuffer.height, 8, outBuffer.rowBytes, colorSpace, CGImageGetBitmapInfo(image.CGImage));
    CGImageRef imageRef        = CGBitmapContextCreateImage(ctx);
    UIImage *returnImage       = [UIImage imageWithCGImage:imageRef];
    
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    free(pixelBuffer);
    CFRelease(inBitmapData);
    CGImageRelease(imageRef);
    
    return returnImage;
}


#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.tag == TAG_BKGSCROLLVIEW) {
        return;
    }
    
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    
    UIImageView *blurImgView = (UIImageView *)[self.bkgImageView viewWithTag:TAG_BLUR_IMAGEVIEW];
    blurImgView.alpha = contentOffsetY / 300;
    
    UIView *gradientView = [self viewWithTag:TAG_GRADIENTVIEW];
    gradientView.alpha = contentOffsetY / 300;
    
    UIScrollView * bkgScrollView = (UIScrollView *)[self viewWithTag:TAG_BKGSCROLLVIEW];
    bkgScrollView.zoomScale = 1 +  + (fabs(MIN(contentOffsetY,0))/200.0f);
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.bkgImageView;
}



@end
