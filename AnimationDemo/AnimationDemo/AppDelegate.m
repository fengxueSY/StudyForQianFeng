//
//  AppDelegate.m
//  AnimationDemo
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
    
    UIView* view1 = [[UIView alloc] initWithFrame:self.window.bounds];
    view1.backgroundColor = [UIColor redColor];
    [self.window addSubview:view1];
    
    UIView* view2 = [[UIView alloc] initWithFrame:self.window.bounds];
    view2.backgroundColor = [UIColor blueColor];
    [self.window addSubview:view2];
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(100, 100, 100, 30);
    [button setTitle:@"点我" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.window addSubview:button];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)buttonClick{
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:2.0];
//    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.window cache:NO];
//    [self.window exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
//    [UIView commitAnimations];
    
    /*
    [UIView animateWithDuration:2.0 animations:^{
        UIView* view = [self.window.subviews objectAtIndex:1];
        view.backgroundColor = [UIColor yellowColor];
    }];
   
    [UIView animateWithDuration:2.0 animations:^{
        UIView* view = [self.window.subviews objectAtIndex:1];
        view.backgroundColor = [UIColor yellowColor];
    } completion:^(BOOL finished) {
        NSLog(@"动画完成");
    }];
    */
    
    [UIView animateWithDuration:2.0 delay:0.0 options:UIViewAnimationOptionTransitionFlipFromLeft | UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.window exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    } completion:^(BOOL finished) {
        
    }];
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
