//
//  CateSubCell.m
//  YundaSOA_IPHONE
//
//  Created by tyson on 13-10-12.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "CateSubCell.h"

@implementation CateSubCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)drawRect:(CGRect)rect
{
    self.ProvinceName.text = @"上海市";
    self.shouldDo.text = @"1663";
}

@end
