//
//  Person.m
//  CopyDemo
//
//  Created by pk on 14/11/24.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "Person.h"

@implementation Person

- (id)copyWithZone:(NSZone *)zone{
    Person* person = [[[self class] alloc] init];
    person.name = self.name;
    return person;
}

- (id)mutableCopyWithZone:(NSZone *)zone{
    Person* person = [[[self class] alloc] init];
    //深拷贝，把里面的属性依次拷贝;
    person.name = [self.name mutableCopy];
    return person;
}


@end
