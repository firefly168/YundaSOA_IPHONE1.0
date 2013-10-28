//
//  ComConfigReader.m
//  HelloWorld
//
//  Created by rangex on 13-6-28.
//  Copyright (c) 2013年 rangex. All rights reserved.
//

#import "ComConfigReader.h"

static NSDictionary *p_moduleList;

@implementation ComConfigReader

+ (NSString *) getModuleURL:(NSString *)module_id {
    @synchronized (self) {
        if (!p_moduleList) {
            NSString * pListPath = [[NSBundle mainBundle] pathForResource:@"Com_Module_List" ofType:@"plist"];
            p_moduleList = [[NSDictionary alloc] initWithContentsOfFile:pListPath];
        }
    }
    return [p_moduleList objectForKey:module_id];
}

@end
