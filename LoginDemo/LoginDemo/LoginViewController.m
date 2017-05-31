//
//  LoginViewController.m
//  LoginDemo
//
//  Created by pk on 14/11/18.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "LoginViewController.h"
#import "RegViewController.h"
#import "HomeViewController.h"

@interface LoginViewController (){
    IBOutlet UITextField* _nameField;
    IBOutlet UITextField* _passwordField;
}

//注册页面
- (IBAction)reg:(id)sender;
//登陆页面
- (IBAction)login:(id)sender;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)reg:(id)sender{
    //显示注册页面
    RegViewController* rvc = [[RegViewController alloc] init];
    //模态视图显示  显示一个页面
    [self presentViewController:rvc animated:YES completion:^{
        NSLog(@"页面加载完毕");
    }];
    [rvc release];
}

- (void)viewWillAppear:(BOOL)animated{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray* userArray = [userDefaults objectForKey:@"userinfo"];
    if (userArray) {
        NSDictionary* userDic = [userArray lastObject];
        _nameField.text = userDic[@"name"];
        _passwordField.text = userDic[@"password"];
    }
}

- (void)login:(id)sender{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray* userArray = [userDefaults objectForKey:@"userinfo"];
    for (NSDictionary* userDic in userArray) {
        if ([_nameField.text isEqualToString:userDic[@"name"]] && [_passwordField.text isEqualToString:userDic[@"password"]]) {
            HomeViewController* hvc = [[HomeViewController alloc] init];
            hvc.view.backgroundColor = [UIColor whiteColor];
            hvc.title = _nameField.text;
            hvc.nickNameLabel.text = userDic[@"nickname"];
            [self.navigationController pushViewController:hvc animated:YES];
            [hvc release];
            return;
        }
    }
}


@end
