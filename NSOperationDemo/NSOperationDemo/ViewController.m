//
//  ViewController.m
//  NSOperationDemo GCD
//
//  Created by pk on 14/12/18.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "ViewController.h"
#import "MyOperation.h"
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(100, 100, 100, 40);
    [button setTitle:@"开启线程" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    //asi
    ASINetworkQueue* queue = [[ASINetworkQueue alloc] init];
    queue.maxConcurrentOperationCount = 1;
    for (int i = 0; i < 5; i++) {
        ASIHTTPRequest* request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:@"http://10.0.8.8/my/sns/user_list.php"]];
        [queue addOperation:request];
    }
    [queue go];
    
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://10.0.8.8/my/sns/user_list.php"]];
    NSOperationQueue* operationQueue = [[NSOperationQueue alloc] init];
    //发送一个异步请求
    [NSURLConnection sendAsynchronousRequest:request queue:operationQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
    }];
}

- (void)buttonClick{
    //操作队列
    NSOperationQueue* queue = [[NSOperationQueue alloc] init];
    //最大同时执行的操作数量
    queue.maxConcurrentOperationCount = 1;
    //创建操作
    NSInvocationOperation* operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(func) object:nil];
    //操作加到队列中
    [queue addOperation:operation];
    
    NSBlockOperation* blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        sleep(3);
        NSLog(@"3");
    }];
    [queue addOperation:blockOperation];
    
    //自定义操作
    MyOperation* oper = [[MyOperation alloc] init];
    [queue addOperation:oper];
}

- (void)func{
    sleep(2);
    NSLog(@"2");
}







@end
