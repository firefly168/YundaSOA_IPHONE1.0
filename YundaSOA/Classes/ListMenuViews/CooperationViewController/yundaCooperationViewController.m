//
//  yundaCooperationViewController.m
//  YundaSOA_IPHONE
//
//  Created by tyson on 13-10-11.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "yundaCooperationViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "CateTableCell.h"
#import "MyColor.h"
#import "UIView+ZXQuartz.h"
#import "ThreeDShapes.h"
#import "HttpCaller.h"
#import "UserBeanReq.h"
#import "CommonUtil.h"
#import "UserBeanRes.h"
#import "TriggerInfo.h"

#define DISTANCEX 10
#define INTERVALX 22
@class CALayer;

@interface yundaCooperationViewController ()
{
    UserBeanReq *req;
}

@property (nonatomic,assign) int reqID;

@end

@implementation yundaCooperationViewController

@synthesize reqID;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    is_strech = NO;
    count = 5;
    //针对屏幕进行适配
    CGRect rect = self.bgImage.frame;
    rect.size.height = self.view.bounds.size.height - self.headView.frame.size.height;
    self.bgImage.frame = rect;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(switchToDetail) name:@"switchToDetail" object:nil];
    
    //屏幕上方的进度表
    processCurrentView = [[ProcessCurrentView alloc] initWithFrame:self.processView.frame];
    [self.view addSubview:processCurrentView];
    
    //设置背景色
    self.view.backgroundColor = RGB(211, 211, 211);
    
    if (req == nil) {
        req = [[UserBeanReq alloc] init];
    }
    [req setUserId:@"90000001"]; //@"90000001"
    [req setPwd:@"000000a"]; //@"000000a"
    self.reqID = [[HttpCaller getCaller] call:MODULE_ID_LOGIN setObj:req];
}

- (void) OnTrigger:(int)iTriggerID byTriggerInfo:(TriggerInfo *)info
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setBackBtn:nil];
    [self setBgImage:nil];
    [self setHeadView:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"switchToDetail" object:nil];
    [self setProcessView:nil];
    [super viewDidUnload];
}

- (IBAction)doBack:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cate_cell";
    
    CateTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
      
    if (cell == nil) {
        NSArray * nibs = [[NSBundle mainBundle] loadNibNamed:@"CateTableCell" owner:self options:nil];
        cell = [nibs objectAtIndex:0];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
//    static NSString *CellIdentifier = @"CateSubCell";
//    
//    CateSubCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        NSArray * nibs = [[NSBundle mainBundle] loadNibNamed:@"CateSubCell" owner:self options:nil];
//        cell = [nibs objectAtIndex:0];
//        cell.selectedBackgroundView = [[UIView alloc] init];
//        cell.selectedBackgroundView.backgroundColor = [UIColor orangeColor];
//        cell.backgroundView = [[UIView alloc] init];
//        cell.backgroundView.backgroundColor = RGB(252, 233, 217);
//    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (subVc == nil) {
        subVc = [[SubCateViewController alloc]
                 initWithNibName:NSStringFromClass([SubCateViewController class])
                 bundle:nil];
        subVc.cateVC = self;
        subVc.view.frame = CGRectMake(0, 0, 320, count*35);
    }

    //切换展开的状态
    CateTableCell *cell = (CateTableCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.strechArrowImg.image = [UIImage imageNamed:@"down_arrow.png"];
//    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
//    self.tableView.scrollEnabled = NO;
    UIFolderTableView *folderTableView = (UIFolderTableView *)tableView;
    [folderTableView openFolderAtIndexPath:indexPath WithContentView:subVc.view
                                 openBlock:^(UIView *subClassView, CFTimeInterval duration, CAMediaTimingFunction *timingFunction){
                                     // opening actions
                                 }
                                closeBlock:^(UIView *subClassView, CFTimeInterval duration, CAMediaTimingFunction *timingFunction){
                                    // closing actions
                                }
                           completionBlock:^{
                               // completed actions
//                               self.tableView.scrollEnabled = YES;
                               CateTableCell *cell = (CateTableCell *)[tableView cellForRowAtIndexPath:indexPath];
                               cell.strechArrowImg.image = [UIImage imageNamed:@"right_arrow.png"];
                           }];
}

