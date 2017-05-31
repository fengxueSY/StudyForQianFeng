//
//  ViewController.m
//  WuGongDemo
//
//  Created by pk on 14/12/8.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "ViewController.h"
#import "FMDBManager.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>{
    UITableView* _tableView;
    NSArray* _dataArray;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (void)viewWillAppear:(BOOL)animated{
    //查询用户并刷新表格
    FMDBManager* manager = [FMDBManager sharedManager];
    _dataArray = [manager getAllUser];
    [_tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ID"];
    }
    
    UserItem* userItem = _dataArray[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@     %@", userItem.name, userItem.menpai];
    cell.detailTextLabel.text = [userItem.wugong componentsJoinedByString:@" "];
    
    return cell;
}


@end
