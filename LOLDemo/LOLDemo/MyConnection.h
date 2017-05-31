//
//  MyConnection.h
//  LOLDemo
//
//  Created by pk on 14/12/2.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyRequest.h"

@interface MyConnection : NSObject

+ (void)connectionWithUrl:(NSString*)url FinishBlock:(FinishBlock)finishBlock FailedBlock:(FailedBlock)failedBlock;


@end
