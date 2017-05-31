//
//  SubjectCell.h
//  爱限免
//
//  Created by pk on 14/12/11.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarView.h"

@interface SubjectCell : UITableViewCell

@property (nonatomic, assign)IBOutlet UILabel* nameLabel;
@property (nonatomic, assign)IBOutlet UILabel* descLabel;
@property (nonatomic, assign)IBOutlet UILabel* nameLabel1;
@property (nonatomic, assign)IBOutlet UILabel* nameLabel2;
@property (nonatomic, assign)IBOutlet UILabel* nameLabel3;
@property (nonatomic, assign)IBOutlet UILabel* commentLabel1;
@property (nonatomic, assign)IBOutlet UILabel* commentLabel2;
@property (nonatomic, assign)IBOutlet UILabel* commentLabel3;
@property (nonatomic, assign)IBOutlet UILabel* downloadLabel1;
@property (nonatomic, assign)IBOutlet UILabel* downloadLabel2;
@property (nonatomic, assign)IBOutlet UILabel* downloadLabel3;
@property (nonatomic, assign)IBOutlet UIImageView* subjectImageView;
@property (nonatomic, assign)IBOutlet UIImageView* descImageView;
@property (nonatomic, assign)IBOutlet UIImageView* iconView1;
@property (nonatomic, assign)IBOutlet UIImageView* iconView2;
@property (nonatomic, assign)IBOutlet UIImageView* iconView3;
@property (nonatomic, assign)IBOutlet StarView* starView1;
@property (nonatomic, assign)IBOutlet StarView* starView2;
@property (nonatomic, assign)IBOutlet StarView* starView3;








@end
