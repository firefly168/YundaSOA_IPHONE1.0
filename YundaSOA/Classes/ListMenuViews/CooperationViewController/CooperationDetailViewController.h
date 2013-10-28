//
//  CooperationDetailViewController.h
//  YundaSOA_IPHONE
//
//  Created by tyson on 13-10-11.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClientDetailViewController.h"
#import "BaseViewController.h"

@interface CooperationDetailViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
{
    ClientDetailViewController *clientDetail;
}

@property (weak, nonatomic) IBOutlet UIButton *backBtn;
- (IBAction)doBack:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITableView *detailTableView;
@property (strong, nonatomic) NSArray *nameData;
@property (strong, nonatomic) NSArray *belongToData;
@property (strong, nonatomic) NSArray *statusData;
@end
