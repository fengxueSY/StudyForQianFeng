//
//  ViewController.m
//  MPMoviePlayerDemo
//
//  Created by pk on 14/12/5.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController (){
    MPMoviePlayerViewController* _playerView;
    MPMoviePlayerController* _player;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(100, 100, 100, 40);
    [button setTitle:@"播放视频" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonClick{
    NSURL* url = [NSURL URLWithString:@"http://g3.letv.cn/vod/v2/OTkvMTkvNDMvYmNsb3VkLzEwMTcxMS92ZXJfMDBfMTYtMzAyMTE2ODMtYXZjLTIzMDAxMi1hYWMtMzIwMDEtMzI1OTkwMC0xMTA4NjM4NzYtOWJhNDY4MGY2N2Y3MjJlMjFjMWQ2YTI4YzMyYTQ1NzItMTQxMzE1Njk5NjM1OS5tcDQ=?b=272&mmsid=23939800&tm=1417765199&key=994f5bfe022dd968ae3a2b53bba79d80&platid=2&splatid=206&playid=0&tss=ios&vtype=21&cvid=114592106885&tag=macos&sign=bcloud_101711&termid=2&pay=0&ostype=macos&hwtype=un"];
    
    //_playerView = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
    //[self presentViewController:_playerView animated:YES completion:nil];
    
    _player = [[MPMoviePlayerController alloc] initWithContentURL:url];
    //设置播放屏幕
    _player.view.frame = CGRectMake(0, 0, 320, 240);
    [self.view addSubview:_player.view];
    //播放
    [_player play];
}






@end
