//
//  ProjectTaskInfoForWholeTableBean.h
//  YundaSOA
//
//  Created by rangex on 13-7-17.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jastor.h"

@interface ProjectTaskInfoForWholeTableBean : Jastor

@property long dtid;
@property NSString * dtdeptids;
@property long sdate;
@property long edate;
@property int ftime;
@property float dpercentage;
@property NSString * templateposition;

@end
