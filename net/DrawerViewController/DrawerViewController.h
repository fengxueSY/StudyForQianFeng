//
//  DrawerViewController.h
//  TVProgramList
//
//  Created by PK on 14-5-31.
//  Copyright (c) 2014年 PK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawerViewController : UIViewController

@property (nonatomic, strong) UIView* leftView;
@property (nonatomic, strong) UIViewController* rootViewController;
@property (nonatomic, strong) UIView* rightView;
@property (nonatomic, assign) float contentOffWidth;

- (id)initWithRootViewController:(UIViewController*)rootViewController;
- (void)leftOpen;
- (void)rightOpen;

@end
