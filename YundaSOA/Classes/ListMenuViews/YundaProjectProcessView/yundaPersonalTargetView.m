//
//  yundaPersonalTargetView.m
//  YundaSOA
//
//  Created by sam on 13-6-9.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "yundaPersonalTargetView.h"
#import "yundaSelfTargetFinishedView.h"
#import "iCarousel.h"

#define ITEM_SPACING 200

@interface yundaPersonalTargetView()<UITextFieldDelegate,UIScrollViewDelegate,iCarouselDataSource,iCarouselDelegate>
{
    UIScrollView *personalScrollView;
    iCarousel *carousel;
    NSMutableArray *personalArray;
}

@property (nonatomic,strong) iCarousel *carousel;
@end

@implementation yundaPersonalTargetView
@synthesize carousel = _carousel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        personalArray = [[NSMutableArray alloc] initWithObjects:
                         @"协调板块",@"分拨中心",@"金融板块",@"总裁办", @"企业战略中心",
                         @"协调板块",@"分拨中心",@"金融板块",@"总裁办", @"企业战略中心",
                         @"协调板块",@"分拨中心",@"金融板块",@"总裁办", @"企业战略中心",
                         @"协调板块",@"分拨中心",@"金融板块",@"总裁办", @"企业战略中心",
                         nil];
        
        carousel = [[iCarousel alloc] initWithFrame:CGRectMake(400, 0, 100, 600)];
        carousel.delegate = self;
        carousel.dataSource = self;
//        carousel.backgroundColor = [UIColor purpleColor];
        [self addSubview:carousel];
        carousel.type = iCarouselTypeRotary;
        
        /*
        personalScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(20, 110, 300, 600)];
        personalScrollView.backgroundColor = [UIColor purpleColor];
        [personalScrollView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        personalScrollView.scrollEnabled = YES;
        personalScrollView.pagingEnabled = YES;
        personalScrollView.showsHorizontalScrollIndicator = YES;
        personalScrollView.showsVerticalScrollIndicator = YES;
        personalScrollView.delegate = self;
        personalScrollView.contentSize = CGSizeMake(1800, 1600);
        [self addSubview:personalScrollView];
        
        _personalTableView = [[PersonalTableView alloc] initWithFrame:CGRectMake(0, 0, 1800, 1600)];
        _personalTableView.backgroundColor = [UIColor whiteColor];
        [personalScrollView addSubview:_personalTableView];
        
        _baseHeadView = [[BaseHeadView alloc] initWithFrame:CGRectMake(0, 0, 900, 80) HeadTitle:@"事项结果闭环控制一表通(计划 开始-- 完成)"];
        _baseHeadView.backgroundColor = [UIColor grayColor];
        [self addSubview:_baseHeadView]; */
    }
    return self;
}

#pragma mark -

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return 20;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index
{
    _baseHeadView = [[BaseHeadView alloc] initWithFrame:CGRectMake(0, 0, 80, 380) HeadTitle:@"事项结果闭环控制一表通(计划 开始-- 完成)"];
    _personalCell = [[PersonalCell alloc] initWithFrame:CGRectMake(0, 0, 140, 380) CellIndexString:[personalArray objectAtIndex:index]];
    _personalCell.backgroundColor = [UIColor whiteColor];
    UIView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image1.jpg"]];//[NSString stringWithFormat:@"%d.jpg",index]]];
    
    view.frame = CGRectMake(70, 80, 180, 260);
    return _personalCell;
}

- (NSUInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel
{
	return 10;
}

- (NSUInteger)numberOfVisibleItemsInCarousel:(iCarousel *)carousel
{
    return 30;
}

- (CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    return ITEM_SPACING;
}

- (CATransform3D)carousel:(iCarousel *)_carousel transformForItemView:(UIView *)view withOffset:(CGFloat)offset
{
    view.alpha = 1.0 - fminf(fmaxf(offset, 0.0), 1.0);
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = self.carousel.perspective;
    transform = CATransform3DRotate(transform, M_PI / 8.0, 0, 1.0, 0);
    return CATransform3DTranslate(transform, 0.0, 0.0, offset * carousel.itemWidth);
}

- (BOOL)carouselShouldWrap:(iCarousel *)carousel
{
//    return wrap;
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

@end

@implementation PersonalTableView

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    //    [personalScrollView setContentOffset:CGPointMake(1000, 300) animated:YES];
    CGContextRef context = UIGraphicsGetCurrentContext();
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

@implementation PersonalCell

- (id)initWithFrame:(CGRect)frame CellIndexString:(NSString *)cellIndexString
{
    if (self = [super initWithFrame:frame]) {
        UIButton *baseButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [baseButton setBackgroundImage:[UIImage imageBundleNamed:@"button_red.png"] forState:UIControlStateNormal];
        CGRect baseButtonRect = frame;
//        [baseButton setTitle:cellIndexString forState:UIControlStateNormal];
        [baseButton setFrame:baseButtonRect];
        baseButton.tag = 0x10;
        [baseButton addTarget:self action:@selector(hideTableView:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:baseButton];
        
        UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)];
        titleLbl.backgroundColor = [UIColor colorWithRed:255 green:255 blue:0 alpha:0.5f];
        titleLbl.text = cellIndexString;
        [baseButton addSubview:titleLbl];
        
        subTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, self.frame.size.width, self.frame.size.height - 50)];
        subTable.delegate = self;
        subTable.dataSource = self;
        subTable.backgroundColor = [UIColor purpleColor];
        [baseButton addSubview:subTable];
    }
    return self;
}

- (void)hidePopoverView
{
    [personalPopvier removeFromSuperview];
    [theDelegate->mainpageController removeFullBackgroundView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifierCell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.textLabel.text = @"geogha";
    }
    return cell;
}

- (void)hideTableView:(UIButton *)sender
{
    [theDelegate->mainpageController showFullBackgroundView];
    
    personalPopvier = [[PersonalSearchPopoverView alloc] initWithFrame:CGRectMake(300, 200, 600, 400)];
    //设置代理的两种方式:1.在interface中添加<delegate>;2.在赋值时使用(id<delegate>) self;
    personalPopvier.delegate = (id<yundaDataDelegate>) self;
    personalPopvier.alpha = 1.0f;
    [theDelegate->mainpageController.view addSubview:personalPopvier];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    //    [personalScrollView setContentOffset:CGPointMake(1000, 300) animated:YES];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context,NO);
	CGContextSetStrokeColorWithColor(context,[UIColor blackColor].CGColor);
	CGContextMoveToPoint(context, 10,10);
	CGContextAddLineToPoint(context, 10,250);
    CGContextAddLineToPoint(context, 60,250);
    CGContextAddLineToPoint(context, 60,10);
    CGContextAddLineToPoint(context, 10,10);
	CGContextStrokePath(context);
    
    CGDrawLine(context, 10, 100, 60, 100, [UIColor blackColor]);
    CGDrawLine(context, 10, 300, 60, 300, [UIColor blackColor]);
}

@end