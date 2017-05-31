//
//  AppDelegate.m
//  UITabbarDemo
//
//  Created by pk on 14/11/20.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController1.h"

@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
//    ViewController1* vc1 = [[ViewController1 alloc] init];
//    self.window.rootViewController = vc1;
    
    NSMutableArray* array = [NSMutableArray array];
    NSArray* titleArray = @[@"要闻", @"军事", @"娱乐", @"科技", @"体育", @"游戏"];
    for (int i = 0; i < 6; i++) {
        UIViewController* vc = [[UIViewController alloc] init];
        vc.title = titleArray[i];
        vc.tabBarItem.image = [UIImage imageNamed:@"00.png"];
        vc.tabBarItem.tag = i;
        UINavigationController* nc = [[UINavigationController alloc] initWithRootViewController:vc];
        //nc.tabBarItem
        [array addObject:nc];
    }
    //tc.viewControllers->nc.viewControllers->vc.view
    //如果有用户保存的顺序
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray* indexArray = [userDefaults objectForKey:@"index"];
    if (indexArray) {
        //如果不为空，证明用户保存过顺序
        NSMutableArray* mArray = [NSMutableArray array];
        for (NSNumber* num in indexArray) {
            //按用户保存的顺序取出试图控制器
            //父类指针可以指向子类对象
            UIViewController* tmpVc = array[[num intValue]];
            [mArray addObject:tmpVc];
        }
        array = mArray;
    }
    
    UITabBarController* tc = [[UITabBarController alloc] init];
    tc.delegate = self;
    tc.viewControllers = array;
    self.window.rootViewController = tc;
    
    [self.window makeKeyAndVisible];
    return YES;
}

//将要选择一项的时候调用
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    return YES;
}
//选择了一项的时候调用
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{

}

- (void)tabBarController:(UITabBarController *)tabBarController willBeginCustomizingViewControllers:(NSArray *)viewControllers{
    //tabBarController.viewControllers
    NSLog(@"将要开始自定义视图控制器");
}

- (void)tabBarController:(UITabBarController *)tabBarController willEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed{
    NSLog(@"将要结束编辑");
    //如果用户改变了顺序，我们把顺序保存到本地
    if (changed) {
        NSMutableArray* array = [NSMutableArray array];
        for (UIViewController* vc in viewControllers) {
            NSLog(@"%ld", vc.tabBarItem.tag);
            NSNumber* num = [NSNumber numberWithInteger:vc.tabBarItem.tag];
            [array addObject:num];
        }
        //把顺序数组存到本地
        NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:array forKey:@"index"];
        [userDefaults synchronize];
    }
}






@end
