//
//  BaseViewController.h
//  YundaSOA
//
//  Created by rangex on 13-7-2.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWindowControl.h"
#import "HttpCaller.h"
#import "TriggerInfo.h"
#import "ResponseBean.h"
#import "ResponsePackage.h"

@interface BaseViewController : UIViewController<IWindowControl>

- (void)ViewDidLoad;
- (void)DidReceiveMemoryWarning;
- (void) OnTrigger:(int)iTriggerID byTriggerInfo:(TriggerInfo *)info;

@end
