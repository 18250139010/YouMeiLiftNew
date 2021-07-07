//
//  RemindVC.m
//  DaiMengJia
//
//  Created by 呆萌价 on 2021/3/31.
//  Copyright © 2021 呆萌价. All rights reserved.
//

#import "RemindVC.h"
#import "DMTool.h"
#import "Masonry.h"
#import "DMTextTool.h"
#import "YJProgressHUD.h"
@interface RemindVC ()<UIScrollViewDelegate>
@property (strong, nonatomic) UIView *visualEffectView;
@property (strong, nonatomic) UIView *allView;
@property (strong, nonatomic) UIButton *periodBtn1;
@property (strong, nonatomic) UIButton *periodBtn2;
@property (strong, nonatomic) UIButton *periodBtn3;

@property (nonatomic, strong) UIDatePicker *datePicker;

@end

@implementation RemindVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)clickBackButtonView:(UIGestureRecognizer *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kUIColorFromRGB(0xFBF8EB);
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, iPhoneX?88:64)];
    headerView.backgroundColor = ColorMaker(255, 255, 255, 255);
    [self.view addSubview:headerView];
    
    UIView *backbBtnview = [[UIView alloc]initWithFrame:CGRectMake(0, iPhoneX?44:20, 44, 44)];
    // backbBtnview.backgroundColor = [UIColor yellowColor];
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(13, 10, 18, 24)];
    imgView.image = [UIImage imageNamed:@"navBack.png"];
    [backbBtnview addSubview:imgView];
    
    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickBackButtonView:)];
    [backbBtnview addGestureRecognizer:backTap];
    [headerView addSubview:backbBtnview];
    
    UILabel *ttLab = [[UILabel alloc]initWithFrame:CGRectMake(0, iPhoneX?44:20, kScreenWidth, 44)];
    ttLab.text =  @"订餐提醒";
    ttLab.textColor = textMinorColor33;
    ttLab.font = [UIFont systemFontOfSize:FontSize(18)];
    ttLab.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:ttLab];
    
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, iPhoneX?88:64, kScreenWidth, kScreenHeight - (iPhoneX?88:64))];
    scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight);
    scrollView.delegate = self;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
   //
    
    UIImageView *headerImgView = [[UIImageView alloc]init];
    headerImgView.image = [UIImage imageNamed:@"remind_header"];
    [scrollView addSubview:headerImgView];
    
    [headerImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scrollView.mas_top).offset(0);
        make.left.equalTo(scrollView.mas_left).offset(0);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 213*BiLi));
    }];
    
    UIView *timeView = [[UIView alloc]init];
    timeView.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:timeView];
    [timeView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerImgView.mas_bottom).offset(0);
        make.left.equalTo(scrollView.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth-20, 380));
    }];
    
    
    UIView *timeBlackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-20, 311)];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = timeBlackView.bounds;
    gradient.colors = [NSArray arrayWithObjects:
                       (id)kUIColorFromRGB(0xFFEA8A).CGColor,
                       (id)kUIColorFromRGB(0xEFD665).CGColor,
                                              nil];
    gradient.startPoint = CGPointMake(0.2, 0.3);
    gradient.endPoint = CGPointMake(0.8, 0.5);
    gradient.masksToBounds = YES;
    gradient.cornerRadius = 8;
    [timeBlackView.layer addSublayer:gradient];
    
    [timeView addSubview:timeBlackView];
    
    
    UIImageView *ttImgView = [[UIImageView alloc]init];
    ttImgView.image = [UIImage imageNamed:@"remind_timeTT"];
    [timeBlackView addSubview:ttImgView];
    
    [ttImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(timeBlackView.mas_top).offset(9);
        make.centerX.mas_equalTo(timeBlackView);
        make.size.mas_equalTo(CGSizeMake(107, 17));
    }];
    
    UIView *timeContentView = [[UIView alloc]init];
    timeContentView.backgroundColor = [UIColor whiteColor];
    timeContentView.layer.masksToBounds = YES;
    timeContentView.layer.cornerRadius = 8;
    [timeBlackView addSubview:timeContentView];
    
    [timeContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(timeBlackView.mas_top).offset(36);
        make.left.equalTo(timeBlackView.mas_left).offset(7);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 34, 252));
    }];
    
    for (int i =0; i<5; i++) {
        
        UIView *oneView = [[UIView alloc]initWithFrame:CGRectMake(0, 0+50.5*i, kScreenWidth - 34, 50)];
        [timeContentView addSubview:oneView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickOneTimeChooseView:)];
        [oneView addGestureRecognizer:tap];
        
        
        UILabel *ttLab = [[UILabel alloc]init];
        ttLab.text = @"每天";
        ttLab.textColor = textMinorColor99;
        ttLab.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
        [oneView addSubview:ttLab];
        
        [ttLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(oneView.mas_top).offset(9);
            make.left.equalTo(oneView.mas_left).offset(12);
            make.height.mas_equalTo(12);
        }];
        
        UILabel *timeLab = [[UILabel alloc]init];
        timeLab.text = @"11:30";
        timeLab.textColor = textMinorColor33;
        timeLab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
        [oneView addSubview:timeLab];
        
        [timeLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(oneView.mas_top).offset(28);
            make.left.equalTo(oneView.mas_left).offset(12);
            make.height.mas_equalTo(12);
        }];
        
        
        UIImageView *toImgView = [[UIImageView alloc]init];
        toImgView.image = [UIImage imageNamed:@"remind_to"];
        [oneView addSubview:toImgView];
        
        [toImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(oneView.mas_top).offset(27);
            make.left.equalTo(timeLab.mas_right).offset(12);
            make.size.mas_equalTo(CGSizeMake(14, 14));
        }];
        
        UISwitch *timeSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(kScreenWidth - 34-49-14, 12, 49, 25)];
        timeSwitch.onTintColor = kUIColorFromRGB(0xF0D767);
        timeSwitch.transform = CGAffineTransformMakeScale(0.7, 0.7);
        [timeSwitch addTarget:self action:@selector(clickOneTimeSwitch:) forControlEvents:UIControlEventTouchUpInside];
        
        [oneView addSubview:timeSwitch];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(12, 50+50.5*i, kScreenWidth - 34-24, 0.5)];
        lineView.backgroundColor = kUIColorFromRGB(0xF2F2F2);
        [timeContentView addSubview:lineView];
        
        
        
    }
    
    
    UIView *tipView = [[UIView alloc]init];
    tipView.backgroundColor = [UIColor whiteColor];
    tipView.layer.masksToBounds = YES;
    tipView.layer.cornerRadius = 8;
    [timeView addSubview:tipView];
    
    [tipView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(timeBlackView.mas_bottom).offset(3);
        make.left.equalTo(timeView.mas_left).offset(0);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 20, 66));
    }];
    
    UILabel *tipLab = [[UILabel alloc]init];
    NSString *tipStr = @"开启后将以推送通知消息提醒您，完成设置后可点击入口按钮【提醒我】进行时间调整";
    tipLab.textColor = kUIColorFromRGB(0xF17510);
    tipLab.font = [UIFont fontWithName:@"PingFangSC-Regular" size:FontSize(12)];
    tipLab.attributedText = [DMTextTool dm_changeLineSpace:2 str:tipStr];
    tipLab.numberOfLines = 0;
    [tipView addSubview:tipLab];
    
    [tipLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tipView.mas_top).offset(22);
        make.left.equalTo(tipView.mas_left).offset(15);
        make.right.equalTo(tipView.mas_right).offset(-15);
    }];
    
    UIImageView *dingImgView1 = [[UIImageView alloc]init];
    dingImgView1.image = [UIImage imageNamed:@"remind_ding"];
    [timeView addSubview:dingImgView1];
    
    [dingImgView1 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(timeContentView.mas_bottom).offset(10);
        make.left.equalTo(timeView.mas_left).offset(61*BiLi);
        make.size.mas_equalTo(CGSizeMake(13, 35));
    }];
    
    
    UIImageView *dingImgView2 = [[UIImageView alloc]init];
    dingImgView2.image = [UIImage imageNamed:@"remind_ding"];
    [timeView addSubview:dingImgView2];
    
    [dingImgView2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(timeContentView.mas_bottom).offset(10);
        make.right.equalTo(timeView.mas_right).offset(-61*BiLi);
        make.size.mas_equalTo(CGSizeMake(13, 35));
    }];
    
}

