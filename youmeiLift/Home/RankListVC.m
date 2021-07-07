//
//  RankListVC.m
//  YouMeiLift
//
//  Created by 有美生活 on 2021/6/22.
//  Copyright © 2021 有美生活. All rights reserved.
//


#import "RankListVC.h"
#import "DMTool.h"
#import "NetWorkManager.h"
#import "MJRefresh.h"
#import <YJProgressHUD.h>
#import "ShopItemsData.h"
#import "ShopData.h"
#import "MJExtension.h"

#import "RankListNewCell.h"
#import "YXAlertView.h"
#import "HomeGoodsDetailVC.h"
#import "TABAnimated.h"

@interface RankListVC ()< UITableViewDelegate, UITableViewDataSource>


@property (strong, nonatomic) NSMutableArray *dataArr;
@property (strong, nonatomic) ShopItemsData *itemData;

@property (strong, nonatomic) UIImageView *runTopView;

@property (strong, nonatomic) NSMutableArray *indexArr;
@property (assign, nonatomic) BOOL toGetData;

@property (strong, nonatomic) UITableView *rankListTab;
@property (copy, nonatomic) NSString *loadStyle;
@end

@implementation RankListVC
{
    NSString *searchtime;
    NSInteger page;
}

- (UIImageView *)runTopView{
    
    if (!_runTopView) {
        self.runTopView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth - 50, kScreenHeight - 180 - (iPhoneX?132:64), 35, 35)];
 
    }
    return _runTopView;
    
}


- (void)viewWillAppear:(BOOL)animated{
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeRankList:) name:@"changeRankList" object:nil];
}

- (void)changeRankList:(NSNotification *)notification{
    
    //请求列表数据
    [self getHeaderData];
    
  
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    self.dataArr = [NSMutableArray array];
   

    self.rankListTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - (iPhoneX?120:104) -(iPhoneX?83:49)) ];
    _rankListTab.delegate = self;
    _rankListTab.dataSource = self;
    _rankListTab.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _rankListTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    _rankListTab.estimatedRowHeight = 137;
    [self.view addSubview:_rankListTab];
    
   
 
   
    // 可以不进行手动初始化，将使用默认属性
//    _rankListTab.tabAnimated = [TABTableAnimated animatedWithCellClass:[RankListNewCell class] cellHeight:137];
////    _rankListTab.tabAnimated.canLoadAgain = YES;
////    _rankListTab.tabAnimated.animatedColor = kUIColorFromRGB(0xF5F7F9);
//
//    _rankListTab.tabAnimated.adjustBlock = ^(TABComponentManager * _Nonnull manager) {
//        manager.animation(0).height(107).width(107);
//        manager.animation(2).height(15).reducedWidth(45);
//        manager.animation(3).height(15).width(15);
//        manager.animation(4).down(3).height(15).reducedWidth(15);
//        manager.animation(6).down(-10).height(15).width(65).right(70);
//        manager.animation(5).down(-12).height(15).width(65).left(20);
//        manager.animation(7).down(3).height(0.001);
//        manager.animation(8).down(3).height(0.001);
//    };
    
    
    
    
    _rankListTab.tabAnimated = [TABTableAnimated animatedWithCellClass:[RankListNewCell class] cellHeight:137];
    _rankListTab.tabAnimated.adjustBlock = ^(TABComponentManager * _Nonnull manager) {
        manager.animation(1).down(3).height(12);
        manager.animation(2).height(12).reducedWidth(70);
        manager.animation(3).down(-5).height(12).radius(0.).reducedWidth(-20);
    };
    
    // 下啦刷新

//    DMGifHeader *header = [DMGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(getHeaderData)];
//    header.lastUpdatedTimeLabel.hidden= YES;
//    header.stateLabel.hidden = YES;
//    self.rankListTab.mj_header = header;
    
 //  [self.rankListTab tab_startAnimationWithCompletion:^{
        // 请求数据
        // ...
        // 获得数据
        // ...
//       [self.rankListTab.mj_header beginRefreshing];
  //  }];
    
    [self getHeaderData];
    
    self.rankListTab.mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(getFooterData)];
    
    
    //注册 通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLogin:) name:@"changeLogin" object:nil];
    

    self.runTopView.image = [UIImage imageNamed:@"run_top.png"];
    UITapGestureRecognizer *teamTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickrunTopViewOnHomeVC:)];
    [_runTopView addGestureRecognizer:teamTap];
    _runTopView.userInteractionEnabled = YES;

    self.rankListTab.backgroundColor = [UIColor clearColor];
    
}

- (void)clickrunTopViewOnHomeVC:(UIGestureRecognizer *)sender{
    
    [self.rankListTab setContentOffset:CGPointMake(0, 0) animated:YES];
    
    
}



