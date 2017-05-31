//
//  ViewController.m
//  POSTDemo
//
//  Created by pk on 14/12/3.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "ViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface ViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate,ASIHTTPRequestDelegate>{
    IBOutlet UIImageView* _headView;
}

@property (nonatomic, copy) NSString* m_auth;

- (IBAction)login:(id)sender;
- (IBAction)uploadImage:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectImage)];
    [_headView addGestureRecognizer:tap];
}

- (void)selectImage{
    UIImagePickerController* ipc = [[UIImagePickerController alloc] init];
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    _headView.image = info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//登陆
- (void)login:(id)sender{
    NSURL* url = [NSURL URLWithString:@"http://10.0.8.8/sns/my/login.php?username=1434pk&password=1434pk"];
    
    ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
    request.tag = 10;
    request.delegate = self;
    [request startAsynchronous];
}

//上传头像
- (void)uploadImage:(id)sender{
    NSURL* url = [NSURL URLWithString:@"http://10.0.8.8/sns/my/upload_headimage.php"];
    //GET http://10.0.8.8/sns/my/upload_headimage.php?m_auth=jhkjhkh&headimage=01010101
    //POST
    ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:url];
    //添加参数
    //token参数
    [request setPostValue:self.m_auth forKey:@"m_auth"];
    //头像参数
    NSData* data = UIImagePNGRepresentation(_headView.image);
    //文件名 类型
    [request setData:data withFileName:@"tmp.png" andContentType:@"image/png" forKey:@"headimage"];
    request.tag = 20;
    request.delegate = self;
    [request startAsynchronous];
}

//asi delegate
- (void)requestFinished:(ASIHTTPRequest *)request{
    //登陆
    if (request.tag == 10) {
        NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:request.responseData options:0 error:nil];
        //登陆成功
        if ([dic[@"code"] isEqualToString:@"login_success"]) {
            NSLog(@"登陆成功");
            self.m_auth = dic[@"m_auth"];
        } else {
            NSLog(@"登陆失败");
        }
    }
    //头像
    if (request.tag == 20) {
        NSLog(@"%@", request.responseString);
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"%ld请求失败", request.tag);
}




@end
