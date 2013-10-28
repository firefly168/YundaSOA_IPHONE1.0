//
//  QueryOrgRes.h
//  YundaSOA
//
//  Created by rangex on 13-7-18.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "ResponseBean.h"

@interface QueryOrgRes : ResponseBean

@property NSArray * orgInfoBeans;
@property NSArray * empInfoBeans;

+(Class) orgInfoBeans_class;
+(Class) empInfoBeans_class;

@end
