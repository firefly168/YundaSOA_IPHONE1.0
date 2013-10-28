//
//  ClientDetailViewController.h
//  YundaSOA_IPHONE
//
//  Created by tyson on 13-10-12.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface ClientDetailViewController : BaseViewController
{
    UIView *currentView;
}

@property (weak, nonatomic) IBOutlet UIImageView *bgImg;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *detailSegment;
@property (weak, nonatomic) IBOutlet UIView *detailView;
- (IBAction)doBack:(UIButton *)sender;
- (IBAction)segAction:(UISegmentedControl *)sender;

@end
