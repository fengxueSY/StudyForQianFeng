//
//  AppDelegate.m
//  BlockDemo
//
//  Created by pk on 14/11/14.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

int add(int a, int b){
    return a + b;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window.backgroundColor = [UIColor whiteColor];
    //函数指针
    int (*addAlias)(int,int) = add;
    //NSLog(@"%d", addAlias(3, 4));
    
    //Block
    int (^addBlock)(int,int) = ^(int a, int b){
        return a + b;
    };
    NSLog(@"%d", addBlock(3, 4));
    
    __block int num = 10;
    void (^ocBlock)() = ^{
        NSLog(@"%d", num); //num=10
    };
    num = 5;
    ocBlock();
    
    
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 100, 100)];
    view.tag = 10;
    view.backgroundColor = [UIColor redColor];
    [self.window addSubview:view];
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(100, 350, 100, 40);
    [button setTitle:@"点我" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.window addSubview:button];
    
    
    return YES;
}

- (void)buttonClick{
    UIView* view = [self.window viewWithTag:10];
     //开始动画
    [UIView beginAnimations:nil context:nil];
    //动画时间
    [UIView setAnimationDuration:2.0];
    //设置代理
    [UIView setAnimationDelegate:self];
    //动画结束调用方法
    [UIView setAnimationDidStopSelector:@selector(animationStop)];
    //大小，位置，alpha值（1可见-0不可见），颜色
    //view.hidden = YES;
    //view.alpha = 0.0;
    view.backgroundColor = [UIColor blueColor];
    //开始动画
    [UIView commitAnimations];
}

- (void)animationStop{
    UIView* view = [self.window viewWithTag:10];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:2.0];
    view.backgroundColor = [UIColor redColor];
    [UIView commitAnimations];
}





@end
