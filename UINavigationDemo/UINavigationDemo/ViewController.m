//
//  ViewController.m
//  UINavigationDemo
//
//  Created by pk on 14/11/18.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    UINavigationBar* _navigationBar;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.view.backgroundColor = [UIColor redColor];

    //UINavigationBar view
    _navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    //半透明
    _navigationBar.translucent = YES;
    //渲染颜色
    _navigationBar.tintColor = [UIColor orangeColor];
    //背景颜色
    _navigationBar.backgroundColor = [UIColor greenColor];
    //背景图片
    [_navigationBar setBackgroundImage:[UIImage imageNamed:@"top.png"] forBarMetrics:UIBarMetricsDefault];
    [self.view addSubview:_navigationBar];
    
    //UINavigationItem model
    UINavigationItem* item = [[UINavigationItem alloc] initWithTitle:@"主页"];
    //标题
    item.title = @"🐷✌️";
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.textColor = [UIColor redColor];
    label.text = @"主页";
    item.titleView = label;
    //右边按钮
    UIBarButtonItem* button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(buttonClick)];
    item.rightBarButtonItem = button;
    
    //[_navigationBar->_itemStack addObject:item];
    [_navigationBar pushNavigationItem:item animated:NO];
}

- (void)buttonClick{
    UINavigationItem* item = [[UINavigationItem alloc] initWithTitle:@"第二页"];
    [_navigationBar pushNavigationItem:item animated:YES];
    //Title
    //UIBarButtonItem* leftButton = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    //Image
    UIBarButtonItem* leftButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"00.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    //[[UIBarButtonItem alloc] initWithCustomView:
    item.leftBarButtonItem = leftButton;
}

//返回
- (void)back{
    [_navigationBar popNavigationItemAnimated:YES];
}


@end