-(void)switchToDetail
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    cooperationDetail = [storyboard instantiateViewControllerWithIdentifier:@"cooperationDetail"];
    [self.navigationController pushViewController:cooperationDetail animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

@end

#define SHOWPIE 0

@implementation ProcessCurrentView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (NSDictionary *)getChartData {
    NSArray *sliceNameArray = [[NSArray alloc] initWithObjects:@"已开发",@"未开发",nil];
    sliceRateArray = [[NSArray alloc] initWithObjects:@"34",@"66", nil];
    
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
#if SHOWPIE
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, YES);  //抗锯齿处理

    CGFloat x1 = 30;
    CGFloat y1 = 10;
    
    //添加文字
    for (int i = 0; i < 5; i ++) {
        UILabel *lbl = [[UILabel alloc] init];
        lbl.frame = CGRectMake(1, 20*i, 30, 30);
        lbl.text = [NSString stringWithFormat:@"%d%%",(100 - 20*i)];
        lbl.font = [UIFont systemFontOfSize:8.0f];
        lbl.backgroundColor = [UIColor clearColor];
        [self addSubview:lbl];
    }
    
    for (int i = 0; i < 12; i ++) {
        UILabel *lbl = [[UILabel alloc] init];
        [self addSubview:lbl];
        lbl.frame = CGRectMake(x1 + INTERVALX*i + DISTANCEX, y1 + 85, 30, 30);
        lbl.text = [NSString stringWithFormat:@"%02d",i + 1];
        lbl.font = [UIFont systemFontOfSize:8.0f];
        lbl.backgroundColor = [UIColor clearColor];
    }
    
    UILabel *lbl = [[UILabel alloc] init];
    [self addSubview:lbl];
    lbl.frame = CGRectMake(x1 + 170, 0, 100, 15);
    lbl.text = @"2013年每月开发进度对比";
    lbl.textColor = [UIColor whiteColor];
    lbl.font = [UIFont systemFontOfSize:8.0f];
    lbl.backgroundColor = [UIColor clearColor];
    
    //画对比提示的背景框
    CGContextSetFillColorWithColor(context, RGB(166, 202, 8).CGColor);
    [self drawRectangle:lbl.frame withRadius:3];
    
    //画坐标
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextSetFillColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextMoveToPoint(context, x1, y1);
    CGContextSetLineWidth(context, 1);
    CGContextAddLineToPoint(context, x1, y1 + 90);
    CGContextAddLineToPoint(context, x1 + 270, y1 + 90);
    CGContextStrokePath(context);
    
    ProcessPoint processPoint[12] = {{73},{34},{63},{84},{33},{54},{43},{74},{23},{34},{73},{54}};
    //画曲线图
//    CGContextSetFillColorWithColor(context, RGB(251, 145, 29).CGColor);   //填充颜色
    CGContextSetStrokeColorWithColor(context,RGB(251, 145, 29).CGColor);    //笔画颜色
    CGContextMoveToPoint(context, x1 + DISTANCEX, processPoint[0].rate);
    CGContextSetLineWidth(context, 1);
    for (int i = 0; i < 12; i ++) {
        CGContextAddLineToPoint(context, x1 + INTERVALX*i + DISTANCEX, processPoint[i].rate);
    }
    CGContextStrokePath(context);
    
    //画两个圆
    for (int i = 0; i < 12; i ++) {
        CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
        [self drawCircleWithCenter:CGPointMake(x1 + INTERVALX*i + DISTANCEX, processPoint[i].rate) radius:3];
        CGContextSetFillColorWithColor(context, RGB(112, 188, 6).CGColor);
        [self drawCircleWithCenter:CGPointMake(x1 + INTERVALX*i + DISTANCEX, processPoint[i].rate) radius:2];
    }
#else
    ThreeDShapes *threedshapes = [[ThreeDShapes alloc] init];
    [threedshapes drawPieChart:self.center.x CenterY:(self.center.y - 35) CenterAngle:M_PI/3 EllipseRadius:70 Thickness:20.0 Data:[self getChartData]];
    [self drawTitle:[self getChartData]];
#endif
}

