//
//  RegViewController.m
//  LoginDemo
//
//  Created by pk on 14/11/18.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "RegViewController.h"

@interface RegViewController (){
    IBOutlet UITextField* _nameField;
    IBOutlet UITextField* _passwordField;
    IBOutlet UITextField* _nickNameField;
}

- (IBAction)reg:(id)sender;

@end

@implementation RegViewController

//注册
- (void)reg:(id)sender{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray* array = [userDefaults objectForKey:@"userinfo"];
    //userArray 就是我们保存用户的数组
    NSMutableArray* userArray = nil;
    if (array == nil) {
        userArray = [NSMutableArray array];
    } else {
        userArray = [NSMutableArray arrayWithArray:array];
    }
    //遍历用户名
    for (NSDictionary* userDic in userArray) {
        if ([userDic[@"name"] isEqualToString:_nameField.text]) {
            NSLog(@"用户名重复");
            return;
        }
    }
    //保存用户信息
    NSDictionary* userDic = @{
                @"name":_nameField.text,
                @"password":_passwordField.text,
                @"nickname":_nickNameField.text
                };
    [userArray addObject:userDic];
    [userDefaults setObject:userArray forKey:@"userinfo"];
    [userDefaults synchronize];
    //返回上一页
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

@end
