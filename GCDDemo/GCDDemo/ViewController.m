//
//  ViewController.m
//  GCDDemo
//
//  Created by pk on 14/12/18.
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
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    [self.view addSubview:_imageView];
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(100, 400, 100, 40);
    [button setTitle:@"开启线程" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(downImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)downImage{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://img3.douban.com/view/commodity_story/medium/public/p12278992.jpg"]];
        NSLog(@"下载完成");
        //到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            _imageView.image = [UIImage imageWithData:data];
        });
    });
}

- (void)buttonClick{
    /*
    //GCD
    //线程队列
    dispatch_queue_t t = dispatch_queue_create(NULL, NULL);
    //在线程队列中做了什么事
    dispatch_async(t, ^{
        sleep(3);
        NSLog(@"3");
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(4);
        NSLog(@"4");
    });
    */
    //创建组
    dispatch_group_t group = dispatch_group_create();
    //在线程中执行操作，线程放到group组中管理
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        int time = arc4random()%5 + 1;
        sleep(time);
        NSLog(@"%d", time);
    });
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        int time = arc4random()%5 + 1;
        sleep(time);
        NSLog(@"%d", time);
    });
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        int time = arc4random()%5 + 1;
        sleep(time);
        NSLog(@"%d", time);
    });
    //[NSOperationQueue mainQueue]; 主线程
    //当group里全部线程执行完成以后，调用
    //dispatch_get_main_queue() 主线程
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"线程执行完成");
    });
}







@end
