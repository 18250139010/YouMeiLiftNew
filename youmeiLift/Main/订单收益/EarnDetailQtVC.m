//
//  EarnDetailQtVC.m
//  DaiMengJia
//
//  Created by 呆萌价 on 2019/9/26.
//  Copyright © 2019年 呆萌价. All rights reserved.
//

#import "EarnDetailQtVC.h"
#import "DMTool.h"

#import "WMPageController.h"
//#import "NetWorkManager.h"
#import "EarnOneItemVC.h"
//#import "StatisticalItem.h"
#import "MJExtension.h"
//#import "WithdrawViewController.h"
#import "YJProgressHUD.h"
//#import "UICountingLabel.h"
@interface EarnDetailQtVC ()<UIScrollViewDelegate, WMPageControllerDataSource,WMPageControllerDelegate>

@property (strong, nonatomic) UIView *headerNavView;
@property (nonatomic, strong) WMPageController *pageController;
@property (strong, nonatomic) NSArray *titleArr;
@property (strong, nonatomic) NSMutableArray *cpsTypeArr;
//@property (strong, nonatomic)  StatisticalItem *statisticalItem;



@property (copy, nonatomic) NSDictionary *bj_ptDict;
@property (copy, nonatomic) NSString *ptCountStyle;

@property (copy, nonatomic) NSString *userType;


@end

@implementation EarnDetailQtVC

