//
//  yundaSelfTargetFinishedView.m
//  YundaSOA
//
//  Created by sam on 13-6-9.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "yundaSelfTargetFinishedView.h"

#define NINEPALACEWIDTH 85
#define NINEPALACEHEIGHT 77
#define interval_y -10
#define NineView_X 40
#define Shirld_Distance 70

@implementation yundaSelfTargetFinishedView

@synthesize reqID,currentProjectTaskRes;

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    if (nineView == nil) {
        nineView = [[NineView alloc] init];
        [self.ninescroll addSubview:nineView];
        self.ninescroll.contentSize = CGSizeMake(self.frame.size.width*3, (self.frame.size.height - 75)*3);  //scroll的尺寸
        nineView.frame = CGRectMake(0, 0, self.frame.size.width*3, (self.frame.size.height - 75)*3);
        self.ninescroll.directionalLockEnabled = YES;        //只能在一个方向上滑动
        self.ninescroll.pagingEnabled = YES;                 //设置这个属性就能使scroll像翻页一样滑动了
        self.ninescroll.showsHorizontalScrollIndicator = NO;
        self.ninescroll.showsVerticalScrollIndicator = NO;
        self.ninescroll.indicatorStyle = UIScreenOverscanCompensationInsetBounds;
        self.ninescroll.bounces = NO;                        //设置这个属性可以锁定scroll，从而不出现反弹的效果
        //可以设置UIView响应相应的手势动作
//        [self.ninescroll.panGestureRecognizer addTarget:self action:@selector(scrollHandlePan:)];
    }

    [self searchTasksByPrID:10];
}

/*
-(void)scrollHandlePan:(UIPanGestureRecognizer*) panParam
{
    CGFloat diff,v_X,finishedX;
    if(panParam.state == UIGestureRecognizerStateCancelled || panParam.state == UIGestureRecognizerStateEnded)
    {
        diff = 20.f;
        v_X = 30.f;
        finishedX = 50.f;
        //防止出现 抖动
        NSTimeInterval duration = MIN(0.3f,ABS(diff/v_X));
        [UIView animateWithDuration:duration
                              delay:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             CGRect frame = self.ninescroll.frame;
                             frame.origin.x = finishedX;
                             self.ninescroll.frame= frame;
                         }
                         completion:^(BOOL finished) {
                         }];
    }
}
*/

- (void)searchProjectNineField
{
     NSString * type;
     NSString * query_maxTime;
     NSString * query_minTime;
     NSString * query_creator;
     NSString * query_keyWords;
//     NSString * orgseq;
//     NSString * dealer;
    
    CategoryQueryInfoReq *req = [[CategoryQueryInfoReq alloc] init];
    [req setType:type];
    [req setCreator:query_creator];
    [req setKeyWords:query_keyWords];
    [req setTimeMax:query_maxTime];
    [req setTimeMin:query_minTime];
    
//    if (start_mode == START_MODE_ORG) {
//        [req setOrgseq:orgseq];
//    } else if (start_mode == START_MODE_OTHERDEALER) {
//        [req setDealer:dealer];
//    }
    self.reqID = [[HttpCaller getCaller] call:MODULE_ID_SELF_QUERY setObj:req];
}

- (void)searchTasksByPrID:(int)prId
{
    ProjectTaskBeanReq *req = [[ProjectTaskBeanReq alloc] init];
    ProjectTaskOfReqBean *criteria = [[ProjectTaskOfReqBean alloc] init];
    criteria.prId = [NSNumber numberWithInt:prId];
    req.criteria = criteria;
    PageBean *pageBean = [[PageBean alloc] init];
    [pageBean setItemOfPage:[NSNumber numberWithInt:10]];
    [req setPage:pageBean];
    
    self.reqID = [[HttpCaller getCaller] call:MODULE_ID_QUERY_TASK setObj:req];
}

- (void)transferDataToView:(PageBean *)page
{
    NSLog(@"%@---%@",self.currentProjectTaskRes.list,self.currentProjectTaskRes.page);
}

- (IBAction)doSelected:(UIButton *)sender {
}

- (void)transformSubview:(BOOL)isShirld
{
    isShirlded = isShirld;
    
    [UIView beginAnimations:@"ResizeView" context:nil];
    [UIView setAnimationDuration:0.5];
    if (isShirlded) {
        CGRect rect = nineView.frame;
        rect.origin.x = NineView_X + Shirld_Distance;
        nineView.frame = rect;
    } else {
        CGRect rect = nineView.frame;
        rect.origin.x = NineView_X;
        nineView.frame = rect;
    }
    [UIView commitAnimations];
}

@end

@implementation NineView

