//
//  BaseTableViewController.m
//  爱限免
//
//  Created by pk on 14/12/9.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()<UISearchBarDelegate>{
    UIRefreshControl* _refreshControl;
    UISearchBar* _searchBar;
}

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = [NSMutableArray array];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 100;
    [self.view addSubview:_tableView];
    [_tableView release];
}

#pragma mark - 搜索
//设置是否需要搜索功能
- (void)setSearch:(BOOL)isSearch{
    if (isSearch) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, WINSIZE.width, 44)];
        _searchBar.showsCancelButton = YES;
        _searchBar.delegate = self;
        self.tableView.tableHeaderView = _searchBar;
        [_searchBar release];
    } else {
        _tableView.tableHeaderView = nil;
    }
}
//点击取消按钮
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}
//点击搜索按钮
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self triggerSearch:searchBar.text];
    [searchBar resignFirstResponder];
}

//触发搜索
- (void)triggerSearch:(NSString*)text{

}

#pragma mark - 下拉刷新
//设置是否需要下拉刷新功能
- (void)setDownRefresh:(BOOL)isRefresh{
    if (isRefresh == YES) {
        _refreshControl = [[UIRefreshControl alloc] init];
        _refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新..."];
        [_refreshControl addTarget:self action:@selector(triggerDownRefresh) forControlEvents:UIControlEventValueChanged];
        [self.tableView addSubview:_refreshControl];
    } else {
        //移除下拉刷新
        if (_refreshControl) {
            [_refreshControl removeFromSuperview];
            _refreshControl = nil;
        }
    }
}

//结束下拉刷新
- (void)endRefresh{
    [_refreshControl endRefreshing];
}

//触发下拉刷新
- (void)triggerDownRefresh{

}

#pragma mark - 上拉刷新
//设置是否需要上拉加载更多
- (void)setUpRefresh:(BOOL)isRefresh{
    _isUpRefresh = isRefresh;
}

//触发上拉刷新
- (void)triggerUpRefresh{

}

#pragma mark - ScrollView delegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    //判断上拉刷新
    if (scrollView.contentOffset.y + scrollView.frame.size.height > scrollView.contentSize.height + 40 && _isUpRefresh) {
        [self triggerUpRefresh];
    }
}

#pragma mark - UITableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

- (void)dealloc{
    self.dataArray = nil;
    [super dealloc];
}


@end
