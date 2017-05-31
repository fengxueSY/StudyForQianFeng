//
//  MyConnection.m
//  LOLDemo
//
//  Created by pk on 14/12/2.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "MyConnection.h"

@implementation MyConnection

+ (void)connectionWithUrl:(NSString *)url FinishBlock:(FinishBlock)finishBlock FailedBlock:(FailedBlock)failedBlock{
    MyRequest* request = [[MyRequest alloc] initWithUrl:url];
    request.finishBlock = finishBlock;
    request.failedBlock = failedBlock;
    [request start];
}







@end
