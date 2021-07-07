//
//  OrderTimeVC.m
//  DaiMengJia
//
//  Created by 呆萌价 on 2018/5/15.
//  Copyright © 2018年 呆萌价. All rights reserved.
//

#import "OrderTimeVC.h"
#import "DMTool.h"
#import "Masonry.h"
@interface OrderTimeVC ()
@property (nonatomic, strong) UIVisualEffectView *visualEffectView;
@property (nonatomic, strong) UIView *totalView;
@property (strong, nonatomic) UIDatePicker *datePicker;
@property (nonatomic, copy) void (^passValueToButton)(NSString *str);
@property (nonatomic, copy) NSString *dateEndStr;
@property (nonatomic, copy) NSString *dateStartStr;

@property (nonatomic, copy) NSDate *contrastStartDate;
@property (nonatomic, copy) NSDate *contrastEndDate;
@property (nonatomic, copy) NSString *type;

@property (nonatomic, strong) UIView *timeView;

@property (nonatomic, strong) UIButton *endTimeBtn;
@property (nonatomic, strong) UIButton *startTimeBtn;


@end

@implementation OrderTimeVC


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}




- (void)viewDidLoad {
    [super viewDidLoad];

  
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, iPhoneX?88:64)];
    headerView.backgroundColor = kUIColorFromRGB(0xF2F2F2);
    [self.view addSubview:headerView];
    
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setImage:[UIImage imageNamed:@"back"] forState:0];
    cancelBtn.frame = CGRectMake(10, 2+(iPhoneX?44:20), 40, 40);
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [cancelBtn addTarget:self action:@selector(clickBackVC:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:cancelBtn];

    
    
    UILabel *ttLab = [[UILabel alloc]initWithFrame:CGRectMake(0, iPhoneX?44:20, kScreenWidth, 44)];
    ttLab.text = @"查询明细";
    ttLab.textColor = textMinorColor33;
    ttLab.font = [UIFont systemFontOfSize:FontSize(18)];
    ttLab.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:ttLab];
    
    
    
    self.timeView = [[UIView alloc]init];
    _timeView.backgroundColor = kUIColorFromRGB(0xF2F2F2);;
    [self.view addSubview:_timeView];
    
    [_timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(iPhoneX?88:64);

        make.left.equalTo(self.view.mas_left).offset(0);

        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 50));
    }];
    
    NSArray *ttArr = @[@"本日", @"近1周", @"近1月", @"近3月", @"近6月"];
    for (int i = 0; i < 5; i++) {
        
        UIButton *_timeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _timeBtn.frame = CGRectMake(20 + ((kScreenWidth - 40 - 250)/4.0 +50)*i, 13, 50, 24);
        [_timeBtn setTitle:ttArr[i] forState:0];
        [_timeBtn setTitleColor:textMinorColor forState:0];
        _timeBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(15)];
        _timeBtn.layer.masksToBounds = YES;
        _timeBtn.layer.cornerRadius = 6.0f;
       
        if (i == 0) {
            _timeBtn.layer.borderColor = DMColor.CGColor;
            _timeBtn.layer.borderWidth = 1.0f;
             [_timeBtn setTitleColor:DMColor forState:0];
            
        }
        
        [_timeBtn addTarget:self action:@selector(clickTimeButtonOnOrderTimeVC:) forControlEvents:UIControlEventTouchUpInside];
        _timeBtn.tag = 778+i;
        [_timeView addSubview:_timeBtn];
        
    }
    
    
    UILabel *startTimeTTLab = [[UILabel alloc]init];
    startTimeTTLab.text = @"起始时间";
    startTimeTTLab.textColor = textMinorColor;
    startTimeTTLab.font = [UIFont systemFontOfSize:FontSize(12)];
    startTimeTTLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:startTimeTTLab];
    
    [startTimeTTLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_timeView.mas_bottom).offset(50);
       
        make.left.equalTo(self.view.mas_left).offset(52*BiLi);
      
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *timeStr = [dateFormatter stringFromDate:[NSDate date]];
    
    self.startTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_startTimeBtn setTitle:timeStr forState:0];
    [_startTimeBtn setTitleColor:textMinorColor33 forState:0];
    _startTimeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:FontSize(16)];
    [_startTimeBtn addTarget:self action:@selector(clickStartTimeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_startTimeBtn];
    
    [_startTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(startTimeTTLab.mas_bottom).offset(10);
       
          make.left.equalTo(self.view.mas_left).offset(32*BiLi);

        make.size.mas_equalTo(CGSizeMake(120, 25));
    }];
    
    UILabel *toTTLab = [[UILabel alloc]init];
    toTTLab.text = @"至";
    toTTLab.textColor = textMinorColor;
    toTTLab.font = [UIFont systemFontOfSize:FontSize(12)];
    toTTLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:toTTLab];
    
    [toTTLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_timeView.mas_bottom).offset(66);
       
      make.centerX.mas_equalTo(self.view);
       
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    
    
    UILabel *endTimeTTLab = [[UILabel alloc]init];
    endTimeTTLab.text = @"截止时间";
    endTimeTTLab.textColor = textMinorColor;
    endTimeTTLab.font = [UIFont systemFontOfSize:FontSize(12)];
    endTimeTTLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:endTimeTTLab];
    
    [endTimeTTLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_timeView.mas_bottom).offset(50);
       
        make.right.equalTo(self.view.mas_right).offset(-52*BiLi);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    


    self.endTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_endTimeBtn setTitle:timeStr forState:0];
    [_endTimeBtn setTitleColor:textMinorColor33 forState:0];
    _endTimeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:FontSize(16)];
    [_endTimeBtn addTarget:self action:@selector(clickEndTimeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_endTimeBtn];
    
    [_endTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(endTimeTTLab.mas_bottom).offset(10);
       
       make.right.equalTo(self.view.mas_right).offset(-32*BiLi);
       
        make.size.mas_equalTo(CGSizeMake(120, 25));
    }];
    
   
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitle:@"确定" forState:0];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:0];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(16)];
    sureBtn.backgroundColor = kUIColorFromRGB(0xFA1560);
    sureBtn.layer.masksToBounds = YES;
    sureBtn.layer.cornerRadius = 16.5;
    
    [sureBtn addTarget:self action:@selector(clickSureButtonOnOrderTimeVC:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
    
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_timeView.mas_bottom).offset(150);
    
        make.centerX.mas_equalTo(self.view);
         make.size.mas_equalTo(CGSizeMake(kScreenWidth - 90, 33));
    }];
    
    

}


