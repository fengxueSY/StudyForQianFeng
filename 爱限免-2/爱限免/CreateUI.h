//
//  CreateUI.h
//  爱限免
//
//  Created by pk on 14/12/9.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateUI : NSObject

+ (UILabel*)createLabelWithFrame:(CGRect)frame Text:(NSString*)text Font:(UIFont*)font Color:(UIColor*)color;

+ (UIButton*)createButtonWithFrame:(CGRect)frame Title:(NSString*)title BackgroundImage:(UIImage*)bgImage Image:(UIImage*)image Target:(id)target Action:(SEL)action;



@end
