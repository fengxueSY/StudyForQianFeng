//
//  ViewController.m
//  UIRefreshDemo
//
//  Created by pk on 14/12/8.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "ViewController.h"
#import "EGORefreshTableHeaderView.h"


@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, EGORefreshTableHeaderDelegate>{
    UITableView* _tableView;
    NSMutableArray* _dataArray;
    EGORefreshTableHeaderView* _refreshView;
    BOOL _isRefresh;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray = [NSMutableArray arrayWithObjects:@"景天", @"雪见", @"龙葵", nil];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    //下拉刷新视图
    _refreshView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, -480, self.view.frame.size.width, 480)];
    _refreshView.delegate = self;
    [_tableView addSubview:_refreshView];
    
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

- (BOOL)prefersStatusBarHidden{
    return YES;
}

//UIScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_refreshView egoRefreshScrollViewDidScroll:scrollView];
}
//结束拖拽
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [_refreshView egoRefreshScrollViewDidEndDragging:scrollView];
}

//下拉刷新
//刷新数据
- (void)refreshData{
    [_dataArray addObject:@"潘松彪"];
    [_tableView reloadData];
    //结束刷新
    [_refreshView egoRefreshScrollViewDataSourceDidFinishedLoading:_tableView];
    _isRefresh = NO;
}

//refresh delegate
//触发刷新
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view{
    //正在刷新
    _isRefresh = YES;
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(refreshData) userInfo:nil repeats:NO];
}

//是否正在刷新
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView *)view{

    return _isRefresh;
}

//返回最后刷新的时间，当前时间
- (NSDate *)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView *)view{
    return [NSDate date];
}








@end
