//
//  ViewController1.m
//  UIToolBarDemo
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
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"next" style:UIBarButtonItemStylePlain target:self action:@selector(next)] autorelease];

    UIToolbar* toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 44)];
    [self.view addSubview:toolBar];
    [toolBar release];
    
    NSMutableArray* array = [NSMutableArray array];
    for (int i = 0; i < 9; i++) {
        if (i%2==0) { // 0 2 4 6 8
            UIBarButtonItem* button = [[UIBarButtonItem alloc] initWithTitle:[NSString stringWithFormat:@"%d", i] style:UIBarButtonItemStylePlain target:self action:@selector(buttonClick)];
            //button.width = 60;
            [array addObject:button];
            [button release];
        } else {
            /*
             UIBarButtonSystemItemFlexibleSpace 自适应
             UIBarButtonSystemItemFixedSpace 固定的
             */
            UIBarButtonItem* button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:@selector(buttonClick)];
            button.width = 50;
            [array addObject:button];
            [button release];
        }
        
    }
    /*
     self
     navigationItem
     toolbarItems
     */
    //[toolBar setItems:array];
    //如果是导航自带的toolbar
    [self setToolbarItems:array];
    
    /*
    //本地存储 NSString NSData NSNumber 字典数组
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@"王小虎" forKey:@"name"];
    [userDefaults setInteger:18 forKey:@"age"];
    //同步操作
    [userDefaults synchronize];
    */
    
    //读
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    NSString* name = [userDefaults objectForKey:@"name"];
    NSInteger age = [userDefaults integerForKey:@"age"];
    NSLog(@"%@---%ld",name, age);
}

- (void)buttonClick{

}

- (void)next{
    ViewController2* vc2 = [[ViewController2 alloc] init];
    [self.navigationController pushViewController:vc2 animated:YES];
    [vc2 release];
}





@end