- (void)drawTitle:(NSDictionary *)data {
    
//    NSArray *sliceRate = [data valueForKey:@"chartRate"];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [[UIColor rgbMYHB:0 DetailColor:0] setFill];
    CGContextMoveToPoint(context, 10, 5);
    CGRect aRect = CGRectMake(10, 5, 20, 20);
    CGContextAddRect(context, aRect);
    CGContextFillPath(context);
    
    CGContextSetStrokeColorWithColor(context,[UIColor grayColor].CGColor);    //笔画颜色
    CGContextMoveToPoint(context, 170, 80);
    CGContextSetLineWidth(context, .5);
    CGContextAddLineToPoint(context, 200, 105);
    CGContextAddLineToPoint(context, 260, 105);
    CGContextStrokePath(context);
    
    UILabel *doneRateLbl = [[UILabel alloc] init];
    doneRateLbl.text = [NSString stringWithFormat:@"%@%%",[sliceRateArray objectAtIndex:0]];
    doneRateLbl.font = [UIFont systemFontOfSize:10.0f];
    doneRateLbl.backgroundColor = [UIColor clearColor];
    doneRateLbl.frame = CGRectMake(260, 100, 30, aRect.size.height);
    [self addSubview:doneRateLbl];
    
    UILabel *doneLbl = [[UILabel alloc] init];
    doneLbl.text = @"已完成";
    doneLbl.font = [UIFont systemFontOfSize:10.0f];
    doneLbl.backgroundColor = [UIColor clearColor];
    doneLbl.frame = CGRectMake(35, aRect.origin.y, 30, aRect.size.height);
    [self addSubview:doneLbl];
    
    [[UIColor rgbMYHB:1 DetailColor:0] setFill];
    CGContextMoveToPoint(context, 10, 45);
    aRect = CGRectMake(10, 45, 20, 20);
    CGContextAddRect(context, aRect);
    CGContextFillPath(context);

    CGContextSetStrokeColorWithColor(context,[UIColor grayColor].CGColor);    //笔画颜色
    CGContextMoveToPoint(context, 170, 45);
    CGContextSetLineWidth(context, .5);
    CGContextAddLineToPoint(context, 200, 20);
    CGContextAddLineToPoint(context, 260, 20);
    CGContextStrokePath(context);
    
    UILabel *noneRateLbl = [[UILabel alloc] init];
    noneRateLbl.text = [NSString stringWithFormat:@"%@%%",[sliceRateArray objectAtIndex:1]];
    noneRateLbl.font = [UIFont systemFontOfSize:10.0f];
    noneRateLbl.backgroundColor = [UIColor clearColor];
    noneRateLbl.frame = CGRectMake(260, 15, 30, aRect.size.height);
    [self addSubview:noneRateLbl];
    
    UILabel *noneLbl = [[UILabel alloc] init];
    noneLbl.text = @"未完成";
    noneLbl.backgroundColor = [UIColor clearColor];
    noneLbl.font = [UIFont systemFontOfSize:10.0f];
    noneLbl.frame = CGRectMake(35, aRect.origin.y, 30, aRect.size.height);
    [self addSubview:noneLbl];
}

struct ProcessPoint {
    CGFloat rate;
};
typedef struct ProcessPoint ProcessPoint;
@end