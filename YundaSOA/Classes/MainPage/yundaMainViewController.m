//
//  yundaMainViewController.m
//  YundaSOA
//
//  Created by sam on 13-6-6.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "yundaMainViewController.h"
#import "yundaSelfTargetFinishedView.h"
#import "CommonUtil.h"
#import "CalendarBeanRes.h"
#import "CalendarBeanReq.h"
#import "SPController.h"
#import "UserBeanReq.h"

#define MIDDLEVIEW_HEIGHT 25
#define k_listMenuWidth 266
#define ymFBaseView_titleBar_height 37
#define HideButton_X 135
#define HideButton_Y 420
#define headView_intervalY .5

@interface yundaMainViewController ()<palaceCKCalendarDelegate,ListMenuDelegate>
{
    UIView *_currentView;
    
    ListMenuView *listMenuView;

    yundaCalendarView     *calendar;
    FullBackgroundView *fullBackgroundView;
    
    BOOL isShirld;  //是否缩放上面的listMenu视图
    NSMutableArray *_contentViews;
    
    NSArray* nibViews;
    
    NSString *yearStr;
    NSString *monthStr;
    
//    CalendarBeanReq *req;
        UserBeanReq *req;
    int tempYear;
    int tempMonth;
}

@property (nonatomic,strong) ListMenuView *listMenuView;

@end

@implementation yundaMainViewController
@synthesize listMenuView = _listMenuView;

- (void)viewDidLoad
{
    [super viewDidLoad];

    isShirld = YES;
    
    //顶部视图
    [self.view bringSubviewToFront:_headView];  //步骤一.将顶部视图放到最顶层

    //针对4寸和3.5寸屏的sotryboard需要在代码中做一次适配操作。
    self.mainScrollView.frame = CGRectMake(0, (self.headView.frame.size.height + self.chooseCalendarView.frame.size.height), self.view.bounds.size.width, (self.view.bounds.size.height - self.headView.frame.size.height - self.chooseCalendarView.frame.size.height));
    if (calendar == nil) {
        calendar = [[yundaCalendarView alloc] initWithStartDay:palaceStartSunday];
        calendar.delegate = self;
        [self.mainScrollView addSubview:calendar];
        [calendar layoutSubviews];
        self.mainScrollView.contentSize = CGSizeMake(calendar.frame.size.width, calendar.frame.size.height);
        self.mainScrollView.directionalLockEnabled = YES;  //只能一个方向滑动
//        self.mainScrollView.pagingEnabled = NO; //是否翻页
//        self.mainScrollView.showsVerticalScrollIndicator =YES; //垂直方向的滚动指示
//        self.mainScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;//滚动指示的风格
//        self.mainScrollView.showsHorizontalScrollIndicator = NO;//水平方向的滚动指示
    }
    
    if (self.listMenuView == nil)
    {
        nibViews =  [[NSBundle mainBundle] loadNibNamed:@"ListMenuView" owner:self options:nil];
        self.listMenuView = [nibViews objectAtIndex:0];//[[ListMenuView alloc] init];
        self.listMenuView.frame = CGRectMake(40, -250, self.listMenuView.frame.size.width, 50);
        self.listMenuView.listmenudelegate = self;
        [self.view addSubview:self.listMenuView];
        [self.view bringSubviewToFront:self.listMenuView];  //步骤一.将顶部视图放到最顶层
        [self.view insertSubview:self.listMenuView belowSubview:_headView];
    }
    
    if (calendar.currentYear >= 0) {
        [self.chooseYearBtn setTitle:[NSString stringWithFormat:@"%d",calendar.currentYear] forState:UIControlStateNormal];
        tempYear = calendar.currentYear;
    }
    if (calendar.currentMonth >= 0) {
        [self.chooseMonthBtn setTitle:[NSString stringWithFormat:@"%d",calendar.currentMonth] forState:UIControlStateNormal];
        tempMonth = calendar.currentMonth;
    }
    
    self.backBtn.hidden = YES;
    
//    if (req == nil) {
//        req = [[CalendarBeanReq alloc] init];
//    }
//    
//    [req setYear:@"2013"];
//    [req setMonth:@"8"];
//    
//    [[HttpCaller getCaller] call:MODULE_ID_CALENDAR setObj:req];
    
    //发送帐号登录信息到服务器

    if (req == nil) {
        req = [[UserBeanReq alloc] init];
    }
    [req setUserId:@"90000001"]; //@"90000001"
    [req setPwd:@"000000a"]; //@"000000a"
    [[HttpCaller getCaller] call:MODULE_ID_LOGIN setObj:req];

}

