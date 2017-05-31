//
//  MySwitch.h
//  UIViewControllerDemo
//
//  Created by pk on 14/11/17.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import <UIKit/UIKit.h>
//1
@protocol MySwitchDelegate <NSObject>

- (void)changeColor:(UIColor*)color;

@end

@interface MySwitch : UIView

//2
@property (nonatomic, assign)id<MySwitchDelegate> delegate;


@end
