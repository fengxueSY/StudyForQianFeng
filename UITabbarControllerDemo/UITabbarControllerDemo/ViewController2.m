//
//  ViewController2.m
//  UITabbarControllerDemo
//
//  Created by pk on 14/11/20.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "ViewController2.h"

@interface ViewController2 ()

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"vc2");
    self.title = @"vc2";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:nil];
    self.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemDownloads tag:1];
}




@end