- (void)viewWillAppear:(BOOL)animated
{
    self.backBtn.hidden = YES;
}

- (void)showListView
{
    isShirld = !isShirld;

    CGRect frame = self.listMenuView.frame;
    frame.origin.y = (isShirld ? -250 : self.headView.frame.size.height);
    NSTimeInterval animationDuration = 0.30f;
    
    [UIView beginAnimations:@"ResizeView" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.listMenuView.frame = frame;
    [UIView commitAnimations];
}

- (void)showCalendar
{
    if (_currentView) {
        [_currentView removeFromSuperview];
        _currentView = nil;
    }
    if (calendar) {
        [calendar bringSubviewToFront:self.view];
    }
}

- (void) OnTrigger:(int)iTriggerID byTriggerInfo:(TriggerInfo *)info
{
    if (iTriggerID == TRIGGER_ID_RESPONSE) {
        ResponseBean *res;
        if ([_currentView isKindOfClass:[yundaSearchProjectView class]])
        {
            yundaSearchProjectView *tempView = (yundaSearchProjectView *)_currentView;
            @try {
                res = [CommonUtil checkResBean:[info getObjParam] reqID:tempView.reqID moduleID:nil delegate:nil message:@"登录失败"];
                //返回res表示获取登录信息失败
                if (res == nil) {
                    return;
                }
            }
            @catch (NSException *exception) {
                return;
            }
            @finally {
                
            }
            tempView.currentProjectRes.projectList = [(ProjectBeanRes *)res projectList];
            tempView.currentProjectRes.page = [(ProjectBeanRes *)res page];
            [tempView.table reloadData];
            [tempView._pageView transferDataToView:(PageBean *)tempView.currentProjectRes.page];
        }
        else if ([_currentView isKindOfClass:[yundaSelfTargetFinishedView class]])
        {
            yundaSelfTargetFinishedView *tempView = (yundaSelfTargetFinishedView *)_currentView;
            @try {
                res = [CommonUtil checkResBean:[info getObjParam] reqID:tempView.reqID moduleID:nil delegate:nil message:@"登录失败"];
                //返回res表示获取登录信息失败
                if (res == nil) {
                    return;
                }
            }
            @catch (NSException *exception) {
                return;
            }
            @finally {
                
            }
            tempView.currentProjectTaskRes.list = [(ProjectTaskBeanRes *)res list];
            tempView.currentProjectTaskRes.page = [(ProjectTaskBeanRes *)res page];
            [tempView transferDataToView:(PageBean *)tempView.currentProjectTaskRes.page];
        } else {
            @try {
                res = [CommonUtil checkResBean:[info getObjParam] reqID:calendar.reqID moduleID:nil delegate:self message:@"登录失败"];
                //返回res表示获取登录信息失败
                if (res == nil) {
                    return;
                }
            }
            @catch (NSException *exception) {
                return;
            }
            @finally {
                
            }
            calendar.currentYearData = [(CalendarBeanRes *)res yeardata];
            calendar.currentMonthData = [(CalendarBeanRes *)res monthdata];
            [calendar layoutSubviews];
        }
    }
}

- (void)showSelectedView:(int)index
{
    if (nibViews == nil) {
        nibViews = [[NSArray alloc] init];        
    }
    
    [self showListView];
    
    if (_currentView) {
        [_currentView removeFromSuperview];
        _currentView = nil;
    }
    
    switch (index) {
        case 0:
        {
            self.backBtn.hidden = NO;

            nibViews =  [[NSBundle mainBundle] loadNibNamed:@"yundaSearchProjectView" owner:self options:nil];
        }
            break;
        case 1:
        {
            self.backBtn.hidden = NO;

            nibViews =  [[NSBundle mainBundle] loadNibNamed:@"yundaBaseView" owner:self options:nil];
        }
            break;
        case 2:
        {
            self.backBtn.hidden = NO;

            nibViews =  [[NSBundle mainBundle] loadNibNamed:@"yundaDepartmentTargetView" owner:self options:nil];
        }
            break;
        case 3:
        {
            self.backBtn.hidden = NO;

            nibViews =  [[NSBundle mainBundle] loadNibNamed:@"yundaSelfTargetFinishedView" owner:self options:nil];
        }
            break;
        case 4:
        {
            self.backBtn.hidden = NO;

            nibViews =  [[NSBundle mainBundle] loadNibNamed:@"yundaFifthView" owner:self options:nil];
        }
            break;
        case 5:
        {
            //代码实现storyboard切换
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
            cooperation = [storyboard instantiateViewControllerWithIdentifier:@"cooperation"];
            [self.navigationController pushViewController:cooperation animated:YES];
            
            //隐藏listview
            isShirld = NO;
            [self showListView];

            return;
        }
            break;
        default:
        {
            nibViews =  [[NSBundle mainBundle] loadNibNamed:@"yundaSearchProjectView" owner:self options:nil];
        }
            break;
    }
    
    _currentView = [nibViews objectAtIndex:0];
    
    if (_currentView) {
        _currentView.frame = CGRectMake(0, _headView.frame.size.height, self.view.bounds.size.width, self.view.frame.size.height - _headView.frame.size.height);
        [self.view addSubview:_currentView];
        [_currentView layoutSubviews];
        //步骤二.将listView的视图放到顶部视图之下和calendar之上
        [self.view insertSubview:_currentView belowSubview:_headView];
        [self.view insertSubview:_currentView aboveSubview:calendar];
        [self.view insertSubview:_currentView belowSubview:self.listMenuView];
        [self.view bringSubviewToFront:_headView];
    }
}

- (void)removeFullBackgroundView
{
    [fullBackgroundView removeFromSuperview];
}

- (IBAction)doSwitch:(UIButton *)sender {
    [self showListView];
}

- (IBAction)doChooseYear:(UIButton *)sender {
    
    if (actionSheet == nil) {
        actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                  delegate:nil
                                         cancelButtonTitle:nil
                                    destructiveButtonTitle:nil
                                         otherButtonTitles:nil];
    }
    
    [actionSheet setActionSheetStyle:UIActionSheetStyleAutomatic];
    
    CGRect pickerFrame = CGRectMake(0, 40, 0, 0);
    
    if (self.monthoryearpicker == nil) {
        self.monthoryearpicker = [[UIPickerView alloc] initWithFrame:pickerFrame];
        self.monthoryearpicker.showsSelectionIndicator = YES;
        self.monthoryearpicker.dataSource = self;
        self.monthoryearpicker.delegate = self;
    }
    
    [actionSheet addSubview:self.monthoryearpicker];
    
    UISegmentedControl *closeButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"关闭", nil]];
    closeButton.momentary = YES;
    closeButton.frame = CGRectMake(10, 7.0f, 50.0f, 30.0f);
    closeButton.segmentedControlStyle = UISegmentedControlStyleBar;
    closeButton.tintColor = [UIColor blackColor];
    [closeButton addTarget:self action:@selector(dismissActionSheet:) forControlEvents:UIControlEventValueChanged];
    [actionSheet addSubview:closeButton];
    
    UISegmentedControl *okButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"确定",nil]];
    okButton.momentary = YES;
    okButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
    okButton.segmentedControlStyle = UISegmentedControlStyleBar;
    okButton.tintColor = [UIColor blackColor];
    [okButton addTarget:self action:@selector(provOk:) forControlEvents:UIControlEventValueChanged];
    [actionSheet addSubview:okButton];
    
    [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
    
    [actionSheet setBounds:CGRectMake(0, 0, 320, 485)];
    
    [self.monthoryearpicker selectRow:(calendar.currentYear - 2004) inComponent:0 animated:YES];
    [self.monthoryearpicker selectRow:(calendar.currentMonth - 1) inComponent:1 animated:YES];
}

