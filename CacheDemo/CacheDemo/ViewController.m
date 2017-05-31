#import "ViewController.h"
#import "NSString+Hashing.h"

@interface ViewController ()<NSURLConnectionDataDelegate>{
    UIImageView* _imageView;
    NSMutableData* _mData;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mData = [[NSMutableData alloc] init];

    _imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_imageView];
    
    //MD5 32位字符串 16   编码，单向
    /*
     http://www.baidu.com/img/bdlogo.png->aaabbb
     tmp/aaabbb
     */
    /*
        先从tmp文件夹中寻找有没有缓存文件，如果有，直接读取，没有再去从网络请求
     */
    NSString* url = @"http://www.baidu.com/img/bdlogo.png";
    //路径为真则有缓存，为假则无缓存
    NSString* path = [NSString stringWithFormat:@"%@/tmp/%@", NSHomeDirectory(), [url MD5Hash]];
    NSFileManager* fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:path]) {
        //有缓存,直接读取
        NSLog(@"缓存读取");
        NSData* data = [NSData dataWithContentsOfFile:path];
        _imageView.image = [UIImage imageWithData:data];
    } else {
        //没有缓存,请求
        NSLog(@"网络请求");
        NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        [NSURLConnection connectionWithRequest:request delegate:self];
    }

}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [_mData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    _imageView.image = [UIImage imageWithData:_mData];
    NSString* url = @"http://www.baidu.com/img/bdlogo.png";
    [_mData writeToFile:[NSString stringWithFormat:@"%@/tmp/%@", NSHomeDirectory(), [url MD5Hash]] atomically:NO];
    NSLog(@"%@", [NSString stringWithFormat:@"%@/tmp/%@", NSHomeDirectory(), [url MD5Hash]]);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"请求失败");
}


@end
