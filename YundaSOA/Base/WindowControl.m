//
//  WindowControl.m
//  YundaSOA
//
//  Created by rangex on 13-7-2.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "WindowControl.h"
#import "MessageCenter.h"
#import "TriggerInfo.h"
#import "BaseViewController.h"

static WindowControl *instance;
@implementation WindowControl

+(WindowControl *) getInstance {
    @synchronized(self) {
        if (!instance) {
            instance = [[self alloc] init];
        }
    }
    return instance;
}

- (id) init {
    threadPool = [NSOperationQueue mainQueue];
    NSLog(@"trigger register");
    [[MessageCenter sharedInstance] registerReceiver:MESSAGE_ID_TRIGGER queue:threadPool usingBlock:^ (NSNotification *msg) {
        if (![self getCurrentWindow]) {
            [self sendTriggerToScreen:[msg object]];
        } else {
            id triggerInfo = [msg object];
            if (triggerInfo && [triggerInfo isKindOfClass:[TriggerInfo class]]) {
                [self onTrigger:[triggerInfo getTriggerID] byTriggerInfo:triggerInfo];
            }
        }
    }];
    
    return self;
}

+(id) allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (!instance) {
            instance = [super allocWithZone:zone];
            return instance;
        }
    }
    return nil;
}

- (void) onTrigger:(int)iTriggerID byTriggerInfo:(TriggerInfo *)info {

    [[self getCurrentWindow] onTrigger:iTriggerID byTriggerInfo:info];
}

- (void) sendTriggerToScreen:(TriggerInfo *)info {
    [[MessageCenter sharedInstance] sendMessage:MESSAGE_ID_TRIGGER setObj:info postingStyle:NSPostWhenIdle];
}

- (void) winForwardTo:(Class)targetWin {

    if ([self getCurrentWindow]) {
        BaseViewController *controller = [[targetWin alloc] init];
        [self getCurrentWindow].view.window.rootViewController = controller;
//        [UIView beginAnimations:@"pageCurl" context:nil];
//        [UIView setAnimationDuration:1.25];
//        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//        [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:[self getCurrentWindow].view cache:YES];
//
//        [UIView commitAnimations];

    }
}

- (void) switchRootController:(Class)targetWin {

}

@end
