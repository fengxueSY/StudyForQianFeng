//
//  FMDBManager.h
//  WuGongDemo
//
//  Created by pk on 14/12/8.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserItem.h"

@interface FMDBManager : NSObject

+ (FMDBManager*)sharedManager;


//得到门派
- (NSArray*)getMenpaiArray;

//得到武功
- (NSArray*)getWuGongArray;

//添加用户
- (void)addUser:(UserItem*)userItem;

//查询所有用户
- (NSArray*)getAllUser;



@end
