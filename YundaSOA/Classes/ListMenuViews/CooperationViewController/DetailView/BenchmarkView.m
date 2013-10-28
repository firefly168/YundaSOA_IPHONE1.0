//
//  BenchmarkView.m
//  YundaSOA_IPHONE
//
//  Created by tyson on 13-10-14.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "BenchmarkView.h"
#import "ThreeDShapes.h"
#import "MyColor.h"

@implementation BenchmarkView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (NSDictionary *)getChartData {
    sliceNameArray = [[NSArray alloc] initWithObjects:@"圆通",@"中通",@"顺丰",@"申通",@"宅急送", nil];
    sliceRateArray = [[NSArray alloc] initWithObjects:@"11",@"22",@"33",@"22",@"12", nil];
    
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

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, YES);  //抗锯齿处理
    
    NSDictionary *chartData = [self getChartData];
    
    ThreeDShapes *threedshapes = [[ThreeDShapes alloc] init];
    [threedshapes drawPieChart:160 CenterY:150 CenterAngle:M_PI/3 EllipseRadius:120 Thickness:20.0 Data:chartData];
    
//    [self drawPromptLine];
    
    [self drawPromptTitle];
}

//绘制提示线
- (void)drawPromptLine
{
    CGFloat x1 = 100;
    CGFloat y1 = 130;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 0.2f, 0.2f, 0.2f, 1);
    CGContextSetRGBFillColor(context, 0.0f, 0.0f, 0.0f, 1.0f);
    //CGContextSetRGBStrokeColor(ctx, 1.0f, 1.0f, 1.0f, 1.0f);
    //CGContextSetRGBFillColor(ctx, 1.0f, 1.0f, 1.0f, 1.0f);
    //CGContextSetShadow(ctx, CGSizeMake(0.0f, 0.0f), 5);
    
    CGContextMoveToPoint(context, x1, y1);
    CGContextSetLineWidth(context, 1);
    CGContextAddLineToPoint(context, x1, y1 + 100);
    CGContextAddLineToPoint(context, x1 + 50, y1 + 100);
    CGContextStrokePath(context);
    
    //CGContextSetRGBFillColor(ctx, 0.0f, 0.0f, 0.0f, 1.0f);
    CGContextMoveToPoint(context, x1-4/2, y1);
    CGContextAddLineToPoint(context, x1, y1-6);
    CGContextAddLineToPoint(context, x1+4/2, y1);
    CGContextClosePath(context);
    CGContextFillPath(context);
}

- (void)drawPromptTitle
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (int i = 0; i < [sliceNameArray count]; i ++) {
        [[UIColor rgbMYHB:i DetailColor:0] setFill];
        CGContextMoveToPoint(context, 10, 5);
        CGRect aRect = CGRectMake(20 + 60 * i, 305, 20, 20);
        CGContextAddRect(context, aRect);
        CGContextFillPath(context);
        
        UILabel *doneLbl = [[UILabel alloc] init];
        doneLbl.text = [NSString stringWithFormat:@"%@",[sliceNameArray objectAtIndex:i]];
        doneLbl.font = [UIFont systemFontOfSize:10.0f];
        doneLbl.backgroundColor = [UIColor clearColor];
        doneLbl.frame = CGRectMake(45 + 60 * i, 303, 30, aRect.size.height);
        [self addSubview:doneLbl];
    }
}

@end
