//
//  yundaMainViewController.h
//  YundaSOA
//
//  Created by sam on 13-6-6.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "yundaCalendarView.h"
#import "yundaSearchProjectView.h"
#import "ListMenuView.h"
#import "yundaCooperationViewController.h"

@interface yundaMainViewController : BaseViewController<UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIActionSheet *actionSheet;
    yundaCooperationViewController *cooperation;
}

@property (strong, nonatomic) IBOutlet UISegmentedControl *soaSegment;
@property (strong, nonatomic) IBOutlet UIImageView *headImageView;
@property (strong, nonatomic) IBOutlet UIButton *switchBtn;
@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) IBOutlet UIButton *chooseYearBtn;
@property (strong, nonatomic) IBOutlet UIButton *chooseMonthBtn;
@property (strong, nonatomic) IBOutlet UILabel *yearDetailLbl;
@property (strong, nonatomic) IBOutlet UILabel *monthDetailLbl;
@property (strong, nonatomic) IBOutlet UIScrollView *mainScrollView;

@property (strong, nonatomic) IBOutlet UIView *chooseCalendarView;
@property (strong, nonatomic) IBOutlet UIView *headView;
@property (strong, nonatomic) IBOutlet UIPickerView *monthoryearpicker;

- (IBAction)doBack:(UIButton *)sender;
- (IBAction)doSwitch:(UIButton *)sender;
- (IBAction)doChooseYear:(UIButton *)sender;
- (IBAction)doChooseMonth:(UIButton *)sender;

- (void)showFullBackgroundView;
- (void)removeFullBackgroundView;
- (void)showSelectedView:(int)index;
@end
