//
//  HCMtalkMyOrderListController.m
//  Project
//
//  Created by 朱宗汉 on 16/3/17.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCMtalkWaitPayController.h"
#import "HCMtalkMyOrderInfo.h"
#import "HCMTalkMyOrderCell.h"

@interface HCMtalkWaitPayController ()

@end

@implementation HCMtalkWaitPayController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBackItem];
    self.title = @"待支付";
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self requestData];
    self.tableView.tableHeaderView = HCTabelHeadView(0.1);
    self.tableView.backgroundColor = kHCBackgroundColor;
    [self.view addSubview:self.tableView];
}

-(void)viewWillAppear:(BOOL)animated
{
    UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    
    statusBarView.backgroundColor=kHCNavBarColor;
    
    [self.view addSubview:statusBarView];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
}


#pragma mark --- tableViewdelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
  
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCMTalkMyOrderCell *cell = [HCMTalkMyOrderCell cellWithTable:tableView];
    cell.info = self.dataSource[indexPath.section];
    
    return cell;
}

#pragma mark ---- network

-(void)requestData
{
    NSArray *arr=@[@"删除订单",@"物流跟踪",@"等待付款"];
    
    for (int i = 0; i<3; i++) {
        
        HCMtalkMyOrderInfo *info = [[HCMtalkMyOrderInfo alloc]init];
        info.title = @"套餐A M-talk二维码标签10张+M-talk烫印机1个";
        info.price = @"￥9.9元";
        info.doWhat = arr[i];
        
        [self.dataSource addObject:info];
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
