//
//  MySwitch.m
//  UIViewControllerDemo
//
//  Created by pk on 14/11/17.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "MySwitch.h"

@implementation MySwitch

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //Button1
        UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(0, 0, frame.size.width/2, frame.size.height);
        [button setTitle:@"开" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(open) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        //Button2
        UIButton* button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button2.frame = CGRectMake(frame.size.width/2, 0, frame.size.width/2, frame.size.height);
        [button2 setTitle:@"关" forState:UIControlStateNormal];
        [button2 addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button2];
    }
    return self;
}

- (void)open{
    //3
    [self.delegate changeColor:[UIColor whiteColor]];
}

- (void)close{
    //3
    [self.delegate changeColor:[UIColor blackColor]];
}



@end
