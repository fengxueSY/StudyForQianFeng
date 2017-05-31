//
//  ViewController.m
//  CopyDemo
//
//  Created by pk on 14/11/24.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     无论拷贝前对象是可变的还是不可变的
     copy 拷贝下的对象是不可变的
     mutableCopy 拷贝下的对象是可变的
     */
    NSString* str = @"潘松彪";
    NSMutableString* str2 = [str mutableCopy];
    [str2 setString:@"令狐冲"];
    //NSLog(@"%@", str2);
    
    NSMutableArray* array = [NSMutableArray arrayWithObjects:@"潘松彪", @"张健", @"郭文明", nil];
    NSMutableArray* array2 = [array mutableCopy];
    [array2 addObject:@"西门吹雪"];
    
//    Person* person = [[Person alloc] init];
//    NSMutableString* name = [NSMutableString stringWithFormat:@"叶孤城"];
//    person.name = name;
//    [name setString:@"陆小凤"];
//    NSLog(@"%@", person.name);
    
    //要让一个自定义的类支持copy,要让自定义的类遵守NSCopying协议，要让一个类支持mutableCopy，自定义的类要遵守NSMutableCopying协议
    Person* person = [[Person alloc] init];
    person.name = [NSMutableString stringWithFormat:@"潘松彪"];
    Person* person2 = [person mutableCopy];
    [person.name setString:@"赵天霸"];
    //NSLog(@"%@", person2.name);
    
    
    
}









@end
