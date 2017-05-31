//
//  ViewController.m
//  UIPickerController
//
//  Created by pk on 14/12/23.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIPickerViewDataSource, UIPickerViewDelegate>{
    UILabel* _label;
    UIPickerView* _pickerView;
    NSArray* _dataArray;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray = @[@"李逍遥", @"王小虎", @"林月如", @"李忆如", @"赵灵儿"];

    _label = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 200, 50)];
    _label.font = [UIFont boldSystemFontOfSize:20.0];
    [self.view addSubview:_label];
    
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 400, self.view.frame.size.width, self.view.frame.size.height - 400)];
    //_pickerView.showsSelectionIndicator = YES;
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    [self.view addSubview:_pickerView];
}

//几段
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

//行高
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    if (component == 0) {
        return 30;
    }
    if (component == 1) {
        return 50;
    }
    return 0;
}

//几行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return _dataArray.count;
    }
    return 8;
}

//行标题
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        return _dataArray[row];
    }
    return nil;
}

//行视图
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    if (component == 1) {
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 42, 46)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%02ld.png", row]];
        return imageView;
    }
    if (component == 0) {
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        label.text = _dataArray[row];
        return label;
    }
    return nil;
}

//选中一行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        _label.text = _dataArray[row];
    }
}

@end
