//
//  LimitViewController.m
//  爱限免
//
//  Created by pk on 14/12/9.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "LimitViewController.h"
#import "AppCell.h"
#import "AppItem.h"

@interface LimitViewController ()

@end

@implementation LimitViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //请求数据
    [MyConnection connectionWithUrl:@"http://iappfree.candou.com:8080/free/applications/limited?page=1&number=10" FinishBlock:^(NSData *data) {
        //解析json
        NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        //遍历每个应用
        for (NSDictionary* appDic in dic[@"applications"]) {
            AppItem* appItem = [[AppItem alloc] init];
            //KVC赋值
            [appItem setValuesForKeysWithDictionary:appDic];
            appItem.des = appDic[@"description"];
            [self.dataArray addObject:appItem];
            [appItem release];
        }
        [self.tableView reloadData];
    } FailedBlock:^{
        NSLog(@"加载失败");
    }];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AppCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AppCell" owner:self options:nil] lastObject];
    }
    //取数据模型
    AppItem* appItem = self.dataArray[indexPath.row];
    //赋值
    cell.nameLabel.text = appItem.name;
    //价格
    cell.priceLabel.text = [NSString stringWithFormat:@"￥%@", appItem.lastPrice];
    //类型
    cell.categoryLabel.text = appItem.categoryName;
    //分享
    cell.shareLabel.text = [NSString stringWithFormat:@"分享:%@", appItem.shares];
    //收藏
    cell.favoriteLabel.text = [NSString stringWithFormat:@"收藏:%@", appItem.favorites];
    //下载
    cell.downloadLabel.text = [NSString stringWithFormat:@"下载:%@", appItem.downloads];
    //图标
    [cell.iconView setImageWithURL:[NSURL URLWithString:appItem.iconUrl]];
    //时间 2014-12-10 01:01:34.0
    cell.dateLabel.text = [NSString stringWithFormat:@"剩余: %@",[self getExpireTime:appItem.expireDatetime]];
    
    return cell;
}

//把过期时间转成剩余时间
- (NSString*)getExpireTime:(NSString*)dateStr{
    //2014-12-10 01:01:34.0 NSDate
    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
    //设定一下时间的格式
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss.S";
    //过期日期
    NSDate* date = [formatter dateFromString:dateStr];
    //过期日期距今还有多少秒
    int time = [date timeIntervalSinceNow];
    //时
    int h = time / 3600;
    //分
    int m = (time % 3600) / 60;
    //秒
    int s = time % 60;
    return [NSString stringWithFormat:@"%02d:%02d:%02d", h, m, s];
}


@end
