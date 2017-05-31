//
//  MyRequest.h
//  爱限免
//
//  Created by pk on 14/12/9.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^FinishBlock)(NSData* data);
typedef void(^FailedBlock)();

@interface MyRequest : NSObject

//外界传来需要请求的url
@property (nonatomic, copy) NSString* url;
//完成回调
@property (nonatomic, copy) FinishBlock finishBlock;
//失败回调
@property (nonatomic, copy) FailedBlock failedBlock;
//开始请求
- (void)start;

@end
