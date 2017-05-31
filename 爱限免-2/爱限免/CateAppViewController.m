//
//  CateAppViewController.m
//  爱限免
//
//  Created by pk on 14/12/10.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "CateAppViewController.h"

@interface CateAppViewController ()

@end

@implementation CateAppViewController

//设置请求地址
- (void)setRequestUrl{
    self.url = [NSString stringWithFormat:@"http://1000phone.net:8088/app/iAppFree/api/limited.php?page=%d&number=20&cate_id=%@", _page++, self.categoryId];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = nil;
}

@end
