//
//  ViewController.m
//  DoubanDemo
//
//  Created by pk on 14/12/8.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

@interface ViewController (){
    AFHTTPClient* _client;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //普通请求
    //[self startRequest];
    //json请求
    //[self jsonRequest];
    //Image请求
    //[self imageRequest];
    //client请求
    [self clientRequest];
}

//client请求
- (void)clientRequest{
    //baseurl 就是前半段请求地址
    _client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://10.0.8.8/sns/"]];
    //进行一个get请求 path后半段地址
    [_client getPath:@"my/user_list.php" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败");
    }];
    //进行一个post请求
    [_client postPath:@"my/user_list.php" parameters:@{@"count":@"20"} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"post请求成功");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败");
    }];
}

//image请求
- (void)imageRequest{
    NSURL* url = [NSURL URLWithString:@"http://1.su.bdimg.com/xingzuo/big/24/mojie.png"];
    /*
    AFImageRequestOperation* operation = [[AFImageRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:url]];
    //这里的responseObject就是下载的图片了
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //UIImage->UIColor
        self.view.backgroundColor = [UIColor colorWithPatternImage:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败");
    }];
    [operation start];
     */
    
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    [self.view addSubview:imageView];
    //2.
    /*
    [imageView setImageWithURLRequest:[NSURLRequest requestWithURL:url] placeholderImage:[UIImage imageNamed:@"00.png"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        imageView.image = image;
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        
    }];
     */
    //3.
    [imageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"001.png"]];
}

//json请求
- (void)jsonRequest{
    NSURL* url = [NSURL URLWithString:@"https://api.douban.com/v2/book/search?q=harry&start=0"];
    AFJSONRequestOperation* operation = [[AFJSONRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:url]];
    //设置回调 这里的responseObject 就是请求完成后，解析完的数组或字典
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败");
    }];
    //开始请求
    [operation start];
}

//普通请求
- (void)startRequest{
    NSURL* url = [NSURL URLWithString:@"https://api.douban.com/v2/book/search?q=harry&start=0"];
    //AF请求基于NSURLRequest
    AFHTTPRequestOperation* operation = [[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:url]];
    //设置完成回调 这里的responseObject就是下载完的NSData
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //解析
        NSDictionary* dic  = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSLog(@"%@", dic);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败");
    }];
    //开始
    [operation start];
}






@end
