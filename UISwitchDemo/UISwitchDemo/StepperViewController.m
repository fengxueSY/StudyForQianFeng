//
//  StepperViewController.m
//  UISwitchDemo
//
//  Created by pk on 14/11/19.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "StepperViewController.h"

@interface StepperViewController (){
    UILabel* _label;
}

@end

@implementation StepperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 40)];
    [self.view addSubview:_label];
    [_label release];
    
    UIStepper* stepper = [[UIStepper alloc] initWithFrame:CGRectMake(150, 150, 100, 40)];
    //最小值
    stepper.minimumValue = 0.0;
    //最大值
    stepper.maximumValue = 20.0;
    //步进值
    stepper.stepValue = 2.0;
    //循环
    stepper.wraps = YES;
    //背景图片
    [stepper setBackgroundImage:[UIImage imageNamed:@"00.png"] forState:UIControlStateNormal];
    //➕图片
    //[stepper setIncrementImage:[UIImage imageNamed:@"000.png"] forState:UIControlStateNormal];
    //➖图片
    //[stepper setDecrementImage: forState:]
    //分割线的图片
    [stepper setDividerImage:nil forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal];
    [stepper addTarget:self action:@selector(stepper:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:stepper];
    [stepper release];
}

- (void)stepper:(UIStepper*)stepper{
    _label.text = [NSString stringWithFormat:@"%lf",stepper.value];
}





@end
