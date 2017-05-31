//
//  ViewController.m
//  UIScrollViewDemo
//
//  Created by pk on 14/11/24.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>{
    UIScrollView* _scrollView;
    UIPageControl* _pageControl;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_scrollView];
    
    for (int i = 0; i < 5; i++) {
        //缩放
        UIScrollView* sv = [[UIScrollView alloc] initWithFrame:CGRectMake(i * self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        sv.tag = 10;
        sv.minimumZoomScale = 1.0;
        sv.maximumZoomScale = 2.0;
        sv.delegate = self;
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"10_%d.jpg",i]];
        [sv addSubview:imageView];
        [_scrollView addSubview:sv];
    }
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(100, 100, 100, 40);
    [button setTitle:@"button" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:button];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 40, self.view.frame.size.width, 20)];
    //总共页数
    _pageControl.numberOfPages = 5;
    //当前页数
    _pageControl.currentPage = 0;
    //颜色
    _pageControl.pageIndicatorTintColor = [UIColor blueColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    [_pageControl addTarget:self action:@selector(nextPage) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_pageControl];
    
    //真实内容大小(设置了这个属性才能滑动)
    _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 5, self.view.bounds.size.height);
    //偏移量
    _scrollView.contentOffset = CGPointMake(0, 0);
    //额外区域大小
    //_scrollView.contentInset = UIEdgeInsetsMake(0, 100, 0, 0);
    /*
    //分页属性
    _scrollView.pagingEnabled = YES;
    //锁定滑动的方向
    _scrollView.directionalLockEnabled = YES;
    //反弹效果
    _scrollView.bounces = YES;
    //在垂直方向总保持反弹(bounces==YES)
    _scrollView.alwaysBounceVertical = YES;
    //滑动效果开关
    _scrollView.scrollEnabled = YES;
    //显示水平方向的滑动条
    _scrollView.showsHorizontalScrollIndicator = NO;
    //滑动条位置
    _scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 100, 100, 100);
    //滑动条类型
    _scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    //减速速度 0~1
    _scrollView.decelerationRate = 1;
    */
    //代理
    _scrollView.delegate = self;
    
    
}

//下一页
- (void)nextPage{
    [_scrollView setContentOffset:CGPointMake(self.view.bounds.size.width * _pageControl.currentPage, 0) animated:YES];
}

- (void)buttonClick{
    [_scrollView setContentOffset:CGPointMake(self.view.bounds.size.width * 4, 0) animated:YES];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    if (scrollView.tag == 10) {
        NSArray* array = scrollView.subviews;
        for (UIView* view in array) {
            if ([view isKindOfClass:[UIImageView class]]) {
                return view;
            }
        }
    }
    return nil;
}

//只要滑动就会调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //NSLog(@"%f",scrollView.contentOffset.x);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"将要开始拖拽");
}

//布尔值代表了拖拽结束后有没有减速过程
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    NSLog(@"已经结束拖拽");
    if (decelerate == NO) {
        //做一些滑动完成后的操作
    }
}

//有拖拽，减速过程不一定有
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    NSLog(@"将要开始减速");
}

//结束减速
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //做一些滑动完成后的操作
    _pageControl.currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
}

//结束动画
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSLog(@"结束动画调用");
}

//允许不允许滑动到顶端
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView{
    return YES;
}

//滑动到顶端
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView{
    NSLog(@"已经滑动到顶端");
}


@end
