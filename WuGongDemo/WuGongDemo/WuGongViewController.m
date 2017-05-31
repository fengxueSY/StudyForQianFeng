//
//  WuGongViewController.m
//  WuGongDemo
//
//  Created by pk on 14/12/8.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "WuGongViewController.h"
#import "FMDBManager.h"

@interface WuGongViewController ()<UITableViewDataSource, UITableViewDelegate>{
    UITableView* _tableView;
    NSArray* _dataArray;
    NSMutableArray* _selectArray;
}

@end

@implementation WuGongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _selectArray = [[NSMutableArray alloc] init];

    //得到武功数组
    FMDBManager* manager = [FMDBManager sharedManager];
    _dataArray = [manager getWuGongArray];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView setEditing:YES];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
}

//完成
- (void)done{
    if (self.block) {
        self.block([_selectArray componentsJoinedByString:@" "]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    
    cell.textLabel.text = _dataArray[indexPath.row];
    
    return cell;
}

//多选
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleInsert | UITableViewCellEditingStyleDelete;
}

//选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_selectArray addObject:_dataArray[indexPath.row]];
}

//取消选中
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_selectArray removeObject:_dataArray[indexPath.row]];
}



@end
