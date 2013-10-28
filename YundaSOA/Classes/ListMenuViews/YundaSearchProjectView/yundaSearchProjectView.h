//
//  yundaSearchProjectView.h
//  YundaSOA
//
//  Created by sam on 13-6-9.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+embundle.h"
//#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>
#import "CKCalendarView.h"
#import "yundaDetailView.h"
#import "ProjectBeanRes.h"
#import "ProjectBeanReq.h"
#import "CommonUtil.h"
#import "PageBean.h"
#import "ProjectQueryInfoBean.h"
#import "ProjectInfoBean.h"
#import "PageView.h"
#import "UIProgressBar.h"

@protocol DetailProjectDelegate <NSObject>
@optional
- (void)showDetailProjectView:(NSString *)projectID ProjectName:(NSString *)projectName SenderName:(NSString *)senderName ReceiverName:(NSString *)receiverName CurrentPage:(NSString *)currentPage ItemPages:(NSString *)itemPages;
- (void)strecthCurrentProjectView:(BOOL)isShow;
- (void)clearDetailProjectView;
@end

@class CALayer,yundaCalendarController,FullBackgroundView,yundaSearchViewController,TextLabelView,PageView;
@interface yundaSearchProjectView : UIView<UITextFieldDelegate,DetailProjectDelegate,UITableViewDataSource,UITableViewDelegate,PageViewDelegate>
{
    BOOL tableAnimated;
    BOOL isShirlded;
    UIView *headView;
    TextLabelView *_textLabelView;
    NSString         *_picUrlString;
    UIImageView      *_imageView;
    ProjectQueryInfoBean *info;
    int itempageindex;
    NSMutableArray     *mColorArray;
}

@property (nonatomic, retain) NSString         *_picUrlString;
@property (nonatomic, retain) UIImageView      *_imageView;
@property (nonatomic,strong)  ProjectBeanRes *currentProjectRes;
@property (strong, nonatomic) IBOutlet UIImageView *bgImage;
@property (nonatomic,strong)  NSTimer *_activeTimer;
@property (nonatomic,assign)  int reqID;
@property (nonatomic,strong)  UITableView *table;
@property (nonatomic,strong)  PageView *_pageView;
- (IBAction)doChoose:(UIButton *)sender;

//请求图片资源
//-(void)imageResourceRequest;
//
////显示图片信息
//-(void)displayImage:(UIImage *)image;
//
//
//- (IBAction)dismissModealView:(id)sender;
//-(void)removeModalView;

- (void)transformSubview:(BOOL)isShirld;
@end

@interface TextLabelView : UIView<yundaDataDelegate,UITextFieldDelegate,UIPopoverControllerDelegate>
{
    yundaCalendarController *calendarController;
    PersonalSearchPopoverView *personalPopvier;
    FullBackgroundView *fullBackgroundView;

    UIPopoverController *popover;
    UIPopoverController *calendarPopover;
    yundaSearchViewController *popoverContent;
    UILabel *_label[6];
    UITextField *_textField[6];
    UIButton *_button[6];
    UIButton *stretchButton;
    id<DetailProjectDelegate> delegate;
    
    BOOL isShow;   //查询视图是否收到上面
}

@property (nonatomic,strong)     UIButton *stretchButton;
@property (nonatomic,assign) id<DetailProjectDelegate> delegate;

@end
@interface yundaSearchViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *myTableView;
    NSMutableArray *arrays;
}

@end

@interface yundaCalendarController : UIViewController<CKCalendarDelegate>
{
    CKCalendarView *calendar;
}

@end

@interface FullBackgroundView : UIView

@end
