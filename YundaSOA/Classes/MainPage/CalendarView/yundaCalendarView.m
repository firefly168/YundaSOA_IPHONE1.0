//
// Copyright (c) 2012 Jason Kozemczak
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
// documentation files (the "Software"), to deal in the Software without restriction, including without limitation
// the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
// and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO
// THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
// ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
// OTHER DEALINGS IN THE SOFTWARE.
//


#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>
#import "yundaCalendarView.h"
#import "yundaData.h"
#import "HttpCaller.h"
#import "CommonUtil.h"
#import "MyColor.h"

#define PERMIT_DATEBUTTON_PRESS 0  //目前的版本屏蔽日历按钮点击事件
#define BUTTON_MARGIN 4
#define DAYS_HEADER_HEIGHT 22
#define DEFAULT_CELL_WIDTH 43
#define CELL_BORDER_WIDTH 1
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@class CALayer;
@class CAGradientLayer;

@interface palaceGradientView : UIView

@property(nonatomic, strong, readonly) CAGradientLayer *gradientLayer;
- (void)setColors:(NSArray *)colors;

@end

@implementation palaceGradientView

- (id)init {
    return [self initWithFrame:CGRectZero];
}

+ (Class)layerClass {
    return [CAGradientLayer class];
}

- (CAGradientLayer *)gradientLayer {
    return (CAGradientLayer *)self.layer;
}

- (void)setColors:(NSArray *)colors {
    NSMutableArray *cgColors = [NSMutableArray array];
    for (UIColor *color in colors) {
        [cgColors addObject:(__bridge id)color.CGColor];
    }
    self.gradientLayer.colors = cgColors;
}

@end

@implementation PalaceDateButton

@synthesize date = _date;
@synthesize label1,label2,label3,dateLabel;

- (void)setDate:(NSDate *)aDate {
    _date = aDate;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"d";

    if (dateLabel) {
        [dateLabel removeFromSuperview];
    }
    dateLabel = [[UILabel alloc] init];
    dateLabel.text = [dateFormatter stringFromDate:_date];
    [self addSubview:dateLabel];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [[UIColor rgbMYHB:0 DetailColor:0] setFill];
    CGContextMoveToPoint(context, 0, 0);
    CGRect aRect = CGRectMake(0, 0, self.frame.size.width, 30);
    CGContextAddRect(context, aRect);
    CGContextFillPath(context);
    
    CGDrawLine(context, 0, 30, self.frame.size.width, 30, [UIColor blackColor]);
}

@end

@implementation TotleMessageButton

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [[UIColor rgbMYHB:0 DetailColor:0] setFill];
    CGContextMoveToPoint(context, 0, 0);
    CGRect aRect = CGRectMake(0, 0, self.frame.size.width, 30);
    CGContextAddRect(context, aRect);
    CGContextFillPath(context);
    
    CGDrawLine(context, 0, 30, self.frame.size.width, 30, [UIColor blackColor]);
}

@end

@interface yundaCalendarView ()
{
    NSMutableArray *weekArray[6];  //一个月最多6周，所以用6足够了
}

@property(nonatomic, strong) UIView *highlight;
@property(nonatomic, strong) UIView *calendarContainer;
@property(nonatomic, strong) palaceGradientView *daysHeader;
@property(nonatomic, strong) NSArray *dayOfWeekLabels;
@property(nonatomic, strong) NSMutableArray *dateButtons;

@property (nonatomic) palaceStartDay calendarStartDay;
@property (nonatomic, strong) NSDate *monthShowing;
@property (nonatomic, strong) NSCalendar *calendar;
@property (nonatomic, assign) CGFloat cellWidth;
@property (nonatomic, strong) UILabel *allWeekLabel;

@end

@implementation yundaCalendarView

@synthesize reqID,currentYearData,currentMonthData;
@synthesize highlight = _highlight;
@synthesize calendarContainer = _calendarContainer;
@synthesize daysHeader = _daysHeader;
@synthesize dayOfWeekLabels = _dayOfWeekLabels;
@synthesize dateButtons = _dateButtons;
@synthesize projectButtons = _projectButtons;
@synthesize monthShowing = _monthShowing;
@synthesize calendar = _calendar;
@synthesize allWeekLabel = _allWeekLabel;
@synthesize selectedDate = _selectedDate;
@synthesize delegate = _delegate;

