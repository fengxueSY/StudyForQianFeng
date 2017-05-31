//
//  MyRequest.m
//  LOLDemo
//
//  Created by pk on 14/12/2.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "MyRequest.h"

@interface MyRequest ()<NSURLConnectionDataDelegate>{
    NSMutableData* _mData;
}

@property (nonatomic, copy) NSString* url;

@end

@implementation MyRequest

- (instancetype)initWithUrl:(NSString*)url{
    if (self = [super init]) {
        _mData = [[NSMutableData alloc] init];
        self.url = url;
    }
    return self;
}

//开始请求
- (void)start{
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [_mData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    //回调数据
    if (self.finishBlock) {
        self.finishBlock(_mData);
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    //回调失败
    if (self.failedBlock) {
        self.failedBlock();
    }
}







@end
