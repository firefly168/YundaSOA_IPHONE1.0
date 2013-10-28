//
//  CalendarInfoBean.h
//  YundaSOA
//
//  Created by rangex on 13-7-17.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jastor.h"

@interface CalendarInfoBean : Jastor

@property NSString * userId;
@property long long time;
@property int zltotal;
@property int zlundeal;
@property int zldealed;
@property int rcTotal;
@property int rcUndeal;
@property int rcDealed;
@property int oaTotal;
@property int oaUndeal;
@property int oaDealed;

@end
