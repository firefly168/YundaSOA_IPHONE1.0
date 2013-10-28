//
//  CalendarBeanRes.h
//  YundaSOA
//
//  Created by rangex on 13-7-17.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "ResponseBean.h"
@class CalendarInfoBean;

@interface CalendarBeanRes : ResponseBean

@property CalendarInfoBean * yeardata;
@property NSArray * monthdata;

+ (Class) monthdata_class;

@end
