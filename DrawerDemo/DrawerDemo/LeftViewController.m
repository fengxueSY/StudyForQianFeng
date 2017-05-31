//
//  LeftViewController.m
//  DrawerDemo
//
//  Created by pk on 14/12/23.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "LeftViewController.h"
#import "AppDelegate.h"

@interface LeftViewController ()

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ID"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID" forIndexPath:indexPath];
    

    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AppDelegate* app = [UIApplication sharedApplication].delegate;
    if (indexPath.row == 0) {
        [app.dvc setPaneViewController:app.vc1];
    }
    if (indexPath.row == 1) {
        [app.dvc setPaneViewController:app.vc2];
    }
    //设置显示界面的状态
    [app.dvc setPaneState:MSDynamicsDrawerPaneStateClosed animated:YES allowUserInterruption:NO completion:nil];
}



@end
