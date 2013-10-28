//
//  yundaDetailView.m
//  YundaSOA
//
//  Created by sam on 13-6-9.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "yundaDetailView.h"
#import "UIImage+embundle.h"
#import "yundaData.h"

@implementation yundaDetailView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self loadView];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closePress) name:@"HIDEPOP" object:nil];
    }
    return self;
}

- (void)loadView
{
    _secondView = [[UIView alloc] init];
    _secondView.autoresizesSubviews = YES;
    _secondView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _secondView.backgroundColor = [UIColor whiteColor];//RGB(204,219,226); //tornado.市场要闻弹出框的背景色
    [self addSubview:_secondView];
    
    _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero];
    _contentTableView.delegate = self;
    _contentTableView.dataSource = self;
    [_secondView addSubview:_contentTableView];

    [_contentTableView setAllowsSelection:NO]; //取消tableviewcell的蓝色选中效果 tornado.cell
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 1100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取消tableviewcell的蓝色选中效果 tornado.cell
//    UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
//    [newCell setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *gridCellIdentifier = @"gridcell_price";
	UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:gridCellIdentifier];
    
	if (nil == cell)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"gridcell_price"];
        cell.textLabel.textAlignment = UITextAutocapitalizationTypeSentences;
		cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.font      = [UIFont boldSystemFontOfSize:12];
        cell.detailTextLabel.textColor = cell.textLabel.textColor;
        cell.detailTextLabel.font      = cell.textLabel.font;
	}
    
	cell.indentationWidth = 10;
    if (indexPath.row == 0) {
        _cellView = [[CellView alloc] initWithFrame:CGRectMake(0, 0, 800, 1000)];
        _cellView.backgroundColor = [UIColor whiteColor];
        [cell addSubview:_cellView];
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"总部";
        cell.detailTextLabel.text = @"22";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"部门目标达成进度表";
        cell.detailTextLabel.text = @"22";
    } else if (indexPath.row == 3) {
        cell.textLabel.text = @"本人目标达成进度墙";
        cell.detailTextLabel.text = @"22";
    } else {
    	cell.textLabel.text = @"个人单个事项达成进度墙";
        cell.detailTextLabel.text = @"22";
    }
	
	return cell;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [super drawRect:rect];
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setBackgroundImage:[UIImage imageBundleNamed:@"redClose.png"] forState:UIControlStateNormal];
    CGRect rectBtn = CGRectMake(rect.origin.x + rect.size.width - 40, 5, 30, 30);
    [closeBtn setFrame:rectBtn];
    [closeBtn addTarget:self action:@selector(closePress) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
        
    _secondView.frame = CGRectMake(15, 45, self.frame.size.width - 30, self.frame.size.height - 70);
    _contentTableView.frame = CGRectMake(0, 10, _secondView.frame.size.width, _secondView.frame.size.height - 10);
    
    UIImage *image = [[UIImage imageBundleNamed:@"popBack.png"] stretchableImageWithLeftCapWidth:40 topCapHeight:50];
    [image drawInRect:rect];
}

- (void)closePress
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"HIDEPOP" object:nil];
    [self removeFromSuperview];
}

@end

@implementation CellView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIButton *releaseNoteBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
        [releaseNoteBtn addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:releaseNoteBtn];
        [releaseNoteBtn setFrame:CGRectMake(50, 40, 40, 40)];
        
        UILabel *label1 = [[UILabel alloc] init];
        label1.text = @"协调板块";
        label1.font = [UIFont systemFontOfSize:10];
        label1.frame = CGRectMake(50, 40, 100, 30);
        [self addSubview:label1];
    }
    return self;
}

- (void)add
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HIDEPOP" object:self];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGFillRect(context, CGRectMake(30, 40, 300, 200), [UIColor purpleColor]);
    CGContextSetAllowsAntialiasing(context,NO);
	CGContextSetStrokeColorWithColor(context,[UIColor blackColor].CGColor);
	CGContextMoveToPoint(context, 10,10);
	CGContextAddLineToPoint(context, 10,950);
    CGContextAddLineToPoint(context, 760,950);
    CGContextAddLineToPoint(context, 760,10);
    CGContextAddLineToPoint(context, 10,10);
	CGContextStrokePath(context);
    
    CGDrawLine(context, 10, 100, 760, 100, [UIColor blackColor]);
    CGDrawLine(context, 10, 300, 760, 300, [UIColor blackColor]);
}

@end

@implementation PersonalSearchPopoverView
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self loadView];
    }
    return self;
}

