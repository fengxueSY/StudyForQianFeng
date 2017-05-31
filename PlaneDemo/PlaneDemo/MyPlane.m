//
//  MyPlane.m
//  PlaneDemo
//
//  Created by pk on 14/11/14.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "MyPlane.h"

@implementation MyPlane

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, 66, 72)]) {
        self.image = [UIImage imageNamed:@"plane1.png"];
    }
    return self;
}

- (void)start{
    self.image = [UIImage imageNamed:@"plane1.png"];
}

- (void)dead{
    self.image = [UIImage imageNamed:@"bow.png"];
}




@end
