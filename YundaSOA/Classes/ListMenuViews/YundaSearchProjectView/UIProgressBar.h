//
//  UIProgressBar.h
//  YundaSOA
//
//  Created by tyson on 13-7-29.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIProgressBar : UIView
{
	float minValue, maxValue;
	float currentValue;
	UIColor *lineColor, *progressRemainingColor, *progressColor;
    UILabel *titleLbl;
}

@property (nonatomic,strong) UILabel *titleLbl;
@property (nonatomic,readwrite) float minValue, maxValue, currentValue;
@property (nonatomic, retain) UIColor *lineColor, *progressRemainingColor, *progressColor;

-(void)setNewRect:(CGRect)newFrame;

@end