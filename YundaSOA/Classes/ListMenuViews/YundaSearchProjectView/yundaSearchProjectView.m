//
//  yundaSearchProjectView.m
//  YundaSOA
//
//  Created by sam on 13-6-9.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "yundaSearchProjectView.h"
#import "yundaData.h"
#import "yundaAppDelegate.h"
#import "CustomCell1.h"
#import "UIView+Positioning.h"
#import "ThreeDShapes.h"
#import "ThreeDShapesView.h"

#define tableViewCellHeight 90
#define textLabelViewY_Pixel 70
#define textViewBgHeight 40
#define Shirld_Distance 70

@implementation yundaSearchProjectView

@synthesize _picUrlString,_imageView;
@synthesize table = _table;
@synthesize _pageView;
@synthesize reqID,currentProjectRes,_activeTimer;

- (id)init
{
    self = [super init];
    if (self) {
        isShirlded = NO;
        _textLabelView = [[TextLabelView alloc] init];
        currentProjectRes = [[ProjectBeanRes alloc] init];
        _textLabelView.delegate = self;
        [self addSubview:_textLabelView];
    }
    return self;
}

#pragma mark -
#pragma mark TableView DataSource Methods

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [super drawRect:rect];
    
//    _textLabelView.frame = CGRectMake(30, textLabelViewY_Pixel, 800, 350);
//    _textLabelView.layer.cornerRadius = 6.0f;
    [self sendSubviewToBack:self.bgImage];
    [self.bgImage setHidden:YES];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, YES);  //抗锯齿处理
    
    ThreeDShapes *threedshapes = [[ThreeDShapes alloc] init];
    [threedshapes drawPieChart:150 CenterY:250 CenterAngle:M_PI/3 EllipseRadius:100 Thickness:40.0 Data:nil];
//    ThreeDShapesView *threeDView = [[ThreeDShapesView alloc] initWithFrame:CGRectMake(20, 200, 150, 200)];
//    [self addSubview:threeDView];
    
//    UIImageView *oneimageView = [[UIImageView alloc] init];
//    [oneimageView setImage:[UIImage imageNamed:@"logo.png"]];
//    oneimageView.frame = CGRectMake(50, 200, 50, 50);
//    [self addSubview:oneimageView];
//    
//    UIImageView *bgImageView = [[UIImageView alloc] init];
//    [bgImageView setImage:[UIImage imageNamed:@"loginbackground.png"]];
//    [self addSubview:bgImageView];
//    bgImageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
//    [self sendSubviewToBack:bgImageView];
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.currentProjectRes.projectList count] > 0) {
        return [self.currentProjectRes.projectList count];
    }
    return 30;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    CustomCell1 *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CustomCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell configureCellContentSizeWidth:tableView.frame.size.width height:tableViewCellHeight];
    }
    
    [cell resetPosition];
    if ([self.currentProjectRes.projectList count] > 0) {
        [cell showAllMessageOnView:(ProjectInfoBean *)[self.currentProjectRes.projectList objectAtIndex:[indexPath row]]];
    }
    // Trigger tableView didLoad and then start animation
    if([indexPath row] == ((NSIndexPath*)[[tableView indexPathsForVisibleRows] lastObject]).row){
        // Show once only
        if (!tableAnimated) [self startTableViewAnimation:tableView];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [theDelegate->mainpageController showSelectedView:4];
}

- (void) startTableViewAnimation:(UITableView *)table
{
    tableAnimated = YES;
    for (AnimatedTableCell *atCell in table.visibleCells) {
        if ([table.visibleCells indexOfObject:atCell] % 2 == 0)
            [atCell pushCellWithAnimation:YES direction:@"left"];
        else
            [atCell pushCellWithAnimation:YES direction:@"right"];
    }
}

#pragma mark -
#pragma mark TableView Delegate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableViewCellHeight;
}

