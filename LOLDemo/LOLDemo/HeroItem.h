//
//  HeroItem.h
//  LOLDemo
//
//  Created by pk on 14/12/2.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeroItem : NSObject
/*
 enName: "Kalista",
 cnName: "卡莉丝塔",
 title: "复仇之矛",
 tags: "marksman",
 rating: "8,2,4,7",
 location: "",
 price: ","
 */
@property (nonatomic, copy) NSString* enName;
@property (nonatomic, copy) NSString* cnName;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* tags;
@property (nonatomic, copy) NSString* rating;
@property (nonatomic, copy) NSString* location;
@property (nonatomic, copy) NSString* price;


@end
