//
//  EarnOneItemVC.m
//  DaiMengJia
//
//  Created by 呆萌价 on 2018/5/11.
//  Copyright © 2018年 呆萌价. All rights reserved.
//

#import "EarnOneItemVC.h"
#import "DMTool.h"
#import "DMTextTool.h"
#import <Masonry.h>
#import "YMMyDetailViewController.h"
@interface EarnOneItemVC ()
@property (strong, nonatomic) UIView *btnView;
@property (copy, nonatomic) NSArray *dateDataArr;
@property (strong, nonatomic) UILabel *qtJssyLab;

@property (strong, nonatomic) UILabel *qtCountNumLab;
@property (strong, nonatomic) UILabel *qtIncomeNumLab;
@property (strong, nonatomic) UIView  *qtOneView;


@property (copy, nonatomic) NSDictionary *bj_tbDict;
@property (copy, nonatomic) NSString *tbCountStyle;

@property (copy, nonatomic) NSDictionary *bj_ptDict;
@property (copy, nonatomic) NSString *ptCountStyle;

@property (copy, nonatomic) NSString *userType;


@end

@implementation EarnOneItemVC

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.view.backgroundColor = allBackgroundColor;
    self.dateDataArr = [NSMutableArray array];
    
    if ([self.type isEqualToString:@"tb"]) {
        
        
        NSData *tbData = [NSData dataWithContentsOfFile:DocumentPath(@"earnTB.plist")];
        if (tbData) {
            
            self.bj_tbDict = [NSJSONSerialization JSONObjectWithData:tbData options:NSJSONReadingMutableContainers error:nil];
            
            DMLog(@"自己编辑的淘宝平台收益 == %@", self.bj_tbDict);
            
            self.userType = self.bj_tbDict[@"userType"];
            self.tbCountStyle = @"666";
            
        }else{
            
            self.userType = [NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"usertype"]];
            
        }
        
        
        UIView *allView = [[UIView alloc]initWithFrame:CGRectMake(12, 12, kScreenWidth - 24, 156)];
        allView.backgroundColor = [UIColor whiteColor];
        allView.layer.masksToBounds = YES;
        allView.layer.cornerRadius = 7.0f;
        [self.view addSubview:allView];
        
        //我的明细
        UIView *mxView=[[UIView alloc]init];
        mxView.backgroundColor=[UIColor whiteColor];
        mxView.layer.masksToBounds = YES;
        mxView.layer.cornerRadius = 7.0f;
        
        [self.view addSubview:mxView];
        [mxView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(allView.mas_bottom).offset(12);
            make.left.equalTo(self.view.mas_left).offset(12);
            make.right.equalTo(self.view.mas_right).offset(-12);
            make.height.mas_offset(54);
        }];
        UITapGestureRecognizer *oneTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickoneImgView:)];
        [mxView addGestureRecognizer:oneTap];
        
        UILabel *wdmxLab=[[UILabel alloc]init];
        wdmxLab.text=@"我的明细";
        wdmxLab.textColor=[UIColor blackColor];
        wdmxLab.textAlignment=NSTextAlignmentCenter;
        wdmxLab.font=[UIFont systemFontOfSize:FontSize(15)];
        [mxView addSubview:wdmxLab];
        [wdmxLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(mxView.mas_top).offset(19.5);
            make.left.equalTo(mxView.mas_left).offset(11);
            make.width.mas_offset(80);
        }];
        
        UIImageView *wdmxImg=[[UIImageView alloc]init];
        wdmxImg.image=[UIImage imageNamed:@"YM_T"];
        [mxView addSubview:wdmxImg];
        [wdmxImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(mxView.mas_top).offset(20.5);
            make.right.equalTo(mxView.mas_right).offset(-11);
            make.width.mas_offset(6);
            make.height.mas_offset(12);
        }];
        
        
        
        UILabel *jssyLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth - 24, 50)];
        
        NSString *jssyStr = [NSString string];
        
//        if ([self.tbCountStyle isEqualToString:@"666"]) {
//            jssyStr = [NSString stringWithFormat:@"结算收入：%.2f", [[NSString stringWithFormat:@"%@", self.bj_tbDict[@"jrjs"]] doubleValue]];
//        }else{
            jssyStr = [NSString stringWithFormat:@"结算收入：%.2f", [[NSString stringWithFormat:@"%@", self.bj_tbDict[@"jrjs"]] doubleValue]?[[NSString stringWithFormat:@"%@", self.bj_tbDict[@"jrjs"]] doubleValue]:0.00];
