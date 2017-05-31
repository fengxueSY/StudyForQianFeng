//
//  AppCell.h
//  爱限免
//
//  Created by pk on 14/12/9.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppCell : UITableViewCell

@property (nonatomic, assign) IBOutlet UIImageView* iconView;
@property (nonatomic, assign) IBOutlet UILabel* nameLabel; //名称
@property (nonatomic, assign) IBOutlet UILabel* dateLabel; //时间
@property (nonatomic, assign) IBOutlet UILabel* priceLabel; //价格
@property (nonatomic, assign) IBOutlet UILabel* categoryLabel; //类型
@property (nonatomic, assign) IBOutlet UILabel* shareLabel; //分享
@property (nonatomic, assign) IBOutlet UILabel* favoriteLabel; //收藏
@property (nonatomic, assign) IBOutlet UILabel* downloadLabel; //下载




@end
