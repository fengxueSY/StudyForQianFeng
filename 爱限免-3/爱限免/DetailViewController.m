//
//  DetailViewController.m
//  爱限免
//
//  Created by pk on 14/12/11.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "DetailViewController.h"
#import "UMSocial.h"

@interface DetailViewController (){
    IBOutlet UIImageView* _iconView;
    IBOutlet UIImageView* _imageView1;
    IBOutlet UIImageView* _imageView2;
    IBOutlet UIImageView* _imageView3;
    IBOutlet UIImageView* _imageView4;
    IBOutlet UIImageView* _imageView5;
    IBOutlet UILabel* _nameLabel;
    IBOutlet UILabel* _priceLabel;
    IBOutlet UILabel* _sizeLabel;
    IBOutlet UILabel* _categoryLabel;
    IBOutlet UILabel* _desLabel;
}

- (IBAction)share:(id)sender;

@end

@implementation DetailViewController

- (void)share:(id)sender{
    [UMSocialSnsService presentSnsIconSheetView:self
    appKey:@"544b4c09fd98c55706050006"
    shareText:_desLabel.text
    shareImage:_iconView.image
     
    shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,nil]
    delegate:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [MyConnection connectionWithUrl:[NSString stringWithFormat:@"http://iappfree.candou.com:8080/free/applications/%@", self.applicationId] FinishBlock:^(NSData *data) {
        NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        //名称
        _nameLabel.text = dic[@"name"];
        //图标
        [_iconView setImageWithURL:[NSURL URLWithString:dic[@"iconUrl"]]];
        //价格
        _priceLabel.text = [NSString stringWithFormat:@"价格：￥%@", dic[@"lastPrice"]];
        //大小
        _sizeLabel.text = [NSString stringWithFormat:@"大小：%@MB", dic[@"fileSize"]];
        //类型
        _categoryLabel.text = [NSString stringWithFormat:@"类型：%@    评分：%@",dic[@"categoryName"], dic[@"starCurrent"]];
        //图片
        NSArray* imageArray = @[_imageView1, _imageView2, _imageView3, _imageView4, _imageView5];
        NSArray* photos = dic[@"photos"];
        for (int i = 0; i < photos.count; i++) {
            NSDictionary* imgDic = photos[i];
            [imageArray[i] setImageWithURL:[NSURL URLWithString:imgDic[@"smallUrl"]]];
        }
        //详情
        _desLabel.text = dic[@"description"];
    } FailedBlock:^{
        NSLog(@"详情请求失败");
    }];
    
    
}


@end