- (NSArray *)titleArr{
    if (!_titleArr) {
        
        self.titleArr = @[@"拼多多", @"京东", @"唯品会", @"苏宁", @"美团", @"考拉"];
        
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

- (void)clickBackVC:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSData *ptData = [NSData dataWithContentsOfFile:DocumentPath(@"earnPT.plist")];
    if (ptData) {
        
        self.bj_ptDict = [NSJSONSerialization JSONObjectWithData:ptData options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"自己编辑的团队收益 == %@", self.bj_ptDict);
        
        self.userType = self.bj_ptDict[@"userType"];
        self.ptCountStyle = @"666";
        
    }else{
        
        self.userType = [NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"usertype"]];
        
    }
    
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, iPhoneX?88:64)];
    headerView.backgroundColor = ColorMaker(255, 255, 255, 255);
    [self.view addSubview:headerView];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setImage:[UIImage imageNamed:@"back"] forState:0];
    cancelBtn.frame = CGRectMake(10, 2+(iPhoneX?44:20), 40, 40);
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [cancelBtn addTarget:self action:@selector(clickBackVC:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:cancelBtn];
    
    
    UILabel *ttLab = [[UILabel alloc]initWithFrame:CGRectMake(0, iPhoneX?44:20, kScreenWidth, 44)];
    ttLab.text = @"其他平台收益";
    ttLab.textColor = textMinorColor33;
    ttLab.font = [UIFont systemFontOfSize:FontSize(18)];
    ttLab.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:ttLab];
    
    
    
    UIScrollView *earnScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, iPhoneX?88:64, kScreenWidth, kScreenHeight - (iPhoneX?88:64))];
    earnScrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight);
    
    [self.view addSubview:earnScrollView];
    
    if (@available(iOS 11.0, *)) {
        earnScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    
    UIImageView *earnTotalView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, kScreenWidth - 0, 180)];
    earnTotalView.image = [UIImage imageNamed:@"earn_pt.png"];
    [earnScrollView addSubview:earnTotalView];
    
    
    UILabel *earnTotalTTLab = [[UILabel alloc]initWithFrame:CGRectMake(30, 50, 150, 20)];
    earnTotalTTLab.text = @"可提现(元）";
    earnTotalTTLab.font = [UIFont systemFontOfSize:FontSize(12)];
    earnTotalTTLab.textColor = [UIColor whiteColor];
    [earnTotalView addSubview:earnTotalTTLab];
    
    UILabel *canWidthNumLab = [[UILabel alloc]initWithFrame:CGRectMake(30, 20, kScreenWidth - 150, 30)];
    canWidthNumLab.text = @"0.00";
    canWidthNumLab.font = [UIFont systemFontOfSize:FontSize(28)];
    canWidthNumLab.textColor = [UIColor whiteColor];
    //     canWidthNumLab.backgroundColor = [UIColor yellowColor];
    //    canWidthNumLab.adjustsFontSizeToFitWidth = YES;
    [earnTotalView addSubview:canWidthNumLab];
    //
    //    //设置格式
    //    canWidthNumLab.format = @"%.2f";
    //    //设置变化范围及动画时间
    
    
    
    UIButton *toWithdrawBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    toWithdrawBtn.frame = CGRectMake(kScreenWidth - 110, 25, 79, 28);
    
    CAGradientLayer *gradient12 = [CAGradientLayer layer];
    gradient12.frame = toWithdrawBtn.bounds;
    gradient12.colors = [NSArray arrayWithObjects:
                         (id)kUIColorFromRGB(0xFFFA96).CGColor,
                         (id)kUIColorFromRGB(0xF9C350).CGColor,
                         nil];
    gradient12.startPoint = CGPointMake(0.2, 0.2);
    gradient12.endPoint = CGPointMake(0.2, 0.8);
    gradient12.cornerRadius = 14;
    [toWithdrawBtn.layer addSublayer:gradient12];
    
    
    
    [toWithdrawBtn setTitle:@"立即提现" forState:0];
    [toWithdrawBtn setTitleColor:kUIColorFromRGB(0x8B3E0B) forState:0];
    toWithdrawBtn.titleLabel.font = [UIFont boldSystemFontOfSize:FontSize(12)];
    
    
    
    
    toWithdrawBtn.userInteractionEnabled = YES;
    earnTotalView.userInteractionEnabled = YES;
    [toWithdrawBtn addTarget:self action:@selector(clickToWithdrawButton:) forControlEvents:UIControlEventTouchUpInside];
    [earnTotalView addSubview:toWithdrawBtn];
    
    
    
    NSArray *ttArr = @[@"累计到账", @"已提现", @"未结算"];
    for (int i = 0; i < 3; i++) {
        UILabel *ttLab = [[UILabel alloc]initWithFrame:CGRectMake(30+(kScreenWidth - 64)/3.0*i, 125, (kScreenWidth - 64)/3.0, 20)];
        ttLab.text = ttArr[i];
        ttLab.font = [UIFont systemFontOfSize:FontSize(12)];
        ttLab.textColor = kUIColorFromRGB(0xFFFFFF);
        
        if (i == 0) {
            ttLab.textAlignment = NSTextAlignmentLeft;
        }
        else if (i == 1){
            ttLab.textAlignment = NSTextAlignmentCenter;
        }
        else if (i == 2){
            ttLab.textAlignment = NSTextAlignmentRight;
        }
        
        [earnTotalView addSubview:ttLab];
        
    }
    
    
    UILabel *ljdzNumLab = [[UILabel alloc]initWithFrame:CGRectMake(30, 98, (kScreenWidth - 64)/3.0, 25)];
    ljdzNumLab.font = [UIFont boldSystemFontOfSize:FontSize(17)];
    ljdzNumLab.textColor = kUIColorFromRGB(0xFFFFFF);
    ljdzNumLab.textAlignment = NSTextAlignmentLeft;
    ljdzNumLab.text = @"0.00";
    ljdzNumLab.adjustsFontSizeToFitWidth = YES;
    // ljdzNumLab.backgroundColor = [UIColor yellowColor];
    [earnTotalView addSubview:ljdzNumLab];
    
    UILabel *ytxNumLab = [[UILabel alloc]initWithFrame:CGRectMake(30+(kScreenWidth - 64)/3.0, 98, (kScreenWidth - 64)/3.0, 25)];
    ytxNumLab.font = [UIFont boldSystemFontOfSize:FontSize(17)];
    ytxNumLab.textColor = kUIColorFromRGB(0xFFFFFF);
    ytxNumLab.textAlignment = NSTextAlignmentCenter;
    ytxNumLab.text = @"0.00";
    ytxNumLab.adjustsFontSizeToFitWidth = YES;
    // ytxNumLab.backgroundColor = [UIColor blueColor];
    [earnTotalView addSubview:ytxNumLab];
    
    UILabel *wjsNumLab = [[UILabel alloc]initWithFrame:CGRectMake(30+(kScreenWidth - 64)/3.0*2, 98, (kScreenWidth - 64)/3.0, 25)];
    wjsNumLab.font = [UIFont boldSystemFontOfSize:FontSize(17)];
    wjsNumLab.textColor = kUIColorFromRGB(0xFFFFFF);
    wjsNumLab.textAlignment = NSTextAlignmentRight;
    wjsNumLab.text = @"0.00";
    wjsNumLab.adjustsFontSizeToFitWidth = YES;
    // wjsNumLab.backgroundColor = [UIColor yellowColor];
    [earnTotalView addSubview:wjsNumLab];
    
    
    //    [YJProgressHUD showCustomAnimation:@"加载中" withImgArry:nil inview:kWindow];
    
    
    //    [NetWorkManager  requestWithType:0 withUrlString:kURLWiteGetProfitViewInfo withParaments:nil withSuccessBlock:^(NSDictionary *responseObject) {
    //
    //        DMLog(@"其他平台收益 =  %@ %@",  responseObject, responseObject[@"msgstr"]);
    //        [YJProgressHUD hide];
    //
    //        NSString *result = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
    //
    //        if ([result isEqualToString:@"1"]) {
    //
    //
    //
    //            NSDictionary *dataDict = (NSDictionary*)responseObject[@"data"];
    //
    //            NSArray *cpsTypeListArr = (NSArray *)dataDict[@"cpsTypeList"];
    //            self.titleArr = [NSMutableArray array];
    //            self.cpsTypeArr = [NSMutableArray array];
    //            for (NSDictionary *dict in cpsTypeListArr) {
    //
    //
    //                [self.titleArr addObject:[NSString stringWithFormat:@"%@", dict[@"name"]]];
    //                [self.cpsTypeArr addObject:[NSString stringWithFormat:@"%@", dict[@"code"]]];
    //
    //            }
    //
    //
    //            if ([self.ptCountStyle isEqualToString:@"666"]) {
    
    
    //                ljdzNumLab.text = [NSString stringWithFormat:@"%@", self.bj_ptDict[@"zje"]];
    //                ytxNumLab.text =[NSString stringWithFormat:@"%@", self.bj_ptDict[@"ytx"]];
    //                wjsNumLab.text = [NSString stringWithFormat:@"%@", self.bj_ptDict[@"wjs"]];
    
    //                NSString *canWidthNumLabStr = [NSString stringWithFormat:@"%.2f", [[NSString stringWithFormat:@"%@", self.bj_ptDict[@"ktx"]] doubleValue]];
    //                [canWidthNumLab countFrom:0
    //                                       to:[canWidthNumLabStr floatValue]
    //                             withDuration:1.0f];
    
    //            }else{
    //
    //                ljdzNumLab.text = [NSString stringWithFormat:@"%.2f", [[NSString stringWithFormat:@"%@",dataDict[@"accumulatedAmt"]] doubleValue]];
    //                ytxNumLab.text = [NSString stringWithFormat:@"%.2f", [[NSString stringWithFormat:@"%@",dataDict[@"extractedAmt"]] doubleValue]];
    //                wjsNumLab.text = [NSString stringWithFormat:@"%.2f", [[NSString stringWithFormat:@"%@",dataDict[@"unsettledAmt"]] doubleValue]];
    
    //                NSString *canWidthNumLabStr = [NSString stringWithFormat:@"%.2f", [[NSString stringWithFormat:@"%@",dataDict[@"availableAmt"]] doubleValue]];
    //                [canWidthNumLab countFrom:0
    //                                       to:[canWidthNumLabStr floatValue]
    //                             withDuration:1.0f];
    
    //            }
    //
    //
    //
    //
    //
    //
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 180, kScreenWidth, kScreenHeight - 150)];
    contentView.backgroundColor=[UIColor redColor];
    [earnScrollView addSubview:contentView];
    
    [contentView addSubview:self.pageController.view];
    //
    //
    //        }
    //
    //    } withFailureBlock:^(NSError *error) {
    //        [YJProgressHUD hide];
    //    } progress:^(float progress) {
    //
    //    }];
}

