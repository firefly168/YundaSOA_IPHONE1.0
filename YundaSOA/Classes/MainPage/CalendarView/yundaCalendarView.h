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
#import "CalendarInfoBean.h"
#import "UserBeanReq.h"
#import "CalendarBeanReq.h"

@protocol palaceCKCalendarDelegate;

@interface PalaceDateButton : UIButton

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) UILabel *label3;
@property (nonatomic, strong) UILabel *dateLabel;
@end

@interface TotleMessageButton : PalaceDateButton

@end

@interface yundaCalendarView : UIView

enum {
    palaceStartSunday = 1,
    palaceStartMonday = 2,
};
typedef int palaceStartDay;

@property (nonatomic, strong) NSDate *selectedDate;
@property (nonatomic, assign) id<palaceCKCalendarDelegate> delegate;
@property(nonatomic, strong) NSMutableArray *projectButtons;
@property (nonatomic,assign) int reqID;
@property (nonatomic,strong) CalendarInfoBean *currentYearData;
@property (nonatomic,strong) NSArray *currentMonthData;
@property (nonatomic, assign)   int currentYear;
@property (nonatomic, assign)   int currentMonth;

- (id)initWithStartDay:(palaceStartDay)firstDay;
- (id)initWithStartDay:(palaceStartDay)firstDay frame:(CGRect)frame;

// Theming
//- (void)setTitleFont:(UIFont *)font;
//- (UIFont *)titleFont;
//
//- (void)setTitleColor:(UIColor *)color;
//- (UIColor *)titleColor;

//- (void)setButtonColor:(UIColor *)color;

- (void)setInnerBorderColor:(UIColor *)color;

- (void)setDayOfWeekFont:(UIFont *)font;
- (UIFont *)dayOfWeekFont;

- (void)setDayOfWeekTextColor:(UIColor *)color;
- (UIColor *)dayOfWeekTextColor;

- (void)setDayOfWeekBottomColor:(UIColor *)bottomColor topColor:(UIColor *)topColor;

- (void)setDateFont:(UIFont *)font;
- (UIFont *)dateFont;

- (void)setDateTextColor:(UIColor *)color;
- (UIColor *)dateTextColor;

- (void)setDateBackgroundColor:(UIColor *)color;
- (UIColor *)dateBackgroundColor;

- (void)setDateBorderColor:(UIColor *)color;
- (UIColor *)dateBorderColor;

- (void)moveCalendarToSpecialYearandMonth:(int)month;

@property (nonatomic, strong) UIColor *selectedDateTextColor;
@property (nonatomic, strong) UIColor *selectedDateBackgroundColor;
@property (nonatomic, strong) UIColor *currentDateTextColor;
@property (nonatomic, strong) UIColor *currentDateBackgroundColor;

@end

@protocol palaceCKCalendarDelegate <NSObject>

- (void)calendar:(yundaCalendarView *)calendar didSelectDate:(NSDate *)date;

@end
