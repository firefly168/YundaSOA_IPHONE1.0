//
//  yundaAppDelegate.h
//  YundaSOA
//
//  Created by sam on 13-6-6.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "yundaLoginViewController.h"
#import "yundaData.h"
#import "yundaMainViewController.h"

@class yundaLoginViewController;
@class yundaMainViewController;
@interface yundaWindow : UIWindow

@end

@interface yundaAppDelegate : UIResponder <UIApplicationDelegate>
{
    yundaLoginViewController *loginController;
@public
    yundaMainViewController *mainpageController;
}

@property (strong, nonatomic) UIWindow *window;

@end
