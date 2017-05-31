//
//  HeroListViewController.m
//  LOLDemo
//
//  Created by pk on 14/12/2.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "HeroListViewController.h"
#import "HeroCell.h"
#import "HeroItem.h"

@interface HeroListViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>{
    UICollectionView* _collectionView;
    NSMutableArray* _dataArray;
}

@end

@implementation HeroListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray = [[NSMutableArray alloc] init];
    
    //布局
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    //一项宽高
    float width = 70;
    float height = 90;
    float widthSpace = (WINSIZE.width - 70 * 4) / 5;
    layout.itemSize = CGSizeMake(width, height);
    //行间距
    layout.minimumLineSpacing = 10;
    //方向
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //四周空白区域
    layout.sectionInset = UIEdgeInsetsMake(widthSpace, widthSpace, widthSpace, widthSpace);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WINSIZE.width, WINSIZE.height) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    //注册cell
    [_collectionView registerNib:[UINib nibWithNibName:@"HeroCell" bundle:nil] forCellWithReuseIdentifier:@"ID"];
    
    //开始请求
    [MyConnection connectionWithUrl:@"http://lolbox.duowan.com/phone/apiHeroes.php?v=61&type=all&OSType=iOS8.1" FinishBlock:^(NSData *data) {
        NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        for (NSDictionary* heroDic in dic[@"all"]) {
            HeroItem* heroItem = [[HeroItem alloc] init];
            //KVC赋值
            [heroItem setValuesForKeysWithDictionary:heroDic];
            [_dataArray addObject:heroItem];
        }
        //刷新数据
        [_collectionView reloadData];
    } FailedBlock:^{
        NSLog(@"请求全部英雄失败");
    }];
}

//几组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//几项
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
}

//自定义cell
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HeroCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ID" forIndexPath:indexPath];
    
    HeroItem* heroItem = _dataArray[indexPath.row];
    cell.nameLabel.text = heroItem.title;
    cell.headView.image = nil;
    NSString* imageUrl = [NSString stringWithFormat:@"http://img.lolbox.duowan.com/champions/%@_120x120.jpg", heroItem.enName];
    [MyConnection connectionWithUrl:imageUrl FinishBlock:^(NSData *data) {
        cell.headView.image = [UIImage imageWithData:data];
    } FailedBlock:^{
        NSLog(@"头像下载失败");
    }];
    
    return cell;
}




@end
