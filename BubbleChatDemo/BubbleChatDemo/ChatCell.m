//
//  ChatCell.m
//  BubbleChatDemo
//
//  Created by pk on 14/11/28.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "ChatCell.h"

@implementation ChatCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeView];
    }
    return self;
}

- (void)makeView{
    //气泡图片
    UIImage* leftBubble = [UIImage imageNamed:@"ReceiverTextNodeBkg.png"];
    UIImage* rightBubble = [UIImage imageNamed:@"SenderTextNodeBkg.png"];
    //设定一行一列像素进行复制
    leftBubble = [leftBubble stretchableImageWithLeftCapWidth:30 topCapHeight:35];
    rightBubble = [rightBubble stretchableImageWithLeftCapWidth:30 topCapHeight:35];
    
    //左气泡
    self.leftView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 20, 20)];
    _leftView.image = leftBubble;
    [self.contentView addSubview:_leftView];
    //右气泡
    self.rightView = [[UIImageView alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width - 25, 5, 20, 20)];
    _rightView.image = rightBubble;
    [self.contentView addSubview:_rightView];
    
    //左label
    self.leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 5, 5)];
    _leftLabel.font = [UIFont systemFontOfSize:15.0];
    _leftLabel.numberOfLines = 0;
    [_leftView addSubview:_leftLabel];
    
    //右label
    self.rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 5, 5)];
    _rightLabel.font = [UIFont systemFontOfSize:15.0];
    _rightLabel.numberOfLines = 0;
    [_rightView addSubview:_rightLabel];
}





@end
