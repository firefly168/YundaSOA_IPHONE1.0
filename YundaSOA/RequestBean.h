//
//  RequestBean.h
//  YundaSOA
//
//  Created by rangex on 13-7-2.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jastor.h"
@class UserInfoBean;


@interface RequestBean : Jastor

@property UserInfoBean *user;
@property NSString *sourceTag;

@end
