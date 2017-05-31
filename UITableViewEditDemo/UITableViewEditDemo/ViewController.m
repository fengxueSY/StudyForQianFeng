//
//  ViewController.m
//  UITableViewEditDemo
//
//  Created by pk on 14/11/25.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView* _tableView;
    NSMutableArray* _dataArray;
    NSMutableArray* _delArray;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;

    _dataArray = [[NSMutableArray alloc] initWithObjects:@"李逍遥", @"赵灵儿", @"林月如", nil];
    _delArray = [[NSMutableArray alloc] init];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    UIBarButtonItem* button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(edit)];
    self.navigationItem.leftBarButtonItem = button;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"del" style:UIBarButtonItemStylePlain target:self action:@selector(del)];
}

- (void)del{
    // 1 2 3
    NSMutableArray* array = [NSMutableArray array];
    for (NSIndexPath* indexPath in _delArray) {
        NSString* str = [_dataArray objectAtIndex:indexPath.row];
        [array addObject:str];
    }
    //
    [_dataArray removeObjectsInArray:array];
    //tableView上删除
    [_tableView deleteRowsAtIndexPaths:_delArray withRowAnimation:UITableViewRowAnimationFade];
    
    [_delArray removeAllObjects];
}

- (void)edit{
    if (_tableView.editing) {
        [_tableView setEditing:NO animated:YES];
    } else {
        //清空删除数组
        [_delArray removeAllObjects];
        [_tableView setEditing:YES animated:YES];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* ID = @"ID";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = _dataArray[indexPath.row];
    
    return cell;
}

//编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

//编辑类型
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleInsert | UITableViewCellEditingStyleDelete;
}

//编辑操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    //删除
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //从数组中删除
        [_dataArray removeObjectAtIndex:indexPath.row];
        //从tableView中删除
        //[tableView reloadData];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    //插入
    if (editingStyle == UITableViewCellEditingStyleInsert) {
        //往数组中添加一项内容
        [_dataArray insertObject:@"酒剑仙" atIndex:indexPath.row];
        //tableView添加一行
        [tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"select");
    if (tableView.editing == YES) {
        [_delArray addObject:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"deSelect");
    if (tableView.editing == YES) {
        [_delArray removeObject:indexPath];
    }
}







@end
