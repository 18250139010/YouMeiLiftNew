//
//  DailyRedPacketWithdrawListVC.m
//  DaiMengJia
//
//  Created by 呆萌价 on 2021/3/30.
//  Copyright © 2021 呆萌价. All rights reserved.
//

#import "DailyRedPacketWithdrawListVC.h"
#import "DMTool.h"
#import "NetWorkManager.h"
#import "WithdrawAlsDataItem.h"
#import "WithdrawAlsData.h"
#import "MJExtension.h"
#import "WithdrawRecordCell.h"
#import "MJRefresh.h"
#import "YJProgressHUD.h"
#import "DMGifHeader.h"
#import "ShowEmptyView.h"
@interface DailyRedPacketWithdrawListVC ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UITableView *withdrawListTab;
@property (strong, nonatomic) NSMutableArray *dataArr;

@end

@implementation DailyRedPacketWithdrawListVC
{
    NSString *searchtime;
    NSInteger page;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)clickBackVC:(UIButton *)sender{
    [YJProgressHUD hide];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [YJProgressHUD showCustomAnimation:@"加载中" withImgArry:nil inview:kWindow];
    self.view.backgroundColor = ColorMaker(244, 244, 244, 255);
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, iPhoneX?88:64)];
    headerView.backgroundColor = ColorMaker(244, 244, 244, 255);
    [self.view addSubview:headerView];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setImage:[UIImage imageNamed:@"back"] forState:0];
    cancelBtn.frame = CGRectMake(10, 2+(iPhoneX?44:20), 40, 40);
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [cancelBtn addTarget:self action:@selector(clickBackVC:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:cancelBtn];

    UILabel *jifenLab=[[UILabel alloc]init];
    jifenLab.frame=CGRectMake((kScreenWidth-100)/2, 2+(iPhoneX?44:20), 100, 40);
    jifenLab.text=@"提现记录";
    jifenLab.textAlignment=NSTextAlignmentCenter;
    jifenLab.textColor=[UIColor blackColor];
    jifenLab.font=[UIFont systemFontOfSize:FontSize(18)];
    [headerView addSubview:jifenLab];
    
    
    self.dataArr = [NSMutableArray array];
    self.withdrawListTab = [[UITableView alloc]initWithFrame:CGRectMake(0, iPhoneX?88:64, kScreenWidth, kScreenHeight - (iPhoneX?88:64) - (iPhoneX?34:0) )];
    _withdrawListTab.delegate = self;
    _withdrawListTab.dataSource = self;
    _withdrawListTab.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 5)];
    _withdrawListTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    _withdrawListTab.backgroundColor = ColorMaker(244, 244, 244, 255);
    
    _withdrawListTab.rowHeight = UITableViewAutomaticDimension;
    _withdrawListTab.estimatedRowHeight = 40;
    
    [self.view addSubview:_withdrawListTab];
    
    DMGifHeader *header = [DMGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(getHeaderData)];
    header.lastUpdatedTimeLabel.hidden= YES;
    header.stateLabel.hidden = YES;
    self.withdrawListTab.mj_header = header;
    
    [self getHeaderData];
    
    self.withdrawListTab.mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(getFooterData)];
    
    
}
- (void)getHeaderData{
   
    [self.dataArr removeAllObjects];
    
    [self getFooterData];
    
}

- (void)getFooterData{
   
   
    
    DMLog(@"self.dataArr = %@", self.dataArr);
    if (self.dataArr.count == 0) {
      
        page = 1;
        
    }
    else{
        
       
        page++;
        
    }
    
    
  
    
    
    NSDictionary *urlDic1 = @{
                             
                              @"startindex":[NSString stringWithFormat:@"%lu", (unsigned long)page],
                              @"pagesize":@"10",
                              
                              };
    
    
    [NetWorkManager  requestWithType:1 withUrlString:kURLWithGetRedPackageWithdrawalRecord withParaments:urlDic1 withSuccessBlock:^(NSDictionary *responseObject) {
        
        DMLog(@"红包 提现记录  =  %@  %@",  responseObject, responseObject[@"msgstr"]);
        
       
        NSString *result = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
        if ([result isEqualToString:@"1"]) {
            NSDictionary *dataDict = (NSDictionary *)responseObject[@"data"];
            WithdrawAlsDataItem *dataItem = [WithdrawAlsDataItem mj_objectWithKeyValues:dataDict];

            for (WithdrawAlsData *data in dataItem.redPackageRecords) {
               [self.dataArr addObject:data];
            }

            if (dataItem.redPackageRecords.count == 0) {
               
                [self.withdrawListTab.mj_footer endRefreshingWithNoMoreData];
                [self.withdrawListTab.mj_header endRefreshing];

            }else{
                [self.withdrawListTab.mj_header endRefreshing];
                [self.withdrawListTab.mj_footer endRefreshing];

            }
            
            
            if (self.dataArr.count == 0) {
                
                
                ShowEmptyView *showView = [[ShowEmptyView alloc]init];
                [showView showeEmptyTipsToView:self.view title:@"这里空空如也" message:@"去赚钱吧~" imageType:@"noRedTX" tryAgain:^(NSInteger buttonTag) {
                    [self.navigationController popViewControllerAnimated:YES];
                    
                    [showView removeFromSuperview];
                    [showView remove];
                }];
                [self.view addSubview:showView];
                
                
            }
            
        }
        else{
           
            [self.withdrawListTab.mj_header endRefreshing];
            [self.withdrawListTab.mj_header endRefreshing];
            [self.withdrawListTab.mj_footer endRefreshingWithNoMoreData];
        }
        
        [self.withdrawListTab reloadData];
        [YJProgressHUD hide];
    } withFailureBlock:^(NSError *error) {
        [YJProgressHUD hide];
    } progress:^(float progress) {
        
    }];
    

}
#pragma mark --UITableViewDelegate, UITableViewDataSource

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
}


- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}



- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.dataArr.count;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    WithdrawAlsData *data = nil;
    if (indexPath.row < self.dataArr.count) {
        data = self.dataArr[indexPath.row];
    }
    WithdrawRecordCell *cell = [WithdrawRecordCell cellWithTableView:tableView];
    //  WithdrawAlsData *data = self.dataArr[indexPath.row];
    [cell configureWithdrawRecordCellWithData:data indexPath:indexPath count:self.dataArr.count type:@"红包提现"];
    
    
    
    return cell;
    
}


- (CGFloat ) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    return 99;
    
    
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
@end