@synthesize selectedDateTextColor = _selectedDateTextColor;
@synthesize selectedDateBackgroundColor = _selectedDateBackgroundColor;
@synthesize currentDateTextColor = _currentDateTextColor;
@synthesize currentDateBackgroundColor = _currentDateBackgroundColor;
@synthesize cellWidth = _cellWidth;

@synthesize calendarStartDay;
@synthesize currentMonth = _currentMonth,currentYear = _currentYear;

- (id)init {
    return [self initWithStartDay:palaceStartSunday];
}

//开始显示的星期数：1为从星期天开始；2为从星期一开始
- (id)initWithStartDay:(palaceStartDay)firstDay {
    self.calendarStartDay = firstDay;
    return [self initWithFrame:CGRectMake(0, 0, 320, 320)];
}

- (id)initWithStartDay:(palaceStartDay)firstDay frame:(CGRect)frame {
    self.calendarStartDay = firstDay;
    return [self initWithFrame:frame];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        [self.calendar setLocale:[NSLocale currentLocale]];
        [self.calendar setFirstWeekday:self.calendarStartDay];
        self.cellWidth = DEFAULT_CELL_WIDTH;
        
        self.currentYear = -1;
        self.currentMonth = -1;
        
        UIView *highlight = [[UIView alloc] initWithFrame:CGRectZero];
        highlight.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
        highlight.layer.cornerRadius = 6.0f;
        [self addSubview:highlight];
        self.highlight = highlight;
        
        // THE CALENDAR ITSELF
        UIView *calendarContainer = [[UIView alloc] initWithFrame:CGRectZero];
//        calendarContainer.layer.borderWidth = 1.0f;
//        calendarContainer.layer.borderColor = [UIColor blackColor].CGColor;
//        calendarContainer.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
//        calendarContainer.layer.cornerRadius = 4.0f;
//        calendarContainer.clipsToBounds = YES;
        [self addSubview:calendarContainer];
        self.calendarContainer = calendarContainer;
        
        palaceGradientView *daysHeader = [[palaceGradientView alloc] initWithFrame:CGRectZero];
        daysHeader.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        [self.calendarContainer addSubview:daysHeader];
        self.daysHeader = daysHeader;
        
        NSMutableArray *labels = [NSMutableArray array];
        //最上方的周一－周日
        for (NSString *day in [self getDaysOfTheWeek]) {
            UILabel *dayOfWeekLabel = [[UILabel alloc] init];
            dayOfWeekLabel.text = [day uppercaseString];
            dayOfWeekLabel.textAlignment = NSTextAlignmentCenter;
            dayOfWeekLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"module_select_cursor.png"]];
