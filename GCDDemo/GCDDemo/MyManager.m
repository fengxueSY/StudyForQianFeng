//
//  MyManager.m
//  GCDDemo
//
//  Created by pk on 14/12/18.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "MyManager.h"

static MyManager* manager = nil;
@implementation MyManager
//线程安全
+ (MyManager *)sharedManager{
    //线程锁 a b
//    NSLock* lock = [[NSLock alloc] init];
//    [lock lock];
    //线程同步
    @synchronized(self){
        if (manager == nil) {
            manager = [[[self class] alloc] init];
        }
    }
//    [lock unlock];
    return manager;
}




@end
