//
//  ViewController1.m
//  UINavigationDemo
//
//  Created by pk on 14/11/18.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "ViewController1.h"
#import "ViewController2.h"

@interface ViewController1 ()

@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"vc1";
    self.view.backgroundColor = [UIColor redColor];
    //每一个UIViewCOntroller都会自带一个NavigationItem
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"next" style:UIBarButtonItemStylePlain target:self action:@selector(buttonClick)];
    NSLog(@"viewDidLoad");
}

- (void)viewWillAppear:(BOOL)animated{
    NSLog(@"viewWillAppear");
}

- (void)viewWillDisappear:(BOOL)animated{
    NSLog(@"viewWillDisappear");
}

- (void)buttonClick{
    ViewController2* vc2 = [[ViewController2 alloc] init];
    [self.navigationController pushViewController:vc2 animated:YES];
}




@end
