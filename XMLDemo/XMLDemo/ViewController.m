//
//  ViewController.m
//  XMLDemo
//
//  Created by pk on 14/12/2.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "ViewController.h"
#import "GDataXMLNode.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)func{
    /*
     Json
     {"name":"潘松彪"}
     {
     "person":[
     {"name":"潘松彪"},
     {"name":"严子涵"}
     ]
     }
     XML  节点 属性,可以加多个,属性值必须加"" 元素
     <person count="2" id="3">
     <name id="1">潘松彪</name>
     <name id="2">严子涵</name>
     </person>
     */
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"xml" ofType:@"txt"];
    NSString* xmlStr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    //解析xml
    //文档类
    GDataXMLDocument* doc = [[GDataXMLDocument alloc] initWithXMLString:xmlStr options:0 error:nil];
    /*
     <root>
     <books>
     <book id="1" language="ch">
     <name>甄嬛传</name>
     */
    //根节点
    GDataXMLElement* rootEle = doc.rootElement;
    //books节点
    GDataXMLElement* booksEle = (GDataXMLElement*)[rootEle childAtIndex:0];
    //遍历books节点的子节点 (3个book节点)
    for (GDataXMLElement* bookEle in [booksEle children]) {
        GDataXMLElement* nameEle = [[bookEle elementsForName:@"name"] lastObject];
        NSLog(@"%@-%@", nameEle.name, nameEle.stringValue);
        //解析属性
        GDataXMLElement* languageEle = (GDataXMLElement*)[bookEle attributeForName:@"language"];
        //XMLString xml原型
        NSLog(@"%@",languageEle.XMLString);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //  https://itunes.apple.com/cn/rss/topgrossingipadapplications/limit=30/xml
    NSString* path = [[NSBundle mainBundle] pathForResource:@"xml" ofType:@"txt"];
    NSString* xmlStr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    //解析xml
    //文档类
    GDataXMLDocument* doc = [[GDataXMLDocument alloc] initWithXMLString:xmlStr options:0 error:nil];
    /*
     <root>
        <books>
            <book id="1" language="ch">
                <name>甄嬛传</name>
                <price>80.00</price>
     
     XPath语法
     /root/books/book/name      绝对路径
     |                          多路径
     //name                     相对路径
     //books/book[1]            第一个book
     //books/book[last()]       最后一个book
     //books/book[@num]         节点必须包含num属性
     //books/book[@id=1]        包含id属性并且为1
     */
    NSArray* array = [doc nodesForXPath:@"//books/book[@id=1]/name" error:nil];
    for (GDataXMLElement* ele in array) {
        NSLog(@"%@", ele.XMLString);
    }
    
    /*
     名称空间
     xmlns xml namespace
     名称空间必须是一个地址uri
     xmlns表示要声明一个名称空间
     缺省名称空间，只要没显示声明属于哪个名称空间的节点，都属于缺省名称空间
     <root xmlns:book="http://pk.local/XMLDemo" xmlns="http://www.baidu.com">
        <book:name>老潘传</name>
        <name>老潘</name>
     */
    
    NSLog(@"名称空间");
    path = [[NSBundle mainBundle] pathForResource:@"xmlns2" ofType:@"txt"];
    xmlStr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    doc = [[GDataXMLDocument alloc] initWithXMLString:xmlStr options:0 error:nil];
    /*
     <root xmlns:book="http://www.baidu.com"
     xmlns="http://www.sina.com.cn">
        <books>
            <book id="1" language="ch">
                <book:name>甄嬛传</book:name>
     */
    GDataXMLElement* bookEle = [[doc nodesForXPath:@"/xmlns:root/xmlns:books/xmlns:book/book:name" namespaces:@{
                                                                                            @"xmlns":@"http://www.sina.com.cn",@"book":@"http://www.baidu.com"} error:nil] firstObject];
    NSLog(@"%@", bookEle.XMLString);
}






@end
