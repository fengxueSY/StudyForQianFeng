//
//  ViewController.m
//  UISpliteViewControllerDemo
//
//  Created by pk on 14/12/23.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    UIPopoverController* _pc;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"vc";
    self.view.backgroundColor = [UIColor whiteColor];

    self.label = [[UILabel alloc] initWithFrame:CGRectMake(200, 200, 200, 50)];
    self.label.font = [UIFont boldSystemFontOfSize:30.0];
    [self.view addSubview:self.label];
    
    UIViewController* vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    UINavigationController* nc = [[UINavigationController alloc] initWithRootViewController:vc];
    
    _pc = [[UIPopoverController alloc] initWithContentViewController:nc];
    //设置窗口大小
    [_pc setPopoverContentSize:CGSizeMake(300, 300)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"pop" style:UIBarButtonItemStylePlain target:self action:@selector(pop:)];
    
}

- (void)pop:(UIBarButtonItem*)button{
    //弹出窗口 1
    //[_pc presentPopoverFromBarButtonItem:button permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    //弹出窗口 2
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 200, 200)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    
    [_pc presentPopoverFromRect:view.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}



@end
