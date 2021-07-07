//
//  YMIntegralViewController.m
//  youmeiLift
//
//  Created by mac on 2021/6/29.
//

#import "YMIntegralViewController.h"
#import <YJProgressHUD.h>
#import "DMGifHeader.h"
#import <MJRefresh.h>
#import "YMintegralTableViewCell.h"
@interface YMIntegralViewController ()
<UITableViewDataSource, UITableViewDelegate>
@property(strong, nonatomic) UITableView *dmDetailTab;
@property (strong, nonatomic) NSMutableArray *dataArr;
@end

@implementation YMIntegralViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    
    self.navigationController.navigationBarHidden = YES;
   // self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    
    self.navigationController.navigationBarHidden = NO;
   // self.tabBarController.tabBar.hidden = YES;
}
-(void)clickBackVC:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = allBackgroundColor;
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, iPhoneX?88:64)];
    navView.backgroundColor = allBackgroundColor;
    [self.view addSubview:navView];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setImage:[UIImage imageNamed:@"back"] forState:0];
    cancelBtn.frame = CGRectMake(10, 2+(iPhoneX?44:20), 40, 40);
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [cancelBtn addTarget:self action:@selector(clickBackVC:) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:cancelBtn];
    
    UILabel *titleLab=[[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-100)/2, 2+(iPhoneX?44:20), 100, 40)];
    titleLab.text=self.receivedTitle;
    titleLab.textColor=[UIColor blackColor];
    titleLab.textAlignment=NSTextAlignmentCenter;
    titleLab.font=[UIFont systemFontOfSize:FontSize(18)];
    [navView addSubview:titleLab];
    
    
    self.dataArr = [NSMutableArray array];
    
    
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, iPhoneX?88:64, kScreenWidth, 10)];
    lineView.backgroundColor = allBackgroundColor;
    [self.view addSubview:lineView];
    
    
    
    self.dmDetailTab = [[UITableView alloc]initWithFrame:CGRectMake(10, 10+(iPhoneX?88:64), kScreenWidth-20, kScreenHeight- (iPhoneX?88:64) - 10) ];
    _dmDetailTab.delegate = self;
    _dmDetailTab.dataSource = self;
    _dmDetailTab.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _dmDetailTab.separatorStyle = UITableViewCellSeparatorStyleNone;
   _dmDetailTab.backgroundColor = allBackgroundColor;
    _dmDetailTab.tableHeaderView = lineView;
    [self.view addSubview:_dmDetailTab];
    
    
//    [YJProgressHUD showCustomAnimation:@"加载中" withImgArry:nil inview:kWindow];
    
//    [self getHeaderData];
//    DMGifHeader *header = [DMGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(getHeaderData)];
//    header.lastUpdatedTimeLabel.hidden= YES;
//    header.stateLabel.hidden = YES;
//    self.dmDetailTab.mj_header = header;
//    self.dmDetailTab.mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(getFooterData)];
}

- (void)getHeaderData{
//    [self.dataArr removeAllObjects];
//    [self getFooterData];
}

- (void)getFooterData{
    
//    if (self.dataArr.count == 0) {
//        pageIndex = 1;
//    }
//    else{
//        pageIndex++;
//    }
//
//
//    NSDictionary *urlDic = @{
//
//
//                             @"startindex":[NSString stringWithFormat:@"%lu", (unsigned long)pageIndex],
//                             @"pagesize":@"10",
//
//                             };
//    NSString *urlStr = [NSString string];
//    if ([self.receivedTitle isEqualToString:@"萌币明细"]) {
//        urlStr = kURLWithScorerecord;
//    }
//    else if ([self.receivedTitle isEqualToString:@"奖金明细"]){
//        urlStr = kURLWithScoreaccount;
//    }
//
//    [NetWorkManager  requestWithType:1 withUrlString:urlStr withParaments:urlDic withSuccessBlock:^(NSDictionary *responseObject) {
//
//        DMLog(@"首页列表数据 =  %@  %@",  responseObject, responseObject[@"msgstr"]);
//
//        NSString *result = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
//        [YJProgressHUD hide];
//
//        if ([result isEqualToString:@"1"]) {
//            DmDetailData *dmDetailData = [DmDetailData mj_objectWithKeyValues:responseObject];
//            for (DmDetailDataItem *item in dmDetailData.data) {
//                [self.dataArr addObject:item];
//            }
//
//            if (dmDetailData.data.count == 0) {
//
//                [self.dmDetailTab.mj_footer endRefreshingWithNoMoreData];
//                [self.dmDetailTab.mj_header endRefreshing];
//
//            }else{
//
//                [self.dmDetailTab.mj_header endRefreshing];
//                [self.dmDetailTab.mj_footer endRefreshing];
//
//
//            }
//
//            [self.dmDetailTab reloadData];
//
//        }
//
//        else{
//
//            [self.dmDetailTab.mj_footer endRefreshingWithNoMoreData];
//            [self.dmDetailTab.mj_header endRefreshing];
//            [self.dmDetailTab reloadData];
//        }
//
//
//    } withFailureBlock:^(NSError *error) {
//        [YJProgressHUD hide];
//
//        [self.dmDetailTab.mj_footer endRefreshingWithNoMoreData];
//        [self.dmDetailTab.mj_header endRefreshing];
//        [self.dmDetailTab reloadData];
//
//    } progress:^(float progress) {
//
//    }];
    
    
    
}
#pragma mark --UITableViewDelegate, UITableViewDataSource

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
}


- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}



- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 20;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YMintegralTableViewCell *cell = [YMintegralTableViewCell cellWithTableView:tableView];

//    DmDetailDataItem *item = nil;
//    if (indexPath.row < self.dataArr.count) {
//        item = self.dataArr[indexPath.row];
//    }
//    [cell configureDmDetailCellDmDetailDataItem:item style:self.receivedTitle];

    return cell;
    
}


- (CGFloat ) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 59;
    
}


@end
