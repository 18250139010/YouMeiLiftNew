//
//  DailyRedPacketWithdrawVC.m
//  DaiMengJia
//
//  Created by 呆萌价 on 2021/3/24.
//  Copyright © 2021 呆萌价. All rights reserved.
//

#import "DailyRedPacketWithdrawVC.h"
#import "DMTool.h"
#import "Masonry.h"
#import "DMTextTool.h"
//#import "ChangeZfbVC.h"
#import "NetWorkManager.h"
#import <YJProgressHUD.h>
#import "YXAlertView.h"
#import "DailyRedPacketWithdrawListVC.h"
@interface DailyRedPacketWithdrawVC ()<UIScrollViewDelegate>
@property (strong, nonatomic) UILabel *ktMonLab;
@property (strong, nonatomic) UILabel *withdrawTipTextLab;
@property (strong, nonatomic) UIView *zfbView;
@property (strong, nonatomic) UIView *withdrawMonView;
@property (strong, nonatomic) UIButton *withdrawBtn;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIView *withdrawTipView;


@end

@implementation DailyRedPacketWithdrawVC
{
    UILabel *zfbNumLab;
    UILabel *zfbNameLab;
    NSString *ktMonStr;
    NSString *withdrawMonStr;
    BOOL haveZfb;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
    [NetWorkManager  requestWithType:1 withUrlString:kURLWithGetRedPackageWithdrawalsInfo withParaments:nil withSuccessBlock:^(NSDictionary *responseObject) {
        
        DMLog(@"红包 提现详情  =  %@  %@",  responseObject, responseObject[@"msgstr"]);
        
        
        NSString *result = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
    if ([result isEqualToString:@"1"]) {
            NSDictionary *dataDict = (NSDictionary *)responseObject[@"data"];
   _ktMonLab.text = [NSString stringWithFormat:@"¥%@", dataDict[@"amount"]];
   ktMonStr = [NSString stringWithFormat:@"%@", dataDict[@"amount"]];
   _withdrawTipTextLab.attributedText = [DMTextTool dm_changeLineSpace:3 str:[NSString stringWithFormat:@"%@", dataDict[@"detail"]]];
            
            
            
            NSString *alipayacount = [NSString stringWithFormat:@"%@", dataDict[@"alipayacount"]];
            NSString *alipayname = [NSString stringWithFormat:@"%@", dataDict[@"alipayname"]];
            
            if (alipayacount.length == 0 || [alipayacount isEqualToString:@""]) {
                //未绑定
                [_zfbView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
                
                UIImageView *zfbMarkImgView = [[UIImageView alloc]init];
                zfbMarkImgView.image = [UIImage imageNamed:@"YM_zfb"];
                [_zfbView addSubview:zfbMarkImgView];
                
                [zfbMarkImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(_zfbView.mas_top).offset(15);
                    make.left.equalTo(_zfbView.mas_left).offset(13);
                    make.size.mas_equalTo(CGSizeMake(19, 19));
                }];
                
                UILabel *tipLab = [[UILabel alloc]init];
                NSString *tipStr = @"支付宝（预计3个工作日到账）";
                tipLab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:FontSize(10)];
                tipLab.textColor = kUIColorFromRGB(0xA5A5A5);
                tipLab.attributedText = [DMTextTool dm_changeFont:FontSize(13) color:textMinorColor33 range:NSMakeRange(0, 3) str:tipStr];
                [_zfbView addSubview:tipLab];
                
                [tipLab mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(_zfbView.mas_top).offset(15);
                    make.left.equalTo(_zfbView.mas_left).offset(43);
                    make.height.mas_equalTo(19);
                }];
                
                UIImageView *toImgView = [[UIImageView alloc]init];
                toImgView.image = [UIImage imageNamed:@"YM_jiantou"];
                [_zfbView addSubview:toImgView];
                
                [toImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(_zfbView.mas_top).offset(18);
                    make.right.equalTo(_zfbView.mas_right).offset(-12);
                    make.size.mas_equalTo(CGSizeMake(7, 13));
                }];
                
                UIButton *addAccountNumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                [addAccountNumBtn setTitle:@"未绑定     " forState:0];
                [addAccountNumBtn setTitleColor:kUIColorFromRGB(0xA5A5A5) forState:0];
                addAccountNumBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(12)];
                [addAccountNumBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
                
                [addAccountNumBtn addTarget:self action:@selector(chlickAddAccountNumBtnOnZfbView:) forControlEvents:UIControlEventTouchUpInside];
                [_zfbView addSubview:addAccountNumBtn];
                
                [addAccountNumBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(_zfbView.mas_top).offset(9.5);
                    make.right.equalTo(_zfbView.mas_right).offset(-12);
                    make.height.mas_equalTo(30);
                    //  make.size.mas_equalTo(CGSizeMake(50, 50));
                }];
                haveZfb = NO;
            }
            else{
                haveZfb = YES;
                [_zfbView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
                
                [_zfbView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_equalTo(CGSizeMake(kScreenWidth-20, 90));
                }];
                
                UIButton *changeZfbBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                [changeZfbBtn setTitle:@"修改" forState:0];
                [changeZfbBtn setTitleColor:textMinorColor99 forState:0];
                changeZfbBtn.layer.masksToBounds = YES;
                changeZfbBtn.layer.cornerRadius = 12.0f;
                changeZfbBtn.layer.borderColor = kUIColorFromRGB(0xB8B6B6).CGColor;
                changeZfbBtn.layer.borderWidth = 0.8f;
                changeZfbBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(12)];
                [changeZfbBtn addTarget:self action:@selector(clickChangeZfbButton:) forControlEvents:UIControlEventTouchUpInside];
                [_zfbView addSubview:changeZfbBtn];
                
                [changeZfbBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.top.equalTo(_zfbView.mas_top).offset(11);
                    make.right.equalTo(self.view.mas_right).offset(-27);
                    make.size.mas_equalTo(CGSizeMake(50, 24));
                    
                }];
                
                zfbNumLab = [[UILabel alloc]init];
                zfbNumLab.textColor = textMinorColor33;
                zfbNumLab.font = [UIFont systemFontOfSize:FontSize(15)];
                zfbNumLab.text = @"到支付宝";
                [_zfbView addSubview:zfbNumLab];
                
                [zfbNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.top.equalTo(_zfbView.mas_top).offset(11);
                    make.left.equalTo(_zfbView.mas_left).offset(10);
                    make.right.equalTo(changeZfbBtn.mas_left).offset(-5);
                    make.height.mas_equalTo( 24);
                    
                }];
                
                
                UIView *lineView = [[UIView alloc]init];
                lineView.backgroundColor = kUIColorFromRGB(0xF6F6F6);
                [_zfbView addSubview:lineView];
                
                [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.top.equalTo(zfbNumLab.mas_bottom).offset(10);
                    make.left.equalTo(_zfbView.mas_left).offset(0);
                    make.right.equalTo(_zfbView.mas_right).offset(0);
                    make.height.mas_equalTo( 1);
                    
                }];
                
                zfbNameLab = [[UILabel alloc]init];
                zfbNameLab.textColor = textMinorColor33;
                zfbNameLab.font = [UIFont systemFontOfSize:FontSize(15)];
                zfbNameLab.text = @"真实姓名";
                [_zfbView addSubview:zfbNameLab];
                
                [zfbNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.top.equalTo(lineView.mas_bottom).offset(10.5);
                    make.left.equalTo(_zfbView.mas_left).offset(10);
                    make.right.equalTo(_zfbView.mas_right).offset(-10);
                    make.height.mas_equalTo( 24);
                    
                }];
                
                
                NSMutableString *zfbNum = [NSMutableString string];
                zfbNum = [NSMutableString stringWithFormat:@"%@", alipayacount];
                NSString *phone = @"^((11[0-9])|(12[0-9])|(13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\\d{8}$";
                NSPredicate *phonePre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phone];
                
                if ([phonePre evaluateWithObject:zfbNum]) {
                    [zfbNum replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
                }
                
                NSString *zfbNumStr = [NSString stringWithFormat:@"到支付宝      %@", zfbNum];
                zfbNumLab.attributedText = [DMTextTool dm_changeFont:FontSize(12)  range:NSMakeRange(4, zfbNumStr.length - 4) str:zfbNumStr];
                
                
                
                
                NSString *alipaynameStr = [NSString string];
                alipaynameStr = [NSString stringWithFormat:@"%@", alipayname];
                
                NSString *alipaynameStr2 = [NSString string];
                NSString *zfbNameStr = [NSString string];
                if (alipaynameStr.length > 1) {
                    
                    for (int i = 0; i<alipaynameStr.length - 1; i++) {
                        
                        alipaynameStr2 =  [alipaynameStr2 stringByAppendingString:@"*"];
                    }
                    
                    NSString *twoNewString = [alipaynameStr stringByReplacingCharactersInRange:NSMakeRange(1,alipaynameStr.length-1) withString:alipaynameStr2];
                    
                    zfbNameStr = [NSString stringWithFormat:@"真实姓名      %@", twoNewString];
                }
                else{
                    
                    zfbNameStr = [NSString stringWithFormat:@"真实姓名      %@", alipaynameStr];
                }
                
                
                zfbNameLab.attributedText = [DMTextTool dm_changeFont:FontSize(12)  range:NSMakeRange(4, zfbNameStr.length - 4) str:zfbNameStr];
                
                
                
            }
            [self.scrollView layoutIfNeeded];
            
            DMLog(@"yyyy----%f  hhhhh----%f", _withdrawTipView.frame.origin.y, _withdrawTipTextLab.frame.size.height);
            _scrollView.contentSize = CGSizeMake(kScreenWidth, _withdrawTipView.frame.origin.y+_withdrawTipTextLab.frame.size.height+90);
            
        }
        [YJProgressHUD hide];
    } withFailureBlock:^(NSError *error) {
        [YJProgressHUD hide];
    } progress:^(float progress) {
        
    }];
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
    
    haveZfb = NO;
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
    jifenLab.text=@"提现中心";
    jifenLab.textAlignment=NSTextAlignmentCenter;
    jifenLab.textColor=[UIColor blackColor];
    jifenLab.font=[UIFont systemFontOfSize:FontSize(18)];
    [headerView addSubview:jifenLab];
    
    
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0+(iPhoneX?88:64), kScreenWidth, kScreenHeight -(0+(iPhoneX?88:64)) -(0+(iPhoneX?34:0)+23) )];
    _scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight);
    _scrollView.delegate = self;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    
    if (@available(iOS 11.0, *)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    
    UIView *monView = [[UIView alloc]init];
    monView.backgroundColor = [UIColor whiteColor];
    monView.layer.masksToBounds = YES;
    monView.layer.cornerRadius = 8;
    [_scrollView addSubview:monView];
    
    [monView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_scrollView.mas_top).offset(0);
        make.left.equalTo(_scrollView.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth-20, 80));
    }];
    
    
    UILabel *ktTTLab = [[UILabel alloc]init];
    ktTTLab.text = @"可提现金额（元）";
    ktTTLab.font = [UIFont fontWithName:@"PingFangSC-Regular" size:FontSize(14)];
    ktTTLab.textColor = textMinorColor;
    // ktTTLab.backgroundColor = allBackgroundColor;
    [monView addSubview:ktTTLab];
    
    [ktTTLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(monView.mas_top).offset(15);
        make.left.equalTo(monView.mas_left).offset(20);
    }];
    
    self.ktMonLab = [[UILabel alloc]init];
    
    _ktMonLab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:FontSize(22)];
    _ktMonLab.textColor = textMinorColor33;
    //  _ktMonLab.backgroundColor = allBackgroundColor;
    [monView addSubview:_ktMonLab];
    
    [_ktMonLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ktTTLab.mas_bottom).offset(3);
        make.left.equalTo(monView.mas_left).offset(20);
    }];
    
    UIButton *withdrawListBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [withdrawListBtn setTitle:@"提现记录" forState:0];
    [withdrawListBtn setTitleColor:kUIColorFromRGB(0x343434) forState:0];
    withdrawListBtn.layer.masksToBounds = YES;
    withdrawListBtn.layer.cornerRadius = 13;
    withdrawListBtn.layer.borderColor = kUIColorFromRGB(0x333333).CGColor;
    withdrawListBtn.layer.borderWidth = 0.5;
    withdrawListBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
    [monView addSubview:withdrawListBtn];
    
    [withdrawListBtn addTarget:self action:@selector(clickwithdrawListButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [withdrawListBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(monView.mas_top).offset(15);
        make.right.equalTo(monView.mas_right).offset(-10);
        make.size.mas_equalTo(CGSizeMake(78, 26));
    }];
    
    self.zfbView = [[UIView alloc]init];
    _zfbView.backgroundColor = [UIColor whiteColor];
    _zfbView.layer.masksToBounds = YES;
    _zfbView.layer.cornerRadius = 8;
    [_scrollView addSubview:_zfbView];
    
    
    [_zfbView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(monView.mas_bottom).offset(10);
        make.left.equalTo(_scrollView.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth-20, 45));
    }];
    
    
    
    
    self.withdrawMonView = [[UIView alloc]init];
    _withdrawMonView.backgroundColor = [UIColor whiteColor];
    _withdrawMonView.layer.masksToBounds = YES;
    _withdrawMonView.layer.cornerRadius = 8;
    [_scrollView addSubview:_withdrawMonView];
    
    [_withdrawMonView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_zfbView.mas_bottom).offset(10);
        make.left.equalTo(_scrollView.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth-20, 228));
    }];
    
    
    UILabel *withdrawTTLab = [[UILabel alloc]init];
    withdrawTTLab.text = @"提现金额";
    withdrawTTLab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:FontSize(15)];
    withdrawTTLab.textColor = textMinorColor33;
    [_withdrawMonView addSubview:withdrawTTLab];
    
    [withdrawTTLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_withdrawMonView.mas_top).offset(12);
        make.left.equalTo(_withdrawMonView.mas_left).offset(15);
    }];
    
    
    NSArray *monArr = @[@"0.5元", @"15元", @"30元", @"50元", @"100元", @"200元"];
    
    for (int i = 0; i<6; i++) {
        
        UIImageView *oneImgView = [[UIImageView alloc]initWithFrame:CGRectMake(6 +((kScreenWidth - 34)/2.0 +2)*(i%2), 44+(56+2)*(i/2), (kScreenWidth - 34)/2.0, 56)];
        [_withdrawMonView addSubview:oneImgView];
        oneImgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickOneImgView:)];
        oneImgView.tag = i;
        [oneImgView addGestureRecognizer:tap];
        
        
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(4, 4, (kScreenWidth - 34)/2.0-8, 48)];
        label.backgroundColor = kUIColorFromRGB(0xF6F6F6);
        label.layer.masksToBounds = YES;
        label.layer.cornerRadius = 8;
        label.layer.borderColor = kUIColorFromRGB(0xEDEDED).CGColor;
        label.layer.borderWidth = 1;
        label.text = monArr[i];
        label.textColor = textMinorColor33;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:FontSize(15)];
        [oneImgView addSubview:label];
        
        
        
    }
    
    
    self.withdrawTipView = [[UIView alloc]init];
    _withdrawTipView.backgroundColor = [UIColor whiteColor];
    _withdrawTipView.layer.masksToBounds = YES;
    _withdrawTipView.layer.cornerRadius = 8;
    [_scrollView addSubview:_withdrawTipView];
    
    [_withdrawTipView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_withdrawMonView.mas_bottom).offset(10);
        make.left.equalTo(_scrollView.mas_left).offset(10);
        make.width.mas_equalTo(kScreenWidth-20);
    }];
    
    UILabel *withdrawTipLab = [[UILabel alloc]init];
    withdrawTipLab.text = @"提现说明";
    withdrawTipLab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:FontSize(15)];
    withdrawTipLab.textColor = textMinorColor33;
    [_withdrawTipView addSubview:withdrawTipLab];
    
    [withdrawTipLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_withdrawTipView.mas_top).offset(12);
        make.left.equalTo(_withdrawTipView.mas_left).offset(15);
    }];
    
    
    self.withdrawTipTextLab = [[UILabel alloc]init];
    NSString *tipTextStr = @"1、每个用户一天最多可发起2次提现，可选择支付宝提现方式，并仅可从指定的提现额度选项中，选择并进行提现。\n2、为了您的资金安全，支付宝提现方式需要您填写提现信息(包括支付宝账号、姓名、手机号码) 。请您确保提现时，所填写信息准确无误，若因您信息填写错误，造成提现资金损失的，由您自行负责。\n3、提现到账查询:若您确定好支付宝账号提现，您可从“支付宝”--“我的”--“账单”，查询到厦门临下集团有限公司转账红包，即提现到账成功。\n4、提现预计将在1-3个工作日到账，请您耐心等待。\n5、同个用户只能绑定1个支付宝提现账号、手机号，需要更换账号请及时修改。若因您提现绑定错误，造成资金损失的，由您自行承担其损失。\n6、若经本平台判断用户在提现环节，存在作弊或违规使用技术手段进行恶意套现等行为的，平台有权采取适当行为(包括但不限于冻结提现功能等)规范用户操作。\n7、您的提现申请将由第三方公司或平台运营公司发放至给您的申请账户，您的以上提现申请行为即视为同意呆萌价平台委托第三方公司或平台运营公司向您发放提现金额。";
    _withdrawTipTextLab.text=tipTextStr;
    _withdrawTipTextLab.font = [UIFont fontWithName:@"PingFangSC-Regular" size:FontSize(13)];
    _withdrawTipTextLab.textColor = textMinorColor;
    _withdrawTipTextLab.numberOfLines = 0;
    
    [_withdrawTipView addSubview:_withdrawTipTextLab];
    
    [_withdrawTipTextLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_withdrawTipView.mas_top).offset(44);
        make.left.equalTo(_withdrawTipView.mas_left).offset(15);
        make.right.equalTo(_withdrawTipView.mas_right).offset(-15);
        make.bottom.equalTo(_withdrawTipView.mas_bottom).offset(-5);
    }];
    
    
    
    UIView *withdrawBtnView = [[UIView alloc]initWithFrame:CGRectMake(10, kScreenHeight - (iPhoneX?34:0) - 46, kScreenWidth-20, 46+(iPhoneX?34:0))];
    withdrawBtnView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:withdrawBtnView];
    
    UIBezierPath *maskPath33 = [UIBezierPath bezierPathWithRoundedRect:withdrawBtnView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(21, 21)];
    CAShapeLayer *maskLayer33 = [[CAShapeLayer alloc] init];
    maskLayer33.frame = withdrawBtnView.bounds;
    maskLayer33.path = maskPath33.CGPath;
    withdrawBtnView.layer.mask = maskLayer33;
    
    self.withdrawBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _withdrawBtn.frame = CGRectMake(0, 0, kScreenWidth-20, 41);
    [_withdrawBtn setTitle:@"确认提现" forState:0];
    [_withdrawBtn setTitleColor:kUIColorFromRGB(0xFCF8F8) forState:0];
    _withdrawBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(15)];
    _withdrawBtn.layer.masksToBounds = YES;
    _withdrawBtn.layer.cornerRadius = 20.5;
    [_withdrawBtn setBackgroundColor:kUIColorFromRGB(0xE49393)];
    [withdrawBtnView addSubview:_withdrawBtn];
    [_withdrawBtn addTarget:self action:@selector(clickWithdrawButton:) forControlEvents:UIControlEventTouchUpInside];
    _withdrawBtn.userInteractionEnabled = NO;
    
    
    
    
}



