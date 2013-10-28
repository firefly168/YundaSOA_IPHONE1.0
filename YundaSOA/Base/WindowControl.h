//
//  WindowControl.h
//  YundaSOA
//
//  Created by rangex on 13-7-2.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IWindowControl.h"
@class TriggerInfo;
@class BaseViewController;

@interface WindowControl : NSObject<IWindowControl> {
    NSOperationQueue *threadPool;
}

@property (getter = getCurrentWindow, setter = setCurrentWindow:) BaseViewController *currentWindow;

+ (WindowControl *) getInstance;

- (void) sendTriggerToScreen:(TriggerInfo *) info;

@end
