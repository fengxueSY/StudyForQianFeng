//
//  ViewController.m
//  CoreImageDemo
//
//  Created by pk on 14/11/16.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    UIImageView* _imageView;
}

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    _imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _imageView.image = [UIImage imageNamed:@"back2.jpg"];
    [self.view addSubview:_imageView];
    
    CIImage* image = [CIImage imageWithCGImage:_imageView.image.CGImage];
    CIFilter* filter = [CIFilter filterWithName:@"CISepiaTone" keysAndValues:@"inputImage", image,@"inputIntensity", @0.9f, nil];
    image = [filter outputImage];
    _imageView.image = [UIImage imageWithCIImage:image];
}


@end
