//
//  BaseTableViewController.h
//  爱限免
//
//  Created by pk on 14/12/9.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseTableViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) NSMutableArray* dataArray;
@property (nonatomic, assign) UITableView* tableView;

@end