- (void)changeLogin:(NSNotification *)notification{
    DMLog(@"登陆状态改变热卖");
    
    self.loadStyle = @"changeLogin";
    [self getHeaderData];
    
    
    
}



- (void)getHeaderData{
   
    [self.dataArr removeAllObjects];
    
//    [self getFooterData];
    
}

- (void)getFooterData{
   
    self.toGetData = YES;
    
    DMLog(@"self.dataArr = %@", self.dataArr);
    if (self.dataArr.count == 0) {
        searchtime = @"";
        page = 1;
        
    }
    else{
        
        searchtime = [NSString stringWithFormat:@"%@", self.itemData.searchtime];
        page++;
        
    }
    
    
  
    
    
//    NSDictionary *urlDic1 = @{
//                              @"cid":self.ID,
//                              @"startindex":[NSString stringWithFormat:@"%lu", (unsigned long)page],
//                              @"pagesize":@"10",
//
//                              };
    
    
//    [NetWorkManager  requestWithType:1 withUrlString:kURLWithGetRankingList withParaments:urlDic1 withSuccessBlock:^(NSDictionary *responseObject) {
//
//        DMLog(@"根据标签检索结果热卖热卖123 =  %@  %@",  responseObject, responseObject[@"msgstr"]);
//
//        NSString *result = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
//
//        if ([result isEqualToString:@"1"]) {
//            // 停止动画,并刷新数据
//         //   [self.rankListTab tab_endAnimationEaseOut];
//
//
//
//            self.itemData = [ShopItemsData mj_objectWithKeyValues:responseObject];
//            for (ShopData *shopData in self.itemData.data) {
//                [self.dataArr addObject:shopData];
//            }
//
//            if (self.itemData.data.count == 0) {
//                self.toGetData = NO;
//                [self.rankListTab.mj_footer endRefreshingWithNoMoreData];
//                [self.rankListTab.mj_header endRefreshing];
//
//            }else{
//                [self.rankListTab.mj_header endRefreshing];
//                [self.rankListTab.mj_footer endRefreshing];
//
//            }
//         //   [self.rankListTab reloadData];
//
//            if (![self.loadStyle isEqualToString:@"changeLogin"] && page == 1) {
//                [DMTool networkRequestHaveVibration];
//            }else{
//                self.loadStyle = @"nomal";
//            }
//
//        }
//        else{
//
//            self.toGetData = NO;
//            [self.rankListTab.mj_header endRefreshing];
//            [self.rankListTab.mj_header endRefreshing];
//            [self.rankListTab.mj_footer endRefreshingWithNoMoreData];
//       //   [self.rankListTab reloadData];
//
//        }
//
//        DMLog(@"self.indexArr = %@", self.indexArr);
//
//            //刷新界面
//        [self.rankListTab reloadData];
//        [YJProgressHUD hide];
//
//    } withFailureBlock:^(NSError *error) {
//        [YJProgressHUD hide];
//
//
//    } progress:^(float progress) {
//
//    }];
    
   
    
   
}



#pragma mark --UITableViewDelegate, UITableViewDataSource

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row > self.dataArr.count - 4) {

        if (self.toGetData) {
           [self getFooterData];
        }

    }
    
    
}


- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}



- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArr.count?self.dataArr.count:20;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ShopData *shopData = nil;
    if (indexPath.row < self.dataArr.count) {
        shopData = self.dataArr[indexPath.row];
    }
   
    RankListNewCell *cell = [RankListNewCell cellWithTableView:tableView];
    [cell configureRankListNewCellWithShopData:shopData withLabelStyle:@"07" indexPath:indexPath];
        return cell;
    
}



- (CGFloat ) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 137;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        
    ShopData *shopData = nil;
    if (indexPath.row < self.dataArr.count) {
        shopData = self.dataArr[indexPath.row];
    }
    
    HomeGoodsDetailVC *detailVC = [[HomeGoodsDetailVC alloc]init];
    
    detailVC.shopID = shopData.ID;
    detailVC.source = shopData.source;
    detailVC.sourceId = shopData.sourceId;
    if (detailVC) {
        [self.nav pushViewController:detailVC animated:YES];
    }
    
    
}


-(void)segmentedcontrolAction:(UISegmentedControl *)sender{
    
    NSUInteger  index=sender.selectedSegmentIndex;
    switch (index) {
        case 0:
            DMLog(@"第一个选项被选中");
            break;
        case 1:
            DMLog(@"第二个选项被选中");
            break;
        default:
            break;
    }
    
    
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
   // DMLog(@"yyyyyyyyy");
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY > kScreenHeight ) {
        [self.view addSubview:_runTopView];
    }
    else{
        [_runTopView removeFromSuperview];
    }
    
     [[NSNotificationCenter defaultCenter] postNotificationName:@"rankListVCScroll" object:nil userInfo:@{@"offsetY":[NSString stringWithFormat:@"%f",scrollView.contentOffset.y]}];
}



@end
