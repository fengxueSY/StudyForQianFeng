//
//  AddUserViewController.m
//  WuGongDemo
//
//  Created by pk on 14/12/8.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "AddUserViewController.h"
#import "MenpaiViewController.h"
#import "WuGongViewController.h"
#import "FMDBManager.h"

@interface AddUserViewController (){
    IBOutlet UITextField* _nameField;
    IBOutlet UIButton* _menpaiButton;
    IBOutlet UIButton* _wugongButton;
}

//添加用户
- (IBAction)addUser:(id)sender;

@end

@implementation AddUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _wugongButton.titleLabel.numberOfLines = 0;
}

//添加一个用户
- (void)addUser:(id)sender{
    FMDBManager* manager = [FMDBManager sharedManager];
    UserItem* userItem = [[UserItem alloc] init];
    userItem.name = _nameField.text;
    userItem.menpai = _menpaiButton.currentTitle;
    userItem.wugong = [_wugongButton.currentTitle componentsSeparatedByString:@" "];
    [manager addUser:userItem];
    
    _nameField.text = @"";
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //拿到要推送的页面指针
    //如果要进入门派
    if ([segue.destinationViewController isKindOfClass:[MenpaiViewController class]]) {
        MenpaiViewController* mvc = segue.destinationViewController;
        mvc.block = ^(NSString* menpai){
            [_menpaiButton setTitle:menpai forState:UIControlStateNormal];
        };
    }
    //如果要进入的是武功页面
    if ([segue.destinationViewController isKindOfClass:[WuGongViewController class]]) {
        WuGongViewController* wvc = segue.destinationViewController;
        wvc.block = ^(NSString* wugong){
            [_wugongButton setTitle:wugong forState:UIControlStateNormal];
        };
    }
}


@end