- (void)clickOneTimeSwitch:(UISwitch *)sender{

    [YJProgressHUD showMessage:@"设置成功，将在06:30提醒您" inView:self.view]; 
    
}

- (void)clickOneTimeChooseView:(UIGestureRecognizer *)sender{
    
    self.visualEffectView = [[UIView alloc]init];
   _visualEffectView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
   _visualEffectView.backgroundColor = ColorMaker(0, 0, 0, 153);
    [self.view addSubview:_visualEffectView];

   
   UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickVisualEffectView:)];
   [_visualEffectView addGestureRecognizer:tap];
   
      
    self.allView = [[UIView alloc]init];
    _allView.frame = CGRectMake(0, kScreenHeight-450-(iPhoneX?34:0), kScreenWidth, 450+(iPhoneX?34:0));
   _allView.backgroundColor = [UIColor whiteColor];
    _allView.layer.masksToBounds = YES;
    _allView.layer.cornerRadius = 8;
    [self.view addSubview:_allView];
    
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(0, 0, 60, 48);
    [cancelBtn setTitle:@"取消" forState:0];
    [cancelBtn setTitleColor:kUIColorFromRGB(0x222222) forState:0];
    cancelBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:FontSize(14)];
    [cancelBtn addTarget:self action:@selector(clickCancleButton:) forControlEvents:UIControlEventTouchUpInside];
    [_allView addSubview:cancelBtn];
    
    UILabel *ttLab = [[UILabel alloc]init];
    ttLab.text = @"选择提醒时间";
    ttLab.textColor = kUIColorFromRGB(0x222222);
    ttLab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:FontSize(16)];
    ttLab.textAlignment = NSTextAlignmentCenter;
    [_allView addSubview:ttLab];
    
    [ttLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_allView.mas_top).offset(0);
        make.left.equalTo(_allView.mas_left).offset(60);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 120, 48));
    }];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = kUIColorFromRGB(0xF0F0F0);
    [_allView addSubview:lineView];
    
    [lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_allView.mas_top).offset(48);
        make.left.equalTo(_allView.mas_left).offset(0);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 0.5));
    }];
    
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
   // datePicker.backgroundColor = [UIColor yellowColor];
    //设置地区: zh-中国
    datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"en_GB"];
    //设置日期模式(Displays month, day, and year depending on the locale setting)
    datePicker.datePickerMode = UIDatePickerModeCountDownTimer;
    // 设置当前显示时间
    [datePicker setDate:[NSDate date] animated:YES];
    // 设置显示最大时间（此处为当前时间）
    [datePicker setMaximumDate:[NSDate date]];
    datePicker.datePickerMode = UIDatePickerModeTime;
    
    
    //设置时间格式
    if (@available(iOS 13.4, *)) {
        datePicker.preferredDatePickerStyle = UIDatePickerStyleWheels;
    } else {
        // Fallback on earlier versions
    }
    datePicker.frame = CGRectMake(0, 50, kScreenWidth, 220);
    //监听DataPicker的滚动
    [datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
        
    self.datePicker = datePicker;

    [_allView addSubview:datePicker];
    
    
    
    
    UIView *lineView2 = [[UIView alloc]init];
    lineView2.backgroundColor = kUIColorFromRGB(0xF0F0F0);
    [_allView addSubview:lineView2];
    
    [lineView2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_allView.mas_top).offset(272);
        make.left.equalTo(_allView.mas_left).offset(0);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 0.5));
    }];
    
    UILabel *periodLab = [[UILabel alloc]init];
    periodLab.text = @"重复周期";
    periodLab.textColor = kUIColorFromRGB(0x222222);
    periodLab.font = [UIFont fontWithName:@"PingFangSC-Regular" size:FontSize(14)];
   
    [_allView addSubview:periodLab];
    
    [periodLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView2.mas_bottom).offset(17);
        make.left.equalTo(_allView.mas_left).offset(14);
        make.height.mas_equalTo(15);
    }];
    
    
    self.periodBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_periodBtn1 setTitle:@"周一至周五" forState:0];
    [_periodBtn1 setTitleColor:textMinorColor99 forState:0];
    _periodBtn1.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:FontSize(14)];
    _periodBtn1.layer.masksToBounds = YES;
    _periodBtn1.layer.cornerRadius = 4;
    _periodBtn1.layer.borderWidth = 1;
    _periodBtn1.layer.borderColor = kUIColorFromRGB(0xF0F0F0).CGColor;
    [_periodBtn1 addTarget:self action:@selector(clickPeriodBtn1:) forControlEvents:UIControlEventTouchUpInside];
    [_allView addSubview:_periodBtn1];
    
    [_periodBtn1 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView2.mas_bottom).offset(47);
        make.left.equalTo(_allView.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(102, 36));
    }];
    
    
    self.periodBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_periodBtn2 setTitle:@"周末" forState:0];
    [_periodBtn2 setTitleColor:textMinorColor99 forState:0];
    _periodBtn2.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:FontSize(14)];
    _periodBtn2.layer.masksToBounds = YES;
    _periodBtn2.layer.cornerRadius = 4;
    _periodBtn2.layer.borderWidth = 1;
    _periodBtn2.layer.borderColor = kUIColorFromRGB(0xF0F0F0).CGColor;
    [_periodBtn2 addTarget:self action:@selector(clickPeriodBtn2:) forControlEvents:UIControlEventTouchUpInside];
    [_allView addSubview:_periodBtn2];
    
    [_periodBtn2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView2.mas_bottom).offset(47);
        make.left.equalTo(_periodBtn1.mas_right).offset(16);
        make.size.mas_equalTo(CGSizeMake(60, 36));
    }];
    
    
    
    self.periodBtn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_periodBtn3 setTitle:@"每天" forState:0];
    [_periodBtn3 setTitleColor:textMinorColor99 forState:0];
    _periodBtn3.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:FontSize(14)];
    _periodBtn3.layer.masksToBounds = YES;
    _periodBtn3.layer.cornerRadius = 4;
    _periodBtn3.layer.borderWidth = 1;
    _periodBtn3.layer.borderColor = kUIColorFromRGB(0xF0F0F0).CGColor;
    [_periodBtn3 addTarget:self action:@selector(clickPeriodBtn3:) forControlEvents:UIControlEventTouchUpInside];
    [_allView addSubview:_periodBtn3];
    
    [_periodBtn3 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView2.mas_bottom).offset(47);
        make.left.equalTo(_periodBtn2.mas_right).offset(16);
        make.size.mas_equalTo(CGSizeMake(60, 36));
    }];
    
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn setTitle:@"保存" forState:0];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:0];
    saveBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:FontSize(16)];
    saveBtn.layer.masksToBounds = YES;
    saveBtn.layer.cornerRadius = 20;
    saveBtn.backgroundColor = kUIColorFromRGB(0x10B2F1);
    [saveBtn addTarget:self action:@selector(clickSaveButton:) forControlEvents:UIControlEventTouchUpInside];
    [_allView addSubview:saveBtn];
    
    [saveBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView2.mas_bottom).offset(119);
        make.left.equalTo(_allView.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 20, 40));
    }];
    
    
}


