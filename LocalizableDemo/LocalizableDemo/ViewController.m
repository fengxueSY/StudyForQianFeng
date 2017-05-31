//
//  ViewController.m
//  LocalizableDemo
//
//  Created by pk on 14/12/23.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    IBOutlet UILabel* label;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    label.text = NSLocalizedString(@"pan", nil);
}




@end
