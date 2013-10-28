//
//  3DShapes.h
//  YundaSOA_IPHONE
//
//  Created by tyson on 13-9-29.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThreeDShapes : NSObject

- (void)drawPieChart:(CGFloat)centerX CenterY:(CGFloat)centerY CenterAngle:(CGFloat)centerAngle
EllipseRadius:(CGFloat)ellipseradius Thickness:(CGFloat)thickness Data:(NSDictionary *)data;
@end
