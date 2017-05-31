//
//  ViewController.m
//  GaoDeDemo
//
//  Created by pk on 14/12/16.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "ViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>

@interface ViewController ()<MAMapViewDelegate, AMapSearchDelegate>{
    MAMapView* _mapView;
    AMapSearchAPI* _search;
}

@end

@implementation ViewController

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //配置用户Key
    [MAMapServices sharedServices].apiKey = @"66aa9b35a973c00737ca32cd794d324e";
    
    _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    _mapView.delegate = self;
    //多了夜景模式
    //_mapView.mapType = MAMapTypeStandardNight;
    //显示交通状况
    //_mapView.showTraffic = YES;
    [self.view addSubview:_mapView];
    
    //画线
    //[self makePolyline];
    //画圆
    //[self makeCircle];
    
    //搜索---------------------
    _search = [[AMapSearchAPI alloc] initWithSearchKey:@"66aa9b35a973c00737ca32cd794d324e" Delegate:self];
    
    //搜索关键字
    //[self searchPOI:@"书店"];
    //地理编码
    //[self geocode:@"宝盛里"];
    //逆地理编码
    //AMapGeoPoint* point = [AMapGeoPoint locationWithLatitude:39.990459     longitude:116.481476];
    //[self regeocode:point];
    
    //路径搜索
    [self navigationSearch];
}

//路径搜索
- (void)navigationSearch{
    //构造AMapNavigationSearchRequest对象，配置查询参数
    AMapNavigationSearchRequest *naviRequest= [[AMapNavigationSearchRequest alloc] init];
    naviRequest.searchType = AMapSearchType_NaviDrive;
    naviRequest.requireExtension = YES;
    //起点位置
    naviRequest.origin = [AMapGeoPoint locationWithLatitude:39.994949 longitude:116.447265];
    //终点位置
    naviRequest.destination = [AMapGeoPoint locationWithLatitude:39.990459 longitude:116.481476];
    //发起路径搜索
    [_search AMapNavigationSearch: naviRequest];
}

//实现路径搜索的回调函数
- (void)onNavigationSearchDone:(AMapNavigationSearchRequest *)request response:(AMapNavigationSearchResponse *)response
{
    //第一个路线方案
    AMapPath* mapPath = response.route.paths[0];
    NSMutableArray* coordinateArray = [NSMutableArray array];
    //遍历一下方案中得路段
    for (AMapStep* step in mapPath.steps) {
        //NSLog(@"%@", step.polyline);
        NSArray* pointArray = [step.polyline componentsSeparatedByString:@";"];
        //遍历所有的所标点
        for (NSString* pointStr in pointArray) {
            [coordinateArray addObject:pointStr];
        }
    }
    
    CLLocationCoordinate2D coordinate[coordinateArray.count];
    //遍历坐标字符串
    for (int i = 0; i < coordinateArray.count; i++) {
        //经纬度字符串 116,14
        NSString* pointStr = coordinateArray[i];
        NSArray* pointArray = [pointStr componentsSeparatedByString:@","];
        //取得经纬度
        coordinate[i].longitude = [pointArray[0] floatValue];
        coordinate[i].latitude = [pointArray[1] floatValue];
    }
    
    MAPolyline* polyline = [MAPolyline polylineWithCoordinates:coordinate count:coordinateArray.count];
    [_mapView addOverlay:polyline];
}

//逆地理编码
- (void)regeocode:(AMapGeoPoint*)geoPoint{
    //创建逆地理编码请求
    AMapReGeocodeSearchRequest *regeoRequest = [[AMapReGeocodeSearchRequest alloc] init];
    regeoRequest.searchType = AMapSearchType_ReGeocode;
    regeoRequest.location = geoPoint;
    regeoRequest.radius = 10000;
    regeoRequest.requireExtension = YES;
    //发起逆地理编码
    [_search AMapReGoecodeSearch: regeoRequest];
}

//实现逆地理编码的回调函数
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    NSLog(@"%@", response.regeocode.formattedAddress);
}

//地理编码
- (void)geocode:(NSString*)name{
    //创建地理编码请求
    AMapGeocodeSearchRequest *geoRequest = [[AMapGeocodeSearchRequest alloc] init];
    geoRequest.searchType = AMapSearchType_Geocode;
    geoRequest.address = name;
    geoRequest.city = @[@"beijing"];
    //发起正向地理编码
    [_search AMapGeocodeSearch: geoRequest];
}

