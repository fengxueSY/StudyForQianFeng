//
//  RootViewController.m
//  UIViewControllerDemo
//
//  Created by pk on 14/11/17.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "RootViewController.h"
#import "MySwitch.h"

@interface RootViewController ()<MySwitchDelegate>

@end

@implementation RootViewController
//UIViewController 生命周期
- (instancetype)init{
    if (self = [super init]) {
        NSLog(@"init");
    }
    return self;
}

//创建self.view这个视图的,一般我们要自定义self.view的时候，再来重写
- (void)loadView{
    [super loadView];
    NSLog(@"loadView");
//    UIView* view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    view.backgroundColor = [UIColor redColor];
//    self.view = view;
    
}

//self.view视图已经加载完成,一般我们对视图的操作都写到这个方法里
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
    
    MySwitch* mySwitch = [[MySwitch alloc] initWithFrame:CGRectMake(100, 50, 100, 40)];
    mySwitch.delegate = self;
    [self.view addSubview:mySwitch];
    [mySwitch release];
}

- (void)changeColor:(UIColor *)color{
    self.view.backgroundColor = color;
}

- (void)viewWillAppear:(BOOL)animated{
    NSLog(@"视图将要显示");
}

- (void)viewDidAppear:(BOOL)animated{
    NSLog(@"视图已经显示");
}

- (void)viewWillDisappear:(BOOL)animated{
    NSLog(@"视图将要消失");
}

- (void)viewDidDisappear:(BOOL)animated{
    NSLog(@"视图已经消失");
}

//清理内存 当前视图没有显示&当前视图存活,当收到内存警告的时候，会调用这个方法来清理一些内存
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

//当前对象要被销毁
- (void)dealloc{
    [super dealloc];
}

@end
