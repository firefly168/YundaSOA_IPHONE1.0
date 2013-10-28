//
//  yundaSeeWallpaperView.m
//  YundaSOA
//
//  Created by sam on 13-6-8.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "yundaSeeWallpaperView.h"
#import "UIImage+embundle.h"

@class yundaManagerWallView;
@implementation yundaSeeWallpaperView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIButton *returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [returnBtn setBackgroundImage:[UIImage imageBundleNamed:@"custom_button.png"] forState:UIControlStateNormal];
        [returnBtn setTitle:@"返回" forState:UIControlStateNormal];
        returnBtn.frame = CGRectMake(20, 10, 150, 70);
        [returnBtn addTarget:self action:@selector(returnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:returnBtn];
    }
    return self;
}

- (void)returnClick
{
    [self removeFromSuperview];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    // Drawing code
    wallview = [[yundaManagerWallView alloc] initWithFrame:CGRectMake(50, 200, 1270, 450)];
    [self addSubview:wallview];
}

@end
