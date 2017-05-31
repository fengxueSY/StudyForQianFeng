//
//  ViewController.m
//  AVPlayerDemo
//
//  Created by pk on 14/12/19.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "ViewController.h"
#import "PlayerView.h"

@interface ViewController (){
    //播放屏幕
    PlayerView* _playerView;
    UISlider* _slider;
    //播放器
    AVPlayer* _player;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //屏幕
    _playerView = [[PlayerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 280)];
    [self.view addSubview:_playerView];
    //进度条
    _slider = [[UISlider alloc] initWithFrame:CGRectMake(50, 320, 200, 20)];
    [_slider addTarget:self action:@selector(setProgress:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_slider];
    //播放，暂停
    UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(150, 360, 100, 40);
    [button setTitle:@"播放" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(150, 420, 100, 40);
    [button setTitle:@"暂停" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(pause) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    //播放地址
    //[NSURL fileURLWithPath:]
    NSURL* url = [NSURL URLWithString:@"http://pk.local/1434/a.mp4"];
    //资源类
    AVURLAsset* asset = [AVURLAsset assetWithURL:url];
    //准备播放
    [asset loadValuesAsynchronouslyForKeys:@[@"tracks"] completionHandler:^{
        //AVPlayer->AVPlayerItem->AVURLAsset
        //播放项
        AVPlayerItem* item = [AVPlayerItem playerItemWithAsset:asset];
        //播放器
        _player = [[AVPlayer alloc] initWithPlayerItem:item];
        //关联屏幕和播放器
        [_playerView setPlayer:_player];
        //添加进度
        //每隔多长时间，在哪个线程中调用block方法
        //间隔时间    帧数   帧率
        CMTime time = CMTimeMake(1, 1);
        __weak AVPlayer* player = _player;
        [_player addPeriodicTimeObserverForInterval:time queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
            //当前时间
            CMTime currentTime = player.currentItem.currentTime;
            //总时间
            CMTime duration = player.currentItem.duration;
            //当前时间/总时间
            [_slider setValue:CMTimeGetSeconds(currentTime)/CMTimeGetSeconds(duration) animated:YES];
        }];
    }];
}

//设置进度
- (void)setProgress:(UISlider*)slider{
    //当前时间=总时间*进度
    CMTime duration = _player.currentItem.duration;
    CMTime currentTime = CMTimeMultiplyByFloat64(duration, slider.value);
    //从当前时间播放
    [_player seekToTime:currentTime];
}

//播放
- (void)play{
    [_player play];
}

//暂停
- (void)pause{
    [_player pause];
}


@end