- (void)clickBackButton{
    
    [self.navigationController popViewControllerAnimated:YES];
}




- (WMPageController *)pageController {
    if (!_pageController) {
        _pageController = [[WMPageController alloc] initWithViewControllerClasses:@[[EarnOneItemVC class],[EarnOneItemVC class],[EarnOneItemVC class]] andTheirTitles:@[@"tab1",@"tab2",@"tab3"]];
        
        _pageController.delegate = self;
        _pageController.dataSource = self;
    }
    return _pageController;
}



#pragma mark -----WMP
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    
    //WMPageController的menuViewStyle需要在控制器初始化之后（init之后 viewLoad之前）设置，如果在控制器的viewLoad中设置则会导致标题栏没有底部滑块的问题。
    pageController.menuViewStyle = WMMenuViewStyleLine;
    pageController.titleColorSelected = DMColor;
    pageController.titleSizeSelected = FontSize(15);
    pageController.titleSizeNormal = FontSize(15);
    pageController.titleColorNormal = textMinorColor33;
    
    NSMutableArray *withArr = [NSMutableArray array];
    NSMutableArray *itemWidthArr = [NSMutableArray array];
    
    for (int i = 0; i < self.titleArr.count; i++) {
        NSString *oneStr = [NSString stringWithFormat:@"%@", self.titleArr[i]];
        if (oneStr.length == 2) {
            [withArr addObject:@"28"];
            [itemWidthArr addObject:@"48"];
        }
        else if (oneStr.length == 3){
            [withArr addObject:@"42"];
            [itemWidthArr addObject:@"62"];
            
        }
        else if (oneStr.length == 4){
            [withArr addObject:@"56"];
            [itemWidthArr addObject:@"76"];
            
        }
        else{
            [withArr addObject:@"30"];
            [itemWidthArr addObject:@"50"];
            
            
        }
    }
    pageController.progressViewWidths = withArr;
    pageController.itemsWidths = itemWidthArr;
    
    return self.titleArr.count;
    
}


- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    
    return [NSString stringWithFormat:@"%@", self.titleArr[index]];
}


- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    
    EarnOneItemVC *earnOneVC = [[EarnOneItemVC alloc]init];
    
    earnOneVC.type = @"qt";
    earnOneVC.index = index;
    earnOneVC.cpsTypeStr = self.cpsTypeArr[index];
    
    return earnOneVC;
    
}



- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    
    
    CGFloat leftMargin = pageController.showOnNavigationBar ? 50 : 0;
    
    return CGRectMake(leftMargin, 0 , self.view.frame.size.width - 2*leftMargin, 40);
    
}


- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    
    return CGRectMake(0, 40 , self.view.frame.size.width, self.view.frame.size.height );
    
}


- (void)clickToWithdrawButton:(UIButton *)sender{
    
    //    WithdrawViewController *withdrawVC = [[WithdrawViewController alloc]init];
    //    withdrawVC.phoneNum = self.phoneNum;
    //    withdrawVC.markType = @"pt";
    //    if (withdrawVC) {
    //        [self.navigationController pushViewController:withdrawVC animated:YES];
    //    }
}


@end
