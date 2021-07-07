//
//  PopView.m
//  youmeiLift
//
//  Created by mac on 2021/6/29.
//

#import "PopView.h"
#import <Masonry.h>
#import "DMTextTool.h"
@implementation PopView

//红包兑换奖励

- (void)setUpregistMnyViewToView:(UIView *)upperView dmb:(NSString *)dmbStr{
    
    //实现模糊效果
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
            self.visualEffectView = [[UIView alloc] init];
        self.visualEffectView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        self.visualEffectView.backgroundColor = ColorMaker(0, 0, 0, 153);
        self.visualEffectView.alpha = 0;
           
           UIWindow* window =  [UIApplication sharedApplication].keyWindow;
            [window addSubview:self.visualEffectView];
           
           self.allView = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth - 375)/2.0, (upperView.frame.size.height - 401 - 19 - 51)/2.0   - (iPhoneX?35:10*BiLi), 375, 401+19+51)];
        self.allView.backgroundColor = [UIColor clearColor];
        self.allView.alpha = 0;
           [window addSubview:self.allView];
           

        
          //兑换红包奖励
           UIImageView *headerImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 375, 338)];
           headerImgView.image = [UIImage imageNamed:@"TCXJHb.png"];
           [self.allView addSubview:headerImgView];
           
           UILabel *countLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 84, 375, 45)];
           countLab.text = dmbStr;
           countLab.textColor = [UIColor colorWithRed:250/255.0 green:16/255.0 blue:28/255.0 alpha:1];
           countLab.font = [UIFont systemFontOfSize:FontSize(50)];
           countLab.textAlignment = NSTextAlignmentCenter;
           countLab.numberOfLines = 0;
        
           countLab.adjustsFontSizeToFitWidth = YES;
           [self.allView addSubview:countLab];
           
                   
        UILabel *gxLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 124, 375, 45)];
        gxLab.text = @"恭喜获得";
        gxLab.textColor = [UIColor colorWithRed:250/255.0 green:16/255.0 blue:28/255.0 alpha:1];
        gxLab.font = [UIFont systemFontOfSize:FontSize(16)];
        gxLab.textAlignment = NSTextAlignmentCenter;
        gxLab.numberOfLines = 0;
     
        gxLab.adjustsFontSizeToFitWidth = YES;
        [self.allView addSubview:gxLab];
        
        
           //关闭按钮
           UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
           
           deleteBtn.frame = CGRectMake(kScreenWidth-40-40, 10, 30, 30);
           [deleteBtn setBackgroundImage:[UIImage imageNamed:@"TCBack.png"] forState:0];
           
        [deleteBtn addTarget:self action:@selector(clickDeleteButtonOnRegisterView:) forControlEvents:UIControlEventTouchUpInside];
           [self.allView addSubview:deleteBtn];
        
        
           [UIView animateWithDuration:0.4 delay:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
               // 执行动画
               self.visualEffectView.alpha +=1;
               self.allView.alpha += 1;
               
           } completion:^(BOOL finished) {

           }];
        
           
    });
}

//红包兑换奖励

