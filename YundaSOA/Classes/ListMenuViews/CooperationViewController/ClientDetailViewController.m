//
//  ClientDetailViewController.m
//  YundaSOA_IPHONE
//
//  Created by tyson on 13-10-12.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "ClientDetailViewController.h"
#import "MyColor.h"

@interface ClientDetailViewController ()

@end

@implementation ClientDetailViewController

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
    
    //针对屏幕进行适配
    CGRect rect = self.bgImg.frame;
    rect.size.height = self.view.bounds.size.height - self.headView.frame.size.height;
    self.bgImg.frame = rect;
    
    rect = self.detailView.frame;
    rect.size.height = self.view.bounds.size.height - self.headView.frame.size.height - self.detailSegment.frame.size.height - 10;
    self.detailView.frame = rect;
    
    if (currentView) {
        [currentView removeFromSuperview];
        currentView = nil;
    }
    
    NSArray * nibs = [[NSBundle mainBundle] loadNibNamed:@"ClientMsgView" owner:self options:nil];
    currentView = [nibs objectAtIndex:0];
    [self.detailView addSubview:currentView];
	
    //设置背景色
    self.view.backgroundColor = RGB(255, 255, 255);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setBgImg:nil];
    [self setBackBtn:nil];
    [self setDetailSegment:nil];
    [self setDetailView:nil];
    [self setHeadView:nil];
    [super viewDidUnload];
}

- (IBAction)doBack:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)segAction:(UISegmentedControl *)sender {
    
    if (currentView) {
        [currentView removeFromSuperview];
        currentView = nil;
    }
    
    if (sender.selectedSegmentIndex == 0) {
        NSArray * nibs = [[NSBundle mainBundle] loadNibNamed:@"ClientMsgView" owner:self options:nil];
        currentView = [nibs objectAtIndex:0];
        [self.detailView addSubview:currentView];
    } else if (sender.selectedSegmentIndex == 1) {
        NSArray * nibs = [[NSBundle mainBundle] loadNibNamed:@"DevelopProcessView" owner:self options:nil];
        UIView *tempView = [nibs objectAtIndex:0];
        UIScrollView *tempScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        tempScroll.bounces = NO;
        tempScroll.showsHorizontalScrollIndicator = NO;
        tempScroll.contentSize = CGSizeMake(320, 700);
        currentView = tempScroll;
        [currentView addSubview:tempView];
        [self.detailView addSubview:currentView];
    } else {
        NSArray * nibs = [[NSBundle mainBundle] loadNibNamed:@"BenchmarkView" owner:self options:nil];
        currentView = [nibs objectAtIndex:0];
        [self.detailView addSubview:currentView];
    }
}
@end
