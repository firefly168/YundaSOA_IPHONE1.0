//
//  CateSubCell.h
//  YundaSOA_IPHONE
//
//  Created by tyson on 13-10-12.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CooperationDetailViewController.h"

@interface CateSubCell : UITableViewCell
{
    CooperationDetailViewController *cooperationDetail;
}

@property (weak, nonatomic) IBOutlet UILabel *ProvinceName;
@property (weak, nonatomic) IBOutlet UILabel *shouldDo;
@property (weak, nonatomic) IBOutlet UILabel *haveDo;
@property (weak, nonatomic) IBOutlet UILabel *noDo;
@property (weak, nonatomic) IBOutlet UILabel *percent;
@end
