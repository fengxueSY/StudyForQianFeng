//
//  MenpaiViewController.h
//  WuGongDemo
//
//  Created by pk on 14/12/8.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MyBlock)(NSString* menpai);
@interface MenpaiViewController : UIViewController

@property (nonatomic, copy) MyBlock block;

@end
