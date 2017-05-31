//
//  Person.h
//  KVCKVODemo
//
//  Created by pk on 14/11/24.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WuGong.h"

@interface Person : NSObject{
    //NSString* name;
}


@property (nonatomic, retain) WuGong* wuGong;
@property (nonatomic, copy) NSString* name;


@end
