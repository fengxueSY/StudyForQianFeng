//
//  FMDBManager.m
//  WuGongDemo
//
//  Created by pk on 14/12/8.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "FMDBManager.h"
#import "FMDatabase.h"

@interface FMDBManager (){
    FMDatabase* _db;
}

@end

static FMDBManager* manager = nil;
@implementation FMDBManager

+ (FMDBManager *)sharedManager{
    if (manager == nil) {
        manager = [[[self class] alloc] init];
    }
    return manager;
}

//初始化
- (instancetype)init{
    if (self = [super init]) {
        //数据库路径
        NSString* path = [NSString stringWithFormat:@"%@/Documents/data.db", NSHomeDirectory()];
        _db = [[FMDatabase alloc] initWithPath:path];
        //打开
        if (![_db open]) {
            NSLog(@"打开失败");
        }
        //创建用户表
        BOOL res = [_db executeUpdate:@"create table if not exists USER(uid integer primary key autoincrement,name,menpai)"];
        if (res == NO) {
            NSLog(@"用户表创建失败");
        }
        //创建武功表
        res = [_db executeUpdate:@"create table if not exists WUGONG(uid,name)"];
        if (res == NO) {
            NSLog(@"武功表创建失败");
        }
    }
    return self;
}

//得到门派
- (NSArray*)getMenpaiArray{
    return @[@"武当", @"少林", @"峨眉", @"华山", @"昆仑", @"丐帮"];
}

//得到武功
- (NSArray*)getWuGongArray{
    return @[@"一阳指", @"蛤蟆功", @"北冥神功", @"九阴真经", @"乾坤大挪移", @"玄冥神掌"];
}

//添加用户
- (void)addUser:(UserItem*)userItem{
    BOOL res = [_db executeUpdate:@"insert into USER(name,menpai) values(?,?)", userItem.name, userItem.menpai];
    if (res == NO) {
        NSLog(@"插入用户失败");
        return;
    }
    //拿到用户的uid
    FMResultSet* set = [_db executeQuery:@"select * from USER order by uid desc limit 1"];
    [set next];
    int uid = [set intForColumn:@"uid"];
    //添加武功
    for (NSString* wugong in userItem.wugong) {
        res = [_db executeUpdate:@"insert into WUGONG values(?,?)", [NSNumber numberWithInt:uid], wugong];
        if (res == NO) {
            NSLog(@"武功添加失败");
        }
    }
}

//查询所有用户
- (NSArray*)getAllUser{
    FMResultSet* set = [_db executeQuery:@"select * from USER"];
    //创建用户数组
    NSMutableArray* array = [NSMutableArray array];
    while ([set next]) {
        UserItem* userItem = [[UserItem alloc] init];
        userItem.uid = [set intForColumn:@"uid"];
        userItem.name = [set stringForColumn:@"name"];
        userItem.menpai = [set stringForColumn:@"menpai"];
        userItem.wugong = [self getWuGong:userItem.uid];
        [array addObject:userItem];
    }
    return array;
}

//通过uid取得武功
- (NSArray*)getWuGong:(int)uid{
    FMResultSet* set = [_db executeQuery:@"select * from WUGONG where uid=?",[NSNumber numberWithInt:uid]];
    //创建武功数组
    NSMutableArray* array = [NSMutableArray array];
    while ([set next]) {
        NSString* wugong = [set stringForColumn:@"name"];
        [array addObject:wugong];
    }
    return array;
}





@end
