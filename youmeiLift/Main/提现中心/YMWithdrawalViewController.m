//
//  YMWithdrawalViewController.m
//  youmeiLift
//
//  Created by mac on 2021/7/6.
//

#import "YMWithdrawalViewController.h"
#import <Masonry.h>
#import "DMTextTool.h"
@interface YMWithdrawalViewController ()<UIScrollViewDelegate>
{
    UIButton *QDTXBtn;
    UIButton *item;
}
@end

@implementation YMWithdrawalViewController

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
    jifenLab.text=@"提现中心";
    jifenLab.textAlignment=NSTextAlignmentCenter;
    jifenLab.textColor=[UIColor blackColor];
    jifenLab.font=[UIFont systemFontOfSize:FontSize(18)];
    [navView addSubview:jifenLab];
    
    UIScrollView *HeaderScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, (iPhoneX?88:64), kScreenWidth, kScreenHeight-(iPhoneX?84:64))];
    HeaderScroll.backgroundColor = [UIColor clearColor];
    HeaderScroll.contentSize = CGSizeMake(kScreenWidth, 80+10+45+10+228+10+446+10+41+10+5);
    HeaderScroll.delegate = self;
    HeaderScroll.scrollEnabled = YES;
    HeaderScroll.showsVerticalScrollIndicator = YES;
    HeaderScroll.showsHorizontalScrollIndicator = YES;
    HeaderScroll.userInteractionEnabled=YES;
    [self.view addSubview:HeaderScroll];
    
    UIView *TXView=[[UIView alloc]init];
    TXView.backgroundColor=[UIColor whiteColor];
    TXView.layer.cornerRadius = 7;
    TXView.layer.masksToBounds = YES;
    [HeaderScroll addSubview:TXView];
    [TXView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(HeaderScroll.mas_top).offset(10);
        make.left.equalTo(HeaderScroll.mas_left).offset(10);
        make.height.mas_equalTo(80);
        make.width.mas_equalTo(kScreenWidth-20);
    }];
    UILabel *KtxLab=[[UILabel alloc]init];
    KtxLab.text=@"可提现金额（元）";
    KtxLab.textColor=[UIColor blackColor];
    KtxLab.font=[UIFont systemFontOfSize:FontSize(14)];
    [TXView addSubview:KtxLab];
    [KtxLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(TXView.mas_top).offset(17);
        make.left.equalTo(TXView.mas_left).offset(20);
        make.height.mas_equalTo(14);
        make.width.mas_equalTo(120);
    }];
    
    UILabel *KMoneyLab=[[UILabel alloc]init];
    KMoneyLab.text=@"￥88.88";
    KMoneyLab.textColor=[UIColor blackColor];
    KMoneyLab.font=[UIFont systemFontOfSize:FontSize(22)];
    [TXView addSubview:KMoneyLab];
    [KMoneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(KtxLab.mas_bottom).offset(13);
        make.left.equalTo(TXView.mas_left).offset(20);
        make.height.mas_equalTo(17);
        
    }];
    
    UIButton *KtxBtn = [[UIButton alloc] init];
    [KtxBtn.layer setBorderColor:allBackgroundColor.CGColor];
    [KtxBtn.layer setBorderWidth:1];
    [KtxBtn.layer setMasksToBounds:YES];
    KtxBtn.layer.cornerRadius = 15;
    KtxBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    KtxBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [KtxBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [KtxBtn setTitle:@"提现记录" forState:0];
    [TXView addSubview:KtxBtn];
    [KtxBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(TXView.mas_top).offset(16);
        make.right.equalTo(TXView.mas_right).offset(-11);
        make.height.mas_equalTo(26);
        make.width.mas_equalTo(85);
    }];
    
    UIView *ZFBView=[[UIView alloc]init];
    ZFBView.backgroundColor=[UIColor whiteColor];
    ZFBView.layer.cornerRadius = 7;
    ZFBView.layer.masksToBounds = YES;
    [HeaderScroll addSubview:ZFBView];
    [ZFBView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(TXView.mas_bottom).offset(10);
        make.left.equalTo(HeaderScroll.mas_left).offset(10);
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(kScreenWidth-20);
    }];
    
    UIImageView *zfbImg=[[UIImageView alloc]init];
    zfbImg.image=[UIImage imageNamed:@"YM_zfb_Z"];
    [ZFBView addSubview:zfbImg];
    [zfbImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ZFBView.mas_top).offset(13);
        make.left.equalTo(ZFBView.mas_left).offset(14);
        make.height.mas_equalTo(19);
        make.width.mas_equalTo(19);
    }];
    
    UILabel *YJzfbLab=[[UILabel alloc]init];
    YJzfbLab.text=@"支付宝";
    YJzfbLab.textColor=[UIColor blackColor];
    YJzfbLab.font=[UIFont systemFontOfSize:FontSize(13)];
    [ZFBView addSubview:YJzfbLab];
    [YJzfbLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ZFBView.mas_top).offset(16);
        make.left.equalTo(zfbImg.mas_right).offset(11);
        make.height.mas_equalTo(13);
        make.width.mas_equalTo(45);
    }];
    
    UILabel *YMyjLab=[[UILabel alloc]init];
    YMyjLab.text=@"(预计3个工作日到账)";
    YMyjLab.textColor=[UIColor blackColor];
    YMyjLab.font=[UIFont systemFontOfSize:FontSize(10)];
    [ZFBView addSubview:YMyjLab];
    [YMyjLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ZFBView.mas_top).offset(17.5);
        make.left.equalTo(YJzfbLab.mas_right).offset(11);
        make.height.mas_equalTo(10);
        make.width.mas_equalTo(110);
    }];
    
    UIImageView *JTImg=[[UIImageView alloc]init];
    JTImg.image=[UIImage imageNamed:@"YM_jiantou"];
    [ZFBView addSubview:JTImg];
    [JTImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ZFBView.mas_top).offset(17);
        make.left.equalTo(ZFBView.mas_right).offset(-13);
        make.height.mas_equalTo(11);
        make.width.mas_equalTo(6);
    }];
    
    UILabel *wbdLab = [[UILabel alloc]init];
    wbdLab.text = @"未绑定";
    wbdLab.textColor = kUIColorFromRGB(0xA5A5A5);
    wbdLab.font = [UIFont systemFontOfSize:FontSize(11)];
    wbdLab.textAlignment = NSTextAlignmentRight;
    [ZFBView addSubview:wbdLab];
    [wbdLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ZFBView.mas_top).offset(16.5);
        make.left.equalTo(ZFBView.mas_right).offset(-65);
        make.height.mas_equalTo(12);
        make.width.mas_equalTo(40);
    }];
    
    
    UIView *TXJEView=[[UIView alloc]init];
    TXJEView.backgroundColor=[UIColor whiteColor];
    TXJEView.layer.cornerRadius = 7;
    TXJEView.layer.masksToBounds = YES;
    [HeaderScroll addSubview:TXJEView];
    [TXJEView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ZFBView.mas_bottom).offset(10);
        make.left.equalTo(HeaderScroll.mas_left).offset(10);
        make.height.mas_equalTo(228);
        make.width.mas_equalTo(kScreenWidth-20);
    }];
    
    UILabel *txjeLab=[[UILabel alloc]init];
    txjeLab.text=@"提现金额";
    txjeLab.textColor=[UIColor blackColor];
    txjeLab.font=[UIFont systemFontOfSize:FontSize(15)];
    [TXJEView addSubview:txjeLab];
    [txjeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(TXJEView.mas_top).offset(15);
        make.left.equalTo(TXJEView.mas_left).offset(16);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(80);
    }];
    
    NSArray *bbgjttArr = @[@"0.5", @"10", @"30", @"50", @"100", @"200"];
    CGFloat marginX =10;
    CGFloat marginY =1;
    CGFloat toTop =44;
    CGFloat gapX =10;
    CGFloat gapY =11;
    NSInteger col =2;
    NSInteger count =6;
    CGFloat viewWidth = self.view.bounds.size.width;
