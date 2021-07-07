//
//  YMTaoBaoViewController.m
//  youmeiLift
//
//  Created by mac on 2021/7/2.
//

#import "YMTaoBaoViewController.h"
#import "WMPageController.h"
#import "YMPTJSViewController.h"
#import "OrderTimeVC.h"
@interface YMTaoBaoViewController ()<UIScrollViewDelegate, WMPageControllerDataSource,WMPageControllerDelegate>

@property (strong, nonatomic) UIView *headerView;
@property (nonatomic, strong) WMPageController *pageController;
@property (copy, nonatomic) NSArray *titleArr;

@property (strong, nonatomic) UIButton *myOrderBtn;
@property (strong, nonatomic) UIButton *teamOrderBtn;

@property (assign, nonatomic) NSInteger type;
@property (assign, nonatomic) NSInteger index;

@property (copy, nonatomic) NSString *startTime;
@property (copy, nonatomic) NSString *endTime;

@property (strong, nonatomic) UISegmentedControl *segment;

@end

@implementation YMTaoBaoViewController

- (NSArray *)titleArr{
    if (!_titleArr) {
        
        self.titleArr = @[@"全部", @"已付款", @"已收货", @"已结算", @"已失效"];
        
    }
    
    return _titleArr;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    
}
-(void)clickBackVC:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = ColorMaker(244, 244, 244, 255);
    
    UIView *headerView = [[UIView alloc]init];
    headerView.frame = CGRectMake(0, 0, kScreenWidth, iPhoneX?88+47:64+47);
    headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headerView];
    
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setImage:[UIImage imageNamed:@"back"] forState:0];
    cancelBtn.frame = CGRectMake(10, 2+(iPhoneX?44:20), 40, 40);
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [cancelBtn addTarget:self action:@selector(clickBackVC:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:cancelBtn];

   
        UIButton *dateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        dateBtn.frame = CGRectMake(kScreenWidth - 44, 25 +(iPhoneX?24:0), 34, 34);
        [dateBtn setImage:[UIImage imageNamed:@"YM_rili.png"] forState:0];
        [dateBtn addTarget:self action:@selector(clickRightItemOnOrderDetailVC:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:dateBtn];
        
     
        
        UIView *_searchView = [[UIView alloc]init];
        _searchView.frame = CGRectMake(44, 6+(iPhoneX?44:20), kScreenWidth - 44 -44, 32);
        _searchView.backgroundColor =allBackgroundColor;
        _searchView.layer.masksToBounds = YES;
        _searchView.layer.cornerRadius = 16.0f;
        UITapGestureRecognizer *searchTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickSearchViewOnOrderDetailVC:)];
        _searchView.userInteractionEnabled = YES;
        [_searchView addGestureRecognizer:searchTap];
        [headerView addSubview:_searchView];
        
        UIImageView *_searchImgView11 = [[UIImageView alloc]init];
        _searchImgView11.frame = CGRectMake(44+13, 15.5+(iPhoneX?44:20), 13, 13);
        _searchImgView11.image = [UIImage imageNamed:@"home_newSearch.png"];
        _searchImgView11.alpha = 1;
        [headerView addSubview:_searchImgView11];
        
        UILabel *_searchTTLab11 = [[UILabel alloc]init];
        _searchTTLab11.frame = CGRectMake(44+13+20, 15.5+(iPhoneX?44:20), kScreenWidth - 170, 13);
        _searchTTLab11.text = @"请输入订单号或商品标题";
        _searchTTLab11.font = [UIFont systemFontOfSize:12];
        _searchTTLab11.textColor = kUIColorFromRGB(0xCCCCCC);
        _searchTTLab11.alpha = 1;
        [headerView addSubview:_searchTTLab11];

        
    
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, iPhoneX?102:78, kScreenWidth, kScreenHeight - (iPhoneX?102:78))];
    contentView.backgroundColor = [UIColor clearColor];
    [headerView addSubview:contentView];
    [contentView addSubview:self.pageController.view];
    
    
    
   
    
    
    
}
- (void)clickRightItemOnOrderDetailVC:(UIButton *)sender{
    //点击选择时间
    DMLog(@"ddddddd 选择时间 ");
    
    OrderTimeVC *orderTimeVC = [[OrderTimeVC alloc]init];
    
      __weak typeof(self) mySelf = self;
    
    [orderTimeVC setPassStartTimeAndEndTime:^(NSString *startTime, NSString *endTime) {
       
        DMLog(@"传递过来的时间 %@ \n%@",  startTime, endTime);
        mySelf.startTime = startTime;
        mySelf.endTime = endTime;
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"order" object:nil userInfo:@{@"startTime":startTime, @"endTime":endTime, @"orderType":[NSString stringWithFormat:@"%ld", (long)mySelf.type]}];
        
        
    }];
    
    if (orderTimeVC) {
        [self.navigationController pushViewController:orderTimeVC animated:YES];
        
    }
    
}