- (void)clickBackVC:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)clickStartTimeBtn:(UIButton *)sender{
    
    __weak typeof(self) mySelf = self;
    
    
    [self setPassValueToButton:^(NSString *str) {
        
        
        [sender setTitle:str forState:0];
        mySelf.dateStartStr = str;
        
    }];
   
    
    self.type = @"起始时间";
    [self setUpDatePickerViewWithStyleTitle:@"起始时间"];
    
    
}


- (void)clickEndTimeBtn:(UIButton *)sender{
    __weak typeof(self) mySelf = self;
    
    
    [self setPassValueToButton:^(NSString *str) {
        
        [sender setTitle:str forState:0];
        mySelf.dateStartStr = str;
        
    }];
    
    self.type = @"截止时间";
    [self setUpDatePickerViewWithStyleTitle:@"截止时间"];
    
}



- (void)setUpDatePickerViewWithStyleTitle:(NSString *)title{
    
    //实现模糊效果
    self.visualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    _visualEffectView.frame = self.view.bounds;
    _visualEffectView.alpha = 0.15;
    _visualEffectView.backgroundColor = [UIColor colorWithHue:0
                                                   saturation:0
                                                   brightness:0
                                                        alpha:1];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickBackgroundView:)];
    [_visualEffectView addGestureRecognizer:tap];
    
    self.totalView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 210, kScreenWidth, 210)];
    _totalView.backgroundColor = [UIColor whiteColor];
    
    
    //****
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(0, 0, 80, 45);
    // cancelBtn.backgroundColor = [UIColor yellowColor];
    [cancelBtn setTitle:@"取消" forState:0];
    [cancelBtn addTarget:self action:@selector(cliclCancelButtonWithDateView:) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitleColor:textMinorColor forState:0];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
    [self.totalView addSubview:cancelBtn];
    
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(kScreenWidth - 80, 0, 80, 45);
    [sureBtn setTitle:@"确定" forState:0];
    [sureBtn setTitleColor:DMColor forState:0];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
    [sureBtn addTarget:self action:@selector(clickSureButtonOnAddOrChangeBidVCDateEndButtonTotalView:) forControlEvents:UIControlEventTouchUpInside];
    [self.totalView addSubview:sureBtn];

    
    
   
    
    UILabel *markTTLab = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 100)/2.0, 10, 100, 25)];
    markTTLab.text = title;
    markTTLab.font = [UIFont systemFontOfSize:FontSize(14)];
    markTTLab.textColor = textMinorColor;
    markTTLab.textAlignment = NSTextAlignmentCenter;
    [self.totalView addSubview:markTTLab];
    
    UIView *btnDownLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 45, kScreenWidth, 1)];
    btnDownLineView.backgroundColor = halvingLineColor;
    [self.totalView addSubview:btnDownLineView];
    
    // ******
    self.datePicker = [[UIDatePicker alloc]init];
    _datePicker.datePickerMode = UIDatePickerModeDate;
    
    if (@available(iOS 13.4, *)) {
        _datePicker.preferredDatePickerStyle = UIDatePickerStyleWheels;
    } else {
        // Fallback on earlier versions
    }
    
    _datePicker.frame = CGRectMake(0, 45, [UIScreen mainScreen].bounds.size.width, 165);
    //最大日期
  
    
    if ([title isEqualToString:@"起始时间"]) {
        
        if (self.contrastEndDate) {
            _datePicker.maximumDate = self.contrastEndDate;
        }else{
            _datePicker.maximumDate=[[NSDate alloc] init];
        }
        
    }
    
    else if ([title isEqualToString:@"截止时间"]){
        
        _datePicker.minimumDate = self.contrastStartDate;
        
        _datePicker.maximumDate=[[NSDate alloc] init];
    }
    
    
    [_totalView addSubview:_datePicker];
    [self.view addSubview:_visualEffectView];
    [self.view addSubview:_totalView];
    
    
}