- (void)setUpregistChaiViewToView:(UIView *)upperView{
    
    //实现模糊效果
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
            self.visualEffectView = [[UIView alloc] init];
        self.visualEffectView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        self.visualEffectView.backgroundColor = ColorMaker(0, 0, 0, 153);
        self.visualEffectView.alpha = 0;
           
           UIWindow* window =  [UIApplication sharedApplication].keyWindow;
            [window addSubview:self.visualEffectView];
           
           self.allView = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth - 375)/2.0, (upperView.frame.size.height - 401 - 19 - 51)/2.0   - (iPhoneX?35:10*BiLi), 375, 401+19+51)];
        self.allView.backgroundColor = [UIColor clearColor];
        self.allView.alpha = 0;
           [window addSubview:self.allView];
           

        
          //兑换红包奖励
           UIImageView *headerImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 375, 338)];
           headerImgView.image = [UIImage imageNamed:@"TCChai.png"];
           [self.allView addSubview:headerImgView];

           //关闭按钮
           UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
           
           deleteBtn.frame = CGRectMake(kScreenWidth-40-40, 10, 30, 30);
           [deleteBtn setBackgroundImage:[UIImage imageNamed:@"TCBack.png"] forState:0];
           
        [deleteBtn addTarget:self action:@selector(clickDeleteButtonOnRegisterView:) forControlEvents:UIControlEventTouchUpInside];
           [self.allView addSubview:deleteBtn];
        
        
           [UIView animateWithDuration:0.4 delay:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
               // 执行动画
               self.visualEffectView.alpha +=1;
               self.allView.alpha += 1;
               
           } completion:^(BOOL finished) {

           }];
        
           
    });
}
//红包规则明细
- (void)setUpDailyRedGuiZeWithStr:(NSString *)guiZeStr{
    
    UIWindow* window =  [UIApplication sharedApplication].keyWindow;
    //实现模糊效果
    self.visualEffectView = [[UIView alloc]init];
   _visualEffectView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
   _visualEffectView.backgroundColor = ColorMaker(0, 0, 0, 153);
   _visualEffectView.tag = 9090;
    [window addSubview:_visualEffectView];

   
   UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickShareToWxAndQQViewBackView:)];
   [_visualEffectView addGestureRecognizer:tap];
   
      
    self.allView = [[UIView alloc]init];
    _allView.frame = CGRectMake(0, 0, 273, 300);
   _allView.backgroundColor = [UIColor whiteColor];
    _allView.center = window.center;
    _allView.layer.masksToBounds = YES;
    _allView.layer.cornerRadius = 8;
    [window addSubview:_allView];
    
    
    UILabel *ttLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 17, 273, 20)];
    ttLab.text = @"抽现金红包规则";
    ttLab.font = [UIFont fontWithName:@"PingFangSC-Regular" size:FontSize(16)];
    ttLab.textColor = kUIColorFromRGB(0x000000);
    ttLab.textAlignment = NSTextAlignmentCenter;
    [_allView addSubview:ttLab];
    
    UILabel *countLab = [[UILabel alloc]init];
    countLab.font = [UIFont fontWithName:@"PingFangSC-Regular" size:FontSize(13)];
    countLab.textColor = textMinorColor99;
    countLab.numberOfLines = 0;
    NSString *str = @"1、活动期间可分别使用3积分、5积分、10积分抽取现金红包，最高可分别获得3元、5元、10元。\n 2、同一用户每天有5次抽红包机会，当日有效。\n 3、每天24点重置次数，不累加。\n 4、抽到的现金红包累计超过0.5元可提现。";
    
    if ([guiZeStr isEqualToString:@"(null)"] || guiZeStr.length == 0) {
        guiZeStr = str;
    }
    countLab.attributedText = [DMTextTool dm_changeLineSpace:3 str:guiZeStr];
    [_allView addSubview:countLab];
    
    [countLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_allView.mas_top).offset(50);
        make.left.equalTo(_allView.mas_left).offset(15);
        make.width.mas_equalTo(243);
    }];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 246, 273, 0.5)];
    lineView.backgroundColor = kUIColorFromRGB(0xEDEDED);
    [_allView addSubview:lineView];
    
    UIButton *iKonwBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    iKonwBtn.frame = CGRectMake(0, 247, 273, 53);
    [iKonwBtn setTitle:@"我知道了" forState:0];
    [iKonwBtn setTitleColor:textMinorColor33 forState:0];
    iKonwBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:FontSize(18)];
    [iKonwBtn addTarget:self action:@selector(clickIKnowBtnToDailyRedGuiZe:) forControlEvents:UIControlEventTouchUpInside];
    [_allView addSubview:iKonwBtn];
    
    
}
- (void)clickDeleteButtonOnRegisterView:(UIButton *)sender{
    
    
    [self.allView removeFromSuperview];
    [self.visualEffectView removeFromSuperview];
    
    self.clickOkButtonRegisterView();
}

- (void)clickShareToWxAndQQViewBackView:(UIGestureRecognizer *)sender{
    [self.allView removeFromSuperview];
    [self.visualEffectView removeFromSuperview];
}
-(void)clickIKnowBtnToDailyRedGuiZe:(UIButton *)sender{
    [self.allView removeFromSuperview];
    [self.visualEffectView removeFromSuperview];
}
    
@end
