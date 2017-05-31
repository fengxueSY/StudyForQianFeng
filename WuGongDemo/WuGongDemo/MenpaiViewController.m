//
//  MenpaiViewController.m
//  WuGongDemo
//
//  Created by pk on 14/12/8.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "MenpaiViewController.h"
#import "FMDBManager.h"

@interface MenpaiViewController ()<UITableViewDelegate, UITableViewDataSource>{
    UITableView* _tableView;
    NSArray* _dataArray;
}

@end

@implementation MenpaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    FMDBManager* manager = [FMDBManager sharedManager];
    _dataArray = [manager getMenpaiArray];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ID"];
    }
    
    cell.textLabel.text = _dataArray[indexPath.row];
    
    return cell;
}

//选中一个门派并返回
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* menpai = _dataArray[indexPath.row];
    if (self.block) {
        self.block(menpai);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}



@end
