//
//  ConfigReader.m
//  YundaSOA
//
//  Created by rangex on 13-7-2.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "ConfigReader.h"

static NSDictionary *config;

@implementation ConfigReader

+ (NSString *) getConfig:(NSString *)key {
    @synchronized (self) {
        if (!config) {
            NSString * pConfig = [[NSBundle mainBundle] pathForResource:@"Config" ofType:@"plist"];
            config = [[NSDictionary alloc] initWithContentsOfFile:pConfig];
        }
    }
    return [config objectForKey:key];
}

@end
