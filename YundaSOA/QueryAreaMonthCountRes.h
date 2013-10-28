//
//  QuerAreaMonthCountRes.h
//  YundaSOA_IPHONE
//
//  Created by rangex on 13-10-21.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "ResponseBean.h"

@interface QueryAreaMonthCountRes : ResponseBean


@property NSString * yearTotal;

@property NSString * yearAvg;

@property NSString * goal;

@property NSArray * monthAmountBeans;

+(Class) monthAmountBeans_class;

@end
