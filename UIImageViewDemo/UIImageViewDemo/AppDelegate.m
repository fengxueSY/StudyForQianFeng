//
//  AppDelegate.m
//  UIImageViewDemo
//
//  Created by pk on 14/11/13.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (){
    NSMutableArray* _birdArray;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //初始化小鸟数组
    _birdArray = [[NSMutableArray alloc] init];
    
    //载入背景图片
    UIImage* image = [UIImage imageNamed:@"back2.jpg"];
    UIImageView* bgView = [[UIImageView alloc] initWithFrame:self.window.bounds];
    //设置图片
    bgView.image = image;
    [self.window addSubview:bgView];//2
    [bgView release];//1
    
    
    //企鹅
    UIImageView* qqView = [[UIImageView alloc] initWithFrame:CGRectMake(250, 450, 84, 92)];
    //设置播放图片
    NSMutableArray* array = [NSMutableArray array];
    for (int i = 1; i < 9; i++) {
        //01.png 02.png ...
        UIImage* qqImage = [UIImage imageNamed:[NSString stringWithFormat:@"%02d.png",i]];
        [array addObject:qqImage];
    }
    [qqView setAnimationImages:array];
    //设置播放时间
    [qqView setAnimationDuration:0.5];
    //设置播放次数 0无限
    [qqView setAnimationRepeatCount:0];
    //开始播放动画
    [qqView startAnimating];
    [self.window addSubview:qqView];
    [qqView release];
    
    //定时器 定时器间隔
    [NSTimer scheduledTimerWithTimeInterval:1.2 target:self selector:@selector(createBird:) userInfo:nil repeats:YES];
    //定时器 刷新小鸟的位置
    [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(refresh) userInfo:nil repeats:YES];
    
    [self.window makeKeyAndVisible];
    return YES;
}

//刷新小鸟位置
- (void)refresh{
    for (int i = 0; i < _birdArray.count; i++) {
        UIImageView* birdView = _birdArray[i];
        birdView.frame = CGRectMake(birdView.frame.origin.x + 3, birdView.frame.origin.y + 0.3, 121, 96);
        //判断小鸟是否移出屏幕
        if (birdView.frame.origin.x > self.window.bounds.size.width) {
            //从父视图中移出
            [birdView removeFromSuperview];
            //从数组中移除
            [_birdArray removeObject:birdView];
        }
    }
}

//创建小鸟
- (void)createBird:(NSTimer*)timer{
    int y = arc4random()%200 + 50;
    UIImageView* birdView = [[UIImageView alloc] initWithFrame:CGRectMake(-121, y, 121, 96)];
    //把小鸟添加到数组里
    [_birdArray addObject:birdView];
    NSMutableArray* array = [NSMutableArray array];
    for (int i = 1; i < 19; i++) {
        UIImage* image = [UIImage imageNamed:[NSString stringWithFormat:@"DOVE %d.png",i]];
        [array addObject:image];
    }
    [birdView setAnimationImages:array];
    [birdView setAnimationDuration:0.5];
    [birdView setAnimationRepeatCount:0];
    [birdView startAnimating];
    [self.window addSubview:birdView];
    [birdView release];
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
