//
//  ViewController.m
//  NSThreadDemo
//
//  Created by pk on 14/12/18.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(100, 100, 100, 40);
    [button setTitle:@"开启线程" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonClick:(UIButton*)button{
//    [self first];
//    [self second];
//    [self third];
    
    NSThread* thread = [[NSThread alloc] initWithTarget:self selector:@selector(first) object:nil];
    //名字
    thread.name = @"线程1";
    //优先级 0-1
    thread.threadPriority = 0.5;
    [thread start];
    
    //创建线程并开启
    [NSThread detachNewThreadSelector:@selector(second) toTarget:self withObject:nil];
}

- (void)first{
    sleep(1);
    NSLog(@"1");
}

- (void)second{
    sleep(2);
    NSLog(@"2");
    //返回主线程
    [self performSelectorOnMainThread:@selector(func) withObject:nil waitUntilDone:NO];
}

- (void)third{
    sleep(3);
    NSLog(@"3");
}

- (void)func{
    NSLog(@"主线程:子线程执行结束");
}


@end