- (id)init
{
    self = [super init];
    if (self) {
        bgView = [[UIView alloc] init];
        [self addSubview:bgView];
        bgimage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"transparent.png"]];
        [bgView addSubview:bgimage];
        
        for (int i = 0; i < 9; i ++) {
            currentNinePalaceView[i] = [[NinePalaceView alloc] init];
            [bgView addSubview:currentNinePalaceView[i]];
            nineImageView[i] = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"ninefield_num%d.png",i + 1]]];
            [bgView addSubview:nineImageView[i]];
        }
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    bgView.frame = CGRectMake(0, 0, self.frame.size.width,self.frame.size.height);
    bgimage.frame = CGRectMake(0, 0, bgView.frame.size.width, bgView.frame.size.height);
    
    for (int i = 0; i < 3; i ++) {
        for (int j = 0; j < 3; j ++) {
            currentNinePalaceView[i + j*3].frame = CGRectMake(8 + self.frame.size.width/3*i, 5 + self.frame.size.height/3*j, self.frame.size.width/3 - 15, self.frame.size.height/3 - 15);
            currentNinePalaceView[i + j*3].backgroundColor = [UIColor whiteColor];

            nineImageView[i + j*3].contentMode = UIViewContentModeScaleToFill;
            nineImageView[i + j*3].backgroundColor = [UIColor clearColor];
            nineImageView[i + j*3].frame = currentNinePalaceView[i + j*3].frame;
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

@end

@implementation NinePalaceView

- (id)init
{
    self = [super init];
    if (self) {
        for (int i = 0; i < 9; i ++) {
            wallCell[i] = [[yundaWallCell alloc] initWithFrame:CGRectZero];
        }
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    for (int i = 0; i < 3; i ++) {
        for (int j = 0; j < 3; j ++) {
            CGRect titleBar_rect = CGRectMake(5 + (NINEPALACEWIDTH - 5)*i, 5 + (NINEPALACEHEIGHT - 5)*j, NINEPALACEWIDTH - 15, NINEPALACEHEIGHT - 15);
            wallCell[i + j*3].frame = titleBar_rect;
            wallCell[i + j*3].tag = i + j*3 + 100;
            [self addSubview:wallCell[i + j*3]];
        }
    }
}

@end

@interface selfHeadView()

@end

@implementation selfHeadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)titleLabelUI
{
    CGFloat x_pixel = 20;
    CGFloat y_pixel = 20;
    CGFloat intervalX = 400;
    CGFloat intervalY = 35;
    CGFloat width = 300;
    CGFloat height = 30;
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(200, 0, 400, 50)];
    label1.textAlignment = NSTextAlignmentRight;
    label1.text = @"目标达成事项推进进度表（事项墙）";
    label1.font = [UIFont systemFontOfSize:20];
    [self addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(x_pixel, y_pixel + intervalY, width, height)];
    label2.text = @"我需要去完成的事项   20   件";
    [self addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(x_pixel, y_pixel + intervalY * 2, width, height)];
    label3.text = @"我发起的事项   5  件";
    [self addSubview:label3];
    
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(x_pixel, y_pixel + intervalY * 3, width*3, height)];
    label4.text = @"所有事项共   85   件， 已完成   12   件， 待完成   73   件， 暂停   0   件";
    [self addSubview:label4];
    
    UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake(x_pixel + intervalX, y_pixel + intervalY, width*2, height)];
    label5.textAlignment = NSTextAlignmentRight;
    label5.text = @"我部门有人参与需要支持跟踪的事项   7   件";
    [self addSubview:label5];
    
    UILabel *label6 = [[UILabel alloc] initWithFrame:CGRectMake(x_pixel + intervalX, y_pixel + intervalY * 2, width, height)];
    label6.textAlignment = NSTextAlignmentRight;
    label6.text = @"我已完成的事项   0   件";
    [self addSubview:label6];
    
    //    UILabel *label7 = [[UILabel alloc] initWithFrame:CGRectMake(x_pixel + intervalX, y_pixel + intervalY * 3, width, height)];
    //    label7.textAlignment = NSTextAlignmentRight;
    //    label7.text = @"(此项仅总裁有查看权限，未完成在前，已完成灰色在后)";
    //    [self addSubview:label7];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [self titleLabelUI];
}

@end

@implementation BaseHeadView

- (id)initWithFrame:(CGRect)frame HeadTitle:(NSString *)headTitle
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UIImageView *bgImageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"transparent.png"]];
        bgImageview.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        [self addSubview:bgImageview];
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(bgImageview.frame.size.width/2 - 175, bgImageview.frame.size.height/2 - 25, 350, 50)];
        label1.textAlignment = NSTextAlignmentCenter;
        label1.text = headTitle;
        label1.backgroundColor = [UIColor clearColor];
        label1.font = [UIFont systemFontOfSize:30];
        [self addSubview:label1];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    
}

@end