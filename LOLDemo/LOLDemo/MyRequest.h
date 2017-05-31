//
//  MyRequest.h
//  LOLDemo
//
//  Created by pk on 14/12/2.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^FinishBlock)(NSData* data);
typedef void(^FailedBlock)();
//typedef int MyInt;
//typedef void(^)(NSData* data) FinishBlock;

@interface MyRequest : NSObject

@property (nonatomic) int tag;
@property (nonatomic, copy) FinishBlock finishBlock;
@property (nonatomic, copy) FailedBlock failedBlock;


- (instancetype)initWithUrl:(NSString*)url;
- (void)start;


@end
