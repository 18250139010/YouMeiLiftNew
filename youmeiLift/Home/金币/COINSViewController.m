//
//  COINSViewController.m
//  youmeiLift
//
//  Created by mac on 2021/6/28.
//

#import "COINSViewController.h"
#import <Masonry.h>
#import "FLAnimatedImageView.h"
#import "RankListVC.h"
#import "RankListNewCell.h"
#import "ShopData.h"
#import "PopView.h"
#import "YMIntegralViewController.h"
#import "DailyRedPacketWithdrawVC.h"
@interface COINSViewController ()< UITableViewDelegate, UITableViewDataSource>
@property (nonatomic ,strong)PopView *popView;
@property (nonatomic ,strong)UIButton *qiandaoBtn;
@property (nonatomic ,strong)NSMutableArray *dataArr;

@end

@implementation COINSViewController

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
-(void)jifenStr{
    self.view.backgroundColor = allBackgroundColor;
    
    UIScrollView *HeaderScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-(iPhoneX?84:64))];
    HeaderScroll.backgroundColor = [UIColor clearColor];
    HeaderScroll.contentSize = CGSizeMake(kScreenWidth, kScreenHeight- (iPhoneX?90:66)-(iPhoneX?83:49)+200);
    HeaderScroll.delegate = self;
    HeaderScroll.scrollEnabled = YES;
    HeaderScroll.showsVerticalScrollIndicator = YES;
    HeaderScroll.showsHorizontalScrollIndicator = YES;
    HeaderScroll.userInteractionEnabled=YES;
    [self.view addSubview:HeaderScroll];
    
    
    
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    navView.backgroundColor = [UIColor colorWithRed:252/255.0 green:72/255.0 blue:77/255.0 alpha:1];
    [HeaderScroll addSubview:navView];
    
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setImage:[UIImage imageNamed:@"back"] forState:0];
    cancelBtn.frame = CGRectMake(10, 2+(iPhoneX?44:20), 40, 40);
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [cancelBtn addTarget:self action:@selector(clickBackVC:) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:cancelBtn];
    
    
    UILabel *jifenLab=[[UILabel alloc]init];
    jifenLab.frame=CGRectMake((kScreenWidth-100)/2, 2+(iPhoneX?44:20), 100, 40);
    jifenLab.text=@"积分商城";
    jifenLab.textAlignment=NSTextAlignmentCenter;
    jifenLab.textColor=[UIColor whiteColor];
    jifenLab.font=[UIFont systemFontOfSize:FontSize(18)];
    [navView addSubview:jifenLab];
    
    UIView *guizeView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth - 60, 53*BiLi, 60, 26)];
    guizeView.backgroundColor = [UIColor colorWithRed:252/255.0 green:238/255.0 blue:208/255.0 alpha:1];
    [navView addSubview:guizeView];
    UIBezierPath *maskPath33 = [UIBezierPath bezierPathWithRoundedRect:guizeView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerTopLeft cornerRadii:CGSizeMake(10.5, 10.5)];
    CAShapeLayer *maskLayer33 = [[CAShapeLayer alloc] init];
    maskLayer33.frame = guizeView.bounds;
    maskLayer33.path = maskPath33.CGPath;
    guizeView.layer.mask = maskLayer33;
    
   
    UILabel *guizeLab = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 60, 53*BiLi, 60, 26)];
    guizeLab.text = @" 去提现";
    guizeLab.font = [UIFont systemFontOfSize:12];
    guizeLab.textAlignment = NSTextAlignmentCenter;
    guizeLab.textColor = kUIColorFromRGB(0xB58630);
    [navView addSubview:guizeLab];
    
    guizeLab.userInteractionEnabled = YES;
    guizeView.userInteractionEnabled = YES;
    navView.userInteractionEnabled = YES;
    UITapGestureRecognizer *guiZeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickGuiZeView:)];
    [guizeLab addGestureRecognizer:guiZeTap];
    
    
    UILabel *fenLab=[[UILabel alloc]init];
    fenLab.frame=CGRectMake(10, 98, kScreenWidth/2-20, 18.5);
    fenLab.text=@"10000";
    fenLab.textAlignment=NSTextAlignmentCenter;
    fenLab.textColor=[UIColor whiteColor];
    fenLab.font=[UIFont systemFontOfSize:FontSize(24)];
    [navView addSubview:fenLab];
    
    UILabel *fenLab1=[[UILabel alloc]init];