//            dayOfWeekLabel.shadowColor = [UIColor whiteColor];
//            dayOfWeekLabel.shadowOffset = CGSizeMake(0, 1);
            [labels addObject:dayOfWeekLabel];
            [self.calendarContainer addSubview:dayOfWeekLabel];
        }
        self.dayOfWeekLabels = labels;
        
        // at most we'll need 42 buttons, so let's just bite the bullet and make them now...
        NSMutableArray *dateButtons = [NSMutableArray array];
        dateButtons = [NSMutableArray array];
        for (int i = 0; i < 43; i++) {
            PalaceDateButton *dateButton = [PalaceDateButton buttonWithType:UIButtonTypeCustom];
//            [dateButton setTitle:[NSString stringWithFormat:@"%d", i] forState:UIControlStateNormal];
            [dateButton addTarget:self action:@selector(dateButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [dateButtons addObject:dateButton];
        }
        self.dateButtons = dateButtons;
        
        _allWeekLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self addSubview:_allWeekLabel];
        
        //实现右边的进度cell
        NSMutableArray *projectButtons = [NSMutableArray array];
        for (int i = 0; i < 6; i ++) {
            TotleMessageButton *projectButton = [TotleMessageButton buttonWithType:UIButtonTypeCustom];
            [projectButton addTarget:self action:@selector(projectButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [projectButtons addObject:projectButton];
        }
        self.projectButtons = projectButtons;
        
        // initialize the thing
        self.monthShowing = [NSDate date];
        [self setDefaultStyle];
    }
    
//    [self layoutSubviews]; // TODO: this is a hack to get the first month to show properly
    return self;
}

- (void)layoutSubviews
{
    CGFloat containerWidth = 690;//self.bounds.size.width - (CALENDAR_MARGIN * 2);
    self.cellWidth = (containerWidth / 7.0) - CELL_BORDER_WIDTH;
    CGFloat containerHeight = (6 * (self.cellWidth + CELL_BORDER_WIDTH) + DAYS_HEADER_HEIGHT);
    //[self numberOfWeeksInMonthContainingDate:self.monthShowing]
    
    CGRect newFrame = self.frame;
    newFrame.size.height = containerHeight;
    newFrame.size.width = 800;
    self.frame = newFrame;
    
    self.highlight.frame = CGRectMake(1, 1, self.bounds.size.width - 2, 1);
    
    self.calendarContainer.frame = CGRectMake(0, 0, containerWidth, containerHeight);
    self.daysHeader.frame = CGRectMake(0, 0, self.calendarContainer.frame.size.width, DAYS_HEADER_HEIGHT);
    
    CGRect lastDayFrame = CGRectZero;
    for (UILabel *dayLabel in self.dayOfWeekLabels) {
        //sunday/monday/tuesday
        dayLabel.frame = CGRectMake(CGRectGetMaxX(lastDayFrame) + CELL_BORDER_WIDTH, lastDayFrame.origin.y, self.cellWidth, self.daysHeader.frame.size.height);
        lastDayFrame = dayLabel.frame;
    }
    
    _allWeekLabel.text = @"一周合计";
    _allWeekLabel.textColor = [UIColor redColor];
    _allWeekLabel.textAlignment = NSTextAlignmentCenter;
    _allWeekLabel.frame = CGRectMake(697, 0, self.cellWidth, self.daysHeader.frame.size.height);
    
    [self addDayButton];
    [self addTotleButton];
}

//添加每天任务的按钮视图 monthShowing 当前天所在的时间 e.g. 2013-10-17 02:55:02 +0000
- (void)addDayButton
{
    for (PalaceDateButton *dateButton in self.dateButtons) {
        [dateButton removeFromSuperview];
    }
    
    int monthcount = [self.currentMonthData count];
    NSLog(@"yeardata = %@,monthdata = %@,monthcount = %d",self.currentYearData,self.currentMonthData,monthcount);
    
    NSDate *date = [self firstDayOfMonthContainingDate:self.monthShowing];
    //如果当月的第一天是在周日，则从第二行开始展示当月的内容，否则都从第一行开始放置
    date = [self resetFirstDayOnCalendar];
    
    uint dateButtonPosition = 0;
    int calendarNum = 0;
    
    while (dateButtonPosition < 42) {
        PalaceDateButton *dateButton = [self.dateButtons objectAtIndex:dateButtonPosition];
        dateButton.date = date;

        if ([dateButton.date isEqualToDate:self.selectedDate]) {
            //选中的颜色
            dateButton.backgroundColor = self.selectedDateBackgroundColor;
            [dateButton setTitleColor:self.selectedDateTextColor forState:UIControlStateNormal];
        } else if ([self dateIsToday:dateButton.date]) {
            //判断是否是今天
            [dateButton setTitleColor:self.currentDateTextColor forState:UIControlStateNormal];
            dateButton.backgroundColor = [UIColor yellowColor];//self.currentDateBackgroundColor;
        } else {
            dateButton.backgroundColor = [self dateBackgroundColor];
            [dateButton setTitleColor:[self dateTextColor] forState:UIControlStateNormal];
        }
        
        if ([self dayOfWeekForDate:dateButton.date] == 1 || [self dayOfWeekForDate:dateButton.date] == 7) {
            //判断是星期天或者是星期六，用红色显示字体颜色
            dateButton.dateLabel.textColor = [UIColor redColor];
        } else {
            dateButton.dateLabel.textColor = [UIColor whiteColor];
        }

        CGRect rect = CGRectMake(dateButtonPosition%7 * (self.cellWidth + CELL_BORDER_WIDTH) + CELL_BORDER_WIDTH, (dateButtonPosition/7 * (self.cellWidth + CELL_BORDER_WIDTH)) + CGRectGetMaxY(self.daysHeader.frame) + CELL_BORDER_WIDTH, self.cellWidth, self.cellWidth);
        dateButton.frame = rect;//[self calculateDayCellFrame:date];
        
        [self.calendarContainer addSubview:dateButton];
        
        if (dateButton.label1) {
            [dateButton.label1 removeFromSuperview];
        }
        if (dateButton.label2) {
            [dateButton.label2 removeFromSuperview];
        }
        
        dateButton.label1 = [[UILabel alloc] init];
        dateButton.label1.text = @"应:0已:0未:0";
        dateButton.label1.font = [UIFont systemFontOfSize:12];
        [dateButton addSubview:dateButton.label1];
        
        dateButton.label2 = [[UILabel alloc] init];
        dateButton.label2.text = @"完成率0%";
        dateButton.label2.font = [UIFont systemFontOfSize:12];
        [dateButton addSubview:dateButton.label2];
        
        if (![self dateIsInMonthShowing:date]) {
            dateButton.label1.textColor = [UIColor grayColor];
            dateButton.label2.textColor = [UIColor grayColor];
        } else {
            dateButton.label1.textColor = [UIColor blackColor];
            dateButton.label2.textColor = [UIColor blackColor];
        }
        //下一天的数据
        date = [self nextDay:date];
        
        //设置一个算法，依次从服务器接收的json数据中截取有完成率相关的信息
        NSDateFormatter *dayDateFormatter = [[NSDateFormatter alloc] init];
        dayDateFormatter.dateFormat = @"YYYY-MM-dd";
        NSString *dayStr = [dayDateFormatter stringFromDate:date];
        calendarNum = 0;
        while (calendarNum < monthcount) {
            CalendarInfoBean *calendarInfoBean = (CalendarInfoBean *)[self.currentMonthData objectAtIndex:calendarNum];
            calendarNum ++ ;
            long long time = calendarInfoBean.time;
            NSDate *currentday = [NSDate dateWithTimeIntervalSince1970:time/1000];
            NSDateFormatter *dayDateFormatter1 = [[NSDateFormatter alloc] init];
            dayDateFormatter1.dateFormat = @"YYYY-MM-dd";
            NSString *dayStr1 = [dayDateFormatter1 stringFromDate:currentday];
            
            //注意：NSDate和NSDateComponents拿到的天数会差一天，获取单独的年月日用NSDateComponents方法
            NSCalendar *ca = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
            NSDateComponents *comp = [ca components:NSSecondCalendarUnit|NSMinuteCalendarUnit|NSHourCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSYearCalendarUnit fromDate:currentday];
            dayStr1 = [NSString stringWithFormat:@"%d-%02d-%02d",comp.year,comp.month,comp.day + 1];
            
            if ([dayStr isEqualToString:dayStr1]) {
                dateButton.label1.text = [NSString stringWithFormat:@"应:%d已:%d未:%d",
                                          (calendarInfoBean.rcTotal + calendarInfoBean.zltotal),
                                          (calendarInfoBean.rcDealed + calendarInfoBean.zldealed),
                                          (calendarInfoBean.rcUndeal + calendarInfoBean.zlundeal)];
                if ((calendarInfoBean.rcTotal + calendarInfoBean.zltotal) > 0) {
                    dateButton.label2.text = [NSString stringWithFormat:@"完成率%.1f%%",
                                              (calendarInfoBean.rcDealed + calendarInfoBean.zldealed)/(calendarInfoBean.rcTotal + calendarInfoBean.zltotal + .0)];
                }
                break;
            }
            
        }
        
        dateButton.dateLabel.frame = CGRectMake(dateButton.frame.size.width/2 - 15, 0, 30, 30);  //在cell上写文字
        dateButton.dateLabel.backgroundColor = [UIColor clearColor];
        dateButton.dateLabel.textAlignment = NSTextAlignmentCenter;
        dateButton.label1.frame = CGRectMake(0, 40, dateButton.frame.size.width, 20);
        dateButton.label1.backgroundColor = [UIColor clearColor];
        dateButton.label1.textAlignment = NSTextAlignmentCenter;
        dateButton.label2.frame = CGRectMake(0, 60, dateButton.frame.size.width, 20);
        dateButton.label2.backgroundColor = [UIColor clearColor];
        dateButton.label2.textAlignment = NSTextAlignmentCenter;
        
        dateButtonPosition++;
    }
}

//每周统计的按钮视图
- (void)addTotleButton
{
    NSDate *date = [self firstDayOfMonthContainingDate:self.monthShowing];

    for (TotleMessageButton *dateButton in self.projectButtons) {
        [dateButton removeFromSuperview];
    }
    
    //做判空处理，防止出现找不到对象的错误
    if ([self.currentMonthData count] > 0) {
        CalendarInfoBean *calendarInfoBean = (CalendarInfoBean *)[self.currentMonthData objectAtIndex:0];
        NSDate *currentDayDate = [NSDate dateWithTimeIntervalSince1970:calendarInfoBean.time/1000];
        int weekNum = [self numberOfWeeksInMonthContainingDate:currentDayDate];  //当天所在的月份的总周数
        for (int m = 0; m < weekNum; m ++) {
            weekArray[m] = [[NSMutableArray alloc] init];
        }
        
        //将所有有数据的天数都统计出来
        for (int i = 0; i < [self.currentMonthData count];i ++) {
            CalendarInfoBean *calendarInfoBean = (CalendarInfoBean *)[self.currentMonthData objectAtIndex:i];
            NSDate *currentDayDate = [NSDate dateWithTimeIntervalSince1970:calendarInfoBean.time/1000];
            int dayperweek = [self weekNumberInMonthForDate:currentDayDate];  //当天在第几周
            for (int j = 1; j <= weekNum; j ++) {
                if (j == dayperweek) {
                    [weekArray[dayperweek - 1] addObject:calendarInfoBean];
                    break;
                }
            }
        }
    }
    
    for (int i = 0; i < 6; i ++) {
        TotleMessageButton *projectButton = [self.projectButtons objectAtIndex:i];
        
        projectButton.date = date;
        projectButton.backgroundColor = [self dateBackgroundColor];
        [projectButton setTitleColor:[self dateTextColor] forState:UIControlStateNormal];
        
        if (projectButton.label1) {
            [projectButton.label1 removeFromSuperview];
        }
        if (projectButton.label2) {
            [projectButton.label2 removeFromSuperview];
        }
        
        int shouldSum = 0;
        int doneSum = 0;
        int unSum = 0;
        
        //上个月最后一天
        NSDate *lastDayPreviousMonth = [[self firstDayOfMonthContainingDate:date] dateByAddingTimeInterval:-1];
        int weekday = [self dayOfWeekForDate:lastDayPreviousMonth];
        
        //判断当前月份是否有任务数据
        if ([self.currentMonthData count] > 0) {
            //判断当月第一天所在周是否有7天，有则从第二行开始查找任务数据，否则从第一行
            if (weekday == 7) {
                if (i == 0) {
                    shouldSum = 0;
                    doneSum = 0;
                    unSum = 0;
                } else {
                    for (int j = 0; j < [weekArray[i-1] count]; j ++) {
                        CalendarInfoBean *calendarInfoBean = [weekArray[i] objectAtIndex:j];
                        shouldSum += (calendarInfoBean.rcTotal + calendarInfoBean.zltotal);
                        doneSum += (calendarInfoBean.rcDealed + calendarInfoBean.zldealed);
                        unSum += (calendarInfoBean.rcUndeal + calendarInfoBean.zlundeal);
                    }
                }
            } else {
                for (int j = 0; j < [weekArray[i] count]; j ++) {
                    CalendarInfoBean *calendarInfoBean = [weekArray[i] objectAtIndex:j];
                    shouldSum += (calendarInfoBean.rcTotal + calendarInfoBean.zltotal);
                    doneSum += (calendarInfoBean.rcDealed + calendarInfoBean.zldealed);
                    unSum += (calendarInfoBean.rcUndeal + calendarInfoBean.zlundeal);
                }
            }
        }

        projectButton.label1 = [[UILabel alloc] init];
        projectButton.label1.text = [NSString stringWithFormat:@"应:%d已:%d未:%d",shouldSum,doneSum,unSum];
        projectButton.label1.font = [UIFont systemFontOfSize:12];
        [projectButton addSubview:projectButton.label1];
        
        projectButton.label2 = [[UILabel alloc] init];
        projectButton.label2.text = (shouldSum == 0)?@"完成率0%":[NSString stringWithFormat:@"完成率%.2f%%",doneSum/(shouldSum + .0)];
        projectButton.label2.font = [UIFont systemFontOfSize:12];
        [projectButton addSubview:projectButton.label2];
        
        projectButton.label1.frame = CGRectMake(0, 40, projectButton.frame.size.width, 20);
        projectButton.label1.backgroundColor = [UIColor clearColor];
        projectButton.label1.textAlignment = NSTextAlignmentCenter;
        
        projectButton.label2.frame = CGRectMake(0, 60, projectButton.frame.size.width, 20);
        projectButton.label2.backgroundColor = [UIColor clearColor];
        projectButton.label2.textAlignment = NSTextAlignmentCenter;

        //若第一行没有当月数据，则显示为灰色，否则显示为黑色
        if (i == 0 && weekday == 7)
        {
            projectButton.label1.textColor = [UIColor grayColor];
            projectButton.label2.textColor = [UIColor grayColor];
        } else {
            projectButton.label1.textColor = [UIColor blackColor];
            projectButton.label2.textColor = [UIColor blackColor];
        }
        
        projectButton.frame = CGRectMake(697, (i * (self.cellWidth + CELL_BORDER_WIDTH)) + CGRectGetMaxY(self.daysHeader.frame) + CELL_BORDER_WIDTH, self.cellWidth, self.cellWidth);
        [self addSubview:projectButton];
    }
}

- (void)setMonthShowing:(NSDate *)aMonthShowing {
    _monthShowing = aMonthShowing;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MMMM YYYY";
//    self.titleLabel.text = [dateFormatter stringFromDate:aMonthShowing];
    
    NSDateFormatter *yeardateFormatter = [[NSDateFormatter alloc] init];
    yeardateFormatter.dateFormat = @"YYYY";
    NSDateFormatter *mouthdateFormatter = [[NSDateFormatter alloc] init];
    mouthdateFormatter.dateFormat = @"MM";
    NSString *yearStr = [yeardateFormatter stringFromDate:aMonthShowing];
    NSString *mouthStr = [mouthdateFormatter stringFromDate:aMonthShowing];
    NSCharacterSet* nonDigits =[[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    int year = [[yearStr stringByTrimmingCharactersInSet:nonDigits] intValue];
    int month = [[mouthStr stringByTrimmingCharactersInSet:nonDigits] intValue];
    
    if (self.currentYear < 0) {
        self.currentYear = year;
    }
    
    if (self.currentMonth < 0) {
        self.currentMonth = month;
    }
    
    yearStr = [NSString stringWithFormat:@"%d",year];
    mouthStr = [NSString stringWithFormat:@"%d",month];
    [self collectCalendarDateMessage:yearStr Mouth:mouthStr];
    
    [self setNeedsLayout];
}

//获取日历当前时间相关信息
- (void)collectCalendarDateMessage:(NSString *)year Mouth:(NSString *)mouth
{
    CalendarBeanReq *req = [[CalendarBeanReq alloc] init];
    
    [req setYear:year]; 
    [req setMonth:mouth]; 
    
    self.reqID = [[HttpCaller getCaller] call:MODULE_ID_CALENDAR setObj:req];
}

//选中的年和月的内容
- (void)moveCalendarToSpecialYearandMonth:(int)month
{
    NSDateComponents* comps = [[NSDateComponents alloc]init];
    [comps setMonth:month];
    self.monthShowing = [self.calendar dateByAddingComponents:comps toDate:self.monthShowing options:0];
}

//某日的按钮被点击之后
- (void)dateButtonPressed:(id)sender {
#if PERMIT_DATEBUTTON_PRESS
    PalaceDateButton *dateButton = sender;
    self.selectedDate = dateButton.date;
    [self.delegate calendar:self didSelectDate:self.selectedDate];
    [self setNeedsLayout];
#endif
}

//右边的项目按钮被点击后
- (void)projectButtonPressed:(id)sender
{
    
}

- (void)setDefaultStyle {
    self.backgroundColor = UIColorFromRGB(0x393B40);
    
    [self setDayOfWeekFont:[UIFont boldSystemFontOfSize:12.0]];
    [self setDayOfWeekTextColor:[UIColor blackColor]];
    [self setDayOfWeekBottomColor:UIColorFromRGB(0xCCCFD5) topColor:[UIColor whiteColor]];
    
    [self setDateFont:[UIFont boldSystemFontOfSize:16.0f]];
    [self setDateTextColor:UIColorFromRGB(0x393B40)];
    [self setDateBackgroundColor:UIColorFromRGB(0xF2F2F2)];
    [self setDateBorderColor:UIColorFromRGB(0xDAE1E6)];
    
    [self setSelectedDateTextColor:UIColorFromRGB(0xF2F2F2)];
    [self setSelectedDateBackgroundColor:UIColorFromRGB(0x88B6DB)];
    
    [self setCurrentDateTextColor:UIColorFromRGB(0xF2F2F2)];
    [self setCurrentDateBackgroundColor:[UIColor lightGrayColor]];
}

//每天内容的坐标位置
- (CGRect)calculateDayCellFrame:(NSDate *)date {
    int row = [self weekNumberInMonthForDate:date] - 1;
    int placeInWeek = (([self dayOfWeekForDate:date] - 1) - self.calendar.firstWeekday + 8) % 7;
    
    return CGRectMake(placeInWeek * (self.cellWidth + CELL_BORDER_WIDTH), (row * (self.cellWidth + CELL_BORDER_WIDTH)) + CGRectGetMaxY(self.daysHeader.frame) + CELL_BORDER_WIDTH, self.cellWidth, self.cellWidth);
}

- (void)setInnerBorderColor:(UIColor *)color {
    self.calendarContainer.layer.borderColor = color.CGColor;
}

- (void)setDayOfWeekFont:(UIFont *)font {
    for (UILabel *label in self.dayOfWeekLabels) {
        label.font = font;
    }
}
- (UIFont *)dayOfWeekFont {
    return (self.dayOfWeekLabels.count > 0) ? ((UILabel *)[self.dayOfWeekLabels lastObject]).font : nil;
}

- (void)setDayOfWeekTextColor:(UIColor *)color {
    for (UILabel *label in self.dayOfWeekLabels) {
        label.textColor = color;
    }
}

- (UIColor *)dayOfWeekTextColor {
    return (self.dayOfWeekLabels.count > 0) ? ((UILabel *)[self.dayOfWeekLabels lastObject]).textColor : nil;
}

- (void)setDayOfWeekBottomColor:(UIColor *)bottomColor topColor:(UIColor *)topColor {
    [self.daysHeader setColors:[NSArray arrayWithObjects:topColor, bottomColor, nil]];
}

- (void)setDateFont:(UIFont *)font {
    for (PalaceDateButton *dateButton in self.dateButtons) {
        dateButton.titleLabel.font = font;
    }
}
- (UIFont *)dateFont {
    return (self.dateButtons.count > 0) ? ((PalaceDateButton *)[self.dateButtons lastObject]).titleLabel.font : nil;
}

- (void)setDateTextColor:(UIColor *)color {
    for (PalaceDateButton *dateButton in self.dateButtons) {
        [dateButton setTitleColor:color forState:UIControlStateNormal];
    }
}

- (UIColor *)dateTextColor {
    return (self.dateButtons.count > 0) ? [((PalaceDateButton *)[self.dateButtons lastObject]) titleColorForState:UIControlStateNormal] : nil;
}

- (void)setDateBackgroundColor:(UIColor *)color {
    for (PalaceDateButton *dateButton in self.dateButtons) {
        dateButton.backgroundColor = color;
    }
}
- (UIColor *)dateBackgroundColor {
    return (self.dateButtons.count > 0) ? ((PalaceDateButton *)[self.dateButtons lastObject]).backgroundColor : nil;
}

- (void)setDateBorderColor:(UIColor *)color {
    self.calendarContainer.backgroundColor = color;
}
- (UIColor *)dateBorderColor {
    return self.calendarContainer.backgroundColor;
}

#pragma mark - Calendar helpers

//当前天所在月份的第一天：e.g. 2013-10-01 00:00:00 CST
- (NSDate *)firstDayOfMonthContainingDate:(NSDate *)date {
    NSDateComponents *comps = [self.calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:date];
    [comps setDay:1];
    return [self.calendar dateFromComponents:comps];
}

//获取一周的标题信息(Sun,Mon,Tue,Wed,Thu,Fri,Sat)
- (NSArray *)getDaysOfTheWeek {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    // adjust array depending on which weekday should be first
    NSArray *weekdays = [dateFormatter shortWeekdaySymbols];
    NSUInteger firstWeekdayIndex = [self.calendar firstWeekday] -1;
    if (firstWeekdayIndex > 0)
    {
        weekdays = [[weekdays subarrayWithRange:NSMakeRange(firstWeekdayIndex, 7-firstWeekdayIndex)]
                    arrayByAddingObjectsFromArray:[weekdays subarrayWithRange:NSMakeRange(0,firstWeekdayIndex)]];
    }
    return weekdays;
}

//重新布局日历上要显示的第一天的内容
- (NSDate *)resetFirstDayOnCalendar {
    
    NSTimeInterval secondperday = 24*60*60;
    //当月第一天
    NSDate *firstDateCurrentMonth = [self firstDayOfMonthContainingDate:self.monthShowing];
    //上个月最后一天
    NSDate *firstShowDate = [firstDateCurrentMonth dateByAddingTimeInterval:-1];

    //如果上个月第一天所在周有7天，则第一行都显示上个月最后一周的内容，从第二行开始展示当月的内容，否则都从第一行开始放置
    int weekday = [self dayOfWeekForDate:firstShowDate];
    firstShowDate = [firstShowDate dateByAddingTimeInterval:-(secondperday * (weekday - 1))];

    return firstShowDate;
}

//获取当天所在月的下个月的内容
- (NSDate *)getNextMonthDateOfMonthShowing {
    NSDateComponents *comps = [self.calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.monthShowing];
    [comps setMonth:1];
    return [self.calendar dateFromComponents:comps];
}

//下个月的内容
- (void)moveCalendarToNextMonth {
    NSDateComponents* comps = [[NSDateComponents alloc]init];
    [comps setMonth:1];
    self.monthShowing = [self.calendar dateByAddingComponents:comps toDate:self.monthShowing options:0];
}

//上个月的内容
- (void)moveCalendarToPreviousMonth {
    self.monthShowing = [[self firstDayOfMonthContainingDate:self.monthShowing] dateByAddingTimeInterval:-100000];
}

//下一年的内容
- (void)moveCalendarToNextYear {
    NSDateComponents* comps = [[NSDateComponents alloc]init];
    [comps setYear:1];
    self.monthShowing = [self.calendar dateByAddingComponents:comps toDate:self.monthShowing options:0];
}

//上一年的内容
- (void)moveCalendarToPreviousYear {
    NSDateComponents* comps = [[NSDateComponents alloc]init];
    [comps setYear:-1];
    self.monthShowing = [self.calendar dateByAddingComponents:comps toDate:self.monthShowing options:0];
}

//当天在该周的第几天
- (int)dayOfWeekForDate:(NSDate *)date {
    NSDateComponents *comps = [self.calendar components:NSWeekdayCalendarUnit fromDate:date];
    return comps.weekday;
}

//判断是否是今天
- (BOOL)dateIsToday:(NSDate *)date {
    NSDateComponents *otherDay = [self.calendar components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
    NSDateComponents *today = [self.calendar components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:[NSDate date]];
    return ([today day] == [otherDay day] &&
            [today month] == [otherDay month] &&
            [today year] == [otherDay year] &&
            [today era] == [otherDay era]);
}

//指定的某天在第几周
- (int)weekNumberInMonthForDate:(NSDate *)date {
    NSDateComponents *comps = [self.calendar components:(NSWeekOfMonthCalendarUnit) fromDate:date];
    return comps.weekOfMonth;
}

//指定的某天所在的月份的总周数
- (int)numberOfWeeksInMonthContainingDate:(NSDate *)date {
    return [self.calendar rangeOfUnit:NSWeekCalendarUnit inUnit:NSMonthCalendarUnit forDate:date].length;
}

//指定的某天和当天是否在同一个月
- (BOOL)dateIsInMonthShowing:(NSDate *)date {
    NSDateComponents *comps1 = [self.calendar components:(NSMonthCalendarUnit) fromDate:self.monthShowing];
    NSDateComponents *comps2 = [self.calendar components:(NSMonthCalendarUnit) fromDate:date];
    return comps1.month == comps2.month;
}

- (NSDate *)nextDay:(NSDate *)date {
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:1];
    return [self.calendar dateByAddingComponents:comps toDate:date options:0];
}

+ (UIImage *)imageNamed:(NSString *)name withColor:(UIColor *)color {
    UIImage *img = [UIImage imageNamed:name];
    
    UIGraphicsBeginImageContext(img.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [color setFill];
    
    CGContextTranslateCTM(context, 0, img.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextSetBlendMode(context, kCGBlendModeColorBurn);
    CGRect rect = CGRectMake(0, 0, img.size.width, img.size.height);
    CGContextDrawImage(context, rect, img.CGImage);
    
    CGContextClipToMask(context, rect, img.CGImage);
    CGContextAddRect(context, rect);
    CGContextDrawPath(context,kCGPathFill);
    
    UIImage *coloredImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return coloredImg;
}

@end
