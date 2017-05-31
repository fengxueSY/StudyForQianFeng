//
//  RootViewController.m
//  AutoLayoutDemo
//
//  Created by pk on 14/11/17.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController (){
    IBOutlet UITextField* _textField;
    IBOutlet UITextView* _textView;
    NSMutableArray* _userArray;
}

- (IBAction)addUser:(id)sender;
- (IBAction)fetch:(id)sender;


@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _userArray = [[NSMutableArray alloc] init];
    
    
}

//添加用户
- (void)addUser:(id)sender{
    if (_textField.text.length > 2) {
        [_userArray addObject:_textField.text];
        _textField.text = @"";
    }
}

//查询用户
- (void)fetch:(id)sender{
    _textView.text = @"";
    for (NSString* str in _userArray) {
        _textView.text = [NSString stringWithFormat:@"%@%@\n",_textView.text, str];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_textField resignFirstResponder];
    [_textView resignFirstResponder];
}



@end
