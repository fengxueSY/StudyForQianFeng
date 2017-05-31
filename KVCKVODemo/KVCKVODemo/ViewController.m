//
//  ViewController.m
//  KVC/KVODemo
//
//  Created by pk on 14/11/24.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController (){
    Person* person;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    person = [[Person alloc] init];
//    person.name = @"郭靖";
//    [person setName:@"郭靖"];
    //KVC
    /*
     name1,name2,name3...name20
     */
    /*
     1.找person里面的name属性
     2.如果没有，找_name成员变量
     3.如果还没有，找name成员变量
     4.还没有...调用person的setValue:forUndefinedKey:方法
     */
    [person setValue:@"郭靖" forKey:@"name"];
    
    
    person.wuGong = [[WuGong alloc] init];
    person.wuGong.name = @"九阴白骨爪";
    [person setValue:@"降龙十八掌" forKeyPath:@"wuGong.name"];
    NSLog(@"%@",[person valueForKeyPath:@"wuGong.name"]);
    
    [person setValuesForKeysWithDictionary:@{@"name":@"黄蓉"}];
    NSLog(@"%@", [person valueForKey:@"name"]);

    //KVO 监听一个值发生变化
    //self监听person里面的name是否发生变化
    [person addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:(void*)@"左右互搏"];
    person.name = @"周伯通";
}

//监听到以后会自动调用 object.keyPath
//arc下void*转oc对象要用__bridge去声明
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    NSLog(@"%@", (__bridge NSString*)context);
    NSLog(@"%@变成了%@", keyPath, change[@"new"]);
}





@end
