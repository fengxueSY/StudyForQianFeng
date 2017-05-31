//
//  BaseTableViewController.h
//  爱限免
//
//  Created by pk on 14/12/9.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseTableViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>{
    BOOL _isUpRefresh; //是否需要上拉功能
}

@property (nonatomic, retain) NSMutableArray* dataArray;
@property (nonatomic, assign) UITableView* tableView;
@property (nonatomic, copy) NSString* url;

//设置是否需要上拉加载更多
- (void)setUpRefresh:(BOOL)isRefresh;
//触发上拉刷新
- (void)triggerUpRefresh;

//设置是否需要下拉刷新功能
- (void)setDownRefresh:(BOOL)isRefresh;
//触发下拉刷新
- (void)triggerDownRefresh;
//结束下拉刷新
- (void)endRefresh;

//设置是否需要搜索功能
- (void)setSearch:(BOOL)isSearch;
//触发搜索
- (void)triggerSearch:(NSString*)text;



@end