//    fenLab1.frame=CGRectMake(10, fenLab.frame.origin.y+20, kScreenWidth/2-20, 11.5);
    fenLab1.text=@"我的积分 >";
    fenLab1.textAlignment=NSTextAlignmentCenter;
    fenLab1.textColor=[UIColor whiteColor];
    fenLab1.font=[UIFont systemFontOfSize:FontSize(12)];
    [navView addSubview:fenLab1];
    [fenLab1 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(fenLab.mas_bottom).offset(10);
        make.left.equalTo(fenLab.mas_left).offset(0);
        make.height.mas_equalTo(11.5);
        make.width.mas_equalTo(kScreenWidth/2-20);
    }];
    UITapGestureRecognizer *jifenTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickjifenButton:)];
    fenLab1.userInteractionEnabled = YES;
    [fenLab1 addGestureRecognizer:jifenTap];
    
    
    UIView *centenView=[[UIView alloc]init];
    centenView.frame=CGRectMake(kScreenWidth/2-0.5, 110, 1, 23);
    centenView.backgroundColor=[UIColor whiteColor];
    [navView addSubview:centenView];
    
    UILabel *qianLab=[[UILabel alloc]init];
    qianLab.frame=CGRectMake(kScreenWidth/2+10, 98, (kScreenWidth-20)/2, 18.5);
    qianLab.text=@"￥10000";
    qianLab.textAlignment=NSTextAlignmentCenter;
    qianLab.textColor=[UIColor whiteColor];
    qianLab.font=[UIFont systemFontOfSize:FontSize(24)];
    [navView addSubview:qianLab];
    
    UILabel *qianLab1=[[UILabel alloc]init];
