//
//  ViewController.m
//  OpenFlow
//
//  Created by qianfeng on 13-8-22.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _openFlowView = [[AFOpenFlowView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    _openFlowView.numberOfImages = 9;
    for (int i = 1; i < 9; i++) {
        NSString* str = [NSString stringWithFormat:@"%d.jpeg",i];
        UIImage* image = [UIImage imageNamed:str];
        image = [UIImage imageWithCGImage:image.CGImage scale:4.0 orientation:UIImageOrientationUp];
        [_openFlowView setImage:image forIndex:i-1];
    }
    _openFlowView.viewDelegate = self;
    _openFlowView.dataSource = self;
    [self.view addSubview:_openFlowView];
    [_openFlowView release];
    
  
}


- (void)openFlowView:(AFOpenFlowView *)openFlowView requestImageForIndex:(int)index{
}

- (void)openFlowView:(AFOpenFlowView *)openFlowView selectionDidChange:(int)index{
    NSLog(@"select %d",index);
}





@end