//实现正向地理编码的回调函数
- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response
{
    for (AMapGeocode* geocode in response.geocodes) {
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(geocode.location.latitude, geocode.location.longitude);
        //创建大头针显示位置信息
        MAPointAnnotation* anno = [[MAPointAnnotation alloc] init];
        anno.coordinate = coordinate;
        anno.title = request.address;
        [_mapView addAnnotation:anno];
    }
}

//搜索兴趣点关键字
- (void)searchPOI:(NSString*)poi{
    //创建一个poi请求
    AMapPlaceSearchRequest *poiRequest = [[AMapPlaceSearchRequest alloc] init];
    poiRequest.searchType = AMapSearchType_PlaceKeyword;
    //搜索的关键字
    poiRequest.keywords = poi;
    //哪个城市
    poiRequest.city = @[@"beijing"];
    //扩展
    poiRequest.requireExtension = YES;
    //发起POI搜索
    [_search AMapPlaceSearch: poiRequest];
}

//poi搜索回调
- (void)onPlaceSearchDone:(AMapPlaceSearchRequest *)request response:(AMapPlaceSearchResponse *)response
{
    //遍历poi数组
    for (AMapPOI* poi in response.pois) {
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(poi.location.latitude, poi.location.longitude);
        //创建大头针显示兴趣点内容
        MAPointAnnotation* anno = [[MAPointAnnotation alloc] init];
        anno.coordinate = coordinate;
        anno.title = poi.name;
        anno.subtitle = poi.address;
        [_mapView addAnnotation:anno];
    }
}













//覆盖物
//画圆
- (void)makeCircle{
    //构造圆
    MACircle *circle = [MACircle circleWithCenterCoordinate:CLLocationCoordinate2DMake(39.952136, 116.50095) radius:5000];
    //在地图上添加圆
    [_mapView addOverlay: circle];
}

//画线
- (void)makePolyline{
    //构造折线数据对象
    CLLocationCoordinate2D commonPolylineCoords[4];
    commonPolylineCoords[0].latitude = 39.832136;
    commonPolylineCoords[0].longitude = 116.34095;
    
    commonPolylineCoords[1].latitude = 39.832136;
    commonPolylineCoords[1].longitude = 116.42095;
    
    commonPolylineCoords[2].latitude = 39.902136;
    commonPolylineCoords[2].longitude = 116.42095;
    
    commonPolylineCoords[3].latitude = 39.902136;
    commonPolylineCoords[3].longitude = 116.44095;
    
    //构造折线对象 (只是折线的数据类)
    MAPolyline *commonPolyline = [MAPolyline polylineWithCoordinates:commonPolylineCoords count:4];
    
    //在地图上添加折线对象
    [_mapView addOverlay: commonPolyline];
}

//真正的创建了覆盖物（画线，画圆等。。。）
- (MAOverlayView *)mapView:(MAMapView *)mapView viewForOverlay:(id<MAOverlay>)overlay{
    //判断是折线
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        //折线类
        MAPolylineView *polylineView = [[MAPolylineView alloc] initWithPolyline:overlay];
        //线宽
        polylineView.lineWidth = 10.f;
        //颜色
        polylineView.strokeColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.6];
        //连接类型
        polylineView.lineJoinType = kMALineJoinRound;
        //端点类型
        polylineView.lineCapType = kMALineCapRound;
        
        return polylineView;
    }
    //判断如果是圆
    if ([overlay isKindOfClass:[MACircle class]]) {
        MACircleView* circleView = [[MACircleView alloc] initWithCircle:overlay];
        //线宽
        circleView.lineWidth = 20;
        //线颜色
        circleView.strokeColor = [UIColor redColor];
        //填充颜色
        circleView.fillColor = [UIColor yellowColor];
        //虚线
        circleView.lineDash = YES;
        return circleView;
    }
    return nil;
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
    MAPinAnnotationView* pinView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"ID"];
    if (pinView == nil) {
        pinView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"ID"];
    }
    
    pinView.canShowCallout = YES;
    //pinView.image = [UIImage imageNamed:@"1.png"];
    
    return pinView;
}




@end
