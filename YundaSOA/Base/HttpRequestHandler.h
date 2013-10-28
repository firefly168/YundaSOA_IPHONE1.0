//
//  HttpRequestHandler.h
//  HelloWorld
//
//  Created by rangex on 13-6-28.
//  Copyright (c) 2013年 rangex. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MessageCenter;
@class NSOperationQueue;
@class NSNotification;

@interface HttpRequestHandler : NSObject {
    
    NSOperationQueue *threadPool;
    MessageCenter *msgCtrl;
}

- (void) handleMessage:(NSNotification *) notification;

@end
