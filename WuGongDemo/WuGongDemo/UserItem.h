//
//  UserItem.h
//  WuGongDemo
//
//  Created by pk on 14/12/8.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserItem : NSObject

@property (nonatomic) int uid;
@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* menpai;
@property (nonatomic, strong) NSArray* wugong;


@end
