//
//  yundaCooperationViewController.h
//  YundaSOA_IPHONE
//
//  Created by tyson on 13-10-11.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CooperationDetailViewController.h"
#import "UIFolderTableView.h"
#import "SubCateViewController.h"
#import "BaseViewController.h"

@class SubCateViewController;
@class ProcessCurrentView;

@interface yundaCooperationViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIFolderTableViewDelegate>
{
    CooperationDetailViewController *cooperationDetail;
    SubCateViewController *subVc;
    ProcessCurrentView *processCurrentView;
    int count;
    BOOL is_strech;
}

@property (strong, nonatomic) IBOutlet UIFolderTableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
- (IBAction)doBack:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIImageView *bgImage;
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UIView *processView;

@end

@interface ProcessCurrentView : UIView
{
    NSArray *sliceRateArray;
}

@end