//        }
        
        
        jssyLab.textColor = textMinorColor33;
        jssyLab.font = [UIFont systemFontOfSize:FontSize(15)];
        jssyLab.attributedText = [DMTextTool dm_changeBoldFont:FontSize(18) color:kUIColorFromRGB(0xFC2628) range:NSMakeRange(5, jssyStr.length - 5) str:jssyStr];
        jssyLab.textAlignment = NSTextAlignmentCenter;
     
        [allView addSubview:jssyLab];
        
        
        
        NSArray *ttArr = @[@"我的推广"];
        
        NSArray *countArr = [NSArray array];
        NSArray *moneyArr = [NSArray array];
        
//        if ([self.tbCountStyle isEqualToString:@"666"]) {
            
            countArr = @[
                          [NSString stringWithFormat:@"%@", self.bj_tbDict[@"wdtgbs"]],
                          [NSString stringWithFormat:@"%@", self.bj_tbDict[@"tdtgbs"]],
                         ];
            
            moneyArr = @[
                         [NSString stringWithFormat:@"%@", self.bj_tbDict[@"wdtgyg"]],
                         [NSString stringWithFormat:@"%@", self.bj_tbDict[@"tdtgyg"]],
                         
                         ];
            
//        }else{
//
//          countArr = @[[NSString stringWithFormat:@"%@", self.statisticalData.myturnovercount ],
//                                  [NSString stringWithFormat:@"%@", self.statisticalData.teamturnovercount ],
//                                  ];
//          moneyArr = @[[NSString stringWithFormat:@"%.2f", [self.statisticalData.myturnoverincome doubleValue]?[self.statisticalData.myturnoverincome doubleValue]:0.00],
//                                  [NSString stringWithFormat:@"%.2f", [self.statisticalData.teamturnoverincome doubleValue]?[self.statisticalData.teamturnoverincome doubleValue]:0.00],
//                                  ];
//
//        }
        
        
       
        
        
        for (int i = 0; i < 1; i ++) {
            
            
            UIView *oneView = [[UIView alloc]initWithFrame:CGRectMake(0, 50 +105*i, kScreenWidth - 24, 105)];
            oneView.backgroundColor = [UIColor whiteColor];
            [allView addSubview:oneView];
            
            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth - 24, 1)];
            lineView.backgroundColor = kUIColorFromRGB(0xEEEEEE);
            [oneView addSubview:lineView];
            
            UILabel *ttLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 15, 100, 20)];
            ttLab.text = ttArr[i];
            ttLab.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:FontSize(14)];
            ttLab.textColor = textMinorColor33;
            [oneView addSubview:ttLab];
            
            UILabel *countTTLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 40, (kScreenWidth - 24)/2.0, 20)];
            countTTLab.text = @"付款笔数(笔)";
            countTTLab.font = [UIFont systemFontOfSize:FontSize(12)];
            countTTLab.textColor = textMinorColor99;
            countTTLab.textAlignment = NSTextAlignmentLeft;
            [oneView addSubview:countTTLab];
            
            UILabel *countNumLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 65, (kScreenWidth - 24)/2.0, 20)];
            countNumLab.text = @"0";
            countNumLab.font = [UIFont boldSystemFontOfSize:FontSize(18)];
            countNumLab.textColor = textMinorColor33;
            countNumLab.textAlignment = NSTextAlignmentLeft;
            [oneView addSubview:countNumLab];
            
            UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth - 24)/2.0, 45, 1, 36)];
            lineView2.backgroundColor = kUIColorFromRGB(0xEEEEEE);
            [oneView addSubview:lineView2];
            
            UILabel *incomeTTLab = [[UILabel alloc]initWithFrame:CGRectMake(20 + (kScreenWidth - 24)/2.0, 40, (kScreenWidth - 60)/2.0, 20)];
            incomeTTLab.text = @"预估收入";
            incomeTTLab.font = [UIFont systemFontOfSize:FontSize(13)];
            incomeTTLab.textColor = textMinorColor99;
            incomeTTLab.textAlignment = NSTextAlignmentLeft;
            [oneView addSubview:incomeTTLab];
            
            UILabel *incomeNumLab = [[UILabel alloc]initWithFrame:CGRectMake(20 + (kScreenWidth - 24)/2.0, 65, (kScreenWidth - 60)/2.0, 20)];
