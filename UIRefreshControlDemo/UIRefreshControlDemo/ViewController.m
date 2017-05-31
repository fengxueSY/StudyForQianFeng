//
//  ViewController.m
//  UIRefreshControlDemo
//
//  Created by pk on 14/12/8.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>{
    UITableView* _tableView;
    NSMutableArray* _dataArray;
    UIRefreshControl* refreshControl;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray arrayWithObjects:@"李寻欢", @"上官金虹", @"阿飞", @"沈浪", nil];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    //刷新控件
    refreshControl = [[UIRefreshControl alloc] init];
    //文本
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新..."];
    //添加事件
    [refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [_tableView addSubview:refreshControl];
}

//刷新数据
- (void)refreshData{
    [_dataArray addObject:@"潘松彪"];
    [_tableView reloadData];
    //结束刷新
    [refreshControl endRefreshing];
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新..."];
}

//触发刷新
- (void)refresh{
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"刷新中..."];
    //开始刷新
    [refreshControl beginRefreshing];
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(refreshData) userInfo:nil repeats:NO];
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



@end