//    CGFloat viewHeight = self.view.bounds.size.height;
    CGFloat itemWidth = (viewWidth - marginX *2- (col -1)*gapX)/col*1.0f;
    CGFloat itemHeight = 49;
    UIButton*last =nil;
    for(int i =0; i < count; i++) {
        
        
        item = [[UIButton alloc] init];
        item.backgroundColor=allBackgroundColor;
        item.titleLabel.textAlignment=NSTextAlignmentCenter;
        item.titleLabel.font = [UIFont systemFontOfSize:15];
        [item setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [item setImage:[UIImage imageNamed:@"YM_Choose"] forState:0];
        [item setTitle:[NSString stringWithFormat:@"%@元",bbgjttArr[i]] forState:0];
        [TXJEView addSubview:item];
        UITapGestureRecognizer *TwoTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickoneImgView:)];
        [item addGestureRecognizer:TwoTap];
        
        [item mas_makeConstraints:^(MASConstraintMaker*make) {
        make.width.mas_equalTo(itemWidth-10);
        make.height.mas_equalTo(itemHeight);
        CGFloat top = toTop + marginY + (i/col)*(itemHeight+gapY);
        make.top.mas_offset(top);
        if (!last || (i%col) == 0) {
           make.left.mas_offset(marginX);
        }
        else
        {
           make.left.mas_equalTo(last.mas_right).mas_offset(gapX);
        }}];
        last = item;
        }
    
    
    
    UIView *TXSMView=[[UIView alloc]init];
    TXSMView.backgroundColor=[UIColor whiteColor];
    TXSMView.layer.cornerRadius = 7;
    TXSMView.layer.masksToBounds = YES;
    [HeaderScroll addSubview:TXSMView];
    [TXSMView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(TXJEView.mas_bottom).offset(10);
        make.left.equalTo(HeaderScroll.mas_left).offset(10);
        make.height.mas_equalTo(446);
        make.width.mas_equalTo(kScreenWidth-20);
    }];
    
    UILabel *TXSMLab=[[UILabel alloc]init];
    TXSMLab.text=@"提现说明";
    TXSMLab.textColor=[UIColor blackColor];
    TXSMLab.font=[UIFont systemFontOfSize:FontSize(15)];
    [TXSMView addSubview:TXSMLab];
    [TXSMLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(TXSMView.mas_top).offset(15);
        make.left.equalTo(TXSMView.mas_left).offset(16);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(80);
    }];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 44, kScreenWidth-40, 0)];
    label.numberOfLines = 0;
    label.font=[UIFont systemFontOfSize:FontSize(13)];
    label.backgroundColor = [UIColor clearColor];
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13],};
    NSString *str = @"1、每个用户一天最多可发起2次提现，可选择支付宝提现方式，并仅可从指定的提现额度选项中，选择并进行提现。\n 2、为了您的资金安全，支付宝提现方式需要您填写提现信息(包括支付宝账号、姓名、手机号码) 。请您确保提现时，所填写信息准确无误，若因您信息填写错误，造成提现资金损失的，由您自行负责。\n 3、提现到账查询:若您确定好支付宝账号提现，您可从“支付宝”--“我的”--“账单”。\n 4、提现预计将在1-3个工作日到账，请您耐心等待。\n 5、同个用户只能绑定1个支付宝提现账号、手机号，需要更换账号请及时修改。若因您提现绑定错误，造成资金损失的，由您自行承担其损失。\n 6、若经本平台判断用户在提现环节，存在作弊或违规使用技术手段进行恶意套现等行为的，平台有权采取适当行为(包括但不限于冻结提现功能等)规范用户操作。\n 7、您的提现申请将由第三方公司或平台运营公司发放至给您的申请账户，您的以上提现申请行为即视为同意第三方公司或平台运营公司向您发放提现金额。";
