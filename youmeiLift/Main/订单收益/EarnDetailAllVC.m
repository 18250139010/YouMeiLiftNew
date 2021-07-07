//
//  EarnDetailAllVC.m
//  DaiMengJia
//
//  Created by 呆萌价 on 2019/9/23.
//  Copyright © 2019年 呆萌价. All rights reserved.
//

#import "EarnDetailAllVC.h"
#import "DMTool.h"
#import "Masonry.h"
#import "EarnDetailVC.h"
#import "EarnDetailQtVC.h"
#import <YJProgressHUD.h>
@interface EarnDetailAllVC ()

@property (copy, nonatomic) NSDictionary *bj_tbDict;
@property (copy, nonatomic) NSString *tbCountStyle;

@property (copy, nonatomic) NSDictionary *bj_ptDict;
@property (copy, nonatomic) NSString *ptCountStyle;

@property (copy, nonatomic) NSString *userType;

@end

@implementation EarnDetailAllVC

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
    
    
    NSData *tbData = [NSData dataWithContentsOfFile:DocumentPath(@"earnTB.plist")];
    if (tbData) {
        
        self.bj_tbDict = [NSJSONSerialization JSONObjectWithData:tbData options:NSJSONReadingMutableContainers error:nil];
        
        DMLog(@"自己编辑的淘宝平台收益 == %@", self.bj_tbDict);
        
        self.userType = self.bj_tbDict[@"userType"];
        self.tbCountStyle = @"666";
        
    }else{
        
        self.userType = [NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"usertype"]];
        
    }
    
    
    
    NSData *ptData = [NSData dataWithContentsOfFile:DocumentPath(@"earnPT.plist")];
    if (ptData) {
        
        self.bj_ptDict = [NSJSONSerialization JSONObjectWithData:ptData options:NSJSONReadingMutableContainers error:nil];
        
        DMLog(@"自己编辑的团队收益 == %@", self.bj_ptDict);
        
        self.userType = self.bj_ptDict[@"userType"];
        self.ptCountStyle = @"666";
        
    }else{
        
        self.userType = [NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"usertype"]];
        
    }
    
    

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
    
    UILabel *ttLab = [[UILabel alloc]initWithFrame:CGRectMake(0, iPhoneX?44:20, kScreenWidth, 44)];
    ttLab.text = @"我的收益";
    ttLab.textColor = textMinorColor33;
    ttLab.font = [UIFont systemFontOfSize:FontSize(18)];
    ttLab.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:ttLab];
    
    
    
    
//    [YJProgressHUD showCustomAnimation:@"加载中" withImgArry:nil inview:kWindow];
    
    
    NSMutableArray *ktMonArr = [NSMutableArray array];
    NSMutableArray *allMonArr = [NSMutableArray array];
   
//    [NetWorkManager  requestWithType:1 withUrlString:kURLWithGetProfitSum withParaments:nil withSuccessBlock:^(NSDictionary *responseObject) {

//        DMLog(@"获取我的收益数据 =  %@ %@",  responseObject, responseObject[@"msgstr"]);
//
//        NSString *result = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
//
//
//        if ([result isEqualToString:@"1"]) {
//
//            NSArray *dataArr = (NSArray *)responseObject[@"data"];



