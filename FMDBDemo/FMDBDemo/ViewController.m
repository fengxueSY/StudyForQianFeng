//
//  ViewController.m
//  FMDBDemo
//
//  Created by pk on 14/12/5.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "ViewController.h"
#import "FMDatabase.h"

@interface ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
    IBOutlet UIImageView* _headView;
    IBOutlet UITextField* _nameField;
    IBOutlet UITextField* _desField;
    FMDatabase* _db;
}

//增 删 查 改
- (IBAction)add:(id)sender;
- (IBAction)del:(id)sender;
- (IBAction)fetch:(id)sender;
- (IBAction)update:(id)sender;

@end

@implementation ViewController

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    _headView.image = info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)selectImage{
    UIImagePickerController* ipc = [[UIImagePickerController alloc] init];
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectImage)];
    [_headView addGestureRecognizer:tap];
    
    //数据库存在沙盒目录
    NSString* path = [NSString stringWithFormat:@"%@/Documents/data.db", NSHomeDirectory()];
    NSLog(@"%@", path);
    //数据库操作类
    _db = [[FMDatabase alloc] initWithPath:path];
    //打开数据库
    BOOL res = [_db open];
    //[_db close];
    if (res == NO) {
        NSLog(@"数据库打开失败");
        return;
    }
    //创建一个表
    res = [_db executeUpdate:@"create table if not exists USER(uid integer primary key autoincrement, name, des, image)"];
    if (res == NO) {
        NSLog(@"创建表失败");
    }
}

- (void)add:(id)sender{
    //添加一条数据
    //NSString, NSNumber, NSData
    if (_nameField.text == nil || _desField.text == nil || _headView.image == nil) {
        return;
    }
    NSData* data = UIImagePNGRepresentation(_headView.image);
    //插入数据
    BOOL res = [_db executeUpdate:@"insert into USER(name,des,image) values(?,?,?)", _nameField.text, _desField.text, data];
    if (res == NO) {
        NSLog(@"插入数据失败");
    }
    _nameField.text = @"";
    _desField.text = @"";
    _headView.image = nil;
}

//删除
- (void)del:(id)sender{
    BOOL res = [_db executeUpdate:@"delete from USER where name=?", _nameField.text];
    if (res == NO) {
        NSLog(@"删除失败");
    }
}

//查询
- (void)fetch:(id)sender{
    FMResultSet* set = [_db executeQuery:@"select * from USER"];
    /*
     id name  des image
     1 曹操   魏王
     2 曹仁   大将
     3 曹洪   大将
     4 夏侯惇  大将
     */
    //每次遍历，指针向下走一行，我们通过列数取值
    while ([set next]) {
        int uid = [set intForColumn:@"uid"];
        //[set objectForColumnName:@"float"];
        NSString* name = [set stringForColumn:@"name"];
        NSString* des = [set stringForColumn:@"des"];
        NSData* data = [set dataForColumn:@"image"];
        NSLog(@"%d-%@",uid, name);
    }
}

- (void)update:(id)sender{

}


@end
