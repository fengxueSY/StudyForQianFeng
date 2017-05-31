//
//  CreateUI.m
//  爱限免
//
//  Created by pk on 14/12/9.
//  Copyright (c) 2014年 pk. All rights reserved.
//

#import "CreateUI.h"

@implementation CreateUI

+ (UILabel*)createLabelWithFrame:(CGRect)frame Text:(NSString*)text Font:(UIFont*)font Color:(UIColor*)color{
    UILabel* label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    if (font) {
        label.font = font;
    }
    if (color) {
        label.textColor = color;
    }
    return [label autorelease];
}

+ (UIButton*)createButtonWithFrame:(CGRect)frame Title:(NSString*)title BackgroundImage:(UIImage*)bgImage Image:(UIImage*)image Target:(id)target Action:(SEL)action{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (bgImage) {
        [button setBackgroundImage:bgImage forState:UIControlStateNormal];
    }
    if (image) {
        [button setImage:image forState:UIControlStateNormal];
    }
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

@end
