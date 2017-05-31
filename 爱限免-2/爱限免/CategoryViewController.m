//
//  CategoryViewController.m
//  爱限免
//
//  Created by pk on 14/12/10.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "CategoryViewController.h"
#import "CateAppViewController.h"
#import "CategoryCell.h"
#import "CategoryItem.h"

@interface CategoryViewController ()

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"限免分类";
    
    self.tableView.rowHeight = 80.0;
    
    [MyConnection connectionWithUrl:@"http://1000phone.net:8088/app/iAppFree/api/appcate.php" FinishBlock:^(NSData *data) {
        //解析分类数据
        NSArray* array = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        //遍历每一个分类
        for (NSDictionary* dic in array) {
            CategoryItem* cateItem = [[CategoryItem alloc] init];
            //kvc赋值
            [cateItem setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:cateItem];
            [cateItem release];
        }
        [self.tableView reloadData];
    } FailedBlock:^{
        NSLog(@"分类请求失败");
    }];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CategoryCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CategoryCell" owner:self options:nil] lastObject];
    }
    
    CategoryItem* cateItem = self.dataArray[indexPath.row];
    cell.nameLabel.text = cateItem.categoryCname;
    cell.desLabel.text = [NSString stringWithFormat:@"共有%@款应用，其中限免%@", cateItem.categoryCount, cateItem.limited];
    [cell.picView setImageWithURL:[NSURL URLWithString:cateItem.picUrl]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CategoryItem* cateItem = self.dataArray[indexPath.row];
    CateAppViewController* cvc = [[CateAppViewController alloc] init];
    cvc.title = cateItem.categoryCname;
    cvc.categoryId = cateItem.categoryId;
    [self.navigationController pushViewController:cvc animated:YES];
    [cvc release];
}


@end
