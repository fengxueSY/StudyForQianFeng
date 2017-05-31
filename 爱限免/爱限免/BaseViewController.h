//
//  BaseViewController.h
//  爱限免
//
//  Created by pk on 14/12/9.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "MyConnection.h"

#define WINSIZE [[UIScreen mainScreen] bounds].size
#define IOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0

@interface BaseViewController : UIViewController

@end
