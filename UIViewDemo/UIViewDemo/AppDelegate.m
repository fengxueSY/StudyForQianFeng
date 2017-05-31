//
//  AppDelegate.m
//  UIViewDemo
//
//  Created by pk on 14/11/14.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    UIView* view1 = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 150, 150)];
    view1.backgroundColor = [UIColor redColor];
    [self.window addSubview:view1];
    //拿到view1的父试图 view1.superview 在这是window
    //拿到window的子试图 self.window.subviews 数组
    
    UIView* view2 = [[UIView alloc] initWithFrame:CGRectMake(70, 70, 150, 150)];
    view2.backgroundColor = [UIColor blueColor];
    [self.window addSubview:view2];
    
    UIView* view3 = [[UIView alloc] initWithFrame:CGRectMake(120, 120, 150, 150)];
    //标签 默认0
    view3.tag = 10;
    view3.backgroundColor = [UIColor purpleColor];
    //插入子视图到另外一个子视图的上方
    //[self.window insertSubview:view3 aboveSubview:view1];
    //插入子视图到另外一个子视图的下方
    //[self.window insertSubview:view3 belowSubview:view2];
    //插入子试图到某一个位置
    [self.window insertSubview:view3 atIndex:1];
    
    //把某一个子试图移动到最上方
    [self.window bringSubviewToFront:view3];
    //把某一个子视图移动到最下方
    [self.window sendSubviewToBack:view3];
    //交换子试图的位置
    [self.window exchangeSubviewAtIndex:0 withSubviewAtIndex:2];
    
    //UIButton
    UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(100, 100, 100, 40);
    [button setTitle:@"点击" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [view3 addSubview:button];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)buttonClick{
    //通过tag拿到view3视图
    UIView* view3 = [self.window viewWithTag:10];
    view3.backgroundColor = [UIColor greenColor];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
