//
//  MyConnection.m
//  爱限免
//
//  Created by pk on 14/12/9.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "MyConnection.h"

@implementation MyConnection

+ (void)connectionWithUrl:(NSString *)url FinishBlock:(FinishBlock)finishBlock FailedBlock:(FailedBlock)failedBlock{
    //实例化请求类，进行请求
    MyRequest* request = [[MyRequest alloc] init];
    request.url = url;
    request.finishBlock = finishBlock;
    request.failedBlock = failedBlock;
    [request start];
    [request release];
}


@end
