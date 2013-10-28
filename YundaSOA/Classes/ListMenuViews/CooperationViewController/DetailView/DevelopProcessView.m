//
//  DevelopProcessView.m
//  YundaSOA_IPHONE
//
//  Created by tyson on 13-10-14.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "DevelopProcessView.h"
#import "MyColor.h"

#define MARGIN_LEFT 20
#define MARGIN_BOTTOM 60
#define MARGIN_TOP 20
#define SHOW_SCALE_NUM 5
#define MARGIN_SCALE_BETWEEN 10
#define BASEGROUNDX 50
#define INTERVALY 42

@implementation DevelopProcessView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGFloat column_Width = 30;
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self getData];
    
    mTime = 0;
    //    [self StartTimer];
    //    [UIView beginAnimations:@"ResizeView" context:nil];
    //    [UIView setAnimationDuration:0.5];
    [self drawLine:context Rect:rect];
    [self drawColumn:context Rect:rect Column_Width:column_Width];
    //    [UIView commitAnimations];
}

- (void)getData
{
    float data[12] = {12.3,55.2,3.3,93.5,31.3,66.2,13.3,62.3,24.5,13.0,52.3,41.1};
    
    NSMutableArray *gArray = [[NSMutableArray alloc] init];
    int count = 0;
    while (count < 12) {
        [gArray addObject:[NSNumber numberWithFloat:data[count]]];
        count ++;
    }
    groupData = gArray;
}

- (void)StartTimer
{
    //repeats设为YES时每次 invalidate后重新执行，如果为NO，逻辑执行完后计时器无效
    [NSTimer scheduledTimerWithTimeInterval:1.0/6.0 target:self selector:@selector(timerAdvanced:) userInfo:nil repeats:YES];
}

- (void)timerAdvanced:(NSTimer *)timer//这个函数将会执行一个循环的逻辑
{
    if (mTime == 0)
    {
        [timer invalidate];
        [self StartTimer];
    }
    mTime ++;
    if(mTime >= 10)
    {
        [timer invalidate];
    }
}

//画坐标
- (void)drawLine:(CGContextRef)context Rect:(CGRect)_rect
{
    CGPoint points[4];
    CGContextSaveGState(context);
    
    //画左侧面
    CGContextSetFillColorWithColor(context, RGBCOLOR(206, 206, 206).CGColor);
    points[0] = CGPointMake(BASEGROUNDX,_rect.size.height - MARGIN_TOP);
    points[1] = CGPointMake(BASEGROUNDX, MARGIN_TOP);
    points[2] = CGPointMake(BASEGROUNDX + MARGIN_SCALE_BETWEEN,MARGIN_TOP - MARGIN_SCALE_BETWEEN);
    points[3] = CGPointMake(BASEGROUNDX + MARGIN_SCALE_BETWEEN,_rect.size.height - MARGIN_TOP);
    
    CGContextAddLines(context, points, 4);
    CGContextDrawPath(context, kCGPathFill);
    
    //画下面
    CGContextSetFillColorWithColor(context, RGBCOLOR(200, 196, 200).CGColor);
    points[0] = CGPointMake(BASEGROUNDX, _rect.size.height - MARGIN_TOP);
    points[1] = CGPointMake(BASEGROUNDX + MARGIN_SCALE_BETWEEN, _rect.size.height - MARGIN_TOP - MARGIN_SCALE_BETWEEN);
    points[2] = CGPointMake(300 + MARGIN_SCALE_BETWEEN,_rect.size.height - MARGIN_TOP - MARGIN_SCALE_BETWEEN);
    points[3] = CGPointMake(300,_rect.size.height - MARGIN_TOP);
    
    CGContextAddLines(context, points, 4);
    CGContextDrawPath(context, kCGPathFill);
}

