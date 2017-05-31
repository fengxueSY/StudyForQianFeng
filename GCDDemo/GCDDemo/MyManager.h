//
//  MyManager.h
//  GCDDemo
//
//  Created by pk on 14/12/18.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyManager : NSObject

@property (nonatomic, copy) NSString* a;

+ (MyManager*)sharedManager;

@end
