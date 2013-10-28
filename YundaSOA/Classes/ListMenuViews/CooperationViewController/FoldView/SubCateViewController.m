//
//  SubCateViewController.m
//  top100
//
//  Created by Dai Cloud on 12-7-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SubCateViewController.h"
#import "CateSubCell.h"
#import "MyColor.h"

#define COLUMN 4

@interface SubCateViewController ()

@end

@implementation SubCateViewController

@synthesize subCates=_subCates;
@synthesize cateVC=_cateVC;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tmall_bg_furley.png"]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"switchToDetail" object:nil];
    //取消选中
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}

- (CGFloat)tableView:(UIFolderTableView *)tableView xForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CateSubCell";
    
    CateSubCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray * nibs = [[NSBundle mainBundle] loadNibNamed:@"CateSubCell" owner:self options:nil];
        cell = [nibs objectAtIndex:0];
        cell.selectedBackgroundView = [[UIView alloc] init];
        cell.selectedBackgroundView.backgroundColor = [UIColor orangeColor];
        cell.backgroundView = [[UIView alloc] init];
        cell.backgroundView.backgroundColor = RGB(252, 233, 217);
    }

    return cell;
}

@end
