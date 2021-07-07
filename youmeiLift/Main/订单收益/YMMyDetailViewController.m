//
//  YMMyDetailViewController.m
//  youmeiLift
//
//  Created by mac on 2021/7/2.
//

#import "YMMyDetailViewController.h"
#import <Masonry.h>
#import "YMMyDetailTableViewCell.h"
#import "ShopData.h"
#import "WMPageController.h"
#import "YMDingDanViewController.h"
@interface YMMyDetailViewController ()<UITableViewDelegate,UITableViewDataSource,WMPageControllerDelegate,WMPageControllerDataSource>
@property (strong, nonatomic) UIButton *myOrderBtn;
@property (strong, nonatomic) UIButton *teamOrderBtn;
@property (strong, nonatomic)NSMutableArray *dataArr;
@property (strong, nonatomic)UITableView *rankListTab;
@property (assign, nonatomic) NSInteger type;
@property (nonatomic, assign) int selectIndex;
@property (nonatomic,strong)WMPageController *pageController;
@property (nonatomic ,strong)NSArray *titleArr;

@end

@implementation YMMyDetailViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillDisappear:animated];
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
    
    self.dataArr=[NSMutableArray array];
    
    self.view.backgroundColor = allBackgroundColor;
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, (iPhoneX?88:64))];
    navView.backgroundColor = allBackgroundColor;
    [self.view addSubview:navView];
    
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setImage:[UIImage imageNamed:@"back"] forState:0];
    cancelBtn.frame = CGRectMake(10, 2+(iPhoneX?44:20), 40, 40);
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [cancelBtn addTarget:self action:@selector(clickBackVC:) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:cancelBtn];

    UILabel *jifenLab=[[UILabel alloc]init];
    jifenLab.frame=CGRectMake((kScreenWidth-100)/2, 2+(iPhoneX?44:20), 100, 40);
    jifenLab.text=@"我的明细";
    jifenLab.textAlignment=NSTextAlignmentCenter;
    jifenLab.textColor=[UIColor blackColor];
    jifenLab.font=[UIFont systemFontOfSize:FontSize(18)];
    [navView addSubview:jifenLab];
    
    
    UIView *AllView=[[UIView alloc]initWithFrame:CGRectMake(12, (iPhoneX?88:64)+10, kScreenWidth-24, 85)];
    AllView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:AllView];
    
    
    UIView *chooseBtnView = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth- 24 - 240)/2.0, 16, 240, 40)];
    //设置frame
    chooseBtnView.backgroundColor =allBackgroundColor;
    chooseBtnView.tintColor = kUIColorFromRGB(0xFC0F42);
    chooseBtnView.layer.masksToBounds = YES;
    chooseBtnView.layer.cornerRadius = 16.0f;
    //添加到主视图
    [AllView addSubview:chooseBtnView];
    
    self.myOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _myOrderBtn.frame = CGRectMake(2, 0, 118, 41);
    [_myOrderBtn setTitle:@"我的订单" forState:0];
    [_myOrderBtn setTitleColor:[UIColor whiteColor] forState:0];
    _myOrderBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
    [_myOrderBtn setBackgroundImage:[UIImage imageNamed:@"order_choose.png"] forState:0];
    [_myOrderBtn addTarget:self action:@selector(clickMyOrderButtonOnOrderDetailVC:) forControlEvents:UIControlEventTouchUpInside];
    [chooseBtnView addSubview:_myOrderBtn];
    
    self.teamOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _teamOrderBtn.frame = CGRectMake(120, 0, 118, 41);
    [_teamOrderBtn setTitle:@"团队订单" forState:0];
    [_teamOrderBtn setTitleColor:textMinorColor forState:0];
    _teamOrderBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
   // [teamOrderBtn setBackgroundImage:[UIImage imageNamed:@"order_choose.png"] forState:0];
    [_teamOrderBtn addTarget:self action:@selector(clickTeamOrderButtonOnOrderDetailVC:) forControlEvents:UIControlEventTouchUpInside];
    [chooseBtnView addSubview:_teamOrderBtn];
    

    self.type = 0;
//    self.selectIndex=0;
    self.pageController.selectIndex=0;
    [self.view addSubview:self.pageController.view];
    [self.pageController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(AllView.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(12);
        make.right.equalTo(self.view.mas_right).offset(-12);
        make.height.mas_equalTo(kScreenHeight  -(iPhoneX?83:49)-85);
    }];
}

- (WMPageController *)pageController {
    
    if (!_pageController) {
        _pageController = [[WMPageController alloc] initWithViewControllerClasses:@[[YMDingDanViewController class],[YMDingDanViewController class]] andTheirTitles:@[@"tab1",@"tab2"]];
        
        _pageController.delegate = self;
        _pageController.dataSource = self;
        _pageController.view.backgroundColor = [UIColor clearColor];
    }
    return _pageController;
    
}

    

-(void)clickMyOrderButtonOnOrderDetailVC:(UIButton *)sender
{
    [_myOrderBtn setBackgroundImage:[UIImage imageNamed:@"order_choose.png"] forState:0];
    [_teamOrderBtn setBackgroundImage:[UIImage imageNamed:@""] forState:0];
    [_myOrderBtn setTitleColor:[UIColor whiteColor] forState:0];
    [_teamOrderBtn setTitleColor:textMinorColor forState:0];
    
    self.type=0;
    self.pageController.selectIndex=0;
}
-(void)clickTeamOrderButtonOnOrderDetailVC:(UIButton *)sender
{
    [_myOrderBtn setBackgroundImage:[UIImage imageNamed:@""] forState:0];
    [_teamOrderBtn setBackgroundImage:[UIImage imageNamed:@"order_choose.png"] forState:0];
    [_myOrderBtn setTitleColor:textMinorColor forState:0];
    [_teamOrderBtn setTitleColor:[UIColor whiteColor] forState:0];
 
    self.type=1;
    self.pageController.selectIndex=1;
}
- (NSArray *)titleArr{
    if (!_titleArr) {
        self.titleArr = @[@"精选", @"猜你喜欢"];
    }
    return _titleArr;
}
#pragma mark -----WMP
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    
    pageController.menuViewStyle = WMMenuViewStyleLine;
    pageController.titleSizeSelected = FontSize(17);
    pageController.titleSizeNormal = FontSize(16);
    
    pageController.titleColorSelected = kUIColorFromRGB(0xFF0134);
    pageController.titleColorNormal = textMinorColor33;
    pageController.scrollEnable = NO;
    pageController.selectIndex=0;
    pageController.progressViewIsNaughty = YES;
    pageController.progressHeight = 3.0f;
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
        
        return self.titleArr.count;

 
    
}
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    
    return [NSString stringWithFormat:@"%@", self.titleArr[index]];
    
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    
    
    CGFloat leftMargin = pageController.showOnNavigationBar ? 50 : 10;
    
    return CGRectMake(0,0 , self.view.frame.size.width, 0);
    
}


- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    
    contentView.backgroundColor = [UIColor clearColor];
    return CGRectMake(0, 0 , self.view.frame.size.width, self.view.frame.size.height );
    
}

@end
