//
//  ViewController3.m
//  UINavigationDemo
//
//  Created by pk on 14/11/18.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "ViewController3.h"

@interface ViewController3 ()

@end

@implementation ViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"vc3";
    self.view.backgroundColor = [UIColor purpleColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"home" style:UIBarButtonItemStylePlain target:self action:@selector(buttonClick)];
    
    //返回隐藏按钮
    //[self.navigationItem setHidesBackButton:YES];
    
    //让self.view的0,0点放到导航的下面
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view];
}

- (void)buttonClick{
    //返回到上一页
    //[self.navigationController popViewControllerAnimated:YES];
    //返回到第一页
    //[self.navigationController popToRootViewControllerAnimated:YES];
    //返回到某一页
    [self.navigationController popToViewController:self.navigationController.viewControllers[0] animated:YES];
}
     
     
     


@end
