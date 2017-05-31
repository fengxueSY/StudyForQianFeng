//
//  ViewController.m
//  UITableViewDemo
//
//  Created by pk on 14/11/25.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>{
    UITableView* _tableView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    //数据源
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView release];
    
    //背景视图
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"10_0.jpg"];
    //_tableView.backgroundView = imageView;
    [imageView release];
    
    //行高
    _tableView.rowHeight = 100;
    //分割线类型
    //_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //分割线颜色
    _tableView.separatorColor = [UIColor blueColor];
    //分割线Inset
    _tableView.separatorInset = UIEdgeInsetsZero;
    
    //重新加载数据
    //[_tableView reloadData];
}

//添加索引
- (NSArray*)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return @[@"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h", @"i", @"j"];
}

//组和索引对应关系
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    NSLog(@"%@---%ld", title, index);
    return index;
}

//多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}

//组头标题
- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"组%ld", section];
}

//组头视图
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 50)];
    label.text = [NSString stringWithFormat:@"组视图%ld", section];
    return [label autorelease];
}

//组头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

//组尾标题
- (NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"end%ld",section];
}

//组尾视图
//- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//
//}

//组尾高度
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//
//}

//必须实现的方法
//多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 5;
    } else if (section == 1){
        return 10;
    }
    return 20;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //队列描述符
    static NSString* ID = @"ID";
    //从ID队列里面去获取Cell
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //如果为空，队列里面是没有的，创建一个cell
    if (cell == nil) {
        //1.类型 2.队列
        //当出了屏幕以后，cell会自动保存到名字叫做ID的队列中
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID] autorelease];
        //选中样式
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //选中背景视图
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, tableView.rowHeight)];
        imageView.image = [UIImage imageNamed:@"Nav_Bg.png"];
        cell.selectedBackgroundView = imageView;
        [imageView release];
        //扩展类型
        cell.accessoryType = UITableViewCellAccessoryDetailButton;
        //扩展视图
        UISwitch* mySwitch = [[UISwitch alloc] init];
        cell.accessoryView = mySwitch;
        
//        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 30)];
//        label.tag = 10;
//        [cell addSubview:label];
//        [label release];
    }
//    UILabel* label = (UILabel*)[cell viewWithTag:10];
//    label.text = [NSString stringWithFormat:@"%ld",indexPath.row];

   
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    cell.detailTextLabel.text = @"副标题/详情...";
    cell.imageView.image = [UIImage imageNamed:@"gerenzhuye.png"];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了第%ld行Button", indexPath.row);
}

//选中一行调用
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"选中%ld组的%ld行", indexPath.section, indexPath.row);
}

//隐藏状态栏
- (BOOL)prefersStatusBarHidden{
    return YES;
}

@end
