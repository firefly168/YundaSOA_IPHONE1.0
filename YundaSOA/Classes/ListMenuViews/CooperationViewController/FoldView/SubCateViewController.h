//
//  SubCateViewController.h
//  top100
//
//  Created by Dai Cloud on 12-7-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "yundaCooperationViewController.h"
#import "CooperationDetailViewController.h"
#import "CateSubCell.h"
#import "BaseViewController.h"

@class yundaCooperationViewController;

@interface SubCateViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *subTableView;
    CooperationDetailViewController *cooperationDetail;
}

@property (strong, nonatomic) NSArray *subCates;
@property (strong, nonatomic) yundaCooperationViewController *cateVC;

@end
