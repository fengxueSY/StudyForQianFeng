//
//  ViewController.m
//  MapViewDemo
//
//  Created by pk on 14/12/16.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController ()<MKMapViewDelegate, CLLocationManagerDelegate>{
    MKMapView* _mapView;
    CLLocationManager* _manager;
    UIImageView* _imageView;
}

@end

@implementation ViewController

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    //显示用户位置
    _mapView.showsUserLocation = YES;
    _mapView.delegate = self;
    //地图类型 Satellite卫星 Standard基本 Hybrid混合
    _mapView.mapType = MKMapTypeStandard;
    [self.view addSubview:_mapView];
    //长按手势
    UILongPressGestureRecognizer* longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [_mapView addGestureRecognizer:longPress];
    
    //定位     基站 wifi a-gps
    _manager = [[CLLocationManager alloc] init];
    //ios8
    [_manager requestAlwaysAuthorization];
    //精确度
    _manager.desiredAccuracy = kCLLocationAccuracyBest;
    //定位距离
    _manager.distanceFilter = 10;
    _manager.delegate = self;
    //开始定位
    [_manager startUpdatingLocation];
    //方向
    [_manager startUpdatingHeading];
    
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 350, 350)];
    _imageView.image = [UIImage imageNamed:@"1.png"];
    [self.view addSubview:_imageView];
}

//定位方向成功
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading{
    NSLog(@"%lf", newHeading.trueHeading);
    _imageView.transform = CGAffineTransformMakeRotation(-1 * newHeading.trueHeading * M_PI / 180);
}

//定位成功
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    //拿到定位的位置
    CLLocation* location = [locations lastObject];
    MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1);
    MKCoordinateRegion region = MKCoordinateRegionMake(location.coordinate, span);
    [_mapView setRegion:region animated:YES];
    
    //停止定位
    [_manager stopUpdatingLocation];
}
//定位失败
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"定位失败");
}


//长按添加大头针
- (void)longPress:(UILongPressGestureRecognizer*)longPress{
    if (longPress.state != UIGestureRecognizerStateBegan) {
        return;
    }
    //坐标
    CGPoint point = [longPress locationInView:_mapView];
    //转成经纬度
    CLLocationCoordinate2D coordinate = [_mapView convertPoint:point toCoordinateFromView:_mapView];
    //缩放比例
    MKCoordinateSpan span = MKCoordinateSpanMake(0.01, 0.01);
    //要显示的区域
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, span);
    //地图中心点经纬度
    //_mapView.centerCoordinate = coordinate;
    //地图显示一个区域
    //[_mapView setRegion:region animated:YES];
    //添加一个标签/大头针(数据类)
    MKPointAnnotation* anno = [[MKPointAnnotation alloc] init];
    //标题
    anno.title = @"KFC";
    //副标题
    anno.subtitle = @"地址：宝盛里天疯利";
    //显示位置
    anno.coordinate = coordinate;
    //添加到地图中
    [_mapView addAnnotation:anno];
}

//自定义大头针
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    //如果是用户位置大头针，不做任何操作
    if ([annotation isKindOfClass:[mapView.userLocation class]]) {
        return nil;
    }
    MKPinAnnotationView* anno = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"ID"];
    if (anno == nil) {
        anno = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"ID"];
    }
    //显示详情面板callout
    anno.canShowCallout = YES;
    //颜色
    anno.pinColor = MKPinAnnotationColorPurple;
    //拖拽
    anno.draggable = YES;
    //动画效果
    anno.animatesDrop = YES;
    //左视图
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    view.backgroundColor = [UIColor redColor];
    anno.leftCalloutAccessoryView = view;
    //右视图
    UIButton* button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    anno.rightCalloutAccessoryView = button;
    
    return anno;
}




@end