//            for (NSDictionary *dict in dataArr) {
//
//                [ktMonArr addObject:[NSString stringWithFormat:@"%@",dict[@"usercommission"]]];
//                [allMonArr addObject:[NSString stringWithFormat:@"%@",dict[@"accumulatedincome"]]];
//            }

            if ([self.tbCountStyle isEqualToString:@"666"]) {

                 [ktMonArr replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%@", self.bj_tbDict[@"ktx"]]];
                [allMonArr replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%@", self.bj_tbDict[@"zje"]]];
            }

            if ([self.ptCountStyle isEqualToString:@"666"]) {

                [ktMonArr replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%@", self.bj_ptDict[@"ktx"]]];
                [allMonArr replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%@", self.bj_ptDict[@"zje"]]];
            }


            NSArray *ttArr =  @[@"淘宝平台收益", @"其他平台收益"];
            NSArray *imgArr = @[[UIImage imageNamed:@"earn_tb.png"],
                                [UIImage imageNamed:@"earn_pt.png"]
                                ];

            for (int i = 0; i<ttArr.count; i++) {

                UIImageView *oneImgView = [[UIImageView alloc]initWithFrame:CGRectMake(6, (iPhoneX?88:64)+8+148*i, kScreenWidth - 12, 147)];
                oneImgView.image = imgArr[i];
                [self.view addSubview:oneImgView];

                UILabel *ttLab= [[UILabel alloc]init];
                ttLab.text = ttArr[i];
                ttLab.textColor = [UIColor whiteColor];
                ttLab.font = [UIFont boldSystemFontOfSize:FontSize(15)];
                [oneImgView addSubview:ttLab];

                [ttLab mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(oneImgView.mas_top).offset(23);
                    make.left.equalTo(oneImgView.mas_left).offset(30);
                    make.height.mas_equalTo(15);
                }];

                UILabel *earnMonLab= [[UILabel alloc]init];
                earnMonLab.text = @"0.00";
                earnMonLab.textColor = [UIColor whiteColor];
                earnMonLab.font = [UIFont boldSystemFontOfSize:FontSize(24)];
                earnMonLab.adjustsFontSizeToFitWidth = YES;
                [oneImgView addSubview:earnMonLab];

                [earnMonLab mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(oneImgView.mas_top).offset(55);
                    make.left.equalTo(oneImgView.mas_left).offset(30);
                    make.size.mas_equalTo(CGSizeMake((kScreenWidth - 12 - 60)/2.0, 35));
                }];

                UILabel *ktMonTTLab= [[UILabel alloc]init];
                ktMonTTLab.text = @"可提金额(元)";
                ktMonTTLab.textColor = [UIColor whiteColor];
                ktMonTTLab.font = [UIFont systemFontOfSize:FontSize(13)];
                [oneImgView addSubview:ktMonTTLab];

                [ktMonTTLab mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(oneImgView.mas_top).offset(98);
                    make.left.equalTo(oneImgView.mas_left).offset(30);
                    make.size.mas_equalTo(CGSizeMake((kScreenWidth - 12 - 60)/2.0, 13));
                }];


                UILabel *earnAllMonLab= [[UILabel alloc]init];
                earnAllMonLab.text = @"0.00";
                earnAllMonLab.textColor = [UIColor whiteColor];
                earnAllMonLab.font = [UIFont boldSystemFontOfSize:FontSize(24)];
                earnAllMonLab.adjustsFontSizeToFitWidth = YES;
                [oneImgView addSubview:earnAllMonLab];

                [earnAllMonLab mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(oneImgView.mas_top).offset(55);
                    make.left.equalTo(earnMonLab.mas_right).offset(0);
                    make.size.mas_equalTo(CGSizeMake((kScreenWidth - 12 - 60)/2.0, 35));
                }];

                UILabel *allMonTTLab= [[UILabel alloc]init];
                allMonTTLab.text = @"总金额(元)";
                allMonTTLab.textColor = [UIColor whiteColor];
                allMonTTLab.font = [UIFont systemFontOfSize:FontSize(13)];
                [oneImgView addSubview:allMonTTLab];

                [allMonTTLab mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(oneImgView.mas_top).offset(98);
                    make.left.equalTo(earnMonLab.mas_right).offset(0);
                    make.height.mas_equalTo(CGSizeMake((kScreenWidth - 12 - 60)/2.0, 13));
                }];



                UIButton *seeDetailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                [seeDetailBtn setTitle:@"查看详细" forState:0];
                seeDetailBtn.backgroundColor = [UIColor whiteColor];
                seeDetailBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(13)];
                seeDetailBtn.layer.masksToBounds = YES;
                seeDetailBtn.layer.cornerRadius = 12.0f;

                if (i == 0) {
                    [seeDetailBtn setTitleColor:kUIColorFromRGB(0xFB0528) forState:0];
                }else{
                    [seeDetailBtn setTitleColor:kUIColorFromRGB(0x1E57FF) forState:0];
                }
                seeDetailBtn.tag = 756 +i;
                [seeDetailBtn addTarget:self action:@selector(clickSeeDetailButton:) forControlEvents:UIControlEventTouchUpInside];
                seeDetailBtn.userInteractionEnabled = YES;
                oneImgView.userInteractionEnabled = YES;
                [oneImgView addSubview:seeDetailBtn];

                [seeDetailBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(oneImgView.mas_top).offset(18.5);
                    make.right.equalTo(oneImgView.mas_right).offset(-25);
                    make.size.mas_equalTo(CGSizeMake(71, 24));
                }];


            }


//        }


//        [YJProgressHUD hide];
//
//    } withFailureBlock:^(NSError *error) {
//        [YJProgressHUD hide];
//    } progress:^(float progress) {
//
//    }];
    
    
    
    
    
   
    
    
    

}

- (void)clickSeeDetailButton:(UIButton *)sender{
    
    
    DMLog(@"self.withdrawMoney == %@",self.withdrawMoney);
    
    if (sender.tag == 756) {
        
        
        EarnDetailVC *earnDetailVC = [[EarnDetailVC alloc]init];
        earnDetailVC.withdrawMoney = self.withdrawMoney;
        earnDetailVC.phoneNum = self.phoneNum;
        earnDetailVC.type = @"tb";
        if (earnDetailVC) {
            [self.navigationController pushViewController:earnDetailVC animated:YES];
        }
        
        
    }
    else if (sender.tag == 757){
        
        EarnDetailQtVC *earnDetailVC = [[EarnDetailQtVC alloc]init];
        earnDetailVC.withdrawMoney = self.withdrawMoney;
        earnDetailVC.phoneNum = self.phoneNum;
        earnDetailVC.type = @"qt";
        if (earnDetailVC) {
            [self.navigationController pushViewController:earnDetailVC animated:YES];
        }
    }
    
    
}



@end
