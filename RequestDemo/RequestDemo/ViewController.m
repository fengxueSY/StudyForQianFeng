//
//  ViewController.m
//  RequestDemo
//
//  Created by pk on 14/12/1.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLConnectionDataDelegate>{
    NSMutableData* _mData;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mData = [[NSMutableData alloc] init];
    
   // NSData* data = [NSData dataWithContentsOfURL:url];
    
    NSString* urlStr = @"http://10.0.8.8/sns/my/user_list.php";
    //NSString->NSURL
    NSURL* url = [NSURL URLWithString:urlStr];
    //创建一个请求
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    //发送请求
    [NSURLConnection connectionWithRequest:request delegate:self];
}

//接收响应头
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    //Content-Length
    NSHTTPURLResponse* res = (NSHTTPURLResponse*)response;
    float length = [res.allHeaderFields[@"Content-Length"] floatValue];
    NSLog(@"%f", length);
}

//接收响应体 会调用很多次
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    /*
     0123456789     abcedf
     012
        abc
           345 edf
                   6789
     */
    [_mData appendData:data];
}

//完成
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    //_mData就是下载完的数据
    //NSData->NSString
    NSString* str = [[NSString alloc] initWithData:_mData encoding:NSUTF8StringEncoding];
    NSLog(@"%@", str);
    //解析 JsonKit SBJson json数据->字典/数组
    //NSJSONReadingMutableContainers返回可变数组/字典
    NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:_mData options:NSJSONReadingMutableContainers error:nil];
    //NSLog(@"%@", dic[@"count"]);
    for (NSDictionary* userDic in dic[@"users"]) {
        NSLog(@"%@", userDic[@"username"]);
    }
    
}

//失败
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"失败");
}






@end
