//
//  QuerAreaCustProgressListRes.h
//  YundaSOA_IPHONE
//
//  Created by rangex on 13-10-21.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "ResponseBean.h"

@interface QueryAreaCustProgressListRes : ResponseBean

@property NSArray * customerInfoBeans;

+(Class) customerInfoBeans_class;

@end
