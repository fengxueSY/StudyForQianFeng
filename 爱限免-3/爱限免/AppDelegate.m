//
//  AppDelegate.m
//  爱限免
//
//  Created by pk on 14/12/9.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "AppDelegate.h"
#import "LimitViewController.h"
#import "SaleViewController.h"
#import "FreeViewController.h"
#import "SubjectViewController.h"
#import "HotViewController.h"
#import "UMSocial.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //友盟appkey
    [UMSocialData setAppKey:@"544b4c09fd98c55706050006"];
    
    //设置默认导航背景图片
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"顶部条背景.png"] forBarMetrics:UIBarMetricsDefault];
    
    NSMutableArray* viewControllers = [NSMutableArray array];
    //创建五个页面
    LimitViewController* limitVC = [[[LimitViewController alloc] init] autorelease];
    [viewControllers addObject:limitVC];
    
    SaleViewController* saleVC = [[[SaleViewController alloc] init] autorelease];
    [viewControllers addObject:saleVC];
    
    FreeViewController* freeVC = [[[FreeViewController alloc] init] autorelease];
    [viewControllers addObject:freeVC];
    
    SubjectViewController* subjectVC = [[[SubjectViewController alloc] init] autorelease];
    [viewControllers addObject:subjectVC];
    
    HotViewController* hotVC = [[[HotViewController alloc] init] autorelease];
    [viewControllers addObject:hotVC];
    
    NSArray* titleArray = @[@"限免", @"降价", @"免费", @"专题", @"热点"];
    for (int i = 0; i < 5; i++) {
        //设置标题
        UIViewController* vc = viewControllers[i];
        vc.title = titleArray[i];
        //添加导航
        UINavigationController* nc = [[[UINavigationController alloc] initWithRootViewController:vc] autorelease];
        [viewControllers replaceObjectAtIndex:i withObject:nc];
        //设置TabbarItem图标
        if (IOS7) {
            nc.tabBarItem.image = [UIImage imageNamed:[NSString stringWithFormat:@"btn_%@_正常.png", titleArray[i]]];
            nc.tabBarItem.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"btn_%@_点击.png",titleArray[i]]];
            //设置渲染模式
            nc.tabBarItem.selectedImage = [nc.tabBarItem.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            //设置nc标题属性
            [nc.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        }
    }
    //状态栏颜色
    
    UITabBarController* tc = [[UITabBarController alloc] init];
    tc.tabBar.tintColor = [UIColor greenColor];
    tc.viewControllers = viewControllers;
    self.window.rootViewController = tc;
    [tc release];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {


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
