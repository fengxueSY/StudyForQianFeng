//
//  AppItem.h
//  爱限免
//
//  Created by pk on 14/12/9.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppItem : NSObject

@property (nonatomic, copy) NSString* applicationId;
@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* des;
@property (nonatomic, copy) NSString* categoryId;
@property (nonatomic, copy) NSString* categoryName;
@property (nonatomic, copy) NSString* iconUrl;
@property (nonatomic, copy) NSString* starCurrent;
@property (nonatomic, copy) NSString* downloads;
@property (nonatomic, copy) NSString* currentPrice;
@property (nonatomic, copy) NSString* lastPrice;
@property (nonatomic, copy) NSString* expireDatetime;
@property (nonatomic, copy) NSString* shares;
@property (nonatomic, copy) NSString* favorites;


@end