-(void)drawColumn:(CGContextRef)context Rect:(CGRect)_rect Column_Width:(CGFloat)column_Width
{
	CGPoint points[4];
    CGFloat baseGroundY = 40;
    CGFloat column_Height = 20;
    
    CGContextSaveGState(context);
    
    //    NSTimeInterval duration = MIN(0.5f,ABS(2.0f));
    //    [UIView animateWithDuration:duration
    //                          delay:0
    //                        options:UIViewAnimationOptionCurveLinear
    //                     animations:^{
    //                         if (times < 10) {
    //                             times ++;
    //                         }
    //                     }
    //                     completion:^(BOOL finished) {
    //                     }];
    NSArray *month = [NSArray arrayWithObjects:
                      @"1",@"2",@"3",@"4",
                      @"5",@"6",@"7",@"8",
                      @"9",@"10",@"11",@"12",nil];
    for(int gNumber = 0;gNumber<[groupData count];gNumber++){
        
        UIColor *columnColor;
        columnColor = [UIColor rgbMYHB:gNumber DetailColor:0];
        
        CGContextSetFillColorWithColor(context, columnColor.CGColor);
        CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
        
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        
        NSNumber *v = [groupData objectAtIndex:gNumber];
        column_Width = [v floatValue] * 2;
        
        //画正面
        CGContextSetFillColorWithColor(context, columnColor.CGColor);
        CGContextAddRect(context, CGRectMake(BASEGROUNDX, baseGroundY + INTERVALY *gNumber, column_Width, column_Height));
        CGContextDrawPath(context, kCGPathFill);
        
        UILabel *lbl = [[UILabel alloc] init];
        lbl.frame = CGRectMake(15, baseGroundY + INTERVALY *gNumber - 5, 50, 30);
        lbl.backgroundColor = [UIColor clearColor];
        lbl.font = [UIFont systemFontOfSize:10];
        lbl.text = [NSString stringWithFormat:@"%@月",[month objectAtIndex:gNumber]];
        [self addSubview:lbl];
        
        UILabel *pencentlbl = [[UILabel alloc] init];
        pencentlbl.frame = CGRectMake(BASEGROUNDX + column_Width + 13, baseGroundY + INTERVALY *gNumber - 5, 50, 30);
        pencentlbl.backgroundColor = [UIColor clearColor];
        pencentlbl.font = [UIFont systemFontOfSize:10];
        pencentlbl.text = [NSString stringWithFormat:@"%@%%",[groupData objectAtIndex:gNumber]];
        [self addSubview:pencentlbl];
        
        //画右侧面
        columnColor = [UIColor rgbMYHB:gNumber DetailColor:1];
        CGContextSetFillColorWithColor(context, columnColor.CGColor);
        points[0] = CGPointMake(BASEGROUNDX + column_Width,baseGroundY + INTERVALY *gNumber + column_Height);
        points[1] = CGPointMake(BASEGROUNDX + column_Width,baseGroundY + INTERVALY *gNumber);
        points[2] = CGPointMake(BASEGROUNDX + column_Width + MARGIN_SCALE_BETWEEN,baseGroundY + INTERVALY *gNumber - MARGIN_SCALE_BETWEEN);
        points[3] = CGPointMake(BASEGROUNDX + column_Width + MARGIN_SCALE_BETWEEN,baseGroundY + INTERVALY *gNumber + column_Height - MARGIN_SCALE_BETWEEN);
        
        CGContextAddLines(context, points, 4);
        CGContextDrawPath(context, kCGPathFill);
        
        //画上面
        columnColor = [UIColor rgbMYHB:gNumber DetailColor:2];
        CGContextSetFillColorWithColor(context, columnColor.CGColor);
        points[0] = CGPointMake(BASEGROUNDX, baseGroundY + INTERVALY *gNumber);
        points[1] = CGPointMake(BASEGROUNDX + MARGIN_SCALE_BETWEEN, baseGroundY + INTERVALY *gNumber - MARGIN_SCALE_BETWEEN);
        points[2] = CGPointMake(BASEGROUNDX + column_Width + MARGIN_SCALE_BETWEEN,baseGroundY + INTERVALY *gNumber - MARGIN_SCALE_BETWEEN);
        points[3] = CGPointMake(BASEGROUNDX + column_Width,baseGroundY + INTERVALY *gNumber);
        
        CGContextAddLines(context, points, 4);
        CGContextDrawPath(context, kCGPathFill);
    }    
}

@end
