//
//  ViewController1.m
//  UITabbarDemo
//
//  Created by pk on 14/11/20.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "ViewController1.h"

@interface ViewController1 (){
    UITabBar* _tabbar;
}

@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];

    _tabbar = [[UITabBar alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 49)];
    [self.view addSubview:_tabbar];
    
    UITabBarItem* item = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemBookmarks tag:0];
    UITabBarItem* item2 = [[UITabBarItem alloc] initWithTitle:@"主页" image:[UIImage imageNamed:@"00.png"] tag:1];
    UITabBarItem* item3 = [[UITabBarItem alloc] initWithTitle:@"朋友圈" image:[UIImage imageNamed:@"00.png"] selectedImage:[UIImage imageNamed:@"000.png"]];
    //图像
    item3.image = [[UIImage imageNamed:@"00.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //选中图像
    item3.selectedImage = [[UIImage imageNamed:@"000.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //图像位置
    item3.imageInsets = UIEdgeInsetsMake(-10, 0, 10, 0);
    //通讯录
    item3.title = @"通讯录";
    item.badgeValue = @"3";
    
    _tabbar.items = @[item, item2, item3];
    //设置选中的item
    _tabbar.selectedItem = item2;
    //设置选中的指示背景图片
    //_tabbar.selectionIndicatorImage = [UIImage imageNamed:@"00.png"];
    //设置颜色
    _tabbar.tintColor = [UIColor redColor];
    //_tabbar.barTintColor = [UIColor greenColor];
    //_tabbar.barStyle = UIBarStyleBlackTranslucent;
    _tabbar.backgroundImage = [UIImage imageNamed:@"000.png"];
}






@end
