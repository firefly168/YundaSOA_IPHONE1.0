//
//  CalendarStatusInfoBean.h
//  YundaSOA
//
//  Created by rangex on 13-7-17.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jastor.h"

@interface CalendarStatusInfoBean : Jastor

@property NSString * userId;
@property NSString * time;
@property NSNumber * total;
@property NSNumber * undeal;
@property NSNumber * dealed;

@end