- (IBAction)doChooseMonth:(UIButton *)sender {
    
    [self doChooseYear:sender];
}

-(IBAction)provOk:(id)sender{
//    [self.monthoryearpicker selectedRowInComponent:0];
    if (actionSheet == nil) {
        return;
    }
    
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
    actionSheet = nil;
    self.monthoryearpicker = nil;
    
    if (yearStr != nil && monthStr != nil) {
        [self.chooseYearBtn setTitle:yearStr forState:UIControlStateNormal];
        [self.chooseMonthBtn setTitle:monthStr forState:UIControlStateNormal];
        
        int changedMonth = ([monthStr intValue] - calendar.currentMonth) + ([yearStr intValue] - calendar.currentYear) * 12;
        
        calendar.currentYear = [yearStr intValue];
        calendar.currentMonth = [monthStr intValue];
        tempYear = [yearStr intValue];
        tempMonth = [monthStr intValue];

        [calendar moveCalendarToSpecialYearandMonth:changedMonth];
    }
}

-(IBAction)dismissActionSheet:(id)sender{
    if (actionSheet == nil) {
        return;
    }
    tempYear = calendar.currentYear;
    tempMonth = calendar.currentMonth;
    yearStr = [NSString stringWithFormat:@"%d",tempYear];
    monthStr = [NSString stringWithFormat:@"%d",tempMonth];
    
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
    actionSheet = nil;
    self.monthoryearpicker = nil;
}

