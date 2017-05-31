//
//  PlayerView.h
//  AVPlayerDemo
//
//  Created by pk on 14/12/19.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface PlayerView : UIView

//关联播放器
- (void)setPlayer:(AVPlayer*)player;

@end
