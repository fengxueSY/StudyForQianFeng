//
//  ViewController.m
//  UIScrollViewZoomDemo
//
//  Created by pk on 14/11/24.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>{
    UIImageView* _imageView;
    UIScrollView* _scrollView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.delegate = self;
    //最小缩放比例
    _scrollView.minimumZoomScale = 1.0;
    //最大缩放比例
    _scrollView.maximumZoomScale = 2.0;
    //缩放反弹效果
    _scrollView.bouncesZoom = NO;
    [self.view addSubview:_scrollView];
    
    _imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _imageView.image = [UIImage imageNamed:@"10_0.jpg"];
    [_scrollView addSubview:_imageView];
}

//返回值就代表需要缩放的view
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _imageView;
}

//将要开始缩放
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view{

}

//结束缩放
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{

}


@end
