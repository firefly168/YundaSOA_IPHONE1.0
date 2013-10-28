//
//  ConfigReader.h
//  YundaSOA
//
//  Created by rangex on 13-7-2.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const CONFIG_KEY_HTTP_SERVER_URL = @"HttpServerUrl";

static NSString * const CONFIG_KEY_HTTP_TIMEOUT = @"HttpTimeout";

static int const DEFAULT_HTTP_TIMEOUT = 10000;

@interface ConfigReader : NSObject

+ (NSString *) getConfig:(NSString *) key;

@end
