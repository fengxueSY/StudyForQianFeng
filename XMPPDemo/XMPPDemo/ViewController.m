//
//  ViewController.m
//  XMPPDemo
//
//  Created by pk on 14/12/22.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "ViewController.h"
#import "XMPPFramework.h"

#define HOST @"1000phone.net"
@interface ViewController ()<XMPPStreamDelegate>{
    IBOutlet UITextField* _nameField;
    IBOutlet UITextField* _passwordField;
    IBOutlet UITextField* _friendField;
    IBOutlet UITextField* _sendField;
    //流
    XMPPStream* _stream;
}

- (IBAction)reg:(id)sender;
- (IBAction)login:(id)sender;
- (IBAction)addFriend:(id)sender;
- (IBAction)getFriendList:(id)sender;
- (IBAction)sendText:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _stream = [[XMPPStream alloc] init];
    //设置服务器
    [_stream setHostName:HOST];
    //设置代理
    [_stream addDelegate:self delegateQueue:dispatch_get_main_queue()];
}

//上线
- (void)goOnline{
    //<presence /> 上线消息
    XMPPPresence* presence = [XMPPPresence presence];
    //发送出去
    [_stream sendElement:presence];
}

//下线
- (void)goOffline{
    //<presence type="unavailable"/>
    XMPPPresence* presence = [XMPPPresence presenceWithType:@"unavailable"];
    [_stream sendElement:presence];
    //断开
    [_stream disconnect];
}

//注册
- (void)reg:(id)sender{
    //如果已经连接，先断开
    if (_stream.isConnected) {
        [self goOffline];
    }
    //希望注册的账号
    NSString* jid = [NSString stringWithFormat:@"%@@%@", _nameField.text, HOST];
    _stream.tag = @"注册";
    //设置jid
    [_stream setMyJID:[XMPPJID jidWithString:jid]];
    //连接
    [_stream connectWithTimeout:30 error:nil];
}

//登陆
- (void)login:(id)sender{
    //如果已经连接，先断开
    if (_stream.isConnected) {
        [self goOffline];
    }
    //拿到想要登陆的账号
    NSString* jid = [NSString stringWithFormat:@"%@@%@", _nameField.text, HOST];
    _stream.tag = @"登陆";
    //设置jid
    [_stream setMyJID:[XMPPJID jidWithString:jid]];
    //连接
    [_stream connectWithTimeout:30 error:nil];
}

//添加好友
- (void)addFriend:(id)sender{
    /*
     <presence type="subscribe" to="jid">
     */
    NSString* jid = [NSString stringWithFormat:@"%@@%@", _friendField.text, HOST];
    XMPPPresence* presence = [XMPPPresence presenceWithType:@"subscribe" to:[XMPPJID jidWithString:jid]];
    [_stream sendElement:presence];
}

//得到好友列表
- (void)getFriendList:(id)sender{
    /*
     <iq type="get" id="roster">
        <query xmlns="jabber:iq:roster"/>
     </iq>
     */
    XMPPIQ* iq = [XMPPIQ iqWithType:@"get"];
    //添加id属性
    [iq addAttributeWithName:@"id" stringValue:@"roster"];
    //query节点
    NSXMLElement* query = [NSXMLElement elementWithName:@"query" xmlns:@"jabber:iq:roster"];
    [iq addChild:query];
    [_stream sendElement:iq];
}

//发送消息
- (void)sendText:(id)sender{
    /*
     <message to="jid" type="chat">
        <body>
            *&^*^*^&6
        </body>
     </message>
     */
    XMPPMessage* message = [XMPPMessage messageWithType:@"chat" to:[XMPPJID jidWithString:[NSString stringWithFormat:@"%@@%@", _friendField.text, HOST]]];
    NSXMLElement* body = [NSXMLElement elementWithName:@"body" stringValue:_sendField.text];
    [message addChild:body];
    [_stream sendElement:message];
}

//接收到message
- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message{
    NSLog(@"%@ : %@", message.fromStr, message.stringValue);
}

//接收到iq
- (BOOL)xmppStream:(XMPPStream *)sender didReceiveIQ:(XMPPIQ *)iq{
    /*
        <iq>
            <query>
               <item jid="">
               <item jid="">
            </query>
        </iq>
     */
    NSXMLElement* query = iq.children[0];
    for (NSXMLElement* item in [query children]) {
        NSXMLElement* jid = item.attributes[0];
        NSLog(@"%@", jid.stringValue);
    }
    return YES;
}

//接收到一个presence
- (void)xmppStream:(XMPPStream *)sender didReceivePresence:(XMPPPresence *)presence{
    //判断是否有人要加自己为好友
    if ([presence.type isEqualToString:@"subscribe"]) {
        //同意
        //<presence type="subscribed" to="jid">
        XMPPPresence* pre = [XMPPPresence presenceWithType:@"subscribed" to:presence.from];
        [_stream sendElement:pre];
        NSLog(@"同意%@加为好友",presence.fromStr);
    }
    //判断对方是否已经同意自己的好友请求
    if ([presence.type isEqualToString:@"subscribed"]) {
        NSLog(@"%@已经同意了您的好友请求", presence.fromStr);
    }
}

//连接成功
- (void)xmppStreamDidConnect:(XMPPStream *)sender{
    NSLog(@"连接成功");
    if ([sender.tag isEqualToString:@"注册"]) {
        //注册
        [_stream registerWithPassword:_passwordField.text error:nil];
    }
    if ([sender.tag isEqualToString:@"登陆"]) {
        //验证密码
        [_stream authenticateWithPassword:_passwordField.text error:nil];
    }
}

//登陆成功
- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender{
    NSLog(@"登陆成功");
    [self goOnline];
}

//登陆失败
- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error{
    NSLog(@"登录失败");
}

//注册成功
- (void)xmppStreamDidRegister:(XMPPStream *)sender{
    NSLog(@"注册成功");
}

//注册失败
- (void)xmppStream:(XMPPStream *)sender didNotRegister:(DDXMLElement *)error{
    NSLog(@"注册失败");
}



@end
