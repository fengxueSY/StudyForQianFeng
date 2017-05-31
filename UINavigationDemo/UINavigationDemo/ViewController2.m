//
//  ViewController2.m
//  UINavigationDemo
//
//  Created by pk on 14/11/18.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "ViewController2.h"
#import "ViewController3.h"

@interface ViewController2 ()

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"vc2";
    self.view.backgroundColor = [UIColor blueColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"next" style:UIBarButtonItemStylePlain target:self action:@selector(buttonClick)];
}

- (void)buttonClick{
    ViewController3* vc3 = [[ViewController3 alloc] init];
    [self.navigationController pushViewController:vc3 animated:YES];

    //[vc3 release];
}



@end
