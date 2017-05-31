//
//  ViewController.m
//  AVAudioPlayerDemo
//
//  Created by pk on 14/11/28.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController (){
    IBOutlet UISlider* _proSlider;
    IBOutlet UISlider* _volumeSlider;
    IBOutlet UISlider* _panSlider;
    IBOutlet UISlider* _rateSlider;
    IBOutlet UIProgressView* _pv1;
    IBOutlet UIProgressView* _pv2;
    
    AVAudioPlayer* _player;
    NSTimer* _timer;
}

- (IBAction)play:(id)sender;
- (IBAction)pause:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"Beat It" ofType:@"mp3"];
    //路径转成url
    NSURL* url = [NSURL fileURLWithPath:path];
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    //准备播放
    [_player prepareToPlay];
    //开启变速
    [_player setEnableRate:YES];
    //开启峰值检测
    [_player setMeteringEnabled:YES];
    
    [_proSlider addTarget:self action:@selector(changeProgress) forControlEvents:UIControlEventValueChanged];
    [_volumeSlider addTarget:self action:@selector(changeVolume) forControlEvents:UIControlEventValueChanged];
    [_panSlider addTarget:self action:@selector(changePan) forControlEvents:UIControlEventValueChanged];
    [_rateSlider addTarget:self action:@selector(changeRate) forControlEvents:UIControlEventValueChanged];
}

//设置进度
- (void)changeProgress{
    //当前时间=总时间*进度
    _player.currentTime = _player.duration * _proSlider.value;
}

//设置音量
- (void)changeVolume{
    _player.volume = _volumeSlider.value;
}

//设置声道
- (void)changePan{
    _player.pan = _panSlider.value;
}

//设置速度
- (void)changeRate{
    _player.rate = _rateSlider.value;
}

//刷新
- (void)refresh{
    //进度=当前时间/总时间
    float pro = _player.currentTime / _player.duration;
    [_proSlider setValue:pro animated:YES];
    
    //刷新峰值
    [_player updateMeters];
    //最大值 峰值
    float peakValue = [_player peakPowerForChannel:0];
    //平均值
    float avgValue = [_player averagePowerForChannel:0];
    //NSLog(@"%f,   %f", peakValue, avgValue);
    [_pv1 setProgress:(peakValue + 20) / 20 animated:YES];
    [_pv2 setProgress:(avgValue + 20) / 20 animated:YES];
}

- (void)play:(id)sender{
    //播放
    [_player play];
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(refresh) userInfo:nil repeats:YES];
    }
}

- (void)pause:(id)sender{
    //暂停
    [_player pause];
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}




@end
