//
//  ViewController.m
//  RegularExpressionDemo
//
//  Created by pk on 14/11/19.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    UITextView* _textView;
    UITextField* _textField;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _textView = [[UITextView alloc] initWithFrame:CGRectMake(30, 30, 300, 50)];
    _textView.font = [UIFont boldSystemFontOfSize:17.0];
    [self.view addSubview:_textView];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(30, 80, 300, 30)];
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_textField];
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(150, 110, 100, 40);
    [button setTitle:@"匹配" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonClick{
    NSString* pattern = _textField.text;
    //谓词类来匹配正则表达式
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL res = [predicate evaluateWithObject:_textView.text];
    if (res) {
        _textView.text = [NSString stringWithFormat:@"%@ 匹配",_textView.text];
    } else {
        _textView.text = [NSString stringWithFormat:@"%@ 不匹配",_textView.text];
    }
}





@end
