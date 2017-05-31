//
//  SubjectViewController.m
//  爱限免
//
//  Created by pk on 14/12/9.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "SubjectViewController.h"
#import "SubjectCell.h"
#import "SubjectItem.h"

@interface SubjectViewController ()

@end

@implementation SubjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.rowHeight = 300;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [MyConnection connectionWithUrl:@"http://iappfree.candou.com:8080/free/special" FinishBlock:^(NSData *data) {
        NSArray* array = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        //遍历专题字典
        for (NSDictionary* subDic in array) {
            SubjectItem* subItem = [[SubjectItem alloc] init];
            [subItem setValuesForKeysWithDictionary:subDic];
            //遍历专题里的应用
            NSMutableArray* appArray = [NSMutableArray array];
            for (NSDictionary* appDic in subDic[@"applications"]) {
                AppItem* appItem = [[AppItem alloc] init];
                [appItem setValuesForKeysWithDictionary:appDic];
                [appArray addObject:appItem];
                [appItem release];
            }
            subItem.applications = appArray;
            [self.dataArray addObject:subItem];
            [subItem release];
        }
        [self.tableView reloadData];
    } FailedBlock:^{
        NSLog(@"专题请求失败");
    }];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SubjectCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SubjectCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    SubjectItem* subItem = self.dataArray[indexPath.row];
    //专题标题
    cell.nameLabel.text = subItem.title;
    //专题图片
    [cell.subjectImageView setImageWithURL:[NSURL URLWithString:subItem.img]];
    //小编头像
    [cell.descImageView setImageWithURL:[NSURL URLWithString:subItem.desc_img]];
    //小编推荐
    cell.descLabel.text = subItem.desc;
    //应用模型
    AppItem* appItem1 = subItem.applications[0];
    AppItem* appItem2 = subItem.applications[1];
    AppItem* appItem3 = subItem.applications[2];
    //app1
    cell.nameLabel1.text = appItem1.name;
    cell.commentLabel1.text = [NSString stringWithFormat:@"%@", appItem1.comment];
    cell.downloadLabel1.text = appItem1.downloads;
    [cell.starView1 setStarScore:[appItem1.starOverall floatValue]];
    [cell.iconView1 setImageWithURL:[NSURL URLWithString:appItem1.iconUrl]];
    //app2
    cell.nameLabel2.text = appItem2.name;
    cell.commentLabel2.text = [NSString stringWithFormat:@"%@", appItem2.comment];
    cell.downloadLabel2.text = appItem2.downloads;
    [cell.starView2 setStarScore:[appItem2.starOverall floatValue]];
    [cell.iconView2 setImageWithURL:[NSURL URLWithString:appItem2.iconUrl]];

    //app3
    cell.nameLabel3.text = appItem3.name;
    cell.commentLabel3.text = [NSString stringWithFormat:@"%@", appItem3.comment];
    cell.downloadLabel3.text = appItem3.downloads;
    [cell.starView3 setStarScore:[appItem3.starOverall floatValue]];
    [cell.iconView3 setImageWithURL:[NSURL URLWithString:appItem3.iconUrl]];

    
    return cell;
}





@end