//            NSString *incomeNumStr = moneyArr[i];
            incomeNumLab.font = [UIFont boldSystemFontOfSize:FontSize(18)];
            incomeNumLab.textColor = textMinorColor33;
            incomeNumLab.text = @"0.00";
           
            incomeNumLab.textAlignment = NSTextAlignmentLeft;
            [oneView addSubview:incomeNumLab];
            
        }
        
        
        
        
        
    }
    
   
    else{
        
        DMLog(@"index == %ld", (long)self.index);
        
        NSData *ptData = [NSData dataWithContentsOfFile:DocumentPath(@"earnPT.plist")];
        if (ptData) {
            
            self.bj_ptDict = [NSJSONSerialization JSONObjectWithData:ptData options:NSJSONReadingMutableContainers error:nil];
            
            DMLog(@"自己编辑的团队收益 == %@", self.bj_ptDict);
            
            self.userType = self.bj_ptDict[@"userType"];
            self.ptCountStyle = @"666";
            
        }else{
            
            self.userType = [NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"usertype"]];
            
        }
        
        
        
        NSArray *btnTTArr = @[@"今日", @"昨日", @"近7日", @"本月", @"上月"];
        
        self.btnView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 48)];
        _btnView.backgroundColor = allBackgroundColor;
        [self.view addSubview:_btnView];
        
        for (int i = 0; i < 5; i++) {
            
            UIButton *dateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            dateBtn.frame = CGRectMake(12+(12+(kScreenWidth -24 - 48)/5.0)*i, 12, (kScreenWidth -24 - 48)/5.0, 24);
            [dateBtn setTitle:btnTTArr[i] forState:0];
            [dateBtn setTitleColor:textMinorColor forState:0];
            dateBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(13)];
            dateBtn.backgroundColor = [UIColor whiteColor];
            dateBtn.layer.masksToBounds = YES;
            dateBtn.layer.cornerRadius = 12.0f;
            dateBtn.layer.borderColor = kUIColorFromRGB(0xDDDDDD).CGColor;
            dateBtn.layer.borderWidth = 0.5f;
            [dateBtn addTarget:self action:@selector(clcikDateButton:) forControlEvents:UIControlEventTouchUpInside];
            [_btnView addSubview:dateBtn];
            
            if (i == 0) {
                dateBtn.layer.borderColor = DMColor.CGColor;
                [dateBtn setTitleColor:DMColor forState:0];
            }
            
            
        }
        
        
        
        
       
        
//        NSDictionary *urlDic = @{
//                                  @"cpsType":self.cpsTypeStr,
//                                 };
        
//        [NetWorkManager  requestWithType:0 withUrlString:kURLWiteGetProfitCpsInfo withParaments:urlDic withSuccessBlock:^(NSDictionary *responseObject) {
//            
//            DMLog(@"单个其他平台收益 =  %@ %@",  responseObject, responseObject[@"msgstr"]);
//            [YJProgressHUD hide];
//            
//            NSString *result = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
//            
//            if ([result isEqualToString:@"1"]) {
//                NSString *code = [NSString stringWithFormat:@"%@", responseObject[@"code"]];
//             //  ifc_buf
//                if ([code isEqualToString:@"200"]) {
//                    self.dateDataArr = (NSArray *)responseObject[@"data"];
//                    
//                    [self setUpQtOneViewWithDict:self.dateDataArr[0]];
//                    
//                }
//                
//               //
//                
//            }
//            
//        } withFailureBlock:^(NSError *error) {
//            [YJProgressHUD hide];
//        } progress:^(float progress) {
//            
//        }];
        
        
        
        
        
        
        
        
        
    }
    
}


- (void)setUpQtOneViewWithDict:(NSDictionary *)dict{
    
    self.qtOneView = [[UIView alloc]initWithFrame:CGRectMake(12, 12+40, kScreenWidth - 24, 260)];
    _qtOneView.backgroundColor = [UIColor whiteColor];
    _qtOneView.layer.masksToBounds = YES;
    _qtOneView.layer.cornerRadius = 7.0f;
    [self.view addSubview:_qtOneView];
    
    NSDictionary *settledDict = (NSDictionary *)dict[@"settled"];
    
    self.qtJssyLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth - 24, 50)];
    
    NSString *jssyStr = [NSString string];
 
//    if ([self.ptCountStyle isEqualToString:@"666"]) {
        jssyStr = [NSString stringWithFormat:@"结算收入：0.00"];
