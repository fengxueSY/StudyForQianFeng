//
//  ViewController.m
//  SoapDemo
//
//  Created by pk on 14/12/3.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLConnectionDataDelegate>{
    NSMutableData* _mData;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _mData = [[NSMutableData alloc] init];
    
    //创建请求体
    NSString* xmlStr = @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
    <soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">\
    <soap12:Body>\
    <getWeatherbyCityName xmlns=\"http://WebXml.com.cn/\">\
    <theCityName>北京</theCityName>\
    </getWeatherbyCityName>\
    </soap12:Body>\
    </soap12:Envelope>";
    
    NSData* body = [xmlStr dataUsingEncoding:NSUTF8StringEncoding];
    
    //创建请求
    NSURL* url = [NSURL URLWithString:@"http://www.webxml.com.cn/WebServices/WeatherWebService.asmx"];
    //自定义post请求
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    //请求方式
    [request setHTTPMethod:@"POST"];
    //添加请求头
    [request setValue:@"application/soap+xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%ld", body.length] forHTTPHeaderField:@"Content-Length"];
    //添加请求体
    [request setHTTPBody:body];
    
    [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [_mData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"%@", [[NSString alloc] initWithData:_mData encoding:NSUTF8StringEncoding]);
}





@end
