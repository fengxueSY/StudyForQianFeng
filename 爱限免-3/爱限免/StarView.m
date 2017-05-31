//
//  StarView.m
//  爱限免
//
//  Created by pk on 14/12/10.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "StarView.h"

@interface StarView (){
    UIView* _backView;
    UIView* _foreView;
}

@end

@implementation StarView
//xib加载
- (void)awakeFromNib{
    [self makeView];
}
//代码加载
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, 75, 14)]) {
        [self makeView];
    }
    return self;
}

- (void)makeView{
    //背景 15 * 14
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 75, 14)];
    [self addSubview:_backView];
    [_backView release];
    //前景
    _foreView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 75, 14)];
    //裁剪子视图
    _foreView.clipsToBounds = YES;
    [self addSubview:_foreView];
    [_foreView release];
    
    //添加星星
    for (int i = 0; i < 5; i++) {
        //背景星星 白色
        UIImageView* backStar = [[UIImageView alloc] initWithFrame:CGRectMake(i * 15, 0, 15, 14)];
        backStar.image = [UIImage imageNamed:@"1.主页_16.png"];
        [_backView addSubview:backStar];
        [backStar release];
        
        //前景星星 颜色
        UIImageView* foreStar = [[UIImageView alloc] initWithFrame:CGRectMake(i * 15, 0, 15, 14)];
        foreStar.image = [UIImage imageNamed:@"1.主页_14.png"];
        [_foreView addSubview:foreStar];
        [foreStar release];
    }
}

- (void)setStarScore:(float)score{
    _foreView.frame = CGRectMake(_foreView.frame.origin.x, _foreView.frame.origin.y, 75 * (score / 5.0), 14);
}

@end
