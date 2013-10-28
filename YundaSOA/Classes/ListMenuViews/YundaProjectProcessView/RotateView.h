//
//  RotateView.h
//  tuoyuan
//
//  Created by tyson on 13-7-9.
//  Copyright (c) 2013年 Yunda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailMessageView.h"
#import "SecondCrystalDetailView.h"

#define TOTLECRYSTALNUM 15
#define RADIUS 300
#define EYESIGHT_DIS 800  //视距

@class RotateData,CrystalButton,DetailViewController;

@interface RotateView : UIView<UIPopoverControllerDelegate>
{
    UISlider *firstSlider;
    UISlider *secondSlider;
    CGFloat secondSlider_temp_value;
    CGFloat firstSlider_temp_value;
    CGFloat step_angle;   //每次计时转过的角度
    CGFloat spin_angle;     //z轴方向翻转的角度
    CrystalButton *btn[TOTLECRYSTALNUM];
    NSTimer *_activeTimer;
    int currentBtnCount;
    BOOL isStretched;        //水晶被展开
    BOOL isStartSecondStretchedAnimation;   //判断当水晶在展开之后被点击，是否完成了第一步动画，而执行第二步水晶展开动画的标志
    UIPopoverController *popover;
    
    DetailViewController *detail;
    UIButton *itemBtn[6];
    NSMutableArray *itemHeightArray;
    DetailMessageView *detailMessageView;
    SecondCrystalDetailView *secondCrystal;
    
    NSInteger crystalItemNum;  //第二级水晶项目的数量
    NSInteger currentItemNum;  //当前选中的item
    BOOL isSecondItemStrecthed; //第二级水晶是否已经展开
}

@end

@interface RotateData : NSObject
{
    
}

@property (nonatomic,readwrite) CGFloat x;
@property (nonatomic,readwrite) CGFloat y;
@property (nonatomic,readwrite) CGFloat z;
@property (nonatomic,readwrite) CGFloat rotate_angle;
@property (nonatomic,readwrite) CGFloat radion;         //当前buttonde的弧度

- (void)draw;
@end

@interface CrystalButton : UIButton
{
    RotateData *rotateData;
}
@property (nonatomic,strong) RotateData *rotateData;
@end

@interface DetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *detailTable;
}

@end