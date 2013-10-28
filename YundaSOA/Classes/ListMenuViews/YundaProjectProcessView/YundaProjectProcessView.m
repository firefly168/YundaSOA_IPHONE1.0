//
//  yundaFifthView.m
//  YundaSOA
//
//  Created by tyson on 13-7-11.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "YundaProjectProcessView.h"

@implementation YundaProjectProcessView

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    UIImageView *bgImgView = [[UIImageView alloc] init];
    [bgImgView setImage:[UIImage imageNamed:@"loginbackground.png"]];
    bgImgView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self addSubview:bgImgView];
    [self sendSubviewToBack:bgImgView];
    
    if (rotateView == nil) {
        rotateView = [[RotateView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    }
    [self addSubview:rotateView];
}

@end