- (void)dateChange:(UIDatePicker *)datePicker {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    //设置时间格式
    formatter.dateFormat = @"yyyy年 MM月 dd日";
    NSString *dateStr = [formatter  stringFromDate:datePicker.date];
    
   
}




-(void)clickCancleButton:(UIButton *)sender{
    [_visualEffectView removeFromSuperview];
    [_allView removeFromSuperview];
}
-(void)clickVisualEffectView:(UIGestureRecognizer *)sender{
    
    [_visualEffectView removeFromSuperview];
    [_allView removeFromSuperview];
    
}


- (void)clickPeriodBtn1:(UIButton *)sender{
    
    [_periodBtn1 setBackgroundColor:kUIColorFromRGB(0xDDF5FF)];
    [_periodBtn1 setTitleColor:kUIColorFromRGB(0x10B2F1) forState:0];
    _periodBtn1.layer.borderColor = kUIColorFromRGB(0x10B2F1).CGColor;
    
    [_periodBtn2 setBackgroundColor:kUIColorFromRGB(0xFFFFFF)];
    [_periodBtn2 setTitleColor:kUIColorFromRGB(0x999999) forState:0];
    _periodBtn2.layer.borderColor = kUIColorFromRGB(0xF0F0F0).CGColor;
    
    [_periodBtn3 setBackgroundColor:kUIColorFromRGB(0xFFFFFF)];
    [_periodBtn3 setTitleColor:kUIColorFromRGB(0x999999) forState:0];
    _periodBtn3.layer.borderColor = kUIColorFromRGB(0xF0F0F0).CGColor;
    
    
}

