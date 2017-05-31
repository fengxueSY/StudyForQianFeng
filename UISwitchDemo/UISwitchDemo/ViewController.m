//
//  ViewController.m
//  UISwitchDemo
//
//  Created by pk on 14/11/19.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    UISwitch* _mySwitch;
    UISlider* _slider;
    UISegmentedControl* _sc;
    UIActivityIndicatorView* _activityView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    
    _activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(150, 20, 100, 100)];
    //类型
    _activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    //颜色
    _activityView.color = [UIColor yellowColor];
    //[_activityView startAnimating];
    //当停止的时候隐藏
    _activityView.hidesWhenStopped = NO;
    [self.view addSubview:_activityView];

    _mySwitch = [[UISwitch alloc] initWithFrame:CGRectMake(50, 50, 300, 50)];
    [_mySwitch addTarget:self action:@selector(myswitch:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_mySwitch];
    [_mySwitch release];
    
//    //边框颜色
//    mySwitch.tintColor = [UIColor redColor];
//    //开的时候背景颜色
//    mySwitch.onTintColor = [UIColor blueColor];
//    //按钮的颜色
//    mySwitch.thumbTintColor = [UIColor orangeColor];

    _sc = [[UISegmentedControl alloc] initWithItems:@[@"0", @"1", @"2", @"3", @"4"]];
    _sc.frame = CGRectMake(50, 100, 200, 40);
    [_sc addTarget:self action:@selector(sc:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_sc];
    
    _slider = [[UISlider alloc] initWithFrame:CGRectMake(50, 150, 200, 20)];
    _slider.minimumValue = 0.0;
    _slider.maximumValue = 4.0;
    [_slider addTarget:self action:@selector(slider:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_slider];
}

- (void)myswitch:(UISwitch*)mySwitch{
    if (mySwitch.on) {
        _sc.selectedSegmentIndex = 4;
        [_slider setValue:4.0 animated:YES];
    } else  {
        _sc.selectedSegmentIndex = 0;
        [_slider setValue:0.0 animated:YES];
    }
}

- (void)sc:(UISegmentedControl*)sc{
    _mySwitch.on = sc.selectedSegmentIndex == 4 ? YES : NO;
    [_slider setValue:sc.selectedSegmentIndex animated:YES];
}

- (void)slider:(UISlider*)slider{
    _sc.selectedSegmentIndex = (NSInteger)slider.value;
    _mySwitch.on = slider.value == 4 ? YES : NO;
}



@end
