//
//  IWindowControl.h
//  YundaSOA
//
//  Created by rangex on 13-7-2.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TriggerInfo.h"

@protocol IWindowControl <NSObject>

- (void) onTrigger:(int) iTriggerID byTriggerInfo:(TriggerInfo *) info;
- (void) winForwardTo:(Class) targetWin;
- (void) switchRootController:(Class) targetWin;

@end
