//
//  yundaSelfTargetFinishedView.h
//  YundaSOA
//
//  Created by sam on 13-6-9.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "yundaManagerWallView.h"
#import "ProjectBeanReq.h"
#import "RequestBean.h"
#import "ProjectTaskBeanReq.h"
#import "ProjectTaskOfReqBean.h"
#import "ProjectTaskBeanRes.h"
#import "CategoryQueryInfoReq.h"

@class NinePalaceView,NineView,selfHeadView;

@interface yundaSelfTargetFinishedView : UIView
{
    selfHeadView *_selfHeadView;
    UIButton *myButton;
    NineView *nineView;
    BOOL isShirlded;
}

@property (weak, nonatomic) IBOutlet UITextField *taskTextField;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *ninescroll;
@property (nonatomic,assign)  int reqID;
@property (nonatomic,strong)  ProjectTaskBeanRes *currentProjectTaskRes;
- (IBAction)doSelected:(UIButton *)sender;

- (void)transformSubview:(BOOL)isShirld;
- (void)transferDataToView:(PageBean *)page;

@end

@interface NineView : UIView
{
    NinePalaceView *currentNinePalaceView[9];
    UIView *bgView;
    UIImageView *bgimage;
    UIImageView *nineImageView[9];
}

@end

@interface NinePalaceView : UIView
{
    yundaWallCell *wallCell[9];
}

@end

@interface selfHeadView : UIView

@end

@interface BaseHeadView : selfHeadView

- (id)initWithFrame:(CGRect)frame HeadTitle:(NSString *)headTitle;

@end
