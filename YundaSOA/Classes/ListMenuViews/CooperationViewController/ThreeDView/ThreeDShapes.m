//
//  3DShapes.m
//  YundaSOA_IPHONE
//
//  Created by tyson on 13-9-29.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "ThreeDShapes.h"
#import "MyColor.h"

@implementation ThreeDShapes

- (NSDictionary *)getChartData {
    NSArray *sliceNameArray = [[NSArray alloc] initWithObjects:@"圆通",@"硅酮",@"中通",@"顺丰",@"申通",@"宅急送", nil];
    NSArray *sliceRateArray = [[NSArray alloc] initWithObjects:@"11",@"22",@"17",@"22",@"12",@"15", nil];
    
    int tempRate[[sliceRateArray count]];
    int rate[[sliceRateArray count]];
    int num = 0;
    
    NSMutableDictionary *sliceDic = [[NSMutableDictionary alloc] init];
    NSMutableArray *sliceName = [[NSMutableArray alloc] init];
    NSMutableArray *tempSliceRate = [[NSMutableArray alloc] init];
    NSMutableArray *sliceRate = [[NSMutableArray alloc] init];
    
    while (num < [sliceRateArray count]) {
        [tempSliceRate addObject:[NSNumber numberWithInt:[[sliceRateArray objectAtIndex:num] intValue]]];
        [sliceName addObject:[NSString stringWithFormat:@"chart%d",num]];
        tempRate[num] = [[tempSliceRate objectAtIndex:num] intValue];
        rate[num] = 0;
        for (int j = 0; j <= num && num < [tempSliceRate count]; j ++) {
            rate[num] += tempRate[j];
        }
        [sliceRate addObject:[NSNumber numberWithInt:rate[num]]];
        num ++;
    }
    
    [sliceDic setValue:sliceNameArray forKey:@"chartName"];
    [sliceDic setValue:sliceRate forKey:@"chartRate"];
    
    return sliceDic;
}

/*
 画一个三D的大饼
 CenterX CenterY 中心点坐标
 CenterAngle //椭圆的倾斜度
 EllipseRadius//椭圆半径
 Thickness //大饼厚度
 */
#define SLICE 1000  //目前的做法是，画SLICE个细小的三角形和矩形拼成一个椭圆
- (void)drawPieChart:(CGFloat)centerX CenterY:(CGFloat)centerY CenterAngle:(CGFloat)centerAngle EllipseRadius:(CGFloat)ellipseradius Thickness:(CGFloat)thickness Data:(NSDictionary *)data
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    NSDictionary *sliceDic = (data == nil ?[self getChartData] : data);
        
    //    NSArray *sliceName = [sliceDic valueForKey:@"chartName"];
    NSArray *sliceRate = [sliceDic valueForKey:@"chartRate"];
    
    for (int i = 0; i < SLICE; i ++) {
        
        CGContextSetRGBStrokeColor(context, 0, 0, 0, 1.0);
        CGContextSetLineWidth(context, 3.0);
        CGPoint aPoint[3];
        
        //设置饼不同角度的颜色
        for (int j = 0; j < [sliceRate count]; j ++) {
            if (M_PI*2*i/SLICE >= (j == 0 ? 0 :[[sliceRate objectAtIndex:j-1] intValue]*M_PI*2/100)
                && M_PI*2*i/SLICE < [[sliceRate objectAtIndex:j] intValue]*M_PI*2/100) {
                [[UIColor rgbMYHB:j%12 DetailColor:0] setFill];
                break;
            }
        }
        
        //分段画底边极小的三角形，slice越小，则三角形越小
        aPoint[0].x = centerX + ellipseradius * sin(M_PI*2*i/SLICE);
        aPoint[0].y = centerY + ellipseradius * cos(M_PI*2*i/SLICE) * cos(centerAngle);
        aPoint[1].x = centerX + ellipseradius * sin(M_PI*2*(i + 1)/SLICE);
        aPoint[1].y = centerY + ellipseradius * cos(M_PI*2*(i + 1)/SLICE) * cos(centerAngle);
        aPoint[2].x = centerX;
        aPoint[2].y = centerY;
        CGContextMoveToPoint(context, centerX, centerY);
        CGContextAddLines(context, aPoint, 3);
        //        CGContextClosePath(context);
        CGContextFillPath(context);
        
        //设置饼不同角度的颜色
        for (int j = 0; j < [sliceRate count]; j ++) {
            if (M_PI*2*i/SLICE >= (j == 0 ? 0 :[[sliceRate objectAtIndex:j-1] intValue]*M_PI*2/100)
                && M_PI*2*i/SLICE < [[sliceRate objectAtIndex:j] intValue]*M_PI*2/100) {
                [[UIColor rgbMYHB:j%12 DetailColor:1] setFill];
                break;
            }
        }
        //分段画底边极小的矩形，slice越小，则矩形越小
        if (cos(M_PI*2*i/SLICE) > 0) {
            CGContextMoveToPoint(context, centerX, centerY);
            CGRect aRect = CGRectMake(aPoint[0].x, aPoint[0].y, fabs(aPoint[1].x - aPoint[0].x), thickness);
            CGContextAddRect(context, aRect);
            CGContextFillPath(context);
        }
        
        //画一圈线
//        CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
//        CGContextMoveToPoint(context, aPoint[0].x, aPoint[0].y);
//        CGContextAddLineToPoint(context, aPoint[1].x, aPoint[1].y);
        
        //        判断sin值最大和最小时
        //        if ((sin(PI*2*(i-1)/SLICE) > sin(PI*2*i/SLICE) && sin(PI*2*i/SLICE) < sin(PI*2*(i + 1)/SLICE)) ||
        //            (sin(PI*2*(i-1)/SLICE) < sin(PI*2*i/SLICE) && sin(PI*2*i/SLICE) > sin(PI*2*(i + 1)/SLICE)))
        //        {
        //        }
        CGContextDrawPath(context, kCGPathStroke);
    }
    
//    [self drawPromptLine];
}

@end
