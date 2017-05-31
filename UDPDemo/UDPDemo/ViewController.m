//
//  ViewController.m
//  UDPDemo
//
//  Created by pk on 14/12/17.
//  Copyright (c) 2014年 pk. All rights reserved.
//
/*
 你吃饭了么？
 
 <message>
    <name>王小虎</name>
    <content>
        你吃饭了么?
    </content>
 </message>
 */

#import "ViewController.h"
#import "AsyncUdpSocket.h"
#import "GDataXMLNode.h"

@interface ViewController ()<AsyncUdpSocketDelegate>{
    IBOutlet UITextField* _ipField;
    IBOutlet UITextField* _textField;
    IBOutlet UITextView* _textView;
    //发送端
    AsyncUdpSocket* _sendSocket;
    //接收端
    AsyncUdpSocket* _recvSocket;
}

- (IBAction)sendText:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //发送端
    _sendSocket = [[AsyncUdpSocket alloc] initWithDelegate:self];
    //绑定端口
    [_sendSocket bindToPort:5555 error:nil];
    
    //接收端
    _recvSocket = [[AsyncUdpSocket alloc] initWithDelegate:self];
    //绑定端口
    [_recvSocket bindToPort:6666 error:nil];
    //等待发送端发送消息
    [_recvSocket receiveWithTimeout:-1 tag:0];
}
//接收到了消息
//host 发送端ip port发送端端口
- (BOOL)onUdpSocket:(AsyncUdpSocket *)sock didReceiveData:(NSData *)data withTag:(long)tag fromHost:(NSString *)host port:(UInt16)port{
    /*
     <message>
       <name>王小虎</name>
       <content>你吃饭了么?</content>
     </message>
     */
    GDataXMLDocument* doc = [[[GDataXMLDocument alloc] initWithData:data options:0 error:nil] autorelease];
    //name
    GDataXMLElement* nameEle = [[doc.rootElement elementsForName:@"name"] lastObject];
    //content
    GDataXMLElement* contentEle = [[doc.rootElement elementsForName:@"content"] lastObject];
    
    _textView.text = [NSString stringWithFormat:@"%@%@:%@\n",_textView.text, nameEle.stringValue, contentEle.stringValue];
    NSLog(@"%@:%@:%@",host, nameEle.stringValue, contentEle.stringValue);
    
    //等待发送端发送消息
    [_recvSocket receiveWithTimeout:-1 tag:0];
    
    _textView.contentOffset = CGPointMake(0, _textView.frame.size.height - _textView.contentSize.height);
    
    return YES;
}

//发送
- (void)sendText:(id)sender{
    /*
     <message>
       <name>王小虎</name>
       <content>你吃饭了么?</content>
     </message>
     */
    GDataXMLElement* nameEle = [GDataXMLElement elementWithName:@"name" stringValue:@"令狐冲"];
    GDataXMLElement* contentEle = [GDataXMLElement elementWithName:@"content" stringValue:_textField.text];
    GDataXMLElement* messageEle = [GDataXMLElement elementWithName:@"message"];
    [messageEle addChild:nameEle];
    [messageEle addChild:contentEle];
    //添加声明
    GDataXMLDocument* doc = [[GDataXMLDocument alloc] initWithRootElement:messageEle];
    //设定编码
    [doc setCharacterEncoding:@"utf-8"];
    
    //发送消息
    [_sendSocket sendData:doc.XMLData toHost:_ipField.text port:6666 withTimeout:30 tag:0];
    _textField.text = @"";
}

//发送成功
- (void)onUdpSocket:(AsyncUdpSocket *)sock didSendDataWithTag:(long)tag{

}



@end