- (void)transformSubview:(BOOL)isShirld
{
    isShirlded = isShirld;
    
    [UIView beginAnimations:@"ResizeView" context:nil];
    [UIView setAnimationDuration:0.5];
    if (!isShirlded) {
        CGRect rect = _textLabelView.frame;
        rect.origin.x = 30;
        _textLabelView.frame = rect;
        rect = _table.frame;
        rect.origin.x = 0;
        _table.frame = rect;
        rect = _pageView.frame;
        rect.origin.x = 20;
        _pageView.frame = rect;
    } else {
        CGRect rect = _textLabelView.frame;
        rect.origin.x = 30 + Shirld_Distance;
        _textLabelView.frame = rect;
        rect = _table.frame;
        rect.origin.x = Shirld_Distance;
        _table.frame = rect;
        rect = _pageView.frame;
        rect.origin.x = 20 + Shirld_Distance;
        _pageView.frame = rect;
    }
    [UIView commitAnimations];
}

- (void)setViewFrame:(CGFloat)height
{
    if (!isShirlded) {
        _table.frame = CGRectMake(0, 0, height, 630);
        _pageView.frame = CGRectMake(20, _table.frame.origin.y + _table.frame.size.height + 20, 810, 40);
    } else {
        _table.frame = CGRectMake(Shirld_Distance, 0, height, 630);
        _pageView.frame = CGRectMake(20 + Shirld_Distance, _table.frame.origin.y + _table.frame.size.height + 20, 810, 40);
    }
}

- (void)strecthCurrentProjectView:(BOOL)isShow
{
    CGRect frame = _textLabelView.frame;
    [_textLabelView.stretchButton setImage:[UIImage imageNamed:(!isShow?@"search_plate_open.png":@"search_plate_close.png")] forState:UIControlStateNormal];
    frame.origin.y = (!isShow?-305:textLabelViewY_Pixel);

    NSTimeInterval animationDuration = 0.70f;
    
    [UIView beginAnimations:@"ResizeView" context:nil];
    [UIView setAnimationDuration:animationDuration];
    _textLabelView.frame = frame;
    [UIView commitAnimations];
}

- (void)clearDetailProjectView
{
    if (_table) {
        [_table removeFromSuperview];
        _table = nil;
    }
    if (_pageView) {
        [_pageView removeFromSuperview];
        _pageView = nil;
    }
}

- (void)reloadDetailProjectViewCellData:(int)pageindex
{
    ProjectBeanReq *req = [[ProjectBeanReq alloc] init];
    PageBean *pageReq = [[PageBean alloc] init];
    [pageReq setCurrentPage:[NSNumber numberWithInt:pageindex]];  //当前第几页
    [pageReq setItemOfPage:[NSNumber numberWithInt:itempageindex]];     //每页显示几个
    
    [req setCriteria:info];
    [req setPage:pageReq];
    
    self.reqID = [[HttpCaller getCaller] call:MODULE_ID_QUERY_PROJECT setObj:req];
}

- (void)showDetailProjectView:(NSString *)projectID ProjectName:(NSString *)projectName SenderName:(NSString *)senderName ReceiverName:(NSString *)receiverName CurrentPage:(NSString *)currentPage ItemPages:(NSString *)itemPages
{
    itempageindex = [itemPages intValue];
    if (info != nil) {
        info = nil;
    }
    info = [[ProjectQueryInfoBean alloc] init];
    
    info.prcode = projectID;
    info.prname = projectName;
    info.prfq = senderName;
    info.prfz = receiverName;
    
    [self reloadDetailProjectViewCellData:[currentPage intValue]];

    CGRect screenFrame = [[UIScreen mainScreen] bounds];
    
    if (_table == nil) {
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenFrame.size.height, 630) style:UITableViewStylePlain];
        _table.dataSource = self;
        _table.delegate = self;
        _table.backgroundColor = [UIColor clearColor];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:_table];
        [self insertSubview:_table belowSubview:_textLabelView];
    } else {
        [_table reloadData];
    }
    
    if (_pageView == nil) {
        _pageView = [[PageView alloc] init];
    }
    _pageView.backgroundColor = [UIColor whiteColor];
    _pageView.delegate = self;
    [self addSubview:_pageView];

    [self setViewFrame:screenFrame.size.height];
}

- (IBAction)doChoose:(UIButton *)sender {
    
}
@end

@implementation TextLabelView
@synthesize delegate = _delegate;
@synthesize stretchButton;

