//
//  YMPTJSViewController.m
//  youmeiLift
//
//  Created by mac on 2021/7/2.
//

#import "YMPTJSViewController.h"
#import "OrderEndCell.h"
@interface YMPTJSViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)UITableView *rankListTab;

@end

@implementation YMPTJSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rankListTab = [[UITableView alloc]initWithFrame:CGRectMake(12, 9, kScreenWidth-24, kScreenHeight-(iPhoneX?86:64))];
        self.rankListTab.delegate = self;
        self.rankListTab.dataSource = self;
        self.rankListTab.backgroundColor= [UIColor clearColor];
        self.rankListTab.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        self.rankListTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.rankListTab.estimatedRowHeight = 198.5;
        [self.view addSubview:self.rankListTab];

    
    
}

#pragma mark TabView Detelgate
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;

}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 20;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

//    ShopData *shopData = nil;
//    if (indexPath.row < self.dataArr.count) {
//        shopData = self.dataArr[indexPath.row];
//    }

    OrderEndCell *cell = [OrderEndCell cellWithTableView:tableView];
//    [cell configureRankListNewCellWithShopData:shopData withLabelStyle:@"07" indexPath:indexPath];
    
        return cell;

}
- (CGFloat ) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 198.5;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}
- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end
