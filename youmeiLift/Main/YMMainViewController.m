//
//  YMMainViewController.m
//  有美生活
//
//  Created by mac on 2021/6/22.
//

#import "YMMainViewController.h"
#import "DDGBannerScrollView.h"
#import "YXAlertView.h"
#import <Masonry.h>
#import "FLAnimatedImageView.h"
#import "YMiMassageViewController.h"
#import "YMSettingViewController.h"
#import "YMMyOrderViewController.h"
#import "EarnDetailAllVC.h"
#import "YMInvitationViewController.h"
#import "DailyRedPacketWithdrawVC.h"
@interface YMMainViewController ()<UIScrollViewDelegate,DDGBannerScrollViewDelegate>
@property (nonatomic ,strong)DDGBannerScrollView *bannerScrollView;
@end

@implementation YMMainViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    
    self.navigationController.navigationBarHidden = YES;
    // self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    
    self.navigationController.navigationBarHidden = NO;
    // self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=allBackgroundColor;
    
    UIScrollView *HeaderScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-(iPhoneX?84:49))];
    HeaderScroll.backgroundColor = [UIColor clearColor];
    HeaderScroll.contentSize = CGSizeMake(kScreenWidth, kScreenHeight- (iPhoneX?84:64)+200);
    HeaderScroll.delegate = self;
    HeaderScroll.scrollEnabled = YES;
    HeaderScroll.showsVerticalScrollIndicator = YES;
    HeaderScroll.showsHorizontalScrollIndicator = YES;
    HeaderScroll.userInteractionEnabled=YES;
    [self.view addSubview:HeaderScroll];
    
    
    UIView *HeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    HeaderView.backgroundColor=[UIColor colorWithRed:248/255.0 green:66/255.0 blue:102/255.0 alpha:1];
    [HeaderScroll addSubview:HeaderView];
    
    UIImageView *headerImg=[[UIImageView alloc]init];
    headerImg.image=[UIImage imageNamed:@""];
    headerImg.backgroundColor=[UIColor whiteColor];
    headerImg.layer.cornerRadius=25;
    headerImg.layer.masksToBounds=YES;
    [HeaderView addSubview:headerImg];
    [headerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(HeaderView.mas_top).offset(50);
        make.left.equalTo(HeaderView.mas_left).offset(16);
        make.height.width.mas_equalTo(50);
    }];
    UITapGestureRecognizer *oneTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickheaderImg:)];
    [headerImg addGestureRecognizer:oneTap];
    
    UILabel *nameLab=[[UILabel alloc]init];
    NSString *nameStr=[NSString stringWithFormat:@"月亮不睡我不睡"];
    nameLab.text=nameStr;
    nameLab.textColor=[UIColor whiteColor];
    nameLab.font=[UIFont systemFontOfSize:FontSize(18)];
    [HeaderView addSubview:nameLab];
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(HeaderView.mas_top).offset(55);
        make.left.equalTo(headerImg.mas_right).offset(12);
        make.height.mas_equalTo(18);
    }];
    
    UILabel *ywnsxLab=[[UILabel alloc]init];
    NSString *ywnsxStr=[NSString stringWithFormat:@"  已为您节省88.88元  "];
    ywnsxLab.text=ywnsxStr;
    ywnsxLab.layer.borderColor = [UIColor colorWithRed:253/255.0 green:132/255.0 blue:78/255.0 alpha:1].CGColor;
    ywnsxLab.layer.borderWidth = 1;
    ywnsxLab.layer.cornerRadius = 6.5;
    ywnsxLab.layer.masksToBounds = YES;
    ywnsxLab.textColor=[UIColor whiteColor];
    ywnsxLab.font=[UIFont systemFontOfSize:FontSize(13)];
    [HeaderView addSubview:ywnsxLab];
    [ywnsxLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLab.mas_bottom).offset(8);
        make.left.equalTo(headerImg.mas_right).offset(12);
        make.height.mas_equalTo(18);
    }];
    
    UIButton *shezhiBtn=[[UIButton alloc]init];
    [shezhiBtn setImage:[UIImage imageNamed:@"YM_shezhi.png"] forState:0];
    [shezhiBtn addTarget:self action:@selector(ClickshezhiButton:) forControlEvents:UIControlEventTouchUpInside];
    [HeaderView addSubview:shezhiBtn];
    [shezhiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(HeaderView.mas_top).offset(40);
        make.right.equalTo(HeaderView.mas_right).offset(-20);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
    }];
    
    UIButton *xinxiBtn=[[UIButton alloc]init];
    [xinxiBtn setImage:[UIImage imageNamed:@"YM_xx.png"] forState:0];
    [xinxiBtn addTarget:self action:@selector(ClickxinxiButton:) forControlEvents:UIControlEventTouchUpInside];
    [HeaderView addSubview:xinxiBtn];
    [xinxiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(HeaderView.mas_top).offset(40);
        make.right.equalTo(shezhiBtn.mas_left).offset(-18);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
    }];
    
    UIView *OneView=[[UIView alloc]initWithFrame:CGRectMake(10,118 , kScreenWidth-20, 138)];
    OneView.backgroundColor=[UIColor whiteColor];
    OneView.layer.masksToBounds = YES;
    OneView.layer.cornerRadius = 12;
    [HeaderScroll addSubview:OneView];
    
    UILabel *ktxMonLab = [[UILabel alloc]init];
    ktxMonLab.textColor = kUIColorFromRGB(0x1D1E23);
    ktxMonLab.textAlignment = NSTextAlignmentLeft;
    ktxMonLab.font = [UIFont boldSystemFontOfSize:FontSize(22)];
    
    NSString *ktxStr = [NSString string];
    ktxStr = [NSString stringWithFormat:@"0.00"];
    if ([ktxStr isEqualToString:@"0"]||[ktxStr isEqualToString:@"(null)"]) {
        ktxStr = @"0.00";
    }
    ktxMonLab.text = ktxStr;
    [OneView addSubview:ktxMonLab];
    
    [ktxMonLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(OneView.mas_top).offset(33.5);
        make.left.equalTo(OneView.mas_left).offset(20);
        make.height.mas_equalTo(25);
    }];
    
    UILabel *ktxMonLastLab = [[UILabel alloc]init];
    ktxMonLastLab.textColor = kUIColorFromRGB(0x1D1E23);
    ktxMonLastLab.textAlignment = NSTextAlignmentLeft;
    ktxMonLastLab.font = [UIFont boldSystemFontOfSize:FontSize(12)];
    ktxMonLastLab.text = @"元";
    [OneView addSubview:ktxMonLastLab];
    
    [ktxMonLastLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(OneView.mas_top).offset(41.5);
        make.left.equalTo(ktxMonLab.mas_right).offset(3);
        make.height.mas_equalTo(15);
    }];
    
    UILabel *ktxMonTipLab = [[UILabel alloc]init];
    ktxMonTipLab.textColor = kUIColorFromRGB(0xB58630);
    ktxMonTipLab.textAlignment = NSTextAlignmentLeft;
    ktxMonTipLab.font = [UIFont boldSystemFontOfSize:FontSize(11)];
    NSString *ktxTipStr = [NSString stringWithFormat:@"可提现金额(元)"];
    ktxMonTipLab.text = ktxTipStr;
    [OneView addSubview:ktxMonTipLab];
    
    [ktxMonTipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(OneView.mas_top).offset(16);
        make.left.equalTo(OneView.mas_left).offset(18);
        make.height.mas_equalTo(11);
    }];
    
    UILabel *ljsrLab=[[UILabel alloc]init];
    ljsrLab.text=@"累计收入(元)";
    ljsrLab.textColor = kUIColorFromRGB(0xB58630);
    ljsrLab.textAlignment = NSTextAlignmentLeft;
    ljsrLab.font = [UIFont boldSystemFontOfSize:FontSize(11)];
    [OneView addSubview:ljsrLab];
    [ljsrLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ktxMonLab.mas_bottom).offset(25);
        make.left.equalTo(OneView.mas_left).offset(18);
        make.height.mas_equalTo(11);
    }];
    
    UILabel *ljsrYLab = [[UILabel alloc]init];
    ljsrYLab.textColor = kUIColorFromRGB(0x1D1E23);
    ljsrYLab.textAlignment = NSTextAlignmentLeft;
    ljsrYLab.font = [UIFont boldSystemFontOfSize:FontSize(18)];
    
    NSString *ljsrYStr = [NSString string];
    ljsrYStr = [NSString stringWithFormat:@"0.00"];
    if ([ljsrYStr isEqualToString:@"0"]||[ljsrYStr isEqualToString:@"(null)"]) {
        ljsrYStr = @"0.00";
    }
    ljsrYLab.text = ljsrYStr;
    [OneView addSubview:ljsrYLab];
    
    [ljsrYLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ljsrLab.mas_bottom).offset(11);
        make.left.equalTo(OneView.mas_left).offset(18);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *rzzLab=[[UILabel alloc]init];
    rzzLab.text=@"入账中(元)";
    rzzLab.textColor = kUIColorFromRGB(0xB58630);
    rzzLab.textAlignment = NSTextAlignmentLeft;
    rzzLab.font = [UIFont boldSystemFontOfSize:FontSize(11)];
    [OneView addSubview:rzzLab];
    [rzzLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ktxMonLab.mas_bottom).offset(25);
        make.left.equalTo(OneView.mas_left).offset(184);
        make.height.mas_equalTo(11);
    }];
    
    UILabel *rzzYLab = [[UILabel alloc]init];
    rzzYLab.textColor = kUIColorFromRGB(0x1D1E23);
    rzzYLab.textAlignment = NSTextAlignmentLeft;
    rzzYLab.font = [UIFont boldSystemFontOfSize:FontSize(18)];
    
    NSString *rzzYStr = [NSString string];
    rzzYStr = [NSString stringWithFormat:@"0.00"];
    if ([rzzYStr isEqualToString:@"0"]||[rzzYStr isEqualToString:@"(null)"]) {
        rzzYStr = @"0.00";
    }
    rzzYLab.text = rzzYStr;
    [OneView addSubview:rzzYLab];
    
    [rzzYLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rzzLab.mas_bottom).offset(11);
        make.left.equalTo(OneView.mas_left).offset(184);
        make.height.mas_equalTo(20);
    }];
    
    
    UIView *guizeView = [[UIView alloc]initWithFrame:CGRectMake(OneView.frame.size.width - 84, 17*BiLi, 84, 29)];
    guizeView.backgroundColor = [UIColor colorWithRed:253/255.0 green:132/255.0 blue:78/255.0 alpha:1];
    [OneView addSubview:guizeView];
    UIBezierPath *maskPath33 = [UIBezierPath bezierPathWithRoundedRect:guizeView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerTopLeft cornerRadii:CGSizeMake(10.5, 10.5)];
    CAShapeLayer *maskLayer33 = [[CAShapeLayer alloc] init];
    maskLayer33.frame = guizeView.bounds;
    maskLayer33.path = maskPath33.CGPath;
    guizeView.layer.mask = maskLayer33;
    
   
    UILabel *guizeLab = [[UILabel alloc]initWithFrame:CGRectMake(OneView.frame.size.width - 84, 17*BiLi, 84, 29)];
    guizeLab.text = @" 我要提现";
    guizeLab.font = [UIFont systemFontOfSize:12];
    guizeLab.textAlignment = NSTextAlignmentCenter;
    guizeLab.textColor = [UIColor whiteColor];
    [OneView addSubview:guizeLab];
    
    guizeLab.userInteractionEnabled = YES;
    guizeView.userInteractionEnabled = YES;
    OneView.userInteractionEnabled = YES;
    UITapGestureRecognizer *guiZeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickGuiZeView:)];
    [guizeLab addGestureRecognizer:guiZeTap];
    
    //第二行
    NSArray *ttArr = @[@"全部订单", @"已收货", @"已结算", @"收益"];
    NSArray *imgArr = @[[UIImage imageNamed:@"YM_dd.png"],
                        [UIImage imageNamed:@"YM_ysh.png"],
                        [UIImage imageNamed:@"YM_yjs.png"],
                        [UIImage imageNamed:@"YM_sy.png"]];
    
    
    UIView *TwoView=[[UIView alloc]initWithFrame:CGRectMake(10,118+138+10 , kScreenWidth-20, 85)];
    TwoView.layer.masksToBounds = YES;
    TwoView.layer.cornerRadius = 12;
    TwoView.backgroundColor=[UIColor whiteColor];
    [HeaderScroll addSubview:TwoView];
    
    for (int i = 0; i < ttArr.count; i ++) {
        UIView *oneView = [[UIView alloc]initWithFrame:CGRectMake( ((kScreenWidth - 20 - 3)/4.0 +1)*(i%4), 13+72*(i/4) , (kScreenWidth - 20 - 3)/4.0, 72)];
        [TwoView addSubview:oneView];
        oneView.tag=i+1;
        UITapGestureRecognizer *oneTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickOneNoLoginViewOnMainItemCell:)];
        [oneView addGestureRecognizer:oneTap];
        UIImageView *imgView = [[UIImageView alloc]init];
        imgView.frame = CGRectMake((oneView.frame.size.width - 30)/2.0, 0, 30, 30);
        imgView.image =  imgArr[i];
        [oneView addSubview:imgView];
        
        UILabel *ttLab = [[UILabel alloc]init];
        ttLab.frame = CGRectMake(0, 40, oneView.frame.size.width, 11.5);
        ttLab.text = ttArr[i];
        ttLab.textAlignment = NSTextAlignmentCenter;
            ttLab.textColor = textMinorColor33;

        
        if ([ttLab.text isEqualToString:@"收益"]) {
            ttLab.textColor = kUIColorFromRGB(0xF9544C);
        }
        ttLab.font = [UIFont systemFontOfSize:FontSize(12)];
        ttLab.adjustsFontSizeToFitWidth = YES;
        [oneView addSubview:ttLab];
    }
    UIImageView *toInviteImgView = [[UIImageView alloc]init];
    toInviteImgView.frame = CGRectMake((kScreenWidth - 20 - 3)/4.0*3, 19.5, 8.5, 48);
    toInviteImgView.image = [UIImage imageNamed:@"YM_fgx.png"];
    [TwoView addSubview:toInviteImgView];
    
    
    
    
    
    
    NSMutableArray *array1 = [NSMutableArray arrayWithObjects:
                              @"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fwx1.sinaimg.cn%2Flarge%2F008fHVgdly4gqfhftvhl5j30u00iv40g.jpg&refer=http%3A%2F%2Fwx1.sinaimg.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1627028752&t=eadfa6c42d5eebb9b76828047ee51d0b",@"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimgres.quxiu.com%2Fquxiu%2F341%2F1703972-2021052312100560a9d59d41f11.jpg&refer=http%3A%2F%2Fimgres.quxiu.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1627028788&t=26e4bc5dcd05b65744c26924cd7e5047",@"https://img1.baidu.com/it/u=2917893129,3433599284&fm=26&fmt=auto&gp=0.jpg",nil];
    CGRect frame = CGRectMake(10, 118+138+10+85+10, kScreenWidth - 20, 68*BiLi);
    self.bannerScrollView = [DDGBannerScrollView cycleScrollViewWithFrame:frame delegate:self placeholderImage:[[YXAlertView shareInstance] CSPlaceholderImageWithWidth:kScreenWidth - 20 height:132.5*BiLi]];
    self.bannerScrollView.imageURLStringsGroup = array1;
    
    self.bannerScrollView.backgroundColor = [UIColor clearColor];
    self.bannerScrollView.pageControlAliment = DDGBannerScrollViewPageContolAlimentCenter;
    self.bannerScrollView.pageControlStyle = DDGBannerScrollViewPageControlHorizontal;
    self.bannerScrollView.pageDotColor = UIColor.whiteColor;
    self.bannerScrollView.currentPageDotColor = [UIColor yellowColor];
    self.bannerScrollView.layer.masksToBounds = YES;
    self.bannerScrollView.layer.cornerRadius = 7.0f;
    self.bannerScrollView.autoScrollTimeInterval = 4.5;
    self.bannerScrollView.pageControlBottomOffset = -5;
    self.bannerScrollView.pageControlRightOffset = -10;
    self.bannerScrollView.tag = 666;
    self.bannerScrollView.userInteractionEnabled = YES;
    [HeaderScroll addSubview:self.bannerScrollView];
    
    
    
    NSArray *bbgjttArr = @[@"全部订单", @"新手教程", @"邀请", @"收益", @"结算", @"收益", @"新手教程", @"结算", @"收益", @"结算", @"收益"];
    NSArray *bbgjArr = @[[UIImage imageNamed:@"YM_xsjc.png"],
                         [UIImage imageNamed:@"YM_yq.png"],
                         [UIImage imageNamed:@"YM_zjf.png"],
                         [UIImage imageNamed:@"YM_zj.png"],
                         [UIImage imageNamed:@"YM_zjf.png"],
                         [UIImage imageNamed:@"YM_zj.png"],
                         [UIImage imageNamed:@"YM_yq.png"],
                         [UIImage imageNamed:@"YM_zjf.png"],
                         [UIImage imageNamed:@"YM_zj.png"],
                         [UIImage imageNamed:@"YM_zjf.png"],
                         [UIImage imageNamed:@"YM_zj.png"]];
    
    UIView *ThreeView=[[UIView alloc]init];
    
    if (bbgjArr.count<5) {
        ThreeView.frame=CGRectMake(10,118+138+10+85+10+68+10+10 , kScreenWidth-20, 116);
    }else if(bbgjArr.count<9){
        ThreeView.frame=CGRectMake(10,118+138+10+85+10+68+10+10 , kScreenWidth-20, 182);
    }else{
        ThreeView.frame=CGRectMake(10,118+138+10+85+10+68+10+10 , kScreenWidth-20, 182+38+25+22);
    }
    ThreeView.layer.masksToBounds = YES;
    ThreeView.layer.cornerRadius = 7.0f;
    ThreeView.backgroundColor=[UIColor whiteColor];
    [HeaderScroll addSubview:ThreeView];
    
    UILabel *bbLab=[[UILabel alloc]init];
    bbLab.text=@"必备工具";
    bbLab.textColor=[UIColor blackColor];
    bbLab.font=[UIFont systemFontOfSize:FontSize(14)];
    [ThreeView addSubview:bbLab];
    [bbLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ThreeView.mas_top).offset(16);
        make.left.equalTo(ThreeView.mas_left).offset(19);
        make.size.mas_equalTo(CGSizeMake(80, 14));
    }];
    
    
    CGFloat marginY = 1;
    CGFloat toTop = 53;
    CGFloat gapY = 22;
    NSInteger col = 4;
    NSInteger count = bbgjArr.count;
    CGFloat itemwTitleWidth = (kScreenWidth - 40-65*4)/3.0;
    CGFloat itemWidth = (kScreenWidth - 80-25*4)/3.0;
    UIButton *last = nil;
    FLAnimatedImageView *twoImgView=nil;
    
    for (int i = 0 ; i < count; i++) {

        FLAnimatedImageView *oneImgView = [[FLAnimatedImageView alloc] init];
        oneImgView.image=bbgjArr[i];
        [ThreeView addSubview:oneImgView];
        UITapGestureRecognizer *oneTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickoneImgView:)];
        [ThreeView addGestureRecognizer:oneTap];
        oneImgView.userInteractionEnabled=YES;
        //布局
        [oneImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(25);
            make.height.mas_equalTo(25);
            CGFloat top = toTop + marginY + (i/col)*(50+gapY);
            make.top.mas_offset(top);
            if (!twoImgView || (i%col) == 0) {
                make.left.mas_offset(30);
            }else{
                make.left.mas_equalTo(twoImgView.mas_right).mas_offset(itemWidth);
            }
        }];
        twoImgView = oneImgView;
        
        UIButton *item = [[UIButton alloc] init];
        item.titleLabel.textAlignment=NSTextAlignmentCenter;
        item.titleLabel.font = [UIFont systemFontOfSize:12];
        [item setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [item setTitle:[NSString stringWithFormat:@"%@",bbgjttArr[i]] forState:0];
        [ThreeView addSubview:item];
        UITapGestureRecognizer *TwoTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickoneImgView:)];
        [item addGestureRecognizer:TwoTap];
        //布局
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(65);
            make.height.mas_equalTo(12);
            CGFloat top = toTop + marginY + (i/col)*(50+gapY);
            make.top.mas_offset(top+32);
            if (!last || (i%col) == 0) {
                make.left.mas_offset(10);
                
            }else{
                make.left.mas_equalTo(last.mas_right).mas_offset(itemwTitleWidth);
            }
        }];
        last = item;
        
        
        
        
    }

  
}