- (id)init
{
    if (self = [super init]) {
        [self titleLabelUI];
        isShow = YES;
        self.backgroundColor = [UIColor clearColor];
        
        stretchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [stretchButton addTarget:self action:@selector(stretchButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:stretchButton];
    }
    return self;
}

- (void)hidePopoverView
{
    [personalPopvier removeFromSuperview];
    [theDelegate->mainpageController removeFullBackgroundView];
}

- (void)buttonPressed:(UIButton *)sender
{
    switch (sender.tag) {
        case 0x10:
        case 0x11:
        {
            [theDelegate->mainpageController showFullBackgroundView];
            
            personalPopvier = [[PersonalSearchPopoverView alloc] initWithFrame:CGRectMake(300, 200, 600, 400)];
            personalPopvier.delegate = self;
            [theDelegate->mainpageController.view addSubview:personalPopvier];
        }
            break;
        case 0x12:
        {
//            if (calendarController == nil) {
//                calendarController = [[yundaCalendarController alloc] init];
//                calendarPopover = [[UIPopoverController alloc] initWithContentViewController:calendarController];
//                calendarPopover.delegate = self;
//            }
//            CGRect calendarRect = CGRectMake(330, 190, 10, 0);
//            calendarPopover.popoverContentSize = CGSizeMake(300, 330);
//            [calendarPopover presentPopoverFromRect:calendarRect
//                                             inView:self
//                           permittedArrowDirections:UIPopoverArrowDirectionUp
//                                           animated:YES];
            isShow = NO;
            [self.delegate showDetailProjectView:_textField[0].text ProjectName:_textField[1].text SenderName:_textField[2].text ReceiverName:_textField[3].text CurrentPage:@"0" ItemPages:_textField[4].text];
            [self.delegate strecthCurrentProjectView:isShow];
        }
            break;
        case 0x13:
        {
            [self.delegate clearDetailProjectView];
        }
            break;
        default:
            break;
    }
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGFloat x_pixel = 30;
    CGFloat y_pixel = 80;
    CGFloat intervalX = 400;
    CGFloat intervalY = 80;
    CGFloat width = 120;
    CGFloat height = 40;
    
    UIImageView *bgImageView = [[UIImageView alloc] init];
    [bgImageView setImage:[UIImage imageNamed:@"loginbackground.png"]];
    [self addSubview:bgImageView];
    [self sendSubviewToBack:bgImageView];
    bgImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - textViewBgHeight);
    
    UIImageView *headImageView = [[UIImageView alloc] init];
    [headImageView setImage:[UIImage imageNamed:@"module_select_cursor.png"]];
    [self addSubview:headImageView];
    [self sendSubviewToBack:bgImageView];
    headImageView.frame = CGRectMake(0, 0, self.frame.size.width, 40);
    
    UILabel *searchlabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0,100, 40)];
    searchlabel.textAlignment = NSTextAlignmentLeft;
    searchlabel.backgroundColor = [UIColor clearColor];
    searchlabel.text = @"项目查询";
    searchlabel.textColor = [UIColor whiteColor];
    [self addSubview:searchlabel];
    
    [stretchButton setImage:[UIImage imageNamed:(!isShow?@"search_plate_open.png":@"search_plate_close.png")] forState:UIControlStateNormal];
    stretchButton.frame = CGRectMake(250, self.frame.size.height - textViewBgHeight - 5, 300, textViewBgHeight);
    
    _label[0].frame = CGRectMake(x_pixel, y_pixel, width, height);
    _label[1].frame = CGRectMake(x_pixel + intervalX, y_pixel, width, height);
    _label[2].frame = CGRectMake(x_pixel, y_pixel + intervalY, width, height);
    _label[3].frame = CGRectMake(x_pixel + intervalX, y_pixel + intervalY, width, height);
    _label[4].frame = CGRectMake(300, y_pixel + intervalY*2, width, height);
//    _label[5].frame = CGRectMake(x_pixel + intervalX, y_pixel + intervalY*2, width, height);
//    _label[6].frame = CGRectMake(300, y_pixel + intervalY*3, width, height);
//    _label[7].frame = CGRectMake(x_pixel + intervalX, y_pixel + intervalY*3, width, height);
    
    width = 175;
    for (int i = 0; i < 4; i ++) {
        _textField[i].frame = CGRectMake(_label[i].frame.origin.x + _label[i].frame.size.width + 15, _label[i].frame.origin.y, width, height);
    }

    width = 30;
    height = 30;
    
    for (int i = 0; i < 2; i ++) {
        _button[i].frame = CGRectMake(_textField[i + 2].frame.origin.x + _textField[i + 2].frame.size.width + 15, _textField[i + 2].frame.origin.y, width, height);
    }
    
    width = 80;
    
    _textField[4].frame = CGRectMake(_label[4].frame.origin.x + _label[4].frame.size.width + 15, _label[4].frame.origin.y + 5, 40, height);
    _button[2].frame = CGRectMake(_textField[3].frame.origin.x + _textField[3].frame.size.width - 200, _textField[4].frame.origin.y, width, height);
    
    _button[3].frame = CGRectMake(_textField[3].frame.origin.x + _textField[3].frame.size.width - 50, _textField[4].frame.origin.y, width, height);
}

