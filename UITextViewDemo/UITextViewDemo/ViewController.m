//
//  ViewController.m
//  UITextViewDemo
//
//  Created by pk on 14/11/17.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextViewDelegate>{
    UITextView* _textView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(50, 50, 200, 200)];
    _textView.backgroundColor = [UIColor grayColor];
    _textView.delegate = self;
    [self.view addSubview:_textView];
    _textView.text = @"aaa\nbbb";
}






@end
