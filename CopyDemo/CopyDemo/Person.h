//
//  Person.h
//  CopyDemo
//
//  Created by pk on 14/11/24.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject<NSCopying, NSMutableCopying>

@property (nonatomic, retain) NSMutableString* name;

@end
