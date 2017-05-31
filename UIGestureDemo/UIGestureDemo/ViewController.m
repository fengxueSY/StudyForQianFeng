//
//  ViewController.m
//  UIGestureDemo
//
//  Created by pk on 14/11/20.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    UIImageView* _imageView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(170, 250, 48, 114)];
    _imageView.image = [UIImage imageNamed:@"player.png"];
    [self.view addSubview:_imageView];
    _imageView.userInteractionEnabled = YES;
    
    //轻触手势
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    //次数
    tap.numberOfTapsRequired = 1;
    //多点
    tap.numberOfTouchesRequired = 2;
    //添加一个手势
    //[_imageView addGestureRecognizer:tap];
    
    //长按手势
    UILongPressGestureRecognizer* longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    //[_imageView addGestureRecognizer:longPress];
    
    //移动手势
    UIPanGestureRecognizer* pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    //[_imageView addGestureRecognizer:pan];
    
    //捏合手势
    UIPinchGestureRecognizer* pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    //[_imageView addGestureRecognizer:pinch];
    
    //旋转手势
    UIRotationGestureRecognizer* rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotation:)];
    [_imageView addGestureRecognizer:rotation];
    
    UISwipeGestureRecognizer* swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    //方向
    swipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [_imageView addGestureRecognizer:swipe];
    
    UISwipeGestureRecognizer* swipe2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    //方向
    swipe2.direction = UISwipeGestureRecognizerDirectionRight;
    [_imageView addGestureRecognizer:swipe2];
}

- (void)swipe:(UISwipeGestureRecognizer*)swipe{
    NSLog(@"滑动");
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        NSLog(@"向左");
    }
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"向右");
    }
}

//旋转
- (void)rotation:(UIRotationGestureRecognizer*)rotation{
    //NSLog(@"%f",rotation.rotation);
    _imageView.transform = CGAffineTransformRotate(_imageView.transform, rotation.rotation);
    [rotation setRotation:0];
}

- (void)pinch:(UIPinchGestureRecognizer*)pinch{
    //pinch.scale 缩放比例
    //100 1.1 1.2 1.3 1.4
    //100 * 1.4      100 * 1.1 * 1.2 * 1.3 * 1.4
    //100 1.1 1.1
    //    110
    _imageView.bounds = CGRectMake(0, 0, _imageView.bounds.size.width * pinch.scale, _imageView.bounds.size.height * pinch.scale);
    //每次比例都按上一次缩放得到的结果去计算
    [pinch setScale:1];
}

//移动
- (void)pan:(UIPanGestureRecognizer*)pan{
    //偏移量
    CGPoint point = [pan translationInView:self.view];
    _imageView.center = CGPointMake(_imageView.center.x + point.x, _imageView.center.y + point.y);
    /*
     0 1 2 3 4 5
     0 0 0 0 0 0
     */
    //清空偏移量
    [pan setTranslation:CGPointZero inView:self.view];
}

- (void)longPress:(UILongPressGestureRecognizer*)longPress{
    if (longPress.state == UIGestureRecognizerStateBegan) {
        NSLog(@"开始长按");
    }
    if (longPress.state == UIGestureRecognizerStateChanged) {
        NSLog(@"位置改变");
    }
    if (longPress.state == UIGestureRecognizerStateEnded) {
        NSLog(@"长按结束");
    }
}

- (void)tap:(UITapGestureRecognizer*)tap{
    //view 就代表触发手势的视图 _imageView
    //tap.view
    NSLog(@"轻触");
}








@end