-(void)chlickAddAccountNumBtnOnZfbView:(UIButton *)sender{
    //    ChangeZfbVC *changeZfbVC = [[ChangeZfbVC alloc]init];
    //    changeZfbVC.phoneNum = [[NSUserDefaults standardUserDefaults] objectForKey:@"userphone"];
    //    changeZfbVC.navTitle = @"设置支付宝账号";
    //    if (changeZfbVC) {
    //        [self.navigationController pushViewController:changeZfbVC animated:YES];
    //    }
    
}
//修改支付宝
- (void)clickChangeZfbButton:(UIButton *)sender{
    
    //    ChangeZfbVC *changeZfbVC = [[ChangeZfbVC alloc]init];
    //    changeZfbVC.phoneNum = [[NSUserDefaults standardUserDefaults] objectForKey:@"userphone"];
    //    changeZfbVC.navTitle = @"修改支付宝账号";
    //    if (changeZfbVC) {
    //        [self.navigationController pushViewController:changeZfbVC animated:YES];
    //    }
}

- (void)clickOneMonButton:(UIButton *)btn{
    
    NSArray *monArr = @[@"0.5", @"15", @"30", @"50", @"100", @"200"];
    
    NSString *clickMonStr = monArr[btn.tag];
    
    if ([clickMonStr floatValue] > [ktMonStr floatValue]) {
        //        [YJProgressHUD showMsgWithMsgStr:@"可提余额不足" imageName:@"YM_jiantou" inview:self.view afterDelayTime:1.5];
        //   return;
    }
    
    for (id view in _withdrawMonView.subviews) {
        
        if ([view isKindOfClass:[UIButton class]]) {
            
            UIButton *oneBtn = (UIButton *)view;
            [oneBtn setBackgroundImage:[UIImage imageNamed:@""] forState:0];
        }
    }
    
    
    [btn setBackgroundImage:[UIImage imageNamed:@"YM_Choose"] forState:0];
    
    btn.layer.borderColor = kUIColorFromRGB(0xEDEDED).CGColor;
    btn.layer.borderWidth = 0.00001;
}

