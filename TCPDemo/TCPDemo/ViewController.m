//
//  ViewController.m
//  TCPDemo
//
//  Created by pk on 14/12/17.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "ViewController.h"
#import "AsyncSocket.h"

@interface ViewController ()<AsyncSocketDelegate>{
    IBOutlet UITextField* _ipField;
    IBOutlet UITextField* _textField;
    IBOutlet UITextView* _textView;
    //客户端
    AsyncSocket* _sendSocket;
    //服务端
    AsyncSocket* _recvSocket;
    
    NSMutableArray* _socketArray;
}

- (IBAction)conToHost:(id)sender;
- (IBAction)sendText:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _socketArray = [[NSMutableArray alloc] init];

    //服务端
    _recvSocket = [[AsyncSocket alloc] initWithDelegate:self];
    //监听有没有客户端来连接
    [_recvSocket acceptOnPort:6666 error:nil];
    
    //客户端
    _sendSocket = [[AsyncSocket alloc] initWithDelegate:self];
}

//当接收到客户端来连接
//newSocket是新生成的套接字，与客户端连接
- (void)onSocket:(AsyncSocket *)sock didAcceptNewSocket:(AsyncSocket *)newSocket{
    [_socketArray addObject:newSocket];
    //等待客户端发送消息
    [newSocket readDataWithTimeout:-1 tag:0];
}

//当接收到客户端发送的消息
- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSString* str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@", str);
    _textView.text = [NSString stringWithFormat:@"%@%@:%@\n", _textView.text, sock.connectedHost, str];
    //继续监听客户端发送消息
    [sock readDataWithTimeout:-1 tag:0];
}

//连接服务端
- (void)conToHost:(id)sender{
    //如果客户端已经连接，先断开
    if (_sendSocket.isConnected) {
        [_sendSocket disconnect];
    }
    //连接
    [_sendSocket connectToHost:_ipField.text onPort:6666 withTimeout:30 error:nil];
}

//连接成功
- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port{
    NSLog(@"连接成功");
}

//发送消息
- (void)sendText:(id)sender{
    NSData* data = [_textField.text dataUsingEncoding:NSUTF8StringEncoding];
    _textField.text = @"";
    [_sendSocket writeData:data withTimeout:30 tag:0];
}

//发送成功
- (void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag{
    NSLog(@"发送成功");
}



@end
