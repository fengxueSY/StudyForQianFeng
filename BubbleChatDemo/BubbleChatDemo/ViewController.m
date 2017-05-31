//
//  ViewController.m
//  BubbleChatDemo
//
//  Created by pk on 14/11/28.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "ViewController.h"
#import "ChatCell.h"
#import "ChatItem.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate, UITextFieldDelegate>{
    NSMutableArray* _dataArray;
    UITableView* _tableView;
    UIView* _chatView;
    UITextField* _textField;
}

@end

@implementation ViewController

//隐藏状态栏
- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _dataArray = [[NSMutableArray alloc] init];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 40)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //分割线
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    _chatView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-40, self.view.frame.size.width, 40)];
    _chatView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_chatView];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 5, self.view.frame.size.width - 70, 30)];
    _textField.delegate = self;
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    [_chatView addSubview:_textField];
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(self.view.frame.size.width - 60, 5, 50, 30);
    [button setTitle:@"发送" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(sendText) forControlEvents:UIControlEventTouchUpInside];
    [_chatView addSubview:button];
    
    //监听键盘出现
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //监听键盘消失
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

//键盘出现
- (void)keyboardWillShow:(NSNotification*)noti{
    //键盘Size
    CGSize size = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    _tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 40 - size.height);
    _chatView.frame = CGRectMake(0, self.view.frame.size.height - 40 - size.height, self.view.frame.size.width, 40);
}

//收键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

//键盘将要消失
- (void)keyboardWillHide:(NSNotification*)noti{
    _tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 40);
    _chatView.frame = CGRectMake(0, self.view.frame.size.height - 40, self.view.frame.size.width, 40);
}

- (void)sendText{
    ChatItem* item = [[ChatItem alloc] init];
    item.isSelf = YES;
    item.content = _textField.text;
    _textField.text = @"";
    [_dataArray addObject:item];
    
    //刷新
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:_dataArray.count-1 inSection:0];
    [_tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    //向上滚动
    [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(autoSpeak) userInfo:nil repeats:NO];
}

//自动回复
- (void)autoSpeak{
    //http://lqcjdx.blog.163.com/blog/static/20748924120138344325384/
    NSArray* array = @[@"好的", @"没门", @"你想多了", @"我去", @"去死", @"一边去", @"没问题", @"妥妥的"];
    ChatItem* item = [[ChatItem alloc] init];
    item.isSelf = NO;
    item.content = array[arc4random()%array.count];
    [_dataArray addObject:item];
    
    //刷新
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:_dataArray.count-1 inSection:0];
    [_tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    //向上滚动
    [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChatCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (cell == nil) {
        cell = [[ChatCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
        //选中
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    ChatItem* item = _dataArray[indexPath.row];
    //限制文本最大宽高
    CGSize size = [item.content boundingRectWithSize:CGSizeMake(250, 1000) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0]} context:nil].size;
    if (item.isSelf) {
        //我们自己发的
        cell.leftView.hidden = YES;
        cell.rightView.hidden = NO;
        //显示内容
        cell.rightLabel.text = item.content;
        //显示大小
        cell.rightLabel.frame = CGRectMake(10, 5, size.width, size.height);
        cell.rightView.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width - size.width - 30, 5, size.width + 25, size.height + 20);
    } else {
        //接收到的
        cell.leftView.hidden = NO;
        cell.rightView.hidden = YES;
        cell.leftLabel.text = item.content;
        cell.leftLabel.frame = CGRectMake(15, 5, size.width, size.height);
        cell.leftView.frame = CGRectMake(5, 5, size.width + 25, size.height + 20);
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChatItem* item = _dataArray[indexPath.row];
    //限制文本最大宽高
    CGSize size = [item.content boundingRectWithSize:CGSizeMake(250, 1000) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0]} context:nil].size;
    return size.height + 20 + 10;
}




@end
