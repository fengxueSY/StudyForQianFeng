//
//  SliderViewController.m
//  UISwitchDemo
//
//  Created by pk on 14/11/19.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "SliderViewController.h"

@interface SliderViewController ()

@end

@implementation SliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UISlider* slider = [[UISlider alloc] initWithFrame:CGRectMake(50, 50, 200, 20)];
    //最小值
    slider.minimumValue = 0.0;
    //最大值
    slider.maximumValue = 255.0;
    //当前值
    slider.value = 0.0;
    //最小值轨道颜色
    //slider.minimumTrackTintColor = [UIColor redColor];
    //最大值轨道颜色
    //slider.maximumTrackTintColor = [UIColor purpleColor];
    //最小值图片
    //slider.minimumValueImage = [UIImage imageNamed:@"00.png"];
    //最大值图片
    //slider.maximumValueImage = [UIImage imageNamed:@"000.png"];
    //最小值轨道图片
    [slider setMinimumTrackImage:[UIImage imageNamed:@"000.png"] forState:UIControlStateNormal];
    //最大值轨道图片
    [slider setMaximumTrackImage:[UIImage imageNamed:@"000.png"] forState:UIControlStateNormal];
    //按钮的图片
    [slider setThumbImage:[UIImage imageNamed:@"00.png"] forState:UIControlStateNormal];
    
    [slider addTarget:self action:@selector(slider:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
    [slider release];
}

- (void)slider:(UISlider*)slider{
    self.view.backgroundColor = [UIColor colorWithRed:slider.value/255.0 green:0.5 blue:0.0 alpha:1.0];
}


@end
