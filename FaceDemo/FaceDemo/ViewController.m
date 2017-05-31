//
//  ViewController.m
//  FaceDemo
//
//  Created by pk on 14/11/16.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    UIImageView* _imageView;
    UIView* _resultView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //放上一张照片
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    _imageView.image = [UIImage imageNamed:@"10_7.jpg"];
    [self.view addSubview:_imageView];
    //一张空白的view，和照片一样大，添加到照片上面
    _resultView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    [self.view addSubview:_resultView];
    //人脸识别出得到的坐标是标准坐标系，我们要把标准的倒过来，和ios的坐标系一致
    [_resultView setTransform:CGAffineTransformMakeScale(1, -1)];
    //创建CIDetector，这个类是用来识别的
    NSDictionary* dic = @{CIDetectorAccuracy:CIDetectorAccuracyHigh};
    CIDetector* detector = [CIDetector detectorOfType:CIDetectorTypeFace context:[CIContext contextWithOptions:nil] options:dic];
    //识别一张图片CIIamge，并得到结果，可能有多个人，所以是数组
    NSArray* resultArray = [detector featuresInImage:[CIImage imageWithCGImage:_imageView.image.CGImage]];
    //便利数组，每一个人脸识别都是一个CIFaceFeature
    for (CIFaceFeature* feature in resultArray) {
        //人脸的区域
        CGRect rect = feature.bounds;
        UIView* view = [[UIView alloc] initWithFrame:rect];
        view.backgroundColor = [UIColor redColor];
        view.alpha = 0.3;
        [_resultView addSubview:view];
        //如果识别出左眼，我们也给显示出来，右眼也一样
        if (feature.hasLeftEyePosition) {
            UIView* eyeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
            eyeView.backgroundColor = [UIColor blueColor];
            eyeView.center = feature.leftEyePosition;
            [_resultView addSubview:eyeView];
        }
    }
}


@end
