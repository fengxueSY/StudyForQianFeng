//
//  Person.m
//  KVCKVODemo
//
//  Created by pk on 14/11/24.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "Person.h"

@implementation Person

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"没有找到%@", key);
}

- (id)valueForUndefinedKey:(NSString *)key{
    return @"没找到...";
}


@end
