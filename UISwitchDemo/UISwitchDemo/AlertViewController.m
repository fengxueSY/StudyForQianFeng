//
//  AlertViewController.m
//  UISwitchDemo
//
//  Created by pk on 14/11/19.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "AlertViewController.h"

@interface AlertViewController ()<UIActionSheetDelegate, UIAlertViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
    UIImageView* _imageView;
}

@end

@implementation AlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 50, 100, 150)];
    [self.view addSubview:_imageView];
    [_imageView release];
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(100, 250, 100, 40);
    [button setTitle:@"选择图片" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonClick{
    UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:@"请选择图片来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"相机" otherButtonTitles:@"相册", @"胶卷", nil];
    [actionSheet showInView:self.view];
    [actionSheet release];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%ld",buttonIndex);
    //取消
    if (buttonIndex == 3) {
        return;
    }
    //相机
    if (buttonIndex == 0) {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"询问" message:@"我长得帅吗?" delegate:self cancelButtonTitle:@"不帅" otherButtonTitles:@"帅", nil];
        //显示警告
        [alertView show];
        [alertView release];
        return;
    }
    //选择相片
    UIImagePickerController* ipc = [[UIImagePickerController alloc] init];
    if (buttonIndex == 1) {
        //相册
        ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    } else {
        //胶卷
        ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:^{
    }];
    [ipc release];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"询问" message:@"我长得帅吗?" delegate:self cancelButtonTitle:@"不帅" otherButtonTitles:@"帅", nil];
        //显示警告
        [alertView show];
        [alertView release];
    }
}

//选择图片
//选中一张图片调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //拿到选中的图片
    UIImage* image = [info objectForKey:UIImagePickerControllerOriginalImage];
    _imageView.image = image;
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
}
//点击取消按钮调用
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
}


@end
