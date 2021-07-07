//
//  InformationVC.m
//  DaiMengJia
//
//  Created by 呆萌价 on 2018/4/8.
//  Copyright © 2018年 呆萌价. All rights reserved.
//

#import "YMSettingViewController.h"
#import "KeFuSetViewController.h"
@interface YMSettingViewController ()
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UIView *allOneView;
@property (weak, nonatomic) IBOutlet UIImageView *userImgView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLab;
@property (weak, nonatomic) IBOutlet UILabel *WhatchNameLab;

@property (strong, nonatomic) IBOutlet UILabel *tbsqTypeLab;
@property (strong, nonatomic) IBOutlet UILabel *zfbTypeLab;
@property (strong, nonatomic) IBOutlet UILabel *phoneTypeLab;

@property (strong, nonatomic) IBOutlet UILabel *kfTypeLab;
@property (strong, nonatomic) IBOutlet UILabel *tsTypeLab;
@property (strong, nonatomic) IBOutlet UILabel *shareDownTypeLab;
@property (strong, nonatomic) IBOutlet UILabel *cleanTypeLab;

@property (strong, nonatomic) IBOutlet UILabel *aboutMainTypeLab;

@property (strong, nonatomic) IBOutlet UILabel *feedbackTypeLab;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollRunHeight;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topHeight;


@property (strong, nonatomic) IBOutlet UILabel *pddSqLab;

@end

@implementation YMSettingViewController

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
    jifenLab.text=@"设置";
    jifenLab.textAlignment=NSTextAlignmentCenter;
    jifenLab.textColor=[UIColor blackColor];
    jifenLab.font=[UIFont systemFontOfSize:FontSize(18)];
    [navView addSubview:jifenLab];
    
//    self.scrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, (iPhoneX?88:64), kScreenWidth, kScreenHeight-(iPhoneX?88:64))];
//    [self.view addSubview:self.scrollView];
    
    //微信号修改昵称
    self.userNameLab.userInteractionEnabled = YES;
    UITapGestureRecognizer *nameTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickUserNameLab:)];
    [self.userNameLab addGestureRecognizer:nameTap];

    
}

-(void)clickUserNameLab:(UIGestureRecognizer *)sender{
    KeFuSetViewController *vc=[[KeFuSetViewController alloc]init];
    vc.type=@"填写微信号";
    [self.navigationController pushViewController:vc animated:YES];
}


@end
