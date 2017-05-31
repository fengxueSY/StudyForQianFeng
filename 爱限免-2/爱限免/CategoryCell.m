//
//  CategoryCell.m
//  爱限免
//
//  Created by pk on 14/12/10.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "CategoryCell.h"

@implementation CategoryCell

- (void)awakeFromNib {
    //圆角
    self.picView.layer.cornerRadius = 12;
    self.picView.layer.masksToBounds = YES;
    
    
}


@end
