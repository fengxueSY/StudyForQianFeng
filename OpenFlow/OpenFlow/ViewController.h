//
//  ViewController.h
//  OpenFlow
//
//  Created by qianfeng on 13-8-22.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFOpenFlowView.h"

@interface ViewController : UIViewController<AFOpenFlowViewDelegate,AFOpenFlowViewDataSource>{
    AFOpenFlowView* _openFlowView;
}

@end