- (void)cliclCancelButtonWithDateView:(UIButton *)sender{
    
    
    [self.totalView removeFromSuperview];
    [self.visualEffectView removeFromSuperview];
    
    
}

- (void)clickBackgroundView:(UITapGestureRecognizer *)sender{
    
    [self.visualEffectView removeFromSuperview];
    [self.totalView removeFromSuperview];
    
    
}


- (void)clickSureButtonOnAddOrChangeBidVCDateEndButtonTotalView:(UIButton *)sender{
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *timeStr = [dateFormatter stringFromDate:self.datePicker.date];
    
    //对比时间
   
    
    if ([self.type isEqualToString:@"起始时间"]) {
        
       self.contrastStartDate = self.datePicker.date;
        
    }
    
    else if ([self.type isEqualToString:@"截止时间"]){
        
        self.contrastEndDate = self.datePicker.date;
    }
    
    //快选时间 还原
    for (id view in self.timeView.subviews) {
        
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)view;
            [btn setTitleColor:DMColor forState:0];
            btn.backgroundColor = [UIColor clearColor];
        }
        
        
    }
    
    self.passValueToButton(timeStr);
    
    [self.totalView removeFromSuperview];
    [self.visualEffectView removeFromSuperview];
    
    
    
}

- (void)clickTimeButtonOnOrderTimeVC:(UIButton *)sender{
    
   
    
    for (id view in self.timeView.subviews) {
        
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)view;
            [btn setTitleColor:textMinorColor forState:0];
            btn.backgroundColor = [UIColor clearColor];
            
            btn.layer.borderColor = [UIColor clearColor].CGColor;
            btn.layer.borderWidth = 0.0f;
        }
        
        
    }
    
    [sender setTitleColor:DMColor forState:0];
