//
//  CategoryQueryInfoRes.h
//  YundaSOA
//
//  Created by rangex on 13-7-17.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "ResponseBean.h"

@interface CategoryQueryInfoRes : ResponseBean

@property NSArray * tasks;
@property NSArray * zltasks;

+(Class) tasks_class;
+(Class) zltasks_class;

@end