- (IBAction)doBack:(UIButton *)sender {
    [self showCalendar];
    self.backBtn.hidden = YES;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return 11;
    } else if (component == 1) {
        return 12;
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return [NSString stringWithFormat:@"%d",row + 2004];
    } else if (component == 1) {
        return [NSString stringWithFormat:@"%d",row + 1];
    }
    return nil;
        
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
//        [self.monthoryearpicker selectRow:row inComponent:1 animated:TRUE];
//        [self.monthoryearpicker reloadComponent:1];
        yearStr = [NSString stringWithFormat:@"%d",row + 2004];
        tempYear = [yearStr intValue];
        monthStr = [NSString stringWithFormat:@"%d",tempMonth];
    } else if (component == 1) {
//        [self.monthoryearpicker selectRow:row inComponent:0 animated:TRUE];
//        [self.monthoryearpicker reloadComponent:0];
        yearStr = [NSString stringWithFormat:@"%d",tempYear];
        monthStr = [NSString stringWithFormat:@"%d",row + 1];
        tempMonth = [monthStr intValue];
    }
}

//显示一个弹出一个视图之后的全屏灰色透明背景，除了该视图其他地方都无法点击
- (void)showFullBackgroundView
{
    if (fullBackgroundView) {
        [fullBackgroundView removeFromSuperview];
    }
    fullBackgroundView = [[FullBackgroundView alloc] initWithFrame:CGRectZero];
    
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (interfaceOrientation == UIDeviceOrientationPortrait || interfaceOrientation == UIDeviceOrientationPortraitUpsideDown)
    {
        //翻转为竖屏时
    }
    else if (interfaceOrientation == UIDeviceOrientationLandscapeLeft || interfaceOrientation == UIDeviceOrientationLandscapeRight)
    {
        //翻转为横屏时
    }
    
    //转换横竖屏
    CGRect rect = [UIScreen mainScreen].bounds;
    rect.size.width = [UIScreen mainScreen].bounds.size.height;
    rect.size.height = [UIScreen mainScreen].bounds.size.width;
    fullBackgroundView.frame = rect;
    [self.view addSubview:fullBackgroundView];
}

- (void)calendar:(yundaCalendarView *)calendar didSelectDate:(NSDate *)date
{
    self.backBtn.hidden = NO;
    
    if (_currentView) {
        [_currentView removeFromSuperview];
    }
    
    if (nibViews == nil) {
        nibViews = [[NSArray alloc] init];
    }
    nibViews =  [[NSBundle mainBundle] loadNibNamed:@"yundaSelfTargetFinishedView" owner:self options:nil];
    
    _currentView = [nibViews objectAtIndex:0];
    _currentView.backgroundColor = [UIColor gridColor];
    if (_currentView) {
        _currentView.frame = CGRectMake(0, _headView.frame.size.height, self.view.bounds.size.width, self.view.frame.size.height - _headView.frame.size.height);
        [self.view addSubview:_currentView];
        [_currentView layoutSubviews];
        [self.view insertSubview:_currentView belowSubview:_headView];
        [self.view insertSubview:_currentView belowSubview:self.listMenuView];
        [self.view bringSubviewToFront:_headView];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [self setSwitchBtn:nil];
    [self setBackBtn:nil];
    [self setChooseYearBtn:nil];
    [self setChooseMonthBtn:nil];
    [self setYearDetailLbl:nil];
    [self setMonthDetailLbl:nil];
    [self setMainScrollView:nil];
    [self setHeadView:nil];
    [self setHeadView:nil];
    [self setChooseCalendarView:nil];
    [self setHeadView:nil];
    [self setMonthoryearpicker:nil];
    [super viewDidUnload];
}
@end