- (void)titleLabelUI
{
    NSArray *labelArray = [NSArray arrayWithObjects:@"项目编号",@"项目名称",@"项目发起人",@"项目负责人",
                           @"每页显示", nil];
    
    for (int i = 0; i < 5; i ++) {
        _label[i] = [[UILabel alloc] init];
        _label[i].textAlignment = NSTextAlignmentRight;
        _label[i].text = [labelArray objectAtIndex:i];
        _label[i].textColor = [UIColor blueColor];
        _label[i].backgroundColor = [UIColor clearColor];
        [self addSubview:_label[i]];
        
        _textField[i] = [[UITextField alloc] init];
        _textField[i].borderStyle = UITextBorderStyleBezel;
        _textField[i].backgroundColor = [UIColor whiteColor];
        _textField[i].contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _textField[i].tag = 0x01 + i;
        _textField[i].text = @"";
        _textField[i].delegate  = self;
        if (i != 4)
            _textField[i].clearButtonMode = UITextFieldViewModeAlways;
        
        [self addSubview:_textField[i]];
        
        if (i < 4) {
            _button[i] = [UIButton buttonWithType:UIButtonTypeCustom];
            _button[i].tag = 0x10 + i;
            [_button[i] addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_button[i]];
        }
    }
    _textField[4].text = @"10";
    _textField[4].keyboardType = UIKeyboardTypeNumberPad;
    
    [_button[0] setBackgroundImage:[UIImage imageNamed:@"group_staff.png"] forState:UIControlStateNormal];
    [_button[1] setBackgroundImage:[UIImage imageNamed:@"group_staff.png"] forState:UIControlStateNormal];
//    [_button[2] setBackgroundImage:[UIImage imageNamed:@"group_government.png"] forState:UIControlStateNormal];
//    [_button[3] setBackgroundImage:[UIImage imageNamed:@"group_government.png"] forState:UIControlStateNormal];
    [_button[2] setBackgroundImage:[UIImage imageBundleNamed:@"button_red.png"] forState:UIControlStateNormal];
    [_button[2] setTitle:@"查询" forState:UIControlStateNormal];
    [_button[3] setBackgroundImage:[UIImage imageBundleNamed:@"button_red.png"] forState:UIControlStateNormal];
    [_button[3] setTitle:@"清空" forState:UIControlStateNormal];
}

- (void)stretchButtonClicked:(UIButton *)sender
{
    isShow = !isShow;
    [self.delegate strecthCurrentProjectView:isShow];
}

@end

@implementation yundaSearchViewController

- (id)init
{
    if (self = [super init]) {
        myTableView.dataSource = self;
        myTableView.delegate = self;
        arrays = [[NSMutableArray alloc] init];
        [arrays addObject:@"全部"];
        [arrays addObject:@"未开始"];
        [arrays addObject:@"运行中"];
        [arrays addObject:@"暂停"];
        [arrays addObject:@"完成"];
        [arrays addObject:@"终止"];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//指定每个分区中有多少行，默认为1
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

//绘制Cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleTableIdentifier];
    }
    cell.textLabel.text = [arrays objectAtIndex:indexPath.row + 1];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end

@implementation yundaCalendarController

- (id)init
{
    if (self = [super init]) {
        calendar = [[CKCalendarView alloc] initWithStartDay:startSunday];
        calendar.frame = CGRectMake(0, 0, 300, 470);
        calendar.delegate = self;
        [self.view addSubview:calendar];
    }
    return self;
}

- (void)calendar:(CKCalendarView *)calendar didSelectDate:(NSDate *)date
{
    
}

@end

@implementation FullBackgroundView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.alpha = 0.5f;
        self.backgroundColor = [UIColor grayColor];
    }
    return self;
}

@end

