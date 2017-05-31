//
//  ViewController.m
//  GuessNameDemo
//
//  Created by pk on 14/12/1.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "ViewController.h"
#import "ASIHTTPRequest.h"

@interface ViewController ()<ASIHTTPRequestDelegate>{
    IBOutlet UIImageView* _headView;
    IBOutlet UILabel* _label;
}

@property (nonatomic, copy) NSString* yesurl;
@property (nonatomic, copy) NSString* nourl;
@property (nonatomic, copy) NSString* notsureurl;

- (IBAction)yesClick:(id)sender;
- (IBAction)noClick:(id)sender;
- (IBAction)notsureClick:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     //本周免费
     http://lolbox.duowan.com/phone/apiHeroes.php?v=61&type=free&OSType=iOS8.1
     //全部英雄 rating 攻 防 法 难度
     http://lolbox.duowan.com/phone/apiHeroes.php?v=61&type=all&OSType=iOS8.1
     //详情
     http://lolbox.duowan.com/phone/apiHeroDetail.php?OSType=iOS8.1&v=61&heroName=Annie
     */
    NSURL* url = [NSURL URLWithString:@"http://renlifang.msra.cn/Q20/api/gamestart.ashx?alias=WP7&stamp=366"];
    //请求
    ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
    request.tag = 10;
    request.delegate = self;
    //开始请求
    [request startAsynchronous];
    
    
    //中文需要转码
    //https://api.douban.com/v2/book/search?q=%E5%93%88%E5%88%A9&page=2
    NSString* str = @"哈利";
    str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@", str);
    
    //NSData->NSString
    NSData* data;
    str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    //NSString->NSData
    data = [str dataUsingEncoding:NSUTF8StringEncoding];
    //NSData->UIImage
    UIImage* image = [UIImage imageWithData:data];
    //UIImage->NSData
    data = UIImagePNGRepresentation(image);
    //0~1 质量
    data = UIImageJPEGRepresentation(image, 1);
}

- (void)yesClick:(id)sender{
    [self questionRequest:self.yesurl];
}

- (void)noClick:(id)sender{
    [self questionRequest:self.nourl];
}

- (void)notsureClick:(id)sender{
    [self questionRequest:self.notsureurl];
}

//问题请求
- (void)questionRequest:(NSString*)url{
    ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    request.tag = 20;
    request.delegate = self;
    [request startAsynchronous];
}

//请求完成
- (void)requestFinished:(ASIHTTPRequest *)request{
    if (request.tag == 10) {
        //如果请求的是图片 request.responseData
        //如果请求的是文本 request.responseString
        //开始问题请求
        NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:request.responseData options:0 error:nil];
        [self questionRequest:dic[@"starturl"]];
    }
    if (request.tag == 20) {
        NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:request.responseData options:0 error:nil];
        //当前的结果是问题
        if ([dic[@"step"] intValue] == 1) {
            //显示问题
            _label.text = dic[@"qtext"];
            //保存三个url
            self.yesurl = dic[@"yesurl"];
            self.nourl = dic[@"nourl"];
            self.notsureurl = dic[@"notsureurl"];
        }
        //当前的结果是答案
        if ([dic[@"step"] intValue] == 2) {
            _label.text = [NSString stringWithFormat:@"小主，您心里想的是:%@",dic[@"guessname"]];
            //请求图片
            NSString* imageUrl = [NSString stringWithFormat:@"http://renlifang.msra.cn/portrait.aspx?id=%@", dic[@"pid"]];
            ASIHTTPRequest* imageRequest = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:imageUrl]];
            imageRequest.tag = 30;
            imageRequest.delegate = self;
            [imageRequest startAsynchronous];
        }
    }
    //拿到图片
    if (request.tag == 30) {
        _headView.image = [UIImage imageWithData:request.responseData];
    }
}

//请求失败
- (void)requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"%ld 请求失败", request.tag);
}




@end
