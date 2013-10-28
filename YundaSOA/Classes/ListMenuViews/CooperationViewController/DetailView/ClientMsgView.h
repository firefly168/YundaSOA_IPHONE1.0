//
//  ClientMsgView.h
//  YundaSOA_IPHONE
//
//  Created by tyson on 13-10-14.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClientMsgView : UIView
@property (weak, nonatomic) IBOutlet UILabel *clientCode;
@property (weak, nonatomic) IBOutlet UILabel *clientPhone;
@property (weak, nonatomic) IBOutlet UILabel *clientIndustry;
@property (weak, nonatomic) IBOutlet UILabel *goodInside;
@property (weak, nonatomic) IBOutlet UILabel *clientContact;
@property (weak, nonatomic) IBOutlet UILabel *clientAddress;
@property (weak, nonatomic) IBOutlet UILabel *belongToBranch;
@property (weak, nonatomic) IBOutlet UILabel *branchArea;

@property (weak, nonatomic) IBOutlet UILabel *branchCharger;
@property (weak, nonatomic) IBOutlet UILabel *chargerPhone;
@property (weak, nonatomic) IBOutlet UILabel *ClinetFinder;
@property (weak, nonatomic) IBOutlet UILabel *finderPhone;

@end
