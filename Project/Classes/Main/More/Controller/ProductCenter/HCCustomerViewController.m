//
//  HCCustomesViewController.m
//  Project
//
//  Created by 朱宗汉 on 15/12/19.
//  Copyright © 2015年 com.xxx. All rights reserved.
//退货/售后

#import "HCCustomerViewController.h"
#import "HCCustomerTableViewCell.h"
@interface HCCustomerViewController ()

@end

@implementation HCCustomerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"退货/售后";
    [self setupBackItem];
    
    
}
#pragma mark--Delegate
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *RecordID = @"record";
    HCCustomerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RecordID];
    cell = [[HCCustomerTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RecordID];
    
    cell.indexPath = indexPath;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row != 2) {
        return 50;
    }else
    {
        return 100;
    }
}



@end