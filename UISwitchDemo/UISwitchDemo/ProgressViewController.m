//
//  ProgressViewController.m
//  UISwitchDemo
//
//  Created by pk on 14/11/19.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "ProgressViewController.h"

@interface ProgressViewController (){
    UIProgressView* _progressView;
}

@end

@implementation ProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    _progressView.frame = CGRectMake(50, 50, 200, 20);
    [self.view addSubview:_progressView];
    //进度颜色
    _progressView.progressTintColor = [UIColor redColor];
    //轨道颜色
    _progressView.trackTintColor = [UIColor orangeColor];
    
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(refresh:) userInfo:nil repeats:YES];
}

- (void)refresh:(NSTimer*)timer{
    //增加进度
    [_progressView setProgress:_progressView.progress + 0.01 animated:YES];
    if (_progressView.progress >= 1.0) {
        [timer invalidate];
    }
}




@end
