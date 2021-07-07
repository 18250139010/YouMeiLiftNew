//
//  YMMyOrderViewController.m
//  youmeiLift
//
//  Created by mac on 2021/7/2.
//

#import "YMMyOrderViewController.h"
#import <Masonry.h>
#import "YMTaoBaoViewController.h"
@interface YMMyOrderViewController ()

@end

@implementation YMMyOrderViewController

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
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setImage:[UIImage imageNamed:@"back"] forState:0];
    cancelBtn.frame = CGRectMake(10, 2+(iPhoneX?44:20), 40, 40);
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [cancelBtn addTarget:self action:@selector(clickBackVC:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];

    UILabel *jifenLab=[[UILabel alloc]init];
    jifenLab.frame=CGRectMake((kScreenWidth-100)/2, 2+(iPhoneX?44:20), 100, 40);
    jifenLab.text=@"我的订单";
    jifenLab.textAlignment=NSTextAlignmentCenter;
    jifenLab.textColor=[UIColor blackColor];
    jifenLab.font=[UIFont systemFontOfSize:FontSize(18)];
    [self.view addSubview:jifenLab];
    
    
    UIView *otherOrderView = [[UIView alloc]init];
    otherOrderView.backgroundColor = [UIColor whiteColor];
    otherOrderView.layer.masksToBounds = YES;
    otherOrderView.layer.cornerRadius = 8.0f;
    [self.view addSubview:otherOrderView];
    
    [otherOrderView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.equalTo(self.view.mas_top).offset(12+(iPhoneX?88:64));
        make.left.equalTo(self.view.mas_left).offset(12);
        make.right.equalTo(self.view.mas_right).offset(-12);
        make.height.mas_equalTo(427);
    }];
    
    NSArray *otherTTArr  = @[@"淘宝",@"拼多多",@"京东",@"唯品会",@"苏宁易购",@"考拉海购",@"美团外卖"];
    NSArray *otherImgArr = @[[UIImage imageNamed:@"YM_PDD"],
                              [UIImage imageNamed:@"YM_PDD"],
                              [UIImage imageNamed:@"YM_PDD"],
                              [UIImage imageNamed:@"YM_PDD"],
                              [UIImage imageNamed:@"YM_PDD"],
                              [UIImage imageNamed:@"YM_PDD"],
                              [UIImage imageNamed:@"YM_PDD"],
                              ];
    
    for (int i = 0; i<otherTTArr.count; i++) {
        
        UIView *oneView = [[UIView alloc]initWithFrame:CGRectMake(0, 0+61*i, kScreenWidth - 24, 60)];
        [otherOrderView addSubview:oneView];
        
        UITapGestureRecognizer *otherOrderTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickOtherOrderView:)];
        [oneView addGestureRecognizer:otherOrderTap];
        
        
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(52, 0+61*i, kScreenWidth - 24 - 64, 1)];
        lineView.backgroundColor = ColorMaker(244, 244, 244, 255);
        [otherOrderView addSubview:lineView];
        if (i == 0) {
            lineView.backgroundColor = [UIColor whiteColor];
        }
        
        
        UIImageView *typeImgView = [[UIImageView alloc]init];
        typeImgView.image = otherImgArr[i];
        [oneView addSubview:typeImgView];
        
        [typeImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(oneView.mas_top).offset(11);
            make.left.equalTo(otherOrderView.mas_left).offset(11);
            make.size.mas_equalTo(CGSizeMake(33, 38));
        }];
        
        UIImageView *toImgView = [[UIImageView alloc]init];
        toImgView.image = [UIImage imageNamed:@"set_to.png"];
        [oneView addSubview:toImgView];
        
        [toImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(oneView.mas_top).offset(24);
            make.right.equalTo(otherOrderView.mas_right).offset(-12);
            make.size.mas_equalTo(CGSizeMake(7, 13));
        }];
        
        UILabel *tbTTLab = [[UILabel alloc]init];
        tbTTLab.text = otherTTArr[i];
        tbTTLab.textColor = textMinorColor33;
        tbTTLab.font = [UIFont systemFontOfSize:FontSize(15)];
        [oneView addSubview:tbTTLab];
        
        [tbTTLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(oneView.mas_top).offset(20);
            make.left.equalTo(typeImgView.mas_right).offset(10);
            make.height.mas_equalTo(20);
        }];

    }
  
    
}
- (void)clickOtherOrderView:(UIGestureRecognizer *)sender{
    
    for (id view in sender.view.subviews) {
        
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *lab = (UILabel *)view;
            NSLog(@"%@", lab.text);

            if ([lab.text isEqualToString:@"淘宝"]) {
                YMTaoBaoViewController *TaoBaoVC = [[YMTaoBaoViewController alloc]init];
//                TaoBaoVC.navTitle = @"淘宝";
//                TaoBaoVC.rateStr = self.rateStr;
                
                if (TaoBaoVC) {
                    [self.navigationController pushViewController:TaoBaoVC animated:YES];
                }
            }
            else{

            }

            
        }
        
    }
    
}

@end
