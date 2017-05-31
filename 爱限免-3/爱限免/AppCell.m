//
//  AppCell.m
//  爱限免
//
//  Created by pk on 14/12/9.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "AppCell.h"

@implementation AppCell

- (void)awakeFromNib {
    //圆角
    self.iconView.layer.cornerRadius = 12;
    self.iconView.layer.masksToBounds = YES;
    
    //裁剪，子视图超出部分不显示
    //self.iconView.clipsToBounds = YES;
}


@end
