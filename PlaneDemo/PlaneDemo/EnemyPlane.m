//
//  EnemyPlane.m
//  PlaneDemo
//
//  Created by pk on 14/11/14.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "EnemyPlane.h"

@implementation EnemyPlane

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, 40, 29)]) {
        self.image = [UIImage imageNamed:@"plane2.png"];
    }
    return self;
}


@end




