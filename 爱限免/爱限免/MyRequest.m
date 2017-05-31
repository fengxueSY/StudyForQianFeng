//
//  MyRequest.m
//  爱限免
//
//  Created by pk on 14/12/9.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "MyRequest.h"

@interface MyRequest ()<NSURLConnectionDataDelegate>{
    NSMutableData* _mData;
}

@end

@implementation MyRequest

- (void)start{
    //普通的请求
    _mData = [[NSMutableData alloc] init];
    [self retain];
    
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

//接收响应头
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    //显示活动指示器
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

//接收响应体 接收数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    //拼接数据
    [_mData appendData:data];
}

//请求完成
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    //活动指示器停止
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    //调用成功的回调方法
    if (self.finishBlock) {
        self.finishBlock([_mData autorelease]);
    }
    [self release];
}

//请求失败
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    //活动指示器停止
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [_mData release];
    //调用失败的回调方法
    if (self.failedBlock) {
        self.failedBlock();
    }
    [self release];
}


@end
