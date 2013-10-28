//
//  SPController.m
//  YundaSOA
//
//  Created by rangex on 13-7-18.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "SPController.h"

static SPController * instance;

@implementation SPController

- (id) init {
    
    if (!sp) {
        sp = [NSUserDefaults standardUserDefaults];
    }
    
    return self;
}

+(SPController *) getInstance {
    @synchronized(self) {
        if (!instance) {
            instance = [[self alloc] init];
        }
    }
    return instance;
}

+ (id) allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (!instance) {
            instance = [super allocWithZone:zone];
            return instance;
        }
    }
    return nil;
}

- (NSString *) getValue:(NSString *)key defValue:(NSString *)defValue {
    if (sp) {
        return [sp objectForKey:key];
    }
    return defValue;
}

- (BOOL) getBooleanValue:(NSString *)key defValue:(BOOL)defValue {
    if (sp) {
        return [sp boolForKey:key];
    }
    return defValue;
}

- (void) setValue:(NSString *)value forKey:(NSString *)key {
    if (sp) {
        [sp setObject:value forKey:key];
    }
}

- (void) setBooleanValue:(BOOL)value forKey:(NSString *)key {
    if (sp) {
        [sp setBool:value forKey:key];
    }
}

@end
