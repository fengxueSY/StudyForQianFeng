//
//  DrawerViewController.m
//  TVProgramList
//
//  Created by PK on 14-5-31.
//  Copyright (c) 2014年 PK. All rights reserved.
//

#import "DrawerViewController.h"

#define SPEED 100;

@interface DrawerViewController (){

}

@end

@implementation DrawerViewController

- (id)initWithRootViewController:(UIViewController *)rootViewController{
    if (self = [super init]) {
        self.rootViewController = rootViewController;
        self.contentOffWidth = 100.0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.rootViewController.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view addSubview:self.rootViewController.view];
    
    UIPanGestureRecognizer* pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.rootViewController.view addGestureRecognizer:pan];
}

- (void)pan:(UIPanGestureRecognizer*)pan{
    CGPoint point = [pan translationInView:self.view];
    [pan setTranslation:CGPointZero inView:self.view];
    if (self.leftView == nil) {
        if (self.rootViewController.view.frame.origin.x >= 0&& point.x > 0) {
            point.x = 0;
        }
    }
    if (self.rightView == nil) {
        if (self.rootViewController.view.frame.origin.x <= 0&& point.x < 0) {
            point.x = 0;
        }
    }
    
    self.rootViewController.view.center = CGPointMake(self.rootViewController.view.center.x + point.x, self.rootViewController.view.center.y);
    if (pan.state == UIGestureRecognizerStateEnded) {
        UIView* view = self.rootViewController.view;
        CGPoint endPoint;
        float width;
        if (view.frame.origin.x > 0) {
            //right
            if (view.frame.origin.x < self.contentOffWidth/2) {
                endPoint = CGPointMake(0, 0);
                width = view.frame.origin.x;
            } else {
                endPoint = CGPointMake(self.contentOffWidth, 0);
                width = self.contentOffWidth - view.frame.origin.x;
            }
            
        } else {
            //left
            float xOffset = fabsf(view.frame.origin.x);
            if (xOffset < self.contentOffWidth/2) {
                endPoint = CGPointMake(0, 0);
                width = xOffset;
            } else {
                endPoint = CGPointMake(-1 * self.contentOffWidth, 0);
                width = self.contentOffWidth - xOffset;
            }
        }
        float time = width/SPEED;
        [UIView animateWithDuration:time delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            view.frame = CGRectMake(endPoint.x, endPoint.y, view.frame.size.width, view.frame.size.height);
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    CGSize winSize = [[UIScreen mainScreen] bounds].size;
    if (self.leftView) {
        self.leftView.frame = CGRectMake(0, 0, self.contentOffWidth, self.leftView.frame.size.height);
        if ([self.view isDescendantOfView:self.leftView]) {
            [self.leftView removeFromSuperview];
        }
        [self.view addSubview:self.leftView];
        [self.view sendSubviewToBack:self.leftView];
    }
    if (self.rightView) {
        self.rightView.frame = CGRectMake(winSize.width-self.contentOffWidth, 0, self.contentOffWidth, self.rightView.frame.size.height);
        if ([self.view isDescendantOfView:self.rightView]) {
            [self.rightView removeFromSuperview];
        }
        [self.view addSubview:self.rightView];
        [self.view sendSubviewToBack:self.rightView];
    }
}

- (void)leftOpen{
    UIView* view = self.rootViewController.view;
    float x;
    if (view.frame.origin.x == 0) {
        x = self.contentOffWidth;
    } else {
        x = 0;
    }
    float time = self.contentOffWidth/SPEED;
    time/=2;
    [UIView animateWithDuration:time delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        view.frame = CGRectMake(x, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)rightOpen{
    UIView* view = self.rootViewController.view;
    float x;
    if (view.frame.origin.x == 0) {
        x = -1 * self.contentOffWidth;
    } else {
        x = 0;
    }
    float time = self.contentOffWidth/SPEED;
    time/=2;
    [UIView animateWithDuration:time delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        view.frame = CGRectMake(x, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
}


@end
