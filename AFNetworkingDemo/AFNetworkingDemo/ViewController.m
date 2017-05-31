//
//  ViewController.m
//  AFNetworkingDemo
//
//  Created by pk on 14/12/18.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

@interface ViewController (){
    IBOutlet UIProgressView* _pv;
    AFHTTPRequestOperation* _operation;
}

- (IBAction)start:(id)sender;
- (IBAction)pause:(id)sender;
- (IBAction)resume:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com/img/bdlogo.png"]];
    _operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [_operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"成功");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"失败");
    }];
    //设置保存文件的路径
    NSString* path = [NSString stringWithFormat:@"%@/Documents/a.png",NSHomeDirectory()];
    NSLog(@"%@", path);
    _operation.outputStream = [NSOutputStream outputStreamToFileAtPath:path append:NO];
    //设置下载的进度
    __weak UIProgressView* pv = _pv;
    [_operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        [pv setProgress:(float)totalBytesRead / totalBytesExpectedToRead animated:YES];
    }];
}
//断点续传
- (void)start:(id)sender{
    [_operation start];
}

- (void)pause:(id)sender{
    [_operation pause];
}

- (void)resume:(id)sender{
    [_operation resume];
}




@end
