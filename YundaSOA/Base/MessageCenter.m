//
//  MessageCenter.m
//  HelloWorld
//
//  Created by rangex on 13-6-28.
//  Copyright (c) 2013年 rangex. All rights reserved.
//

#import "MessageCenter.h"
@class NSNotificationCenter;
@class NSNotificationQueue;

@implementation MessageCenter

static MessageCenter* instance = nil;

-(id) init {
    
    if (self = [super init]) {
        center = [NSNotificationCenter defaultCenter];
        queue = [NSNotificationQueue defaultQueue];
    }
    
    return self;
}

+(MessageCenter *) sharedInstance {
    @synchronized(self) {
        if (!instance) {
            instance = [[self alloc] init];
        }
    }
    return instance;
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

- (void) _sendMessage:(NSString *)msgID setObj:(NSObject *)obj postingStyle:(int)style {
    if (queue) {
        [queue enqueueNotification:[NSNotification notificationWithName:msgID object:obj] postingStyle:style];
    }
}

- (BOOL) sendMessage:(NSString *)msgID setObj:(NSObject *)obj postingStyle:(int)style {
    NSMethodSignature *sig = [self methodSignatureForSelector:@selector(_sendMessage:setObj:postingStyle:)];
    NSInvocation *invo = [NSInvocation invocationWithMethodSignature:sig];
    [invo setTarget:self];
    [invo setSelector:@selector(_sendMessage:setObj:postingStyle:)];
    [invo setArgument:&msgID atIndex:2];
    [invo setArgument:&obj atIndex:3];
    [invo setArgument:&style atIndex:4];
    [invo retainArguments];
    [invo performSelectorOnMainThread:@selector(invoke) withObject:nil waitUntilDone:NO];
    return YES;
}

- (void) registerReceiver:(NSString *)msgID queue:(NSOperationQueue *)thread usingBlock:(void (^)(NSNotification *))block {

    if (center) {
        [center addObserverForName:msgID object:nil queue:thread usingBlock:block];
    }
}

- (void) unregisterReceiver:(NSString *)msgID {
    if (center ) {
        [center removeObserver:self name:msgID object:nil];
    }
}

@end
