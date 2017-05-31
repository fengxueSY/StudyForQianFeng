//
//  AppDelegate.h
//  DrawerDemo
//
//  Created by pk on 14/12/23.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSDynamicsDrawerStyler.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MSDynamicsDrawerViewController* dvc;
@property (strong, nonatomic) UIViewController* vc1;
@property (strong, nonatomic) UIViewController* vc2;


@end

