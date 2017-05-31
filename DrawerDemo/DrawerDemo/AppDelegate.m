//
//  AppDelegate.m
//  DrawerDemo
//
//  Created by pk on 14/12/23.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "AppDelegate.h"
#import "LeftViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.vc1 = [[UIViewController alloc] init];
    self.vc1.view.backgroundColor = [UIColor redColor];
    self.vc1 = [[UINavigationController alloc] initWithRootViewController:self.vc1];
    self.vc2 = [[UIViewController alloc] init];
    self.vc2.view.backgroundColor = [UIColor blueColor];
    self.vc2 = [[UINavigationController alloc] initWithRootViewController:self.vc2];
    
    LeftViewController* lvc = [[LeftViewController alloc] init];
    
    self.dvc = [[MSDynamicsDrawerViewController alloc] init];
    //设置左边视图控制器
    [self.dvc setDrawerViewController:lvc forDirection:MSDynamicsDrawerDirectionLeft];
    //显示页面
    [self.dvc setPaneViewController:self.vc1];
    self.window.rootViewController = self.dvc;

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
