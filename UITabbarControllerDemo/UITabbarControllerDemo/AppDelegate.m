//
//  AppDelegate.m
//  UITabbarControllerDemo
//
//  Created by pk on 14/11/20.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController1.h"
#import "ViewController2.h"
#import "ViewController3.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray* array = [NSMutableArray array];
    ViewController1* vc1 = [[ViewController1 alloc] init];
    UINavigationController* nc1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    ViewController2* vc2 = [[ViewController2 alloc] init];
//    vc2.view.backgroundColor = [UIColor redColor];
//    vc2.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemDownloads tag:1];
    UINavigationController* nc2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    ViewController3* vc3 = [[ViewController3 alloc] init];
    UINavigationController* nc3 = [[UINavigationController alloc] initWithRootViewController:vc3];

    [array addObject:nc1];
    [array addObject:nc2];
    [array addObject:nc3];
    
    UITabBarController* tc = [[UITabBarController alloc] init];
    //tc.tabBar
    //选中的是第几个
    //tc.selectedIndex
    //选中的是哪一个Controller
    //tc.selectedViewController
    tc.viewControllers = array;
    self.window.rootViewController = tc;
    
    [self.window makeKeyAndVisible];
    return YES;
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