- (void)clickOneImgView:(UIGestureRecognizer *)sender{
    
    
//    if (haveZfb == NO) {
        //        [YJProgressHUD showMsgWithMsgStr:@"请绑定支付宝" imageName:@"show_tipError.png" inview:self.view afterDelayTime:1.5];
//        return;
//    }
    
    NSArray *monArr = @[@"0.5", @"15", @"30", @"50", @"100", @"200"];
    
    NSString *clickMonStr = monArr[sender.view.tag];
    DMLog(@"%f-------%f", [clickMonStr floatValue], [ktMonStr floatValue]);
//    if ([clickMonStr floatValue] > [ktMonStr floatValue]) {
        //        [YJProgressHUD showMsgWithMsgStr:@"可提余额不足" imageName:@"show_tipError.png" inview:self.view afterDelayTime:1.5];
//        return;
//    }
    
    for (id view in _withdrawMonView.subviews) {
        
        if ([view isKindOfClass:[UIImageView class]]) {
            UIImageView *oneImgView = (UIImageView *)view;
            oneImgView.image = [UIImage imageNamed:@""];
            
            for (id view in oneImgView.subviews) {
                
                if ([view isKindOfClass:[UILabel class]]) {
                    UILabel *label = (UILabel *)view;
                    label.backgroundColor = kUIColorFromRGB(0xF6F6F6);
                    label.layer.masksToBounds = YES;
                    label.layer.cornerRadius = 8;
                    label.layer.borderColor = kUIColorFromRGB(0xEDEDED).CGColor;
                    label.layer.borderWidth = 1;
                    
                }
            }
            
        }
    }
    
    
    
    
    UIImageView *imgView = (UIImageView *)sender.view;
    imgView.image = [UIImage imageNamed:@"YM_Choose"];
    withdrawMonStr = monArr[sender.view.tag];
    for (id view in imgView.subviews) {
        
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)view;
            label.backgroundColor = [UIColor clearColor];
            label.layer.masksToBounds = YES;
            label.layer.cornerRadius = 8;
            label.layer.borderColor = [UIColor clearColor].CGColor;
            label.layer.borderWidth = 1;
            
        }
    }
    
    _withdrawBtn.userInteractionEnabled = YES;
    
    [_withdrawBtn setBackgroundColor:kUIColorFromRGB(0xFF0134)];
}