//    }else{
//        jssyStr = [NSString stringWithFormat:@"结算收入：%.2f", [[NSString stringWithFormat:@"%@", settledDict[@"mny"]] doubleValue]];
//    }
    
    _qtJssyLab.textColor = textMinorColor33;
    _qtJssyLab.font = [UIFont systemFontOfSize:FontSize(15)];
    _qtJssyLab.attributedText = [DMTextTool dm_changeBoldFont:FontSize(18) color:kUIColorFromRGB(0xFC2628) range:NSMakeRange(5, jssyStr.length - 5) str:jssyStr];
    _qtJssyLab.textAlignment = NSTextAlignmentCenter;

    [_qtOneView addSubview:_qtJssyLab];
    
    NSDictionary *selfDict = (NSDictionary *)dict[@"self"];
    NSDictionary *teamDict = (NSDictionary *)dict[@"team"];
    
    NSArray *ttArr = @[@"我的推广"];
    
    NSArray *countArr = [NSArray array];
    NSArray *moneyArr = [NSArray array];
    
//    if ([self.ptCountStyle isEqualToString:@"666"]) {
        
        countArr = @[
                     [NSString stringWithFormat:@"%@", self.bj_ptDict[@"wdtgbs"]],
                     [NSString stringWithFormat:@"%@", self.bj_ptDict[@"tdtgbs"]],
                     ];
        
        moneyArr = @[
                     [NSString stringWithFormat:@"%@", self.bj_ptDict[@"wdtgyg"]],
                     [NSString stringWithFormat:@"%@", self.bj_ptDict[@"tdtgyg"]],
                     
                     ];
        
//    }else{
//
//        countArr = @[[NSString stringWithFormat:@"%@", selfDict[@"cnt"]],
//                              [NSString stringWithFormat:@"%@", teamDict[@"cnt"]],
//                              ];
//        moneyArr = @[
//                              [NSString stringWithFormat:@"%.2f", [[NSString stringWithFormat:@"%@", selfDict[@"mny"]] doubleValue]],
//                              [NSString stringWithFormat:@"%.2f", [[NSString stringWithFormat:@"%@", teamDict[@"mny"]] doubleValue]],
//                              ];
//
//
//    }
    
    
   
    
    
    
    
    for (int i = 0; i < 1; i ++) {
        
        
        UIView *oneView = [[UIView alloc]initWithFrame:CGRectMake(0, 50 +105*i, kScreenWidth - 24, 105)];
        oneView.backgroundColor = [UIColor whiteColor];
        [_qtOneView addSubview:oneView];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth - 24, 1)];
        lineView.backgroundColor = kUIColorFromRGB(0xEEEEEE);
        [oneView addSubview:lineView];
        
        UILabel *ttLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 15, 100, 20)];
        ttLab.text = ttArr[i];
        ttLab.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:FontSize(14)];
        ttLab.textColor = textMinorColor33;
        [oneView addSubview:ttLab];
        
        UILabel *countTTLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 40, (kScreenWidth - 24)/2.0, 20)];
        countTTLab.text = @"付款笔数(笔)";
        countTTLab.font = [UIFont systemFontOfSize:FontSize(12)];
        countTTLab.textColor = textMinorColor99;
        countTTLab.textAlignment = NSTextAlignmentLeft;
        [oneView addSubview:countTTLab];
        
        self.qtCountNumLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 65, (kScreenWidth - 24)/2.0, 20)];
        _qtCountNumLab.text = @"0.00";
        _qtCountNumLab.font = [UIFont boldSystemFontOfSize:FontSize(18)];
        _qtCountNumLab.textColor = textMinorColor33;
        _qtCountNumLab.textAlignment = NSTextAlignmentLeft;
        _qtCountNumLab.tag = 8997+i;
        [oneView addSubview:_qtCountNumLab];
        
        UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth - 24)/2.0, 45, 1, 36)];
        lineView2.backgroundColor = kUIColorFromRGB(0xEEEEEE);
        [oneView addSubview:lineView2];
        
        UILabel *incomeTTLab = [[UILabel alloc]initWithFrame:CGRectMake(20 + (kScreenWidth - 24)/2.0, 40, (kScreenWidth - 60)/2.0, 20)];
        incomeTTLab.text = @"预估收入";
        incomeTTLab.font = [UIFont systemFontOfSize:FontSize(13)];
        incomeTTLab.textColor = textMinorColor99;
        incomeTTLab.textAlignment = NSTextAlignmentLeft;
        [oneView addSubview:incomeTTLab];
        
        self.qtIncomeNumLab = [[UILabel alloc]initWithFrame:CGRectMake(20 + (kScreenWidth - 24)/2.0, 65, (kScreenWidth - 60)/2.0, 20)];
        NSString *incomeNumStr = @"0.00";
        _qtIncomeNumLab.font = [UIFont boldSystemFontOfSize:FontSize(18)];
        _qtIncomeNumLab.textColor = textMinorColor33;
        _qtIncomeNumLab.text = incomeNumStr;
    
        _qtIncomeNumLab.textAlignment = NSTextAlignmentLeft;
        _qtIncomeNumLab.tag = 7997+i;
        [oneView addSubview:_qtIncomeNumLab];
        
    }
}


