//
//  PlayerView.m
//  AVPlayerDemo
//
//  Created by pk on 14/12/19.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "PlayerView.h"

@implementation PlayerView

+ (Class)layerClass{
    return [AVPlayerLayer class];
}

- (void)setPlayer:(AVPlayer *)player{
    AVPlayerLayer* layer = (AVPlayerLayer*)self.layer;
    //关联播放器
    [layer setPlayer:player];
}


@end