//    fenLab1.frame=CGRectMake(10, fenLab.frame.origin.y+20, kScreenWidth/2-20, 11.5);
    qianLab1.text=@"红包金额 >";
    qianLab1.textAlignment=NSTextAlignmentCenter;
    qianLab1.textColor=[UIColor whiteColor];
    qianLab1.font=[UIFont systemFontOfSize:FontSize(12)];
    [navView addSubview:qianLab1];
    [qianLab1 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(qianLab.mas_bottom).offset(10);
        make.left.equalTo(qianLab.mas_left).offset(0);
        make.height.mas_equalTo(11.5);
        make.width.mas_equalTo(kScreenWidth/2-20);
    }];
    UITapGestureRecognizer *searchTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickhongbaoButton:)];
    qianLab1.userInteractionEnabled = YES;
    [qianLab1 addGestureRecognizer:searchTap];
    
    
    UIView *qiandaoView=[[UIView alloc]init];
    qiandaoView.frame=CGRectMake(10, 153, kScreenWidth-20, 200);
    qiandaoView.backgroundColor=[UIColor whiteColor];
    qiandaoView.layer.cornerRadius=7;
    qiandaoView.layer.masksToBounds = YES;
    [HeaderScroll addSubview:qiandaoView];
    
    UILabel *mrqdLab=[[UILabel alloc]init];
    mrqdLab.text=@"每日签到";
    mrqdLab.textColor=HEXCOLOR(0x333333);
    mrqdLab.font=[UIFont fontWithName:@"Helvetica" size:FontSize(15)];
    [qiandaoView addSubview:mrqdLab];
    [mrqdLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(qiandaoView.mas_top).offset(11);
        make.left.equalTo(qiandaoView.mas_left).offset(12);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(80);
    }];
    
    UILabel *lxqdLab=[[UILabel alloc]init];
    lxqdLab.text=@"连续签到，领神秘大礼";
    lxqdLab.textColor=[UIColor lightGrayColor];
    lxqdLab.font=[UIFont systemFontOfSize:FontSize(12)];
    [qiandaoView addSubview:lxqdLab];
    [lxqdLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(qiandaoView.mas_top).offset(12);
        make.left.equalTo(mrqdLab.mas_right).offset(12);
        make.height.mas_equalTo(12);
        make.width.mas_equalTo(150);
    }];
    
    
    CGFloat jianju = (kScreenWidth - 20 -24-36*7)/6.0;
    
    for (int i = 0; i < 7; i ++) {
        UIView *newOneView = [[UIView alloc]initWithFrame:CGRectMake(12 + (35+jianju)*i, 58, 36, 42)];
        [qiandaoView addSubview:newOneView];
       
        FLAnimatedImageView *oneImgView = [[FLAnimatedImageView alloc] initWithFrame:CGRectMake(5, 5, 36, 42)];
        [newOneView addSubview:oneImgView];
        
        
        
        UILabel *oneTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 55*BiLi, 30*BiLi, 11*BiLi)];
        oneTitleLabel.font = [UIFont systemFontOfSize:FontSize(11)];
        oneTitleLabel.textAlignment = NSTextAlignmentCenter;
        oneTitleLabel.textColor = textMinorColor33;
        [newOneView addSubview:oneTitleLabel];
        
        if (i==6) {
            oneImgView.image=[UIImage imageNamed:@"YMShengMi"];
        }else{
            oneImgView.image=[UIImage imageNamed:@"YMWeiQianDao"];
        }
        
        
        oneTitleLabel.text = [NSString stringWithFormat:@"第%d天",i+1];
        newOneView.tag = 676+i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapTwoView:)];
        [newOneView addGestureRecognizer:tap];
        
        
        
    }
    UIImageView *jxImg=[[UIImageView alloc]init];
    jxImg.image=[UIImage imageNamed:@"YMJingXi"];
    [qiandaoView addSubview:jxImg];
    [jxImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(qiandaoView.mas_top).offset(35);
        make.left.equalTo(qiandaoView.mas_left).offset(12+35+jianju);
        make.height.mas_equalTo(23);
        make.width.mas_equalTo(42);
    }];
    
    UILabel *jxLab=[[UILabel alloc]init];
    jxLab.frame=CGRectMake(6, 0.5, 30, 20);
    jxLab.textAlignment=NSTextAlignmentCenter;
    jxLab.font=[UIFont systemFontOfSize:FontSize(11)];
    jxLab.text=@"惊喜";
    jxLab.textColor=HEXCOLOR(0xC06300);
    [jxImg addSubview:jxLab];
    
    
    UIImageView *smImg=[[UIImageView alloc]init];
    smImg.image=[UIImage imageNamed:@"YMJingXi"];
    [qiandaoView addSubview:smImg];
    [smImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(qiandaoView.mas_top).offset(35);
        make.left.equalTo(qiandaoView.mas_right).offset(-53);
        make.height.mas_equalTo(23);
        make.width.mas_equalTo(42);
    }];
    
    UILabel *smLab=[[UILabel alloc]init];
    smLab.frame=CGRectMake(6, 0.5, 30, 20);
    smLab.textAlignment=NSTextAlignmentCenter;
    smLab.font=[UIFont systemFontOfSize:FontSize(11)];
    smLab.text=@"神秘";
    smLab.textColor=HEXCOLOR(0xC06300);
    [smImg addSubview:smLab];
    
    self.qiandaoBtn=[[UIButton alloc]init];
    [self.qiandaoBtn setTitle:@"签到" forState:0];
    self.qiandaoBtn.userInteractionEnabled=YES;
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
        CGColorRef color = CGColorCreate(colorSpaceRef, (CGFloat[]){1,0,0,1});
        [self.qiandaoBtn.layer setBorderWidth:2];
        [self.qiandaoBtn.layer setBorderColor:color];
    self.qiandaoBtn.layer.cornerRadius=19;
    self.qiandaoBtn.layer.masksToBounds=YES;
    [self.qiandaoBtn setTitleColor:[UIColor redColor] forState:0];
    [self.qiandaoBtn addTarget:self action:@selector(ClickQianDaoButton:) forControlEvents:UIControlEventTouchUpInside];
    [qiandaoView addSubview:self.qiandaoBtn];
    qiandaoView.userInteractionEnabled=YES;
    [self.qiandaoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(qiandaoView.mas_bottom).offset(-11);
        make.left.equalTo(qiandaoView.mas_left).offset(47.5);
        make.right.equalTo(qiandaoView.mas_right).offset(-47.5);
        make.height.mas_equalTo(38);
    }];
    
    UIView *choujiangView=[[UIView alloc]init];
    choujiangView.backgroundColor=[UIColor whiteColor];
    choujiangView.layer.cornerRadius=7;
    choujiangView.layer.masksToBounds = YES;
    [HeaderScroll addSubview:choujiangView];
    [choujiangView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(qiandaoView.mas_bottom).offset(10);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.height.mas_equalTo(200);
    }];
    
    UILabel *jfcjLab=[[UILabel alloc]init];
    jfcjLab.text=@"积分抽现金红包";
    jfcjLab.textColor=HEXCOLOR(0x333333);
    jfcjLab.font=[UIFont fontWithName:@"Helvetica" size:FontSize(15)];
    [choujiangView addSubview:jfcjLab];
    [jfcjLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(choujiangView.mas_top).offset(11);
        make.left.equalTo(choujiangView.mas_left).offset(12);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(120);
    }];
    
    UILabel *gzxqLab=[[UILabel alloc]init];
    gzxqLab.text=@"规则详情 >";
    gzxqLab.textColor=[UIColor lightGrayColor];
    gzxqLab.font=[UIFont systemFontOfSize:FontSize(12)];
    [choujiangView addSubview:gzxqLab];
    [gzxqLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(choujiangView.mas_top).offset(12);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(12);
        make.width.mas_equalTo(80);
    }];
    UITapGestureRecognizer *GuiZeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickGuiZeButton:)];
    gzxqLab.userInteractionEnabled = YES;
    [gzxqLab addGestureRecognizer:GuiZeTap];
    
    
    CGFloat hbjianju = (kScreenWidth -56 -84*3)/2.0;
    
    for (int i = 0; i < 3; i ++) {
        UIView *hbView = [[UIView alloc]initWithFrame:CGRectMake(18 + (84+hbjianju)*i, 42, 84, 120)];
        [choujiangView addSubview:hbView];
       
        FLAnimatedImageView *oneImgView = [[FLAnimatedImageView alloc] initWithFrame:CGRectMake(0, 5, 84, 100)];
        [hbView addSubview:oneImgView];
        
        UILabel *hbTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 120, 80*BiLi, 11*BiLi)];
        hbTitleLabel.font = [UIFont systemFontOfSize:FontSize(11)];
        hbTitleLabel.textAlignment = NSTextAlignmentCenter;
        hbTitleLabel.textColor = textMinorColor33;
        [hbView addSubview:hbTitleLabel];
        
        UILabel *zgkdLab=[[UILabel alloc]init];
        zgkdLab.text=@"最高可得";
        zgkdLab.textAlignment=NSTextAlignmentCenter;
        zgkdLab.textColor=[UIColor whiteColor];
        zgkdLab.font = [UIFont systemFontOfSize:FontSize(10)];
        [oneImgView addSubview:zgkdLab];
        [zgkdLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(oneImgView.mas_top).offset(54);
            make.left.equalTo(oneImgView.mas_left).offset(18.5);
            make.right.equalTo(oneImgView.mas_right).offset(-18.5);
            make.height.mas_equalTo(12);
        }];
       
        UILabel *jeLab=[[UILabel alloc]init];
        
        jeLab.textAlignment=NSTextAlignmentCenter;
        jeLab.textColor=[UIColor whiteColor];
        jeLab.font=[UIFont fontWithName:@"Helvetica" size:FontSize(22)];
        [oneImgView addSubview:jeLab];
        [jeLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(zgkdLab.mas_bottom).offset(6);
            make.left.equalTo(oneImgView.mas_left).offset(20);
            make.right.equalTo(oneImgView.mas_right).offset(-20);
            make.height.mas_equalTo(19);
        }];
        
        oneImgView.image=[UIImage imageNamed:@"YMHb"];
        if (i==0)
        {
            jeLab.text=@"¥3";
            hbTitleLabel.text = [NSString stringWithFormat:@"%d积分/次",i+3];
        }else if(i==1){
            jeLab.text=@"¥5";
            hbTitleLabel.text = [NSString stringWithFormat:@"%d积分/次",i+4];
        }else{
            jeLab.text=@"¥10";
            hbTitleLabel.text = [NSString stringWithFormat:@"%d积分/次",i+8];
        }
        
        hbView.tag = 676+i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapHbView:)];
        [hbView addGestureRecognizer:tap];
        
        
    }
    
    UILabel *loveLab=[[UILabel alloc]init];
    loveLab.text=@"← 您可能还喜欢 →";
    loveLab.textColor=[UIColor redColor];
    loveLab.textAlignment=NSTextAlignmentCenter;
    lxqdLab.font=[UIFont systemFontOfSize:FontSize(13)];
    [HeaderScroll addSubview:loveLab];
    [loveLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(choujiangView.mas_bottom).offset(15);
        make.left.equalTo(self.view.mas_left).offset(100);
        make.right.equalTo(self.view.mas_right).offset(-100);
        make.height.mas_equalTo(17);
        
    }];
    
    
    UITableView *rankListTab = [[UITableView alloc]init];
    rankListTab.delegate = self;
    rankListTab.dataSource = self;
    rankListTab.backgroundColor= [UIColor clearColor];
    rankListTab.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    rankListTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    rankListTab.estimatedRowHeight = 137;
    [HeaderScroll addSubview:rankListTab];
    [rankListTab mas_makeConstraints:^(MASConstraintMaker *make) {
    
     make.top.equalTo(loveLab.mas_bottom).offset(15);
    make.left.equalTo(self.view.mas_left).offset(10);
     make.right.equalTo(self.view.mas_right).offset(-10);
     make.height.mas_equalTo(kScreenHeight  -(iPhoneX?83:49));
    }];
   
    
}


