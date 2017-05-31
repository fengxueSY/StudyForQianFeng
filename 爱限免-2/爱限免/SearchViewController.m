//
//  SearchViewController.m
//  爱限免
//
//  Created by pk on 14/12/10.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

//设置请求地址
- (void)setRequestUrl{
    self.url = [NSString stringWithFormat:@"http://1000phone.net:8088/app/iAppFree/api/limited.php?page=%d&number=20&search=%@", _page++, [self.title stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //关闭搜索功能
    [self setSearch:NO];
}


@end