- (void)loadView
{
    _secondView = [[UIView alloc] init];
    _secondView.autoresizesSubviews = YES;
    _secondView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _secondView.backgroundColor = [UIColor whiteColor];//RGB(204,219,226); //tornado.弹出框的背景色
    [self addSubview:_secondView];
    
    UILabel *chooseLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 45, 100, 30)];
    chooseLabel.backgroundColor = [UIColor clearColor];
    chooseLabel.text = @"请选择人员";
    [self addSubview:chooseLabel];
    
    UILabel *choosedLabel = [[UILabel alloc] initWithFrame:CGRectMake(415, 45, 100, 30)];
    choosedLabel.backgroundColor = [UIColor clearColor];
    choosedLabel.text = @"选择的人员";
    [self addSubview:choosedLabel];
    
    UIButton *addSelectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addSelectedBtn setBackgroundImage:[UIImage imageBundleNamed:@"button_red.png"] forState:UIControlStateNormal];
    [addSelectedBtn setTitle:@"添加选择" forState:UIControlStateNormal];
    [addSelectedBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [addSelectedBtn setFrame:CGRectMake(220, 100, 100, 30)];
    addSelectedBtn.tag = 0x01;
    [self addSubview:addSelectedBtn];
    
    UIButton *delSelectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [delSelectedBtn setBackgroundImage:[UIImage imageBundleNamed:@"button_red.png"] forState:UIControlStateNormal];
    [delSelectedBtn setTitle:@"删除选择" forState:UIControlStateNormal];
    [delSelectedBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [delSelectedBtn setFrame:CGRectMake(220, 150, 100, 30)];
    delSelectedBtn.tag = 0x0;
    [self addSubview:delSelectedBtn];
    
    UIButton *delAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [delAllBtn setBackgroundImage:[UIImage imageBundleNamed:@"button_red.png"] forState:UIControlStateNormal];
    [delAllBtn setTitle:@"删除全部" forState:UIControlStateNormal];
    [delAllBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [delAllBtn setFrame:CGRectMake(220, 200, 100, 30)];
    delAllBtn.tag = 0x03;
    [self addSubview:delAllBtn];
    
    leftTableView = [[UITableView alloc] initWithFrame:CGRectZero];
    leftTableView.delegate = self;
    leftTableView.dataSource = self;
    leftTableView.tag = 0x10;
    [_secondView addSubview:leftTableView];
        
    rightTableView = [[UITableView alloc] initWithFrame:CGRectZero];
    rightTableView.delegate = self;
    rightTableView.dataSource = self;
    rightTableView.tag = 0x11;
    [_secondView addSubview:rightTableView];
}

- (void)buttonPressed:(UIButton *)sender
{
    if (sender.tag == 0x01) {
        
    } else if (sender.tag == 0x02) {
        
    } else {
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 1100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取消tableviewcell的蓝色选中效果 tornado.cell
    //    UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
    //    [newCell setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *gridCellIdentifier = @"gridcell_price";
	UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:gridCellIdentifier];
    
	if (nil == cell)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"gridcell_price"];
        cell.textLabel.textAlignment = UITextAutocapitalizationTypeSentences;
		cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.font      = [UIFont boldSystemFontOfSize:12];
        cell.detailTextLabel.textColor = cell.textLabel.textColor;
        cell.detailTextLabel.font      = cell.textLabel.font;
	}
    
	cell.indentationWidth = 10;
    proposerCell = [[ProposerCellView alloc] initWithFrame:CGRectMake(0, 0, 180, 1000)];
    proposerCell.backgroundColor = [UIColor yellowColor];
    [cell addSubview:proposerCell];
	
	return cell;
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [super drawRect:rect];
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setBackgroundImage:[UIImage imageBundleNamed:@"redClose.png"] forState:UIControlStateNormal];
    CGRect rectBtn = CGRectMake(rect.origin.x + rect.size.width - 40, 5, 30, 30);
    [closeBtn setFrame:rectBtn];
    [closeBtn addTarget:self action:@selector(closePress) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    
    _secondView.frame = CGRectMake(15, 45, self.frame.size.width - 30, self.frame.size.height - 70);
    leftTableView.frame = CGRectMake(0, 50, 200, _secondView.frame.size.height - 50);
    rightTableView.frame = CGRectMake(350, 50, 200, _secondView.frame.size.height - 50);
    
    UIImage *image = [[UIImage imageBundleNamed:@"popBack.png"] stretchableImageWithLeftCapWidth:40 topCapHeight:50];
    [image drawInRect:rect];
    
    UILabel *msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 100, 30)];
    msgLabel.backgroundColor = [UIColor clearColor];
    msgLabel.text = @"选择申请人";
    [self addSubview:msgLabel];
}

- (void)closePress
{
    [_delegate hidePopoverView];
}
@end

@implementation ProposerCellView

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    //    CGFillRect(context, CGRectMake(30, 40, 300, 200), [UIColor purpleColor]);
    CGContextSetAllowsAntialiasing(context,NO);
	CGContextSetStrokeColorWithColor(context,[UIColor blackColor].CGColor);
	CGContextMoveToPoint(context, 10,10);
	CGContextAddLineToPoint(context, 10,950);
    CGContextAddLineToPoint(context, 160,950);
    CGContextAddLineToPoint(context, 160,10);
    CGContextAddLineToPoint(context, 10,10);
	CGContextStrokePath(context);
    
    CGDrawLine(context, 10, 100, 160, 100, [UIColor blackColor]);
    CGDrawLine(context, 10, 300, 160, 300, [UIColor blackColor]);
}

@end