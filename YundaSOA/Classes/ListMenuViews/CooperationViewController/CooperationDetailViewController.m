//
//  CooperationDetailViewController.m
//  YundaSOA_IPHONE
//
//  Created by tyson on 13-10-11.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "CooperationDetailViewController.h"
#import "CooperationDetailCell.h"
#import "MyColor.h"

@interface CooperationDetailViewController ()

@end

@implementation CooperationDetailViewController

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
	NSArray *nameArray = [[NSArray alloc] initWithObjects:@"达芙妮(10020)", @"达芙妮(10021)",@"达芙妮(10022)", @"达芙妮(10023)", @"达芙妮(10024)", @"达芙妮(10025)", @"达芙妮(10026)",@"达芙妮(10027)", @"达芙妮(10028)" , @"达芙妮(10029)",nil];
    self.nameData = nameArray;
    
    NSArray *belongToArray=[[NSArray alloc] initWithObjects:@"上海青浦赵巷营业部", @"上海青浦赵巷营业部",@"上海青浦赵巷营业部",@"上海青浦赵巷营业部",@"上海青浦赵巷营业部",@"上海青浦赵巷营业部",@"上海青浦赵巷营业部",@"上海青浦赵巷营业部",@"上海青浦赵巷营业部",@"上海青浦赵巷营业部",nil];
    self.belongToData=belongToArray;
    
    NSArray *statusArray=[[NSArray alloc] initWithObjects:@"已合作", @"已合作",@"已合作",@"已合作",@"已合作",@"已合作",@"已合作",@"已合作",@"已合作",@"已合作",nil];
    
    self.statusData=statusArray;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setBackBtn:nil];
    [self setDetailTableView:nil];
    self.statusData=nil;
    self.nameData=nil;
    self.belongToData=nil;
    [super viewDidUnload];
}

- (IBAction)doBack:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CooperationDetailCell";
    
    CooperationDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray * nibs = [[NSBundle mainBundle] loadNibNamed:@"CooperationDetail" owner:self options:nil];
        cell = [nibs objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.selectedBackgroundView = [[UIView alloc] init];
        cell.selectedBackgroundView.backgroundColor = [UIColor orangeColor];
    }

    // Configure the cell...
    NSUInteger row = [indexPath row];
    cell.name.text=[self.nameData objectAtIndex:row];
    cell.belongTo.text=[self.belongToData objectAtIndex:row];
    cell.status.text=[self.statusData objectAtIndex:row];
    
    if (row%2 == 1) {
        cell.backgroundView=[[UIView alloc] init];
        cell.backgroundView.backgroundColor = RGB(252, 233, 217);
         
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    clientDetail = [storyboard instantiateViewControllerWithIdentifier:@"clientDetail"];
    [self.navigationController pushViewController:clientDetail animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.nameData count];
}
@end