#pragma mark TabView Detelgate
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ShopData *shopData = nil;
    if (indexPath.row < self.dataArr.count) {
        shopData = self.dataArr[indexPath.row];
    }
   
    RankListNewCell *cell = [RankListNewCell cellWithTableView:tableView];
    [cell configureRankListNewCellWithShopData:shopData withLabelStyle:@"07" indexPath:indexPath];
        return cell;
    
}
- (CGFloat ) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 137;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
}
- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self jifenStr];
    
    self.dataArr=[NSMutableArray array];
}


- (void)clickBackVC:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];

}

-(void)clickGuiZeButton:(UIGestureRecognizer *)sender{
    DMLog(@"规则详情");
    self.popView = [[PopView alloc]init];
    [self.popView setUpDailyRedGuiZeWithStr:@""];
    [self.view addSubview:self.popView];
}
-(void)clickhongbaoButton:(UIGestureRecognizer *)sender{
    DMLog(@"红包金额");
    YMIntegralViewController *VC=[[YMIntegralViewController alloc]init];
    VC.receivedTitle=@"红包金额";
    [self.navigationController pushViewController:VC animated:YES];
}
-(void)clickjifenButton:(UIGestureRecognizer *)sender{
    DMLog(@"我的积分");
    YMIntegralViewController *VC=[[YMIntegralViewController alloc]init];
    VC.receivedTitle=@"我的积分";
    [self.navigationController pushViewController:VC animated:YES];
}
-(void)ClickQianDaoButton:(UIButton *)sender{
    DMLog(@"签到第%ld天",sender.tag+1);
    [self.qiandaoBtn setTitle:@"签到第一天" forState:0];
    self.qiandaoBtn.userInteractionEnabled=NO;
    
}
-(void)OnTapTwoView:(UIGestureRecognizer *)sender{
    DMLog(@"签到第%ld天",sender.view.tag+1);
    
}
-(void)OnTapHbView:(UIGestureRecognizer *)sender{
    DMLog(@"拆红包");
    DMLog(@"111%ld",(long)sender.view.tag);
    self.popView = [[PopView alloc]init];
    switch (sender.view.tag) {
        case 676:
            [self.popView setUpregistMnyViewToView:self.view dmb:@"¥3"];
            break;
        case 677:
            [self.popView setUpregistMnyViewToView:self.view dmb:@"¥5"];
            break;
        case 678:
            [self.popView setUpregistMnyViewToView:self.view dmb:@"¥10"];
            break;
        default:
            break;
    }
   
    [self.popView setClickOkButtonRegisterView:^{
        
    }];
    [self.view addSubview:self.popView];
    
}
-(void)clickGuiZeView:(UIGestureRecognizer *)sender{
    DailyRedPacketWithdrawVC *WithdrawVC=[[DailyRedPacketWithdrawVC alloc]init];
    [self.navigationController pushViewController:WithdrawVC animated:YES];
}

@end
