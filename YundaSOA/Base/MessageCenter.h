//
//  MessageCenter.h
//  HelloWorld
//
//  Created by rangex on 13-6-28.
//  Copyright (c) 2013年 rangex. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSNotificationCenter;
@class NSNotificationQueue;


static NSString * const MESSAGE_ID_HTTP_REQ = @"HTTP_REQ";

static NSString * const MESSAGE_ID_TRIGGER = @"TRIGGER";

@interface MessageCenter : NSObject {
    
    NSNotificationCenter *center;
    NSNotificationQueue *queue;
}

+ (MessageCenter *) sharedInstance;

- (BOOL) sendMessage:(NSString *) msgID setObj:(NSObject *) obj postingStyle:(int) style;

- (void) registerReceiver:(NSString *) msgID queue:(NSOperationQueue *) thread usingBlock:(void (^)(NSNotification *)) block;
- (void) unregisterReceiver:(NSString *) msgID;

@end
