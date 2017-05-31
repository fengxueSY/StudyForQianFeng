//
//  RootViewController.m
//  UITextFieldDemo
//
//  Created by pk on 14/11/17.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()<UITextFieldDelegate>{
    UITextField* _textField;
}

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //文本输入框
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(50, 50, 200, 30)];
    //输入框类型
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    //文本
    _textField.text = @"困吗？";
    //属性字符串
    //_textField.attributedText = [[NSAttributedString alloc] initWithString:@"出去。。。" attributes:nil];
    //占位符
    _textField.placeholder = @"请输入内容。。。";
    //_textField.attributedPlaceholder
    //对齐方式
    _textField.textAlignment = NSTextAlignmentCenter;
    //文本颜色
    _textField.textColor = [UIColor redColor];
    //字体
    _textField.font = [UIFont systemFontOfSize:20.0];
    //开始编辑时候清空
    _textField.clearsOnBeginEditing = NO;
    //适应字体大小
    _textField.adjustsFontSizeToFitWidth = YES;
    //适应的最小字号
    _textField.minimumFontSize = 1.0;
    //允许编辑
    //_textField.enabled = NO;
    //清除按钮的样式
    _textField.clearButtonMode = UITextFieldViewModeAlways;
    //左视图
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    imageView.image = [UIImage imageNamed:@"00.png"];
    _textField.leftView = imageView;
    _textField.leftViewMode = UITextFieldViewModeAlways;
    //_textField.rightView
    //安全输入
    _textField.secureTextEntry = NO;
    //自动大写
    _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    //键盘类型
    _textField.keyboardType = UIKeyboardTypeURL;
    //return键类型
    _textField.returnKeyType = UIReturnKeySend;
    //扩展视图
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    view.backgroundColor = [UIColor purpleColor];
    _textField.inputAccessoryView = view;
    //代理
    _textField.delegate = self;
    
    [self.view addSubview:_textField];
    [_textField release];
    
    //获得第一响应 让键盘出来
    [_textField becomeFirstResponder];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //收键盘
    [_textField resignFirstResponder];
}

//将要开始编辑
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NSLog(@"ShouldBegin");
    return YES;
}

//已经开始编辑
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"DidBegin");
}

//将要结束编辑
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}

//已经结束编辑
- (void)textFieldDidEndEditing:(UITextField *)textField{

}

//将要改变字符调用
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.text.length > 8 && (![string isEqualToString:@""])) {
        return NO;
    }
    
    return YES;
}

//清除按钮按下是否有效
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}

//按下了return键调用
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


@end
