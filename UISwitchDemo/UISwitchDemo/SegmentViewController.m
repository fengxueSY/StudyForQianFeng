//
//  SegmentViewController.m
//  UISwitchDemo
//
//  Created by pk on 14/11/19.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "SegmentViewController.h"

@interface SegmentViewController ()

@end

@implementation SegmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UISegmentedControl* sc = [[UISegmentedControl alloc] initWithItems:@[@"令狐冲", @"岳不群",[UIImage imageNamed:@"00.png"]]];
    sc.frame = CGRectMake(50, 50, 200, 50);
    //自动反弹
    sc.momentary = YES;
    //得到当前一共有几段 3
    //sc.numberOfSegments
    //更改标题
    [sc setTitle:@"珊" forSegmentAtIndex:1];
    //更改图片
    
    [sc setImage:[[UIImage imageNamed:@"000.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forSegmentAtIndex:2];
    //取得某一段的标题
    //NSString* str = [sc titleForSegmentAtIndex:0];
    //取得某一段的图片
    //UIImage* image = [sc imageForSegmentAtIndex:2];
    //修改颜色
    sc.tintColor = [UIColor redColor];
    //添加一段
    [sc insertSegmentWithTitle:@"东方不败" atIndex:3 animated:YES];
    //适应宽度
    sc.apportionsSegmentWidthsByContent = YES;
    
    [sc addTarget:self action:@selector(sc:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:sc];
    [sc release];
}


- (void)sc:(UISegmentedControl*)sc{
    NSLog(@"当前选中:%ld", sc.selectedSegmentIndex);
    //移除一段
    [sc removeSegmentAtIndex:sc.selectedSegmentIndex animated:YES];
}






@end