- (WMPageController *)pageController {
    
    
    if (!_pageController) {
        _pageController = [[WMPageController alloc] initWithViewControllerClasses:@[[YMPTJSViewController class],[YMPTJSViewController class]] andTheirTitles:@[@"tab1",@"tab2"]];
       
        _pageController.delegate = self;
        _pageController.dataSource = self;
         _pageController.view.backgroundColor = [UIColor clearColor];
    }
    return _pageController;
    
}


#pragma mark -----WMP
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    
    //WMPageController的menuViewStyle需要在控制器初始化之后（init之后 viewLoad之前）设置，如果在控制器的viewLoad中设置则会导致标题栏没有底部滑块的问题。
    pageController.menuViewStyle = WMMenuViewStyleLine;
    pageController.titleColorSelected = kUIColorFromRGB(0xF10606);
    pageController.titleSizeSelected = FontSize(15);
    pageController.titleSizeNormal = FontSize(15);
    pageController.titleColorNormal = textMinorColor33;
    
    
    pageController.progressViewIsNaughty = YES;
    pageController.progressHeight = 2.0f;
    NSMutableArray *withArr = [NSMutableArray array];
    NSMutableArray *itemWidthArr = [NSMutableArray array];
    
    for (int i = 0; i < self.titleArr.count; i++) {
        NSString *oneStr = [NSString stringWithFormat:@"%@", self.titleArr[i]];
        if (oneStr.length == 2) {
            [withArr addObject:@"20"];
            [itemWidthArr addObject:@"55"];
        }
        else if (oneStr.length == 1){
            [withArr addObject:@"15"];
            [itemWidthArr addObject:@"35"];
        }
        else if (oneStr.length == 3){
            [withArr addObject:@"35"];
            [itemWidthArr addObject:@"65"];
        }
        else if (oneStr.length == 4){
            [withArr addObject:@"45"];
            [itemWidthArr addObject:@"80"];
        }
        else{
            [withArr addObject:@"55"];
            [itemWidthArr addObject:@"100"];
        }
        
        
    }
    
    
    pageController.progressViewWidths = withArr;
    pageController.itemsWidths = itemWidthArr;
    
    
    return 5;
    
}


- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    
    return [NSString stringWithFormat:@"%@", self.titleArr[index]];
    
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    
    DMLog(@"0000000");
    
    YMPTJSViewController *myOrderOneVC = [[YMPTJSViewController alloc]init];
    myOrderOneVC.type = pageController.selectIndex;
     myOrderOneVC.view.backgroundColor = [UIColor clearColor];
    return myOrderOneVC;
    
}



- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
     menuView.backgroundColor = [UIColor clearColor];
    
    CGFloat leftMargin = pageController.showOnNavigationBar ? 50 : 0;
    
    return CGRectMake(leftMargin, 0 , self.view.frame.size.width - 2*leftMargin, 34);
    
}


- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    contentView.backgroundColor = [UIColor clearColor];
    return CGRectMake(0, 34 , self.view.frame.size.width, self.view.frame.size.height );
    
}

- (void)clickSearchViewOnOrderDetailVC:(UIGestureRecognizer *)sender{
    
//    OrderSearchVC *orderSearchVC = [[OrderSearchVC alloc]init];
//    orderSearchVC.navTitle = self.navTitle;
//    orderSearchVC.rateStr = self.rateStr;
//    if (orderSearchVC) {
//        [self.navigationController pushViewController:orderSearchVC animated:YES];
//    }
}

@end