- (void)clickWithdrawButton:(UIButton *)sender{
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(clickWithdrawButtonLater:) object:sender];
    [self performSelector:@selector(clickWithdrawButtonLater:) withObject:sender afterDelay:0.2f];
    
}

- (void)clickWithdrawButtonLater:(UIButton *)sender{
    
    
    [YJProgressHUD showCustomAnimation:@"加载中" withImgArry:nil inview:kWindow];
    
    DMLog(@"-------%@",withdrawMonStr);
    NSDictionary *dict = @{
        @"money":withdrawMonStr,
    };
    
    [NetWorkManager  requestWithType:1 withUrlString:kURLWithGetRedPackageWithdrawals withParaments:dict withSuccessBlock:^(NSDictionary *responseObject) {
        
        DMLog(@"红包 提现详情  =  %@  %@",  responseObject, responseObject[@"msgstr"]);
        
        
        NSString *result = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
        if ([result isEqualToString:@"1"]) {
            
            [[YXAlertView shareInstance] showAlert:@"恭喜您" message:@"提现成功！" cancelTitle:nil titleArray:nil viewController:self confirm:^(NSInteger buttonTag) {
                
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
        else{
            
            //            [YJProgressHUD showMsgWithMsgStr:[NSString stringWithFormat:@"%@", responseObject[@"msgstr"]] imageName:@"show_tipError.png" inview:self.view afterDelayTime:2];
        }
        [YJProgressHUD hide];
    } withFailureBlock:^(NSError *error) {
        [YJProgressHUD hide];
    } progress:^(float progress) {
        
    }];
    
    
}

- (void)clickwithdrawListButton:(UIButton *)sender{
    
    DailyRedPacketWithdrawListVC *listVC = [[DailyRedPacketWithdrawListVC alloc]init];
    if (listVC) {
        [self.navigationController pushViewController:listVC animated:YES];
    }
    
}


@end