//    sender.backgroundColor = DMColor;
    sender.layer.borderColor = DMColor.CGColor;
    sender.layer.borderWidth = 1.0f;
    
    
    if ([sender.titleLabel.text isEqualToString:@"本日"]) {
       
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *timeStr = [dateFormatter stringFromDate:[NSDate date]];
        
         [_startTimeBtn setTitle:timeStr forState:0];
         [_endTimeBtn setTitle:timeStr forState:0];
        
       
        
    }
    else if ([sender.titleLabel.text isEqualToString:@"近1周"]) {
        
        //
        NSDate *zhouDate = [NSDate dateWithTimeIntervalSinceNow:-24*60*60*7];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *endTimeStr = [dateFormatter stringFromDate:[NSDate date]];
        NSString *startTimeStr = [dateFormatter stringFromDate:zhouDate];
        [_startTimeBtn setTitle:startTimeStr forState:0];
        [_endTimeBtn setTitle:endTimeStr forState:0];
        
       
        
    }
    else if ([sender.titleLabel.text isEqualToString:@"近1月"]) {
        
        
       DMLog(@"近1月 ==  %@", [self ddpGetExpectTimestamp:0 month:-1 day:0] ) ;
        
        
        NSString *startTimeStr = [self ddpGetExpectTimestamp:0 month:-1 day:0];
         [_startTimeBtn setTitle:startTimeStr forState:0];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *timeStr = [dateFormatter stringFromDate:[NSDate date]];
        [_endTimeBtn setTitle:timeStr forState:0];
        
    }
    else if ([sender.titleLabel.text isEqualToString:@"近3月"]) {
        NSString *startTimeStr = [self ddpGetExpectTimestamp:0 month:-3 day:0];
        [_startTimeBtn setTitle:startTimeStr forState:0];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *timeStr = [dateFormatter stringFromDate:[NSDate date]];
        [_endTimeBtn setTitle:timeStr forState:0];
        
    }else if ([sender.titleLabel.text isEqualToString:@"近6月"]) {
        NSString *startTimeStr = [self ddpGetExpectTimestamp:0 month:-6 day:0];
        [_startTimeBtn setTitle:startTimeStr forState:0];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *timeStr = [dateFormatter stringFromDate:[NSDate date]];
        [_endTimeBtn setTitle:timeStr forState:0];
        
    }
    
    
    
}

///< 获取当前时间的: 前一周(day:-7)丶前一个月(month:-30)丶前一年(year:-1)的时间戳
- (NSString *)ddpGetExpectTimestamp:(NSInteger)year month:(NSUInteger)month day:(NSUInteger)day {
    
    ///< 当前时间
    NSDate *currentdata = [NSDate date];
    
    ///< NSCalendar -- 日历类，它提供了大部分的日期计算接口，并且允许您在NSDate和NSDateComponents之间转换
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    /*
     ///<  NSDateComponents：时间容器，一个包含了详细的年月日时分秒的容器。
     ///< 下例：获取指定日期的年，月，日
     NSDateComponents *comps = nil;
     comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:currentdata];
     DMLog(@"年 year = %ld",comps.year);
     DMLog(@"月 month = %ld",comps.month);
     DMLog(@"日 day = %ld",comps.day);*/
    
    
    NSDateComponents *datecomps = [[NSDateComponents alloc] init];
    [datecomps setYear:year?:0];
    [datecomps setMonth:month?:0];
    [datecomps setDay:day?:0];
    
    ///< dateByAddingComponents: 在参数date基础上，增加一个NSDateComponents类型的时间增量
    NSDate *calculatedate = [calendar dateByAddingComponents:datecomps toDate:currentdata options:0];
    
    //快速选择的时候 需要确定起始时间的 对比
    self.contrastStartDate = calculatedate;
    
    ///< 打印推算时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *calculateStr = [formatter stringFromDate:calculatedate];
    
    DMLog(@"calculateStr 推算时间: %@",calculateStr );
    
    ///< 预期的推算时间
   // NSString *result = [NSString stringWithFormat:@"%ld", (long)[calculatedate timeIntervalSince1970]];
    
    return calculateStr;
}

- (void)clickSureButtonOnOrderTimeVC:(UIButton *)sender{
    
    
    DMLog(@"%@ \n%@",  self.startTimeBtn.titleLabel.text, self.endTimeBtn.titleLabel.text);
    
    self.passStartTimeAndEndTime(self.startTimeBtn.titleLabel.text, self.endTimeBtn.titleLabel.text);
    [self.navigationController popViewControllerAnimated:YES];
    
}







@end