- (void)clickPeriodBtn2:(UIButton *)sender{
    
    [_periodBtn2 setBackgroundColor:kUIColorFromRGB(0xDDF5FF)];
    [_periodBtn2 setTitleColor:kUIColorFromRGB(0x10B2F1) forState:0];
    _periodBtn2.layer.borderColor = kUIColorFromRGB(0x10B2F1).CGColor;
    
    [_periodBtn1 setBackgroundColor:kUIColorFromRGB(0xFFFFFF)];
    [_periodBtn1 setTitleColor:kUIColorFromRGB(0x999999) forState:0];
    _periodBtn1.layer.borderColor = kUIColorFromRGB(0xF0F0F0).CGColor;
    
    [_periodBtn3 setBackgroundColor:kUIColorFromRGB(0xFFFFFF)];
    [_periodBtn3 setTitleColor:kUIColorFromRGB(0x999999) forState:0];
    _periodBtn3.layer.borderColor = kUIColorFromRGB(0xF0F0F0).CGColor;
    
}

- (void)clickPeriodBtn3:(UIButton *)sender{
    
    [_periodBtn3 setBackgroundColor:kUIColorFromRGB(0xDDF5FF)];
    [_periodBtn3 setTitleColor:kUIColorFromRGB(0x10B2F1) forState:0];
    _periodBtn3.layer.borderColor = kUIColorFromRGB(0x10B2F1).CGColor;
    
    [_periodBtn2 setBackgroundColor:kUIColorFromRGB(0xFFFFFF)];
    [_periodBtn2 setTitleColor:kUIColorFromRGB(0x999999) forState:0];
    _periodBtn2.layer.borderColor = kUIColorFromRGB(0xF0F0F0).CGColor;
    
    [_periodBtn1 setBackgroundColor:kUIColorFromRGB(0xFFFFFF)];
    [_periodBtn1 setTitleColor:kUIColorFromRGB(0x999999) forState:0];
    _periodBtn1.layer.borderColor = kUIColorFromRGB(0xF0F0F0).CGColor;
    
}

-(void)clickSaveButton:(UIButton *)sender{
    
    
    
}

@end
