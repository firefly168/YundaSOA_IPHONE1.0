//
//  HeadquarProgressBeanRes.h
//  YundaSOA
//
//  Created by rangex on 13-7-17.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "ResponseBean.h"
#import "HeadquarProgressInfoBean.h"

@interface HeadquarProgressBeanRes : ResponseBean

@property NSArray * list;
@property HeadquarProgressInfoBean * bean;

+(Class) list_class;

@end
