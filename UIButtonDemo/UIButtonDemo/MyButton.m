//
//  MyButton.m
//  UIButtonDemo
//
//  Created by pk on 14/11/13.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "MyButton.h"

@interface MyButton (){
    UILabel* _titleLabel;
}
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* selectTitle;

@end

@implementation MyButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //实例化titleLabel
        _titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        [_titleLabel release];
        
        //添加事件
        [self addTarget:self action:@selector(touchDown) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(touchUpInside) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

//按下事件
- (void)touchDown{
    _titleLabel.text = _selectTitle;
    _titleLabel.textColor = [UIColor grayColor];
}

//抬起事件
- (void)touchUpInside{
    _titleLabel.text = _title;
    _titleLabel.textColor = [UIColor blackColor];
}

//设置标题
- (void)setTitle:(NSString *)title selectTitle:(NSString *)selectTitle{
    //设置默认标题
    _titleLabel.text = title;
    //保存正常和点击的标题
    self.title = title;
    /*
     _title = [title copy];
    */
    self.selectTitle = selectTitle;
}




@end
