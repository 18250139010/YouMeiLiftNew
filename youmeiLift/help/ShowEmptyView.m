//
//  ShowEmptyView.m
//  DaiMengJia
//
//  Created by 呆萌价 on 2019/3/9.
//  Copyright © 2019年 呆萌价. All rights reserved.
//

#import "ShowEmptyView.h"
#import "DMTool.h"
@interface ShowEmptyView ()
@property (nonatomic, copy) AlertViewBlock block;
@property (nonatomic, copy) TryAgainBlock tryAgainblock;

@property (nonatomic, strong)  UIView *allView;

@end

@implementation ShowEmptyView

- (instancetype)init{
    
    if (self = [super init]) {
        
    }
    return self;
}
- (void)showeEmptyTipsToView:(UIView *)view title:(NSString *)title message:(NSString *)message imageType:(NSString* )imageType tryAgain:(TryAgainBlock)tryAgain{
    
    view.backgroundColor = allBackgroundColor;
    
    CGFloat width = view.frame.size.width;
    CGFloat height = view.frame.size.height;
    
    
    self.allView = [[UIView alloc]init];
    _allView.backgroundColor = allBackgroundColor;
    [view addSubview:_allView];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((width - 190)/2.0, (_allView.frame.size.height- 190)/2.0 - 190/2.0, 190, 190)];
    [_allView addSubview:imageView];
    
    
    DMLog(@"%f   %f", width, height);
    imageView.userInteractionEnabled = YES;
    _allView.userInteractionEnabled = YES;
    UITapGestureRecognizer *imageTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickEmptyImageView:)];
    [_allView addGestureRecognizer:imageTap];
    
    [self setBlock:^(NSInteger buttonTag) {
        DMLog(@"buttonTag == %ld", (long)buttonTag);
        tryAgain(buttonTag);
    }];
    
    UIImage *image = [[UIImage alloc]init];
    if ([imageType isEqualToString:@"noNetRec"]) {
        
        _allView.frame = CGRectMake(0, 0, width, height );
        image = [UIImage imageNamed:@"no_net.png"];
        imageView.frame = CGRectMake((width - 190)/2.0, (height- 190)/2.0 - 190/2.0, 190, 190);
        
        UILabel *ttLab = [[UILabel alloc]initWithFrame:CGRectMake(0, imageView.frame.origin.y +190+20, width, 20)];
        ttLab.text = title;
        ttLab.textColor = textMinorColor33;
        ttLab.font = [UIFont systemFontOfSize:FontSize(16)];
        ttLab.textAlignment = NSTextAlignmentCenter;
        [_allView addSubview:ttLab];
        
        UILabel *messageLab = [[UILabel alloc]initWithFrame:CGRectMake((width-88)/2.0, ttLab.frame.origin.y +20+15, 88, 34)];
        messageLab.text = @"刷新一下";
        messageLab.textColor = textMinorColor33;
        messageLab.font = [UIFont systemFontOfSize:FontSize(14)];
        messageLab.textAlignment = NSTextAlignmentCenter;
        messageLab.layer.masksToBounds = YES;
        messageLab.layer.cornerRadius = 17;
        messageLab.layer.borderWidth = 0.5;
        messageLab.layer.borderColor = textMinorColor.CGColor;
        [_allView addSubview:messageLab];
        
    }
    else if ([imageType isEqualToString:@"noNetClassify"]){
        _allView.frame = CGRectMake(0, iPhoneX?88:64, width, height - (iPhoneX?88:64));
        image = [UIImage imageNamed:@"no_net.png"];
        imageView.frame = CGRectMake((width - 190)/2.0, (_allView.frame.size.height- 190)/2.0 - 190/2.0, 190, 190);
        
        UILabel *ttLab = [[UILabel alloc]initWithFrame:CGRectMake(0, imageView.frame.origin.y +190+20, width, 20)];
        ttLab.text = title;
        ttLab.textColor = textMinorColor33;
        ttLab.font = [UIFont systemFontOfSize:FontSize(16)];
        ttLab.textAlignment = NSTextAlignmentCenter;
        [_allView addSubview:ttLab];
        
        UILabel *messageLab = [[UILabel alloc]initWithFrame:CGRectMake((width-88)/2.0, ttLab.frame.origin.y +20+15, 88, 34)];
        messageLab.text = @"刷新一下";
        messageLab.textColor = textMinorColor33;
        messageLab.font = [UIFont systemFontOfSize:FontSize(14)];
        messageLab.textAlignment = NSTextAlignmentCenter;
        messageLab.layer.masksToBounds = YES;
        messageLab.layer.cornerRadius = 17;
        messageLab.layer.borderWidth = 0.5;
        messageLab.layer.borderColor = textMinorColor.CGColor;
        [_allView addSubview:messageLab];
        
    }
    else if ([imageType isEqualToString:@"noNet"]){
        
        _allView.frame = CGRectMake(0, 0, width, height);
        image = [UIImage imageNamed:@"no_net.png"];
        imageView.frame = CGRectMake((width - 190)/2.0, (_allView.frame.size.height- 190)/2.0 - 190/2.0, 190, 190);
        
        UILabel *ttLab = [[UILabel alloc]initWithFrame:CGRectMake(0, imageView.frame.origin.y +190+20, width, 20)];
        ttLab.text = title;
        ttLab.textColor = textMinorColor33;
        ttLab.font = [UIFont systemFontOfSize:FontSize(16)];
        ttLab.textAlignment = NSTextAlignmentCenter;
        [_allView addSubview:ttLab];
        
        UILabel *messageLab = [[UILabel alloc]initWithFrame:CGRectMake((width-88)/2.0, ttLab.frame.origin.y +20+15, 88, 34)];
        messageLab.text = @"刷新一下";
        messageLab.textColor = textMinorColor33;
        messageLab.font = [UIFont systemFontOfSize:FontSize(14)];
        messageLab.textAlignment = NSTextAlignmentCenter;
        messageLab.layer.masksToBounds = YES;
        messageLab.layer.cornerRadius = 17;
        messageLab.layer.borderWidth = 0.5;
        messageLab.layer.borderColor = textMinorColor.CGColor;
        [_allView addSubview:messageLab];
        
    }
    else if ([imageType isEqualToString:@"noSC"]){
        
        _allView.frame = CGRectMake(0, 0, width, height);
        _allView.backgroundColor = ColorMaker(244, 244, 244, 255);
        image = [UIImage imageNamed:@"no_sc.png"];
        imageView.frame = CGRectMake((width - 190)/2.0, (_allView.frame.size.height- 190)/2.0 - 190/2.0 - (iPhoneX?64:0), 190, 190);
        
        UILabel *ttLab = [[UILabel alloc]initWithFrame:CGRectMake(0, imageView.frame.origin.y +190+20, width, 20)];
        ttLab.text = title;
        ttLab.textColor = textMinorColor33;
        ttLab.font = [UIFont systemFontOfSize:FontSize(16)];
        ttLab.textAlignment = NSTextAlignmentCenter;
        [_allView addSubview:ttLab];
        
        UILabel *messageLab = [[UILabel alloc]initWithFrame:CGRectMake((width-88)/2.0, ttLab.frame.origin.y +20+15, 88, 34)];
        messageLab.text = message;
        messageLab.textColor = textMinorColor33;
        messageLab.font = [UIFont systemFontOfSize:FontSize(14)];
        messageLab.textAlignment = NSTextAlignmentCenter;
        messageLab.layer.masksToBounds = YES;
        messageLab.layer.cornerRadius = 17;
        messageLab.layer.borderWidth = 0.5;
        messageLab.layer.borderColor = textMinorColor.CGColor;
        [_allView addSubview:messageLab];
    }
    else if ([imageType isEqualToString:@"noScSearch"]){
        
        _allView.frame = CGRectMake(0, iPhoneX?88:64, width, height - (iPhoneX?88:64));
        _allView.backgroundColor = ColorMaker(244, 244, 244, 255);
        image = [UIImage imageNamed:@"no_sc_new.png"];
        imageView.frame = CGRectMake((width - 204)/2.0, (_allView.frame.size.height- 143)/2.0 - 143/2.0 - (iPhoneX?64:0), 204, 143);
        
        UILabel *ttLab = [[UILabel alloc]initWithFrame:CGRectMake(0, imageView.frame.origin.y +143+20, width, 22)];
        ttLab.text = title;
        ttLab.textColor = textMinorColor33;
        ttLab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:FontSize(18)];
        ttLab.textAlignment = NSTextAlignmentCenter;
        [_allView addSubview:ttLab];
        
        UILabel *messageLab = [[UILabel alloc]initWithFrame:CGRectMake(0, ttLab.frame.origin.y +20+5, width, 20)];
        messageLab.text = message;
        messageLab.textColor = textMinorColor;
        messageLab.font = [UIFont systemFontOfSize:FontSize(15)];
        messageLab.textAlignment = NSTextAlignmentCenter;
        [_allView addSubview:messageLab];
        
        UIButton *goToHomeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        goToHomeBtn.frame = CGRectMake((width - 149)/2.0, messageLab.frame.origin.y +20+15, 149, 40);
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = goToHomeBtn.bounds;
        gradient.colors = [NSArray arrayWithObjects:
                           (id)kUIColorFromRGB(0xFA0760).CGColor,
                           (id)kUIColorFromRGB(0xFB0232).CGColor,
                           nil];
        gradient.startPoint = CGPointMake(0.2, 0.3);
        gradient.endPoint = CGPointMake(0.8, 0.5);
        gradient.cornerRadius = 20.0f;
        [goToHomeBtn.layer addSublayer:gradient];
        
        [goToHomeBtn setTitle:@"去首页逛逛" forState:0];
        [goToHomeBtn setTitleColor:[UIColor whiteColor] forState:0];
        goToHomeBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(18)];
        goToHomeBtn.userInteractionEnabled = NO;
        [_allView addSubview:goToHomeBtn];
        
    }
    else if ([imageType isEqualToString:@"noTX"]){
        
        _allView.frame = CGRectMake(0, 0, width, height);
        _allView.backgroundColor = ColorMaker(244, 244, 244, 255);
      
        image = [UIImage imageNamed:@"no_sc.png"];
        imageView.frame = CGRectMake((width - 190)/2.0, (_allView.frame.size.height- 190)/2.0 - 190/2.0 - (iPhoneX?64:30), 190, 190);
        
        UILabel *ttLab = [[UILabel alloc]initWithFrame:CGRectMake(0, imageView.frame.origin.y +190+20, width, 20)];
        ttLab.text = title;
        ttLab.textColor = textMinorColor33;
        ttLab.font = [UIFont systemFontOfSize:FontSize(16)];
        ttLab.textAlignment = NSTextAlignmentCenter;
        [_allView addSubview:ttLab];
        
        UILabel *messageLab = [[UILabel alloc]initWithFrame:CGRectMake((width-88)/2.0, ttLab.frame.origin.y +20+15, 88, 34)];
        messageLab.text = message;
        messageLab.textColor = textMinorColor33;
        messageLab.font = [UIFont systemFontOfSize:FontSize(14)];
        messageLab.textAlignment = NSTextAlignmentCenter;
        messageLab.layer.masksToBounds = YES;
        messageLab.layer.cornerRadius = 17;
        messageLab.layer.borderWidth = 0.5;
        messageLab.layer.borderColor = textMinorColor.CGColor;
        [_allView addSubview:messageLab];
        
    }
    else if ([imageType isEqualToString:@"noRedTX"]){
        
        _allView.frame = CGRectMake(0, iPhoneX?88:64, width, height - (iPhoneX?88:64));
        _allView.backgroundColor = ColorMaker(244, 244, 244, 255);
      
        image = [UIImage imageNamed:@"no_sc.png"];
        imageView.frame = CGRectMake((width - 190)/2.0, (_allView.frame.size.height- 190)/2.0 - 190/2.0 - (iPhoneX?64:30), 190, 190);
        
        UILabel *ttLab = [[UILabel alloc]initWithFrame:CGRectMake(0, imageView.frame.origin.y +190+20, width, 20)];
        ttLab.text = title;
        ttLab.textColor = textMinorColor33;
        ttLab.font = [UIFont systemFontOfSize:FontSize(16)];
        ttLab.textAlignment = NSTextAlignmentCenter;
        [_allView addSubview:ttLab];
        
        UILabel *messageLab = [[UILabel alloc]initWithFrame:CGRectMake((width-88)/2.0, ttLab.frame.origin.y +20+15, 88, 34)];
        messageLab.text = message;
        messageLab.textColor = textMinorColor33;
        messageLab.font = [UIFont systemFontOfSize:FontSize(14)];
        messageLab.textAlignment = NSTextAlignmentCenter;
        messageLab.layer.masksToBounds = YES;
        messageLab.layer.cornerRadius = 17;
        messageLab.layer.borderWidth = 0.5;
        messageLab.layer.borderColor = textMinorColor.CGColor;
        [_allView addSubview:messageLab];
        
    }
    
    
    else if ([imageType isEqualToString:@"noZJ"]){
        
        _allView.frame = CGRectMake(0, 0, width, height);
        _allView.backgroundColor = ColorMaker(244, 244, 244, 255);
        image = [UIImage imageNamed:@"no_sc.png"];
        imageView.frame = CGRectMake((width - 190)/2.0, (_allView.frame.size.height- 190)/2.0 - 190/2.0 - (iPhoneX?64:0), 190, 190);
        
        UILabel *ttLab = [[UILabel alloc]initWithFrame:CGRectMake(0, imageView.frame.origin.y +190+20, width, 20)];
        ttLab.text = title;
        ttLab.textColor = textMinorColor33;
        ttLab.font = [UIFont systemFontOfSize:FontSize(16)];
        ttLab.textAlignment = NSTextAlignmentCenter;
        [_allView addSubview:ttLab];
        
        UILabel *messageLab = [[UILabel alloc]initWithFrame:CGRectMake((width-88)/2.0, ttLab.frame.origin.y +20+15, 88, 34)];
        messageLab.text = message;
        messageLab.textColor = textMinorColor33;
        messageLab.font = [UIFont systemFontOfSize:FontSize(14)];
        messageLab.textAlignment = NSTextAlignmentCenter;
        messageLab.layer.masksToBounds = YES;
        messageLab.layer.cornerRadius = 17;
        messageLab.layer.borderWidth = 0.5;
        messageLab.layer.borderColor = textMinorColor.CGColor;
        [_allView addSubview:messageLab];
    }
    else if ([imageType isEqualToString:@"noTeam"]){
        
        _allView.frame = CGRectMake(0, (iPhoneX?88:64), width, height);
        _allView.backgroundColor = ColorMaker(244, 244, 244, 255);
        
        image = [UIImage imageNamed:@"no_team.png"];
        imageView.frame = CGRectMake((width - 230)/2.0, (_allView.frame.size.height- 220)/2.0 - 220/2.0 , 230, 220);
        
        UILabel *ttLab = [[UILabel alloc]initWithFrame:CGRectMake(0, imageView.frame.origin.y +190+40, width, 20)];
        ttLab.text = title;
        ttLab.textColor = textMinorColor33;
        ttLab.font = [UIFont systemFontOfSize:FontSize(16)];
        ttLab.textAlignment = NSTextAlignmentCenter;
        [_allView addSubview:ttLab];
        
        
//         UIView *messageLabView = [[UILabel alloc]initWithFrame:CGRectMake((width - 117)/2.0, ttLab.frame.origin.y +20+20, 117, 36)];
//         CAGradientLayer *gradient = [CAGradientLayer layer];
//         gradient.frame = messageLabView.bounds;
//         gradient.colors = [NSArray arrayWithObjects:
//                            (id)kUIColorFromRGB(0xFDA541).CGColor,
//                            (id)kUIColorFromRGB(0xFC5449).CGColor,
//                            nil];
//         gradient.startPoint = CGPointMake(0.2, 0.2);
//         gradient.endPoint = CGPointMake(0.2, 0.8);
//         gradient.cornerRadius = 18;
//         [messageLabView.layer addSublayer:gradient];
//        [_allView addSubview:messageLabView];
//
//
//        UILabel *messageLab = [[UILabel alloc]initWithFrame:CGRectMake((width - 117)/2.0, ttLab.frame.origin.y +20+20, 117, 36)];
//        messageLab.text = message;
//        messageLab.textColor = [UIColor whiteColor];
//        messageLab.font = [UIFont systemFontOfSize:FontSize(15)];
//        messageLab.textAlignment = NSTextAlignmentCenter;
//        [_allView addSubview:messageLab];
        UILabel *messageLab = [[UILabel alloc]initWithFrame:CGRectMake((width-88)/2.0, ttLab.frame.origin.y +20+15, 88, 34)];
        messageLab.text = message;
        messageLab.textColor = textMinorColor33;
        messageLab.font = [UIFont systemFontOfSize:FontSize(14)];
        messageLab.textAlignment = NSTextAlignmentCenter;
        messageLab.layer.masksToBounds = YES;
        messageLab.layer.cornerRadius = 17;
        messageLab.layer.borderWidth = 0.5;
        messageLab.layer.borderColor = textMinorColor.CGColor;
        [_allView addSubview:messageLab];
        
    }
    else if ([imageType isEqualToString:@"noOrder"]){
         _allView.frame = CGRectMake(0, 5, width, height - (iPhoneX?88:64) );
         _allView.backgroundColor = ColorMaker(244, 244, 244, 255);
        image = [UIImage imageNamed:@"no_order.png"];
        imageView.frame = CGRectMake((width - 190)/2.0, (_allView.frame.size.height- 190)/2.0 - 190/2.0 - (iPhoneX?34:0)-35, 190, 190);
        
        UILabel *ttLab = [[UILabel alloc]initWithFrame:CGRectMake(0, imageView.frame.origin.y +190+20, width, 20)];
        ttLab.text = title;
        ttLab.textColor = textMinorColor33;
        ttLab.font = [UIFont systemFontOfSize:FontSize(16)];
        ttLab.textAlignment = NSTextAlignmentCenter;
        [_allView addSubview:ttLab];
        
        UILabel *messageLab = [[UILabel alloc]initWithFrame:CGRectMake((width-88)/2.0, ttLab.frame.origin.y +20+15, 88, 34)];
        messageLab.text = message;
        messageLab.textColor = textMinorColor33;
        messageLab.font = [UIFont systemFontOfSize:FontSize(14)];
        messageLab.textAlignment = NSTextAlignmentCenter;
        messageLab.layer.masksToBounds = YES;
        messageLab.layer.cornerRadius = 17;
        messageLab.layer.borderWidth = 0.5;
        messageLab.layer.borderColor = textMinorColor.CGColor;
        [_allView addSubview:messageLab];
    }
    else if ([imageType isEqualToString:@"noApprove"]){
        
        _allView.frame = CGRectMake(0, 5, width, height - (iPhoneX?88:64) );
        _allView.backgroundColor = ColorMaker(244, 244, 244, 255);
        image = [UIImage imageNamed:@"no_approve.png"];
        imageView.frame = CGRectMake((width - 193)/2.0, (_allView.frame.size.height- 190)/2.0 - 190/2.0 , 193, 190);
        
        UILabel *ttLab = [[UILabel alloc]initWithFrame:CGRectMake(0, imageView.frame.origin.y +190+20, width, 20)];
        ttLab.text = title;
        ttLab.textColor = textMinorColor;
        ttLab.font = [UIFont systemFontOfSize:FontSize(17)];
        ttLab.textAlignment = NSTextAlignmentCenter;
        [_allView addSubview:ttLab];
        
        UILabel *messageLab = [[UILabel alloc]initWithFrame:CGRectMake(0, ttLab.frame.origin.y +20+5, width, 20)];
        messageLab.text = message;
        messageLab.textColor = textMinorColor99;
        messageLab.font = [UIFont systemFontOfSize:FontSize(11)];
        messageLab.textAlignment = NSTextAlignmentCenter;
        [_allView addSubview:messageLab];
    }
    else if ([imageType isEqualToString:@"noNetHome"]){
        
        _allView.frame = CGRectMake(0, iPhoneX?88:64, width, height - (iPhoneX?88:64));
        image = [UIImage imageNamed:@"no_net.png"];
        imageView.frame = CGRectMake((width - 190)/2.0, (_allView.frame.size.height- 190)/2.0 - 190/2.0, 190, 190);
        
        UILabel *ttLab = [[UILabel alloc]initWithFrame:CGRectMake(0, imageView.frame.origin.y +190+20, width, 20)];
        ttLab.text = title;
        ttLab.textColor = textMinorColor33;
        ttLab.font = [UIFont systemFontOfSize:FontSize(16)];
        ttLab.textAlignment = NSTextAlignmentCenter;
        [_allView addSubview:ttLab];
        
        UILabel *messageLab = [[UILabel alloc]initWithFrame:CGRectMake((width-88)/2.0, ttLab.frame.origin.y +20+15, 88, 34)];
        messageLab.text = @"刷新一下";
        messageLab.textColor = textMinorColor33;
        messageLab.font = [UIFont systemFontOfSize:FontSize(14)];
        messageLab.textAlignment = NSTextAlignmentCenter;
        messageLab.layer.masksToBounds = YES;
        messageLab.layer.cornerRadius = 17;
        messageLab.layer.borderWidth = 0.5;
        messageLab.layer.borderColor = textMinorColor.CGColor;
        [_allView addSubview:messageLab];
        
    }
    else if ([imageType isEqualToString:@"college_noHistory"]){
        
        _allView.frame = CGRectMake(0, 0, width, height - (iPhoneX?88:64));
        _allView.backgroundColor = allBackgroundColor;
        image = [UIImage imageNamed:@"college_noHistory.png"];
        imageView.frame = CGRectMake((width - 204)/2.0, (_allView.frame.size.height- 158)/2.0 - 158/2.0, 204, 158);
        
        UILabel *ttLab = [[UILabel alloc]initWithFrame:CGRectMake(0, imageView.frame.origin.y +190+20, width, 20)];
        ttLab.text = title;
        ttLab.textColor = textMinorColor;
        ttLab.font = [UIFont systemFontOfSize:FontSize(16)];
        ttLab.textAlignment = NSTextAlignmentCenter;
        [_allView addSubview:ttLab];
        
    }
    else if ([imageType isEqualToString:@"college_noSearch"]){
        
        _allView.frame = CGRectMake(0, (iPhoneX?88:64), width, height - (iPhoneX?88:64));
        _allView.backgroundColor = allBackgroundColor;
        image = [UIImage imageNamed:@"college_noSearch.png"];
        imageView.frame = CGRectMake((width - 204)/2.0, (_allView.frame.size.height- 158)/2.0 - 158/2.0, 204, 158);
        
        UILabel *ttLab = [[UILabel alloc]initWithFrame:CGRectMake(0, imageView.frame.origin.y +190+20, width, 20)];
        ttLab.text = title;
        ttLab.textColor = textMinorColor;
        ttLab.font = [UIFont systemFontOfSize:FontSize(16)];
        ttLab.textAlignment = NSTextAlignmentCenter;
        [_allView addSubview:ttLab];
        
    }
    else if ([imageType isEqualToString:@"noRecSearch"]){
        
        _allView.frame = CGRectMake(0, 0, width, height - (iPhoneX?128:104));
        _allView.backgroundColor = allBackgroundColor;
        image = [UIImage imageNamed:@"rec_empty.png"];
        imageView.frame = CGRectMake((width - 131)/2.0, 125*BiLi, 131, 96);
        
        UILabel *ttLab = [[UILabel alloc]initWithFrame:CGRectMake(0, imageView.frame.origin.y +96+20, width, 20)];
        ttLab.text = message;
        ttLab.textColor = textMinorColor99;
        ttLab.font = [UIFont systemFontOfSize:FontSize(15)];
        ttLab.textAlignment = NSTextAlignmentCenter;
        [_allView addSubview:ttLab];
        
        imageView.userInteractionEnabled = NO;
        _allView.userInteractionEnabled = NO;
        
    }
    else if ([imageType isEqualToString:@"noRec"]){
        
        _allView.frame = CGRectMake(0, 0, width, height );
        _allView.backgroundColor = allBackgroundColor;
        image = [UIImage imageNamed:@"rec_empty.png"];
        imageView.frame = CGRectMake((width - 131)/2.0, (_allView.frame.size.height- 96)/2.0 - 96/2.0, 131, 96);
        UILabel *ttLab = [[UILabel alloc]initWithFrame:CGRectMake(0, imageView.frame.origin.y +96+20, width, 20)];
        ttLab.text = message;
        ttLab.textColor = textMinorColor99;
        ttLab.font = [UIFont systemFontOfSize:FontSize(15)];
        ttLab.textAlignment = NSTextAlignmentCenter;
        [_allView addSubview:ttLab];
        
        imageView.userInteractionEnabled = YES;
        _allView.userInteractionEnabled = YES;
    }
    else{
        _allView.frame = CGRectMake(0, 0, width, height);
        imageView.frame = CGRectMake((width - 190)/2.0, (_allView.frame.size.height- 190)/2.0 - 190/2.0, 190, 190);
        UILabel *ttLab = [[UILabel alloc]initWithFrame:CGRectMake(0, imageView.frame.origin.y +190+20, width, 20)];
        ttLab.text = title;
        ttLab.textColor = textMinorColor;
        ttLab.font = [UIFont systemFontOfSize:FontSize(17)];
        ttLab.textAlignment = NSTextAlignmentCenter;
        [_allView addSubview:ttLab];
        
        UILabel *messageLab = [[UILabel alloc]initWithFrame:CGRectMake(0, ttLab.frame.origin.y +20+5, width, 20)];
        messageLab.text = message;
        messageLab.textColor = textMinorColor99;
        messageLab.font = [UIFont systemFontOfSize:FontSize(11)];
        messageLab.textAlignment = NSTextAlignmentCenter;
        [_allView addSubview:messageLab];
    }
    
    imageView.image = image;
   
}


- (void)clickEmptyImageView:(UIGestureRecognizer *)sender{
    self.block(233);
}


- (void)remove{
    [_allView removeFromSuperview];
    [_allView removeFromSuperview];
    [_allView removeFromSuperview];
    [_allView removeFromSuperview];
    [_allView removeFromSuperview];
    [_allView removeFromSuperview];
    [_allView removeFromSuperview];
    [_allView removeFromSuperview];
}
@end
