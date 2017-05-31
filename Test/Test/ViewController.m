//
//  ViewController.m
//  Test
//
//  Created by pk on 14/11/25.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView* _tableView;
    NSMutableArray* openArray;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    openArray = [[NSMutableArray alloc] init];
    NSNumber* num = [NSNumber numberWithBool:YES];
    [openArray addObject:num];
    [openArray addObject:num];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 460) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(0, 0, 320, 35);
    button.tag = section;
    [button setImage:[UIImage imageNamed:@"Nav_Bg.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}

- (void)buttonClick:(UIButton*)button{
    BOOL isOpen = [[openArray objectAtIndex:button.tag] boolValue];
    if (isOpen == YES) {
        NSNumber* num = [NSNumber numberWithBool:NO];
        [openArray replaceObjectAtIndex:button.tag withObject:num];
    } else {
        NSNumber* num = [NSNumber numberWithBool:YES];
        [openArray replaceObjectAtIndex:button.tag withObject:num];
    }
    
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:button.tag] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([[openArray objectAtIndex:section] boolValue]  == NO) {
        return 0;
    }
    return 10;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ID"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"好友%ld",indexPath.row];
    
    return cell;
}


@end
