//
//  ViewController.m
//  QfsnsPOSTDemo
//
//  Created by pk on 14/12/3.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "ViewController.h"
#import "ASIHTTPRequest.h"
#import "GDataXMLNode.h"
#import "GTMBase64.h"
//#import "UIDevice+IdentifierAddition.h"

/*
 get    NSURLRequest  ASIHttpRequest
 标准post  ASIFormDataRequest
 自定义post  NSMutableURLRequest  ASIHttpRequest
 */

@interface ViewController ()<ASIHTTPRequestDelegate,PKDownloadDelegate>{

}

@property (nonatomic, copy) NSString* token;

- (IBAction)login:(id)sender;
- (IBAction)reg:(id)sender;
- (IBAction)uploadImage:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

//注册
- (void)reg:(id)sender{
    NSURL* url = [NSURL URLWithString:@"http://10.0.8.8/app/qianfeng/ichat/register.php"];
    
    //获取客户端类型 @"iphone" @"ipad"
    NSString* clientType = [[UIDevice currentDevice] model];
    //udid
    NSString* udid = @"89723987498234";
    //请求体
    NSDictionary* dic = @{@"Name":@"1434pk",
                          @"Password":@"1434pk",
                          @"Email":@"1434pk@163.com",
                          @"Age":@"90",
                          @"Sex":@"男",
                          @"Description":@"💰",
                          @"ClientType":clientType,
                          @"DeviceIdentifier":udid,
                          @"Address":@"宝盛里天丰利商场",};
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];

    //请求
    ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
    //请求方式
    [request setRequestMethod:@"POST"];
    //请求头
    [request addRequestHeader:@"Content-Type" value:@"application/x-www-form-data"];
    [request addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%ld", jsonData.length]];
    //请求体
    [request setPostBody:[NSMutableData dataWithData:jsonData]];
    request.delegate = self;
    request.tag = 10;
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request{
    NSLog(@"%@", request.responseString);
}


- (void)requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"请求失败");
}

//登陆
- (void)login:(id)sender{
    NSString* url = @"http://10.0.8.8/app/qianfeng/ichat/login.php";
    /*
     <root>
      <Position>
        <IP>192.168.11.32</IP>
        <Longitude>45.222122</Longitude>
        <Latitude>116.22222</Latitude>
      </Position> 
      <Password>123456</Password> 
      <Name>oyangjian</Name> 
      <Status>hidden</Status>
     </root>
     */
    GDataXMLElement* ipEle = [GDataXMLElement elementWithName:@"IP" stringValue:@"192.168.11.32"];
    GDataXMLElement* longitude = [GDataXMLElement elementWithName:@"Longitude" stringValue:@"45.222"];
    GDataXMLElement* latitude = [GDataXMLElement elementWithName:@"Latitude" stringValue:@"122.1122"];
    GDataXMLElement* position = [GDataXMLElement elementWithName:@"Position"];
    //添加子节点
    [position addChild:ipEle];
    [position addChild:longitude];
    [position addChild:latitude];
    GDataXMLElement* password = [GDataXMLElement elementWithName:@"Password" stringValue:@"1434pk"];
    GDataXMLElement* name = [GDataXMLElement elementWithName:@"Name" stringValue:@"1434pk"];
    GDataXMLElement* status = [GDataXMLElement elementWithName:@"Status" stringValue:@"hidden"];
    GDataXMLElement* root = [GDataXMLElement elementWithName:@"root"];
    [root addChild:position];
    [root addChild:password];
    [root addChild:name];
    [root addChild:status];
    //创建一个xml文档
    GDataXMLDocument* doc = [[GDataXMLDocument alloc] initWithRootElement:root];
    //设定文档编码
    [doc setCharacterEncoding:@"utf-8"];
    //doc.XMLData就是我们创建好的xml
    PKDownload* download = [[PKDownload alloc] initWithURL:url Delegate:self];
    download.tag = 10;
    [download startPostWithJsonOrXmlString:[doc.XMLData stringValue]];
}

- (void)uploadImage:(id)sender{
    UIImage* image = [UIImage imageNamed:@"00.png"];
    NSData* imageData = UIImagePNGRepresentation(image);
    //base64加密
    NSString* base64Str = [GTMBase64 stringByEncodingData:imageData];
    /*
     <root>
         <Token></Token>
         <HeadImage> </HeadImage>
         <ImageType>image/png</ImageType>
     </root>
     */
    GDataXMLElement* token = [GDataXMLElement elementWithName:@"Token" stringValue:self.token];
    GDataXMLElement* headImage = [GDataXMLElement elementWithName:@"HeadImage" stringValue:base64Str];
    GDataXMLElement* imageType = [GDataXMLElement elementWithName:@"ImageType" stringValue:@"image/png"];
    GDataXMLElement* root = [GDataXMLElement elementWithName:@"root"];
    [root addChild:token];
    [root addChild:headImage];
    [root addChild:imageType];
    GDataXMLDocument* doc = [[GDataXMLDocument alloc] initWithRootElement:root];
    [doc setCharacterEncoding:@"utf-8"];
    
    PKDownload* download = [[PKDownload alloc] initWithURL:@"http://10.0.8.8/app/qianfeng/ichat/upload_headimg.php" Delegate:self];
    download.tag = 20;
    [download startPostWithJsonOrXmlString:[doc.XMLData stringValue]];
}

- (void)PKDownloadFinish:(PKDownload *)download Data:(NSData *)data{
    //登陆
    if (download.tag == 10) {
        if ([[[data stringValue] PKXmlElement:@"Msg"] isEqualToString:@"OK"]) {
            NSLog(@"登陆成功");
            self.token = [[data stringValue] PKXmlElement:@"Token"];
        }
    }
    //上传头像
    if (download.tag == 20) {
        NSLog(@"%@", [data stringValue]);
    }
}

- (void)PKDownloadFailed:(PKDownload *)download{
    NSLog(@"请求失败");
}


@end