- (void)changeCountWithDict:(NSDictionary *)dict{
     NSDictionary *settledDict = (NSDictionary *)dict[@"settled"];
    NSString *jssyStr = [NSString stringWithFormat:@"结算收入：%.2f", [[NSString stringWithFormat:@"%@", settledDict[@"mny"]] doubleValue]];
    _qtJssyLab.attributedText = [DMTextTool dm_changeBoldFont:FontSize(18) color:kUIColorFromRGB(0xFC2628) range:NSMakeRange(5, jssyStr.length - 5) str:jssyStr];
    _qtJssyLab.textAlignment = NSTextAlignmentCenter;
    
    NSDictionary *selfDict = (NSDictionary *)dict[@"self"];
    NSDictionary *teamDict = (NSDictionary *)dict[@"team"];
    NSArray *countArr = @[[NSString stringWithFormat:@"%@", selfDict[@"cnt"]],
                          [NSString stringWithFormat:@"%@", teamDict[@"cnt"]],
                          ];
    
    NSArray *moneyArr = @[
                          [NSString stringWithFormat:@"%.2f", [[NSString stringWithFormat:@"%@", selfDict[@"mny"]] doubleValue]],
                          [NSString stringWithFormat:@"%.2f", [[NSString stringWithFormat:@"%@", teamDict[@"mny"]] doubleValue]],
                          ];
    
    DMLog(@"countArr = %@  %@", countArr, moneyArr);
    
    
    
    for (id view in self.qtOneView.subviews) {
        if ([view isKindOfClass:[UIView class]]) {
            UIView *oneView = (UIView *)view;
            
            for (id view in oneView.subviews) {
                
                if ([view isKindOfClass:[UILabel class]]) {
                    
                    UILabel *ttLab = (UILabel *)view;
                    
                    DMLog(@"ttLab == %@", ttLab);
                    
                    
                    if (ttLab.tag == 8997) {
                         ttLab.text = countArr[0];
                    }
                    if (ttLab.tag == 8998) {
                        ttLab.text = countArr[1];
                    }
                    if (ttLab.tag == 7997) {
                        ttLab.text = moneyArr[0];
                    }
                    if (ttLab.tag == 7998) {
                        ttLab.text = moneyArr[1];
                    }
                }
                
            }
            
            
        }
        
        
    }
    
    
}

- (void)clcikDateButton:(UIButton *)btn{
    
    for (id view in self.btnView.subviews) {
        
        if ([view isKindOfClass:[UIButton class]]) {
            
            UIButton *oneBtn = (UIButton *)view;
            oneBtn.layer.borderColor = kUIColorFromRGB(0xDDDDDD).CGColor;
            [oneBtn setTitleColor:textMinorColor forState:0];
            
           
        }
        
    }
    

        btn.layer.borderColor = DMColor.CGColor;
        [btn setTitleColor:DMColor forState:0];
    
    if ([btn.titleLabel.text isEqualToString:@"今日"]) {
        
        if (self.dateDataArr.count>0) {
             [self changeCountWithDict:self.dateDataArr[0]];
        }
       
    }
    else if ([btn.titleLabel.text isEqualToString:@"昨日"]) {
        
        if (self.dateDataArr.count>1) {
             [self changeCountWithDict:self.dateDataArr[1]];
        }
    }
    else if ([btn.titleLabel.text isEqualToString:@"近7日"]) {
        
       if (self.dateDataArr.count>2) {
             [self changeCountWithDict:self.dateDataArr[2]];
        }
    }
    else if ([btn.titleLabel.text isEqualToString:@"本月"]) {
        
        if (self.dateDataArr.count>3) {
             [self changeCountWithDict:self.dateDataArr[3]];
        }
    }
    else if ([btn.titleLabel.text isEqualToString:@"上月"]) {
        
        if (self.dateDataArr.count>4) {
             [self changeCountWithDict:self.dateDataArr[4]];
        }
    }
    
}
-(void)clickoneImgView:(UIGestureRecognizer *)sender{
    YMMyDetailViewController *MyDetailVC=[[YMMyDetailViewController alloc]init];
    
    [self.nav pushViewController:MyDetailVC animated:YES];
}


@end