#pragma 必备工具
-(void)clickoneImgView:(UIGestureRecognizer *)sender{
    for (id view in sender.view.subviews) {
        
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *lab = (UILabel *)view;
            NSLog(@"%@", lab.text);

            if ([lab.text isEqualToString:@"全部订单"]) {
                YMMyOrderViewController *MyOrderVC=[[YMMyOrderViewController alloc]init];
                [self.navigationController pushViewController:MyOrderVC animated:YES];
            }
            else if([lab.text isEqualToString:@"收益"])
            {
                EarnDetailAllVC *EarnVC=[[EarnDetailAllVC alloc]init];
                [self.navigationController pushViewController:EarnVC animated:YES];

            }else if([lab.text isEqualToString:@"邀请"])
            {
                YMInvitationViewController *EarnVC=[[YMInvitationViewController alloc]init];
                EarnVC.inviteNum=@"123456";
                [self.navigationController pushViewController:EarnVC animated:YES];

            }

            
        }
        
    }
}

#pragma dingdan 订单列表
-(void)clickOneNoLoginViewOnMainItemCell:(UIGestureRecognizer *)sender{

    
    for (id view in sender.view.subviews) {
        
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *lab = (UILabel *)view;
            NSLog(@"%@", lab.text);

            if ([lab.text isEqualToString:@"全部订单"]) {
                YMMyOrderViewController *MyOrderVC=[[YMMyOrderViewController alloc]init];
                [self.navigationController pushViewController:MyOrderVC animated:YES];
            }
            else if([lab.text isEqualToString:@"收益"])
            {
                EarnDetailAllVC *EarnVC=[[EarnDetailAllVC alloc]init];
                [self.navigationController pushViewController:EarnVC animated:YES];

            }

            
        }
        
    }
}
#pragma tixian 我要提现
-(void)clickGuiZeView:(UIGestureRecognizer *)sender{
    DailyRedPacketWithdrawVC *WithdrawalVC=[[DailyRedPacketWithdrawVC alloc]init];
    [self.navigationController pushViewController:WithdrawalVC animated:YES];
}


#pragma shezhi 设置
-(void)ClickshezhiButton:(UIButton *)sender{
    YMSettingViewController *settingVC=[[YMSettingViewController alloc]init];
    [self.navigationController pushViewController:settingVC animated:YES];
    
}

#pragma xinxi 消息
-(void)ClickxinxiButton:(UIButton *)sender{
    YMiMassageViewController *imassageVC=[[YMiMassageViewController alloc]init];
    [self.navigationController pushViewController:imassageVC animated:YES];
}

#pragma touxiang 头像设置
-(void)clickheaderImg:(UIGestureRecognizer *)sender{
    
}
@end
