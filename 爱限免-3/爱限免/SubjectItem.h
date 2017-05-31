//
//  SubjectItem.h
//  爱限免
//
//  Created by pk on 14/12/11.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppItem.h"

@interface SubjectItem : NSObject


@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* date;
@property (nonatomic, copy) NSString* img;
@property (nonatomic, copy) NSString* desc_img;
@property (nonatomic, copy) NSString* desc;
@property (nonatomic, retain) NSArray* applications;


@end