//    CGSize textSize = [str boundingRectWithSize:CGSizeMake(kScreenWidth-40, 387) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;;

//    label.attributedText = [DMTextTool dm_changeLineSpace:3.0 str:[NSString stringWithFormat:@"%@",str]];
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 4.0;
    [attributedStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributedStr.length)];

    label.attributedText = attributedStr;
    [label sizeToFit];
    
//    [label setFrame:CGRectMake(10, 44, kScreenWidth-40, 0)];
    label.textColor = [UIColor blackColor];
    label.text = str;
    [TXSMView addSubview:label];
    
    
    QDTXBtn=[[UIButton alloc]init];
    [QDTXBtn setTitle:@"确定提现" forState:0];
    QDTXBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [QDTXBtn setTitleColor:[UIColor whiteColor] forState:0];
    QDTXBtn.backgroundColor = kUIColorFromRGB(0xE49393);
    QDTXBtn.layer.cornerRadius = 20.5;
    QDTXBtn.layer.masksToBounds = YES;
    QDTXBtn.userInteractionEnabled = NO;
    [QDTXBtn addTarget:self action:@selector(ClickQDTXButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:QDTXBtn];
    [QDTXBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_bottom).offset(-51);
        make.left.equalTo(HeaderScroll.mas_left).offset(10);
        make.height.mas_equalTo(41);
        make.width.mas_equalTo(kScreenWidth-20);
    }];
    
    
    
}

-(void)ClickQDTXButton:(UIButton *)sender{
    QDTXBtn.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self->QDTXBtn.userInteractionEnabled = YES;
    });
    
    
    
}

-(void)clickoneImgView:(UIGestureRecognizer *)sender{
    NSArray *monArr = @[@"0.5", @"15", @"30", @"50", @"100", @"200"];
    
    NSString *clickMonStr = monArr[sender.view.tag];
    
    
}

@end
