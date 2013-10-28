//
//  SPController.h
//  YundaSOA
//
//  Created by rangex on 13-7-18.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const AUTO_LOGIN = @"auto_login";
static NSString * const AUTO_LOGIN_USERID = @"auto_login_userid";
static NSString * const AUTO_LOGIN_PWD = @"auto_login_pwd";
static NSString * const AUTO_LOGIN_OPERID = @"auto_login_operid";
static NSString * const AUTO_LOGIN_ROLEIDS = @"auto_login_roleids";
static NSString * const AUTO_LOGIN_USERNAME = @"auto_login_username";

@interface SPController : NSObject {
    NSUserDefaults * sp;
}

+(SPController *) getInstance;

-(NSString *) getValue:(NSString *) key defValue:(NSString *) defValue;
-(BOOL) getBooleanValue:(NSString *) key defValue:(BOOL) defValue;

-(void) setValue:(NSString *)value forKey:(NSString *)key;
-(void) setBooleanValue:(BOOL) value forKey:(NSString *)key;

@end
