//
//  YMDingDanViewController.m
//  youmeiLift
//
//  Created by mac on 2021/7/5.
//

#import "YMDingDanViewController.h"
#import "YMMyDetailTableViewCell.h"
#import <Masonry.h>
@interface YMDingDanViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)UITableView *rankListTab;
@end

@implementation YMDingDanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rankListTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-24, kScreenHeight-(iPhoneX?86:64)-100)];
        self.rankListTab.delegate = self;
        self.rankListTab.dataSource = self;
        self.rankListTab.backgroundColor= [UIColor clearColor];
        self.rankListTab.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        self.rankListTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.rankListTab.estimatedRowHeight = 90;
        [self.view addSubview:self.rankListTab];

    
    
}

#pragma mark TabView Detelgate
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;

}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 5;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

//    ShopData *shopData = nil;
//    if (indexPath.row < self.dataArr.count) {
//        shopData = self.dataArr[indexPath.row];
//    }

    YMMyDetailTableViewCell *cell = [YMMyDetailTableViewCell cellWithTableView:tableView];
//    [cell configureRankListNewCellWithShopData:shopData withLabelStyle:@"07" indexPath:indexPath];
   
        return cell;

}
- (CGFloat ) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}
- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end
