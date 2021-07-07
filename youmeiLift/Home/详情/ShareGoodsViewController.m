//
//  ShareGoodsViewController.m
//  DaiMengJia
//
//  Created by 呆萌价 on 2017/12/12.
//  Copyright © 2017年 呆萌价. All rights reserved.
//

#import "ShareGoodsViewController.h"
#import "DMTool.h"
#import "DMTextTool.h"
#import "UIImageView+WebCache.h"
#import "TSShareHelper.h"
#import "Masonry.h"
#import "YXAlertView.h"
#import "NetWorkManager.h"
#import "ShowImageVC.h"
//#import "UIView+Extension.h"
#import "PopView.h"
#import "YJProgressHUD.h"
#import <Masonry.h>
//#import "SkipWebVC.h"
#import <MJExtension.h>
@interface ShareGoodsViewController ()<UITextViewDelegate, UITextFieldDelegate>
@property (strong, nonatomic) NSMutableArray *allImgeArr;

@property (strong, nonatomic) NSMutableArray *clickImgeArr;
@property (strong, nonatomic) NSMutableArray *shareImgeArr;
@property (strong, nonatomic) NSMutableArray *shareTagArr;

@property (copy, nonatomic) NSString *goodsShareStyle;
@property (copy, nonatomic) NSString *imgShareStyle;

@property (copy, nonatomic) NSString *wenAnShareStyle;
@property (copy, nonatomic) NSString *pwdAndlinkShareStyle;

@property (strong, nonatomic) UITextView *contentTV;

@property (strong, nonatomic) UILabel *imgCountLab;

@property (copy, nonatomic) NSString *shareLinkContent;
@property (copy, nonatomic) NSString *shareTextContent;
@property (copy, nonatomic) NSString *sharetPwdContent;
@property (copy, nonatomic) NSString *emptyrecommend;
@property (strong, nonatomic) UIView *shareChooseView;

@property (copy, nonatomic) NSString *shareStyle;
@property (strong, nonatomic) UIScrollView *shareImgScrollView;

@property (strong, nonatomic) UIView *visualEffectView;
@property (strong, nonatomic) UIView *allView;
@property (strong, nonatomic) UIScrollView *changeScrollView;
@property (strong, nonatomic) UIImageView *lastImgView;

@end

@implementation ShareGoodsViewController{
     CGFloat contentH;
     NSInteger index;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [NetWorkManager  requestWithType:1 withUrlString:kURLWithGetRatio withParaments:nil withSuccessBlock:^(NSDictionary *responseObject) {
        
        DMLog(@"分佣 =  %@  %@",  responseObject, responseObject[@"msgstr"]);
        NSString *result = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
        
        if ([result isEqualToString:@"1"]) {
           self.agentratio = [NSString stringWithFormat:@"%@", responseObject[@"agentratio"]];
        }
        
    } withFailureBlock:^(NSError *error) {
        
    } progress:^(float progress) {
        
    }];
    
    
     self.navigationController.navigationBarHidden = YES;
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:self.wenAnShareStyle forKey:@"wenAnShareStyle"];
    [defaults setValue:self.pwdAndlinkShareStyle forKey:@"pwdAndlinkShareStyle"];
    
    
}

- (void)clickBackButtonView:(UIGestureRecognizer *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //self.navigationItem.title = @"创建分享";
    
   self.view.backgroundColor = ColorMaker(244, 244, 244, 255);
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, iPhoneX?88:64)];
    headerView.backgroundColor = ColorMaker(244, 244, 244, 255);
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
    ttLab.text = @"创建分享";
    ttLab.textColor = textMinorColor33;
    ttLab.font = [UIFont systemFontOfSize:FontSize(18)];
    ttLab.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:ttLab];
    
    
    
    
    
    
    //获取字典路径
    NSString *documentFilePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    //拼接完整路径
    NSString *filePath = [documentFilePath stringByAppendingPathComponent:@"dictionary.dic"];
    NSDictionary *dataDict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    self.shareLinkContent = [NSString stringWithFormat:@"%@", dataDict[@"sharelinknew"]];
    self.shareTextContent = [NSString stringWithFormat:@"%@", dataDict[@"sharetextnew"]];
    self.sharetPwdContent = [NSString stringWithFormat:@"%@", dataDict[@"sharetpwdnew"]];
    self.emptyrecommend = [NSString stringWithFormat:@"%@", dataDict[@"emptyrecommend"]];
    
    
    if (self.shareTextContent.length<7 || !self.shareTextContent) {
        
        [NetWorkManager  requestWithType:1 withUrlString:kURLWithGetappset withParaments:nil withSuccessBlock:^(NSDictionary *responseObject) {
            
            DMLog(@"获取分享 内容 预先设置 =  %@ %@",  responseObject, responseObject[@"msgstr"]);
            NSString *result = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
            
            if ([result isEqualToString:@"1"]) {
                
                NSDictionary *dataDict = (NSDictionary *)responseObject[@"data"];
                NSString *documentFilePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
                //拼接完整路径
                NSString *filePath = [documentFilePath stringByAppendingPathComponent:@"dictionary.dic"];
                BOOL isSucceed = [dataDict writeToFile:filePath atomically:YES];
                DMLog(@"分享 内容 预先设置 存储 %@",isSucceed ? @"成功":@"失败失败");
                
                  self.shareLinkContent = [NSString stringWithFormat:@"%@", dataDict[@"sharelinknew"]];
                   self.shareTextContent = [NSString stringWithFormat:@"%@", dataDict[@"sharetextnew"]];
                   self.sharetPwdContent = [NSString stringWithFormat:@"%@", dataDict[@"sharetpwdnew"]];
                   self.emptyrecommend = [NSString stringWithFormat:@"%@", dataDict[@"emptyrecommend"]];
                
//                      [self setUpShareView];
             }
            
        } withFailureBlock:^(NSError *error) {
            
        } progress:^(float progress) {
            
        }];
        
        
    }else{
//         [self setUpShareView];
    }
    
    
    
    
    
    
    
   
    
    
    
    
    
  
    
    
}


//- (void)setUpShareView{
//
//    self.allImgeArr = [NSMutableArray array];
//    self.clickImgeArr = [NSMutableArray array];
//    self.shareImgeArr = [NSMutableArray array];
//    self.shareTagArr = [NSMutableArray array];
//
//
//    UIScrollView *backScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, iPhoneX?88:64, kScreenWidth, kScreenHeight - (iPhoneX?88:64) - 65)];
//    backScrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight);
//    backScrollView.showsHorizontalScrollIndicator = NO;
//    backScrollView.showsVerticalScrollIndicator = NO;
//    backScrollView.scrollEnabled = NO;
//    [self.view addSubview:backScrollView];
//
//    UIView *imgBackView0 = [[UIView alloc]init];
//    imgBackView0.layer.masksToBounds = YES;
//    imgBackView0.layer.cornerRadius = 8.0f;
//    imgBackView0.backgroundColor = [UIColor whiteColor];
//    [backScrollView addSubview:imgBackView0];
//
//    [imgBackView0 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(backScrollView.mas_top).offset(0);
//        //  make.centerX.mas_equalTo(self).multipliedBy(1.45);
//        make.left.equalTo(backScrollView.mas_left).offset(12);
//        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 24, 147));
//    }];
//
//
//
//
//
//
//
//    UILabel *imgTipLab = [[UILabel alloc]init];
//    imgTipLab.text = @"分享图片";
//    imgTipLab.font = [UIFont boldSystemFontOfSize:FontSize(14)];
//    imgTipLab.textColor = textMinorColor33;
//    [imgBackView0 addSubview:imgTipLab];
//    [imgTipLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(imgBackView0.mas_top).offset(17.5);
//        make.left.equalTo(imgBackView0.mas_left).offset(12);
//        make.height.mas_equalTo(13.5);
//    }];
//
//
//
//    self.imgCountLab = [[UILabel alloc]init];
//    _imgCountLab.text = @"已选1张";
//    _imgCountLab.font = [UIFont systemFontOfSize:FontSize(12)];
//    _imgCountLab.textColor = textMinorColor;
//    _imgCountLab.textAlignment = NSTextAlignmentRight;
//    [imgBackView0 addSubview:_imgCountLab];
//
//    [_imgCountLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(imgBackView0.mas_top).offset(18.5);
//        make.left.equalTo(imgTipLab.mas_right).offset(9.5);
//        make.height.mas_equalTo(11.5);
//    }];
//
//    UIButton *changeEwmImgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [changeEwmImgBtn setBackgroundImage:[UIImage imageNamed:@"share_changeImgBtn"] forState:0];
//    [changeEwmImgBtn setTitle:@"更换二维码主图" forState:0];
//    [changeEwmImgBtn setTitleColor:[UIColor whiteColor] forState:0];
//    changeEwmImgBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(11)];
//    [changeEwmImgBtn addTarget:self action:@selector(clickChangeImgButton:) forControlEvents:UIControlEventTouchUpInside];
//    [imgBackView0 addSubview:changeEwmImgBtn];
//    [changeEwmImgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(imgBackView0.mas_top).offset(6);
//        make.right.equalTo(imgBackView0.mas_right).offset(-6);
//        make.size.mas_equalTo(CGSizeMake(112, 35));
//    }];
//
//
//    self.shareImgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(12, 47, kScreenWidth- 48 , 88)];
//
//    if (self.imgArr.count < 3) {
//        _shareImgScrollView.contentSize = CGSizeMake(kScreenWidth - 24, 88);
//    }
//    else{
//        _shareImgScrollView.contentSize = CGSizeMake(100*self.imgArr.count+0, 88);
//    }
//
//    _shareImgScrollView.showsHorizontalScrollIndicator = NO;
//    [imgBackView0 addSubview:_shareImgScrollView];
//
//
//
//
//
//    for (int i = 0; i < self.imgArr.count; i ++) {
//
//        [self.allImgeArr addObject:[UIImage imageNamed:@"onecell.png"]];
//
//        UIImageView *shareImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0 + 100 * i, 0, 88, 88)];
//       // shareImgView.image = [UIImage imageNamed:@"onecell.png"];
//        shareImgView.layer.masksToBounds = YES;
//        shareImgView.layer.cornerRadius = 5.0f;
//         shareImgView.tag = 999+i;
//
//        [_shareImgScrollView addSubview:shareImgView];
//
//        UIButton *markImgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        markImgBtn.frame = CGRectMake(58, 2, 27, 27);
//        markImgBtn.tag = 789+i;
//
//
//        UILabel *ewmtgtLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 68, 88, 20)];
//        ewmtgtLab.textColor = [UIColor whiteColor];
//        ewmtgtLab.font = [UIFont systemFontOfSize:FontSize(11)];
//        ewmtgtLab.adjustsFontSizeToFitWidth = YES;
//        ewmtgtLab.textAlignment = NSTextAlignmentCenter;
//
//        ewmtgtLab.backgroundColor = [UIColor clearColor];
//        UIBezierPath *maskPath22 = [UIBezierPath bezierPathWithRoundedRect:ewmtgtLab.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
//        CAShapeLayer *maskLayer22 = [[CAShapeLayer alloc] init];
//        maskLayer22.frame = ewmtgtLab.bounds;
//        maskLayer22.path = maskPath22.CGPath;
//        ewmtgtLab.layer.mask = maskLayer22;
//        [shareImgView addSubview:ewmtgtLab];
//
//
//        if ([self.type isEqualToString:@"rec"]) {
//
//            if (i==0) {
//
//                [self.shareTagArr addObject:@"999"];
//                index = 0;
//                [markImgBtn setImage:[UIImage imageNamed:@"share_checked11.png"] forState:0];
//                markImgBtn.selected = YES;
//                ewmtgtLab.text = @"二维码推广图";
//                ewmtgtLab.backgroundColor = DMColor;
//
//
//                shareImgView.image = self.imgArr[i];
//
//                [self.allImgeArr replaceObjectAtIndex:0 withObject:self.imgArr[i]];
//                [self.clickImgeArr addObject:self.allImgeArr[0]];
//
//
//
//            }
//            else{
//
//                //   markImg.image = [UIImage imageNamed:@"share_unchecked.png"];
//                [markImgBtn setImage:[UIImage imageNamed:@"share_unchecked11.png"] forState:0];
//                markImgBtn.selected = NO;
//
//
//                shareImgView.image = self.imgArr[i];
//
//                [self.allImgeArr replaceObjectAtIndex:i withObject:self.imgArr[i]];
//
//              //  shareImgView.image = [UIImage imageNamed:@"onecell.png"];
//
//
//
//            }
//
//        }
//
//
//        else{
//
//
//        if (i==0) {
//            [self.shareTagArr addObject:@"999"];
//            index = 0;
//            [markImgBtn setImage:[UIImage imageNamed:@"share_checked11.png"] forState:0];
//             markImgBtn.selected = YES;
//            ewmtgtLab.text = @"二维码推广图";
//            ewmtgtLab.backgroundColor = DMColor;
//            [shareImgView sd_setImageWithURL:[NSURL URLWithString:self.imgArr[i]] placeholderImage:[UIImage imageNamed:@"onecell.png"] options:SDWebImageRetryFailed completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//
//                if (image) {
//                  //  shareImgView.image = image;
//
//                    [UIView transitionWithView:shareImgView duration:0.2 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
//
//                        shareImgView.image = image;
//
//                    } completion:nil];
//
//                    [self.allImgeArr replaceObjectAtIndex:0 withObject:image];
//                    [self.clickImgeArr addObject:self.allImgeArr[0]];
//
//                }
//                else{
//
//                    shareImgView.image = [UIImage imageNamed:@"onecell.png"];
//                  //[self.allImgeArr addObject:[UIImage imageNamed:@"onecell.png"]];
//                    [self.clickImgeArr addObject:[UIImage imageNamed:@"onecell.png"]];
//
//                }
//
//            }];
//
//        }
//        else{
//
//         //   markImg.image = [UIImage imageNamed:@"share_unchecked.png"];
//           [markImgBtn setImage:[UIImage imageNamed:@"share_unchecked11.png"] forState:0];
//            markImgBtn.selected = NO;
//
//            [shareImgView sd_setImageWithURL:[NSURL URLWithString:self.imgArr[i]] placeholderImage:[UIImage imageNamed:@"onecell.png"] options:SDWebImageRetryFailed completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//
//                if (image) {
//                   // shareImgView.image = image;
//
//                    [UIView transitionWithView:shareImgView duration:0.2 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
//
//                        shareImgView.image = image;
//
//                    } completion:nil];
//
//
//                   // [self.allImgeArr addObject:image];
//                    [self.allImgeArr replaceObjectAtIndex:i withObject:image];
//                }
//                else{
//                    shareImgView.image = [UIImage imageNamed:@"onecell.png"];
//                   // [self.allImgeArr addObject:[UIImage imageNamed:@"onecell.png"]];
//                }
//
//            }];
//
//        }
//
//        }
//
//        markImgBtn.userInteractionEnabled = YES;
//        shareImgView.userInteractionEnabled = YES;
//        self.view.userInteractionEnabled = YES;
//
//
//        [markImgBtn addTarget:self action:@selector(clickMarkImageViewTap:) forControlEvents:UIControlEventTouchUpInside];
//        [shareImgView addSubview:markImgBtn];
//
//
//
//         UITapGestureRecognizer *imgTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickShareImageView:)];
//         [shareImgView addGestureRecognizer:imgTap];
//
//
//    }
//
//
//
//
//
//
//    UIView *wenAnView0 = [[UIView alloc]init];
//
//    [backScrollView addSubview:wenAnView0];
//
//    [wenAnView0 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(imgBackView0.mas_bottom).offset(5);
//        make.left.equalTo(self.view.mas_left).offset(12);
//        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 24, 300));
//    }];
//
//
//    UIView *wenAnView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth - 24, 300)];
//    wenAnView.layer.masksToBounds = YES;
//    wenAnView.layer.cornerRadius = 8.0f;
//    [wenAnView0 addSubview:wenAnView];
////    UIBezierPath *maskPath222 = [UIBezierPath bezierPathWithRoundedRect:wenAnView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(8, 8)];
////    CAShapeLayer *maskLayer222 = [[CAShapeLayer alloc] init];
////    maskLayer222.frame = wenAnView.bounds;
////    maskLayer222.path = maskPath222.CGPath;
////    wenAnView.layer.mask = maskLayer222;
//    wenAnView.backgroundColor = [UIColor whiteColor];
//
//
//
//
//    UILabel *contentTipLab = [[UILabel alloc]init];
//    contentTipLab.text = @"分享文案";
//    contentTipLab.font = [UIFont boldSystemFontOfSize:FontSize(14)];
//    contentTipLab.textColor = textMinorColor33;
//    [wenAnView addSubview:contentTipLab];
//
//    [contentTipLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(wenAnView.mas_top).offset(14.5);
//        make.left.equalTo(wenAnView.mas_left).offset(12);
//        make.height.mas_equalTo(13.5);
//    }];
//
//   // NSString *extensionid = [NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"extensionid"]?[[NSUserDefaults standardUserDefaults] objectForKey:@"extensionid"]:@""];
//
//    NSArray *shareChooseBtnTTArr = @[@"商品文案", @"淘口令", @"下单链接"];
//
//    self.shareChooseView = [[UIView alloc]init];
//    _shareChooseView.backgroundColor = kUIColorFromRGB(0xF5F5F5);
//    _shareChooseView.layer.masksToBounds = YES;
//    _shareChooseView.layer.cornerRadius = 8.0f;
//    [wenAnView addSubview:_shareChooseView];
//
//    [_shareChooseView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(wenAnView.mas_top).offset(40);
//        make.left.equalTo(wenAnView.mas_left).offset(12);
//        make.right.equalTo(wenAnView.mas_right).offset(-12);
//        make.height.mas_equalTo(40);
//    }];
//
//
//
//    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"wenAnShareStyle"]) {
//        NSLog(@"有有有有");
//        self.wenAnShareStyle = [NSString stringWithFormat:@"%@",  [[NSUserDefaults standardUserDefaults] objectForKey:@"wenAnShareStyle"]];
//        self.pwdAndlinkShareStyle = [NSString stringWithFormat:@"%@",  [[NSUserDefaults standardUserDefaults] objectForKey:@"pwdAndlinkShareStyle"]];
//    }
//    else{
//        NSLog(@"没有没有");
//        self.wenAnShareStyle = @"1";
//        self.pwdAndlinkShareStyle = @"0";
//    }
//
//
//    NSLog(@"wenAnShareStyle12 = %@   pwdAndlinkShareStyle = %@", self.wenAnShareStyle, self.pwdAndlinkShareStyle);
//
//    for (int i = 0; i <shareChooseBtnTTArr.count; i++) {
//
//        UIButton *shareChooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        shareChooseBtn.frame = CGRectMake(0 + (kScreenWidth-48)/3.0*i, 5, (kScreenWidth-48)/3.0, 30);
//        [shareChooseBtn setTitle:shareChooseBtnTTArr[i] forState:0];
//        [shareChooseBtn setTitleColor:textMinorColor33 forState:0];
//        shareChooseBtn.titleLabel.font = [UIFont boldSystemFontOfSize:FontSize(12)];
//        [shareChooseBtn setImage:[UIImage imageNamed:@"share_chooseBtn_no.png"] forState:0];
//       // shareChooseBtn.backgroundColor = [UIColor yellowColor];
//
//        if ([self.wenAnShareStyle isEqualToString:@"1"]) {
//
//            if (i == 0) {
//                self.wenAnShareStyle = @"1";
//                shareChooseBtn.selected = YES;
//                [shareChooseBtn setImage:[UIImage imageNamed:@"share_chooseBtn_yes.png"] forState:0];
//            }
//        }else{
//             self.wenAnShareStyle = @"0";
//        }
//
//        if ([self.pwdAndlinkShareStyle isEqualToString:@"2"]) {
//
//            if (i == 1) {
//                self.pwdAndlinkShareStyle = @"2";
//                shareChooseBtn.selected = YES;
//                [shareChooseBtn setImage:[UIImage imageNamed:@"share_chooseBtn_yes.png"] forState:0];
//            }
//        }
//
//       else  if ([self.pwdAndlinkShareStyle isEqualToString:@"3"]) {
//
//            if (i == 2) {
//                self.pwdAndlinkShareStyle = @"3";
//                shareChooseBtn.selected = YES;
//                [shareChooseBtn setImage:[UIImage imageNamed:@"share_chooseBtn_yes.png"] forState:0];
//            }
//        }
//       else{
//           self.pwdAndlinkShareStyle = @"0";
//       }
//
//
//        //先设置按钮里面的内容居   中
//        shareChooseBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
//        //设置文字居左 －>向左移   35
//        [shareChooseBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
//        //设置图片居右 －>向右移   30
//        shareChooseBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5*BiLi, 0, 0);
//
//        shareChooseBtn.tag = 689+i;
//        [shareChooseBtn addTarget:self action:@selector(clickShareChooseBtn:) forControlEvents:UIControlEventTouchUpInside];
//
//        [_shareChooseView addSubview:shareChooseBtn];
//
//    }
//
//
//    UIView *contentBacnView = [[UIView alloc]init];
//    contentBacnView.layer.masksToBounds = YES;
//     contentBacnView.layer.cornerRadius = 8.0f;
//    contentBacnView.backgroundColor = kUIColorFromRGB(0xF5F5F5);
//    [wenAnView addSubview:contentBacnView];
//
//    [contentBacnView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_shareChooseView.mas_bottom).offset(8);
//        make.left.equalTo(wenAnView.mas_left).offset(12);
//        make.right.equalTo(wenAnView.mas_right).offset(-12);
//        make.height.mas_equalTo(200);
//    }];
//
//
//    self.contentTV = [[UITextView alloc]init];
//   // contentTF.text = @"编辑分享文案编辑分享文案\n编辑分享文案";
//    _contentTV.layer.masksToBounds = YES;
//    _contentTV.layer.cornerRadius = 8.0f;
//   _contentTV.backgroundColor = kUIColorFromRGB(0xF5F5F5);
//    _contentTV.delegate = self;
//    [contentBacnView addSubview:_contentTV];
//
//    [_contentTV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(contentBacnView.mas_top).offset(0);
//        make.left.equalTo(contentBacnView.mas_left).offset(5);
//        make.right.equalTo(contentBacnView.mas_right).offset(-5);
//        make.height.mas_equalTo(145);
//    }];
//
//
//    NSString *shareStr = [[NSString alloc]init];;
//
//
//    shareStr = [self setShareStrWithWenAnShareStyle:self.wenAnShareStyle pwdAndLinkStyle:self.pwdAndlinkShareStyle];
//
//
//    _contentTV.attributedText = [DMTextTool dm_changeLineSpace:3 str:shareStr];
//     _contentTV.font = [UIFont systemFontOfSize:FontSize(14)];
//    _contentTV.returnKeyType = UIReturnKeyDone;
//    _contentTV.textColor = textMinorColor99;
//
//
//    UIButton *copyWenAnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    copyWenAnBtn.backgroundColor = [UIColor whiteColor];
//    copyWenAnBtn.layer.masksToBounds = YES;
//    copyWenAnBtn.layer.cornerRadius = 16;
//    copyWenAnBtn.layer.borderColor = kUIColorFromRGB(0xEEEEEE).CGColor;
//    copyWenAnBtn.layer.borderWidth = 1;
//    [copyWenAnBtn setTitle:@"复制选中文案" forState:0];
//    [copyWenAnBtn setTitleColor:kUIColorFromRGB(0xFC3951) forState:0];
//    copyWenAnBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(13)];
//    [copyWenAnBtn addTarget:self action:@selector(clickCopyWenAnButton:) forControlEvents:UIControlEventTouchUpInside];
//    [contentBacnView addSubview:copyWenAnBtn];
//
//    [copyWenAnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_contentTV.mas_bottom).offset(7);
//        make.centerX.mas_equalTo(contentBacnView);
//        make.size.mas_equalTo(CGSizeMake(145, 36));
//    }];
//
//
//    UIView *tipView = [[UIView alloc]init];
//    tipView.backgroundColor = kUIColorFromRGB(0xFCF1D3);
//    tipView.layer.masksToBounds = YES;
//    tipView.layer.cornerRadius = 8.0f;
//    [backScrollView addSubview:tipView];
//
//    UITapGestureRecognizer *tipTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTipView:)];
//    [tipView addGestureRecognizer:tipTap];
//
//    [tipView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(wenAnView.mas_bottom).offset(12);
//        make.left.equalTo(backScrollView.mas_left).offset(12);
//        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 24, 32));
//    }];
//
//    UIImageView *tipToImgView = [[UIImageView alloc]init];
//    tipToImgView.image = [UIImage imageNamed:@"share_to.png"];
//    [tipView addSubview:tipToImgView];
//
//    [tipToImgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(tipView.mas_top).offset(8);
//        make.right.equalTo(tipView.mas_right).offset(-10);
//        make.size.mas_equalTo(CGSizeMake(11, 17));
//    }];
//
//    UILabel *tipLab = [[UILabel alloc]init];
//    tipLab.text = @"分享后不要忘记复制黏贴【评论区文案】!!!";
//    tipLab.textColor = kUIColorFromRGB(0xFC564B);
//    tipLab.font = [UIFont systemFontOfSize:FontSize(12*BiLi)];
//    [tipView addSubview:tipLab];
//
//    [tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(tipView.mas_top).offset(0);
//        make.left.equalTo(tipView.mas_left).offset(10);
//        make.height.mas_equalTo(32);
//    }];
//
//
//    UIView *downBackViw = [[UIView alloc]init];
//    [self.view addSubview:downBackViw];
//
//    [downBackViw mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.view.mas_bottom).offset(0);
//        make.left.equalTo(self.view.mas_left).offset(0);
//        make.right.equalTo(self.view.mas_right).offset(0);
//        make.height.mas_equalTo(88+(iPhoneX?34:0));
//    }];
//
//
//    UIView *downView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 88+(iPhoneX?34:0))];
//
//    [downBackViw addSubview:downView];
////    UIBezierPath *maskPath11 = [UIBezierPath bezierPathWithRoundedRect:downView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(8, 8)];
////    CAShapeLayer *maskLayer11 = [[CAShapeLayer alloc] init];
////    maskLayer11.frame = downView.bounds;
////    maskLayer11.path = maskPath11.CGPath;
////    downView.layer.mask = maskLayer11;
//    downView.backgroundColor = [UIColor whiteColor];
//
//
//
//    NSArray *shareToImgArr = @[@"share_toWX.png", @"share_toPYQ.png", @"share_toQQ.png", @"share_toKJ.png", @"share_down.png"];
//    NSArray *shareToTitleArr = @[@"微信好友", @"朋友圈", @"QQ", @"QQ空间", @"保存图片"];
//
//    for (int i = 0; i <shareToImgArr.count; i++) {
//
//        UIView *oneView = [[UIView alloc]initWithFrame:CGRectMake(0 + kScreenWidth/5.0 *i, 0, kScreenWidth/5.0, 88)];
//        [downView addSubview:oneView];
//
//        oneView.tag = 345+i;
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickOneShareViewOnShareGoodsVC:)];
//        [oneView addGestureRecognizer:tap];
//
//
//        UIImageView *shareToImg = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth/5.0 - 40)/2.0, 15.5, 40, 40)];
//        shareToImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", shareToImgArr[i]]];
//        [oneView addSubview:shareToImg];
//
//
//        UILabel *shareToTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 56, kScreenWidth/5.0, 20)];
//        shareToTitleLab.text = shareToTitleArr[i];
//        shareToTitleLab.textAlignment = NSTextAlignmentCenter;
//        shareToTitleLab.textColor = textPrimaryColor;
//        shareToTitleLab.font = [UIFont systemFontOfSize:FontSize(11)];
//        [oneView addSubview:shareToTitleLab];
//
//
//    }
//
//
//
//}
//
//- (NSString *)setShareStrWithWenAnShareStyle:(NSString *)wenAnShareStyle pwdAndLinkStyle:(NSString *)pwdAndLinkStyle{
//
//
//
//
//    NSString *replacingStrWenAn = [NSString stringWithFormat:@"%@", self.shareTextContent];
//    NSString *replacingStrPwd = [NSString stringWithFormat:@"%@", self.sharetPwdContent];
//    NSString *replacingStrLink = [NSString stringWithFormat:@"%@", self.shareLinkContent];
//   //  DMLog(@"替换前文案内容 == %@", replacingStrWenAn);
//
//
//    DMLog(@"替换前文案内容 -- replacingStrWenAn = %@\nreplacingStrPwd = %@\n replacingStrLink =%@",replacingStrWenAn, replacingStrPwd, replacingStrLink);
//
//    if ([self.type isEqualToString:@"superSearch"]) {
//
//        NSString *couponStr  = [NSString string];
////        couponStr = [NSString stringWithFormat:@"%@", self.superSearch.couponAmount];
//        couponStr = [NSString stringWithFormat:@"123456"];
//        if ([couponStr integerValue] == 0) {
//            couponStr = @"0";
//        }
//
//
//        NSString *couponStr1  = [NSString string];
//        NSString *yhqStr  = [NSString string];
//
//
//        NSString *couponInfoLast = [NSString string];
////        couponInfoLast = [NSString stringWithFormat:@"%@", self.superSearch.couponAmount];
//        couponInfoLast = [NSString stringWithFormat:@"123456"];
//
//        if ([couponInfoLast integerValue] == 0) {
//            couponStr1  = [NSString stringWithFormat:@"优惠券 ¥0元"];
//            couponInfoLast = @"0";
//            yhqStr = @"0";
//        }else{
//
//            couponStr1  = [NSString stringWithFormat:@"优惠券 ¥%@元", couponInfoLast];
//            yhqStr = couponInfoLast;
//
//        }
//
////        float incomeStr = [[NSString stringWithFormat:@"%f", [self.superSearch.zkFinalPrice doubleValue] - [couponInfoLast doubleValue]] floatValue] * ([[NSString stringWithFormat:@"%@", self.superSearch.commissionRate] floatValue] / 10000) * ([self.agentratio?self.agentratio:@"50" floatValue]/100);
//      //  DMLog(@"incomeStr == %f %@", incomeStr, self.agentratio);
//
//
////        replacingStrWenAn = [replacingStrWenAn stringByReplacingOccurrencesOfString:@"{标题}" withString:self.superSearch.title];
////        replacingStrWenAn = [replacingStrWenAn stringByReplacingOccurrencesOfString:@"{原价}" withString:[NSString stringWithFormat:@"%.2f", [self.superSearch.zkFinalPrice doubleValue]]];
////        replacingStrWenAn = [replacingStrWenAn stringByReplacingOccurrencesOfString:@"{券后价}" withString:[NSString stringWithFormat:@"%.2f", [self.superSearch.zkFinalPrice doubleValue] - [couponStr doubleValue]]];
////        replacingStrWenAn = [replacingStrWenAn stringByReplacingOccurrencesOfString:@"{券额}" withString:couponStr];
////         replacingStrWenAn = [replacingStrWenAn stringByReplacingOccurrencesOfString:@"{佣金}" withString:[NSString stringWithFormat:@"%.2f", incomeStr]];
////        replacingStrWenAn = [replacingStrWenAn stringByReplacingOccurrencesOfString:@"\r" withString:@""];
////        replacingStrWenAn = [replacingStrWenAn stringByReplacingOccurrencesOfString:@"{推荐内容}" withString:@""];
////        replacingStrWenAn = [replacingStrWenAn stringByReplacingOccurrencesOfString:@"\r" withString:@""];
////        replacingStrWenAn = [replacingStrWenAn stringByReplacingOccurrencesOfString:@"---------------\n" withString:@""];
////        replacingStrWenAn = [replacingStrWenAn stringByReplacingOccurrencesOfString:@"{淘口令}" withString:self.taoKouLin];
////        replacingStrWenAn = [replacingStrWenAn stringByReplacingOccurrencesOfString:@"{短链接}" withString:self.shareshortlink];
////
////
////        replacingStrWenAn = [replacingStrWenAn stringByReplacingOccurrencesOfString:@"\n-------------\n" withString:@""];
////
////
////
////        replacingStrPwd = [replacingStrPwd stringByReplacingOccurrencesOfString:@"{淘口令}" withString:self.taoKouLin];
////        replacingStrPwd = [replacingStrPwd stringByReplacingOccurrencesOfString:@"{短链接}" withString:self.shareshortlink];
////        replacingStrPwd = [replacingStrPwd stringByReplacingOccurrencesOfString:@"{标题}" withString:self.superSearch.title];
////        replacingStrPwd = [replacingStrPwd stringByReplacingOccurrencesOfString:@"{原价}" withString:[NSString stringWithFormat:@"%.2f", [self.superSearch.zkFinalPrice doubleValue]]];
////        replacingStrPwd = [replacingStrPwd stringByReplacingOccurrencesOfString:@"{券后价}" withString:[NSString stringWithFormat:@"%.2f", [self.superSearch.zkFinalPrice doubleValue] - [couponStr doubleValue]]];
////        replacingStrPwd = [replacingStrPwd stringByReplacingOccurrencesOfString:@"{券额}" withString:couponStr];
////         replacingStrPwd = [replacingStrPwd stringByReplacingOccurrencesOfString:@"{佣金}" withString:[NSString stringWithFormat:@"%.2f", incomeStr]];
////        replacingStrPwd = [replacingStrPwd stringByReplacingOccurrencesOfString:@"\r" withString:@""];
////        replacingStrPwd = [replacingStrPwd stringByReplacingOccurrencesOfString:@"{推荐内容}" withString:@""];
////        replacingStrPwd = [replacingStrPwd stringByReplacingOccurrencesOfString:@"\r" withString:@""];
////        replacingStrPwd = [replacingStrPwd stringByReplacingOccurrencesOfString:@"---------------\n" withString:@""];
////
////
////
////        replacingStrLink = [replacingStrLink stringByReplacingOccurrencesOfString:@"{淘口令}" withString:self.taoKouLin];
////        replacingStrLink = [replacingStrLink stringByReplacingOccurrencesOfString:@"{短链接}" withString:self.shareshortlink];
////        replacingStrLink = [replacingStrLink stringByReplacingOccurrencesOfString:@"{标题}" withString:self.superSearch.title];
////        replacingStrLink = [replacingStrLink stringByReplacingOccurrencesOfString:@"{原价}" withString:[NSString stringWithFormat:@"%.2f", [self.superSearch.zkFinalPrice doubleValue]]];
////        replacingStrLink = [replacingStrLink stringByReplacingOccurrencesOfString:@"{券后价}" withString:[NSString stringWithFormat:@"%.2f", [self.superSearch.zkFinalPrice doubleValue] - [couponStr doubleValue]]];
////        replacingStrLink = [replacingStrLink stringByReplacingOccurrencesOfString:@"{券额}" withString:couponStr];
////         replacingStrLink = [replacingStrLink stringByReplacingOccurrencesOfString:@"{佣金}" withString:[NSString stringWithFormat:@"%.2f", incomeStr]];
////        replacingStrLink = [replacingStrLink stringByReplacingOccurrencesOfString:@"\r" withString:@""];
////        replacingStrLink = [replacingStrLink stringByReplacingOccurrencesOfString:@"{推荐内容}" withString:@""];
////        replacingStrLink = [replacingStrLink stringByReplacingOccurrencesOfString:@"\r" withString:@""];
////        replacingStrLink = [replacingStrLink stringByReplacingOccurrencesOfString:@"---------------\n" withString:@""];
//
//    }
//
//    else if ([self.type isEqualToString:@"rec"]){
//
//
//
//
//
////        replacingStrWenAn = [NSString stringWithFormat:@"%@",self.rec_tjly];
//
////        ShopData *shopData = [ShopData mj_objectWithKeyValues:self.recommendData.goods];
//
////        replacingStrPwd = [replacingStrPwd stringByReplacingOccurrencesOfString:@"{淘口令}" withString:self.taoKouLin];
////        replacingStrPwd = [replacingStrPwd stringByReplacingOccurrencesOfString:@"{短链接}" withString:self.shareshortlink];
////        replacingStrPwd = [replacingStrPwd stringByReplacingOccurrencesOfString:@"{标题}" withString:shopData.name];
////        replacingStrPwd = [replacingStrPwd stringByReplacingOccurrencesOfString:@"{原价}" withString:[NSString stringWithFormat:@"%@", shopData.cost]];
////        replacingStrPwd = [replacingStrPwd stringByReplacingOccurrencesOfString:@"{券后价}" withString:[NSString stringWithFormat:@"%@", shopData.price]];
////        replacingStrPwd = [replacingStrPwd stringByReplacingOccurrencesOfString:@"{券额}" withString:[NSString stringWithFormat:@"%@", shopData.coupon]];
////        replacingStrPwd = [replacingStrPwd stringByReplacingOccurrencesOfString:@"{佣金}" withString:[NSString stringWithFormat:@"%@", shopData.normalCommission]];
////        replacingStrPwd = [replacingStrPwd stringByReplacingOccurrencesOfString:@"\r" withString:@""];
////        replacingStrPwd = [replacingStrPwd stringByReplacingOccurrencesOfString:@"{推荐内容}" withString:@""];
////        replacingStrPwd = [replacingStrPwd stringByReplacingOccurrencesOfString:@"\r" withString:@""];
////        replacingStrPwd = [replacingStrPwd stringByReplacingOccurrencesOfString:@"---------------\n" withString:@""];
////
////
////
////       replacingStrLink = [replacingStrLink stringByReplacingOccurrencesOfString:@"{淘口令}" withString:self.taoKouLin];
////        replacingStrLink = [replacingStrLink stringByReplacingOccurrencesOfString:@"{短链接}" withString:self.shareshortlink];
////        replacingStrLink = [replacingStrLink stringByReplacingOccurrencesOfString:@"{标题}" withString:shopData.name];
////        replacingStrLink = [replacingStrLink stringByReplacingOccurrencesOfString:@"{原价}" withString:[NSString stringWithFormat:@"%@", shopData.cost]];
////        replacingStrLink = [replacingStrLink stringByReplacingOccurrencesOfString:@"{券后价}" withString:[NSString stringWithFormat:@"%@", shopData.price]];
////        replacingStrLink = [replacingStrLink stringByReplacingOccurrencesOfString:@"{券额}" withString:[NSString stringWithFormat:@"%@", shopData.coupon]];
////        replacingStrLink = [replacingStrLink stringByReplacingOccurrencesOfString:@"{佣金}" withString:[NSString stringWithFormat:@"%@", shopData.normalCommission]];
////        replacingStrLink = [replacingStrLink stringByReplacingOccurrencesOfString:@"\r" withString:@""];
////        replacingStrLink = [replacingStrLink stringByReplacingOccurrencesOfString:@"{推荐内容}" withString:@""];
////        replacingStrLink = [replacingStrLink stringByReplacingOccurrencesOfString:@"\r" withString:@""];
////        replacingStrLink = [replacingStrLink stringByReplacingOccurrencesOfString:@"---------------\n" withString:@""];
//
//
//
//
//
//    }
//    else if ([self.type isEqualToString:@"newHome"]){
//
//
//
////        replacingStrWenAn = [replacingStrWenAn stringByReplacingOccurrencesOfString:@"{淘口令}" withString:self.taoKouLin];
////        replacingStrWenAn = [replacingStrWenAn stringByReplacingOccurrencesOfString:@"{短链接}" withString:self.shareshortlink];
////        replacingStrWenAn = [replacingStrWenAn stringByReplacingOccurrencesOfString:@"{标题}" withString:self.shopData.name];
////        replacingStrWenAn = [replacingStrWenAn stringByReplacingOccurrencesOfString:@"{原价}" withString:[NSString stringWithFormat:@"%@", [self reviseString:self.shopData.cost]]];
////        replacingStrWenAn = [replacingStrWenAn stringByReplacingOccurrencesOfString:@"{券后价}" withString:[NSString stringWithFormat:@"%@", [self reviseString:self.shopData.price]]];
////        replacingStrWenAn = [replacingStrWenAn stringByReplacingOccurrencesOfString:@"{券额}" withString:[NSString stringWithFormat:@"%@", [self reviseString:self.shopData.coupon]]];
////        replacingStrWenAn = [replacingStrWenAn stringByReplacingOccurrencesOfString:@"{佣金}" withString:[NSString stringWithFormat:@"%@", [self reviseString:self.shopData.normalCommission]]];
////         replacingStrWenAn = [replacingStrWenAn stringByReplacingOccurrencesOfString:@"\r" withString:@""];
////        replacingStrWenAn = [replacingStrWenAn stringByReplacingOccurrencesOfString:@"{推荐内容}" withString:self.shopData.desc?self.shopData.desc:@""];
////       // replacingStrWenAn = [replacingStrWenAn stringByReplacingOccurrencesOfString:@"\r" withString:@""];
////
////        if (self.shopData.desc.length == 0 || [self.shopData.desc isEqualToString:@"(null)"]) {
////             replacingStrWenAn = [replacingStrWenAn stringByReplacingOccurrencesOfString:@"\n-------------\n" withString:@""];
////        }
////
////
////
////
////        replacingStrPwd = [replacingStrPwd stringByReplacingOccurrencesOfString:@"{淘口令}" withString:self.taoKouLin];
////        replacingStrPwd = [replacingStrPwd stringByReplacingOccurrencesOfString:@"{短链接}" withString:self.shareshortlink];
////        replacingStrPwd = [replacingStrPwd stringByReplacingOccurrencesOfString:@"{标题}" withString:self.shopData.name];
////        replacingStrPwd = [replacingStrPwd stringByReplacingOccurrencesOfString:@"{原价}" withString:[NSString stringWithFormat:@"%@", [self reviseString:self.shopData.cost]]];
////        replacingStrPwd = [replacingStrPwd stringByReplacingOccurrencesOfString:@"{券后价}" withString:[NSString stringWithFormat:@"%@", [self reviseString:self.shopData.price]]];
////        replacingStrPwd = [replacingStrPwd stringByReplacingOccurrencesOfString:@"{券额}" withString:[NSString stringWithFormat:@"%@", [self reviseString:self.shopData.coupon]]];
////        replacingStrPwd = [replacingStrPwd stringByReplacingOccurrencesOfString:@"{佣金}" withString:[NSString stringWithFormat:@"%@", [self reviseString:self.shopData.normalCommission]]];
////         replacingStrPwd = [replacingStrPwd stringByReplacingOccurrencesOfString:@"\r" withString:@""];
////        replacingStrPwd = [replacingStrPwd stringByReplacingOccurrencesOfString:@"{推荐内容}" withString:self.shopData.desc?self.shopData.desc:@""];
////
////
////
////        replacingStrLink = [replacingStrLink stringByReplacingOccurrencesOfString:@"{淘口令}" withString:self.taoKouLin];
////        replacingStrLink = [replacingStrLink stringByReplacingOccurrencesOfString:@"{短链接}" withString:self.shareshortlink];
////        replacingStrLink = [replacingStrLink stringByReplacingOccurrencesOfString:@"{标题}" withString:self.shopData.name];
////        replacingStrLink = [replacingStrLink stringByReplacingOccurrencesOfString:@"{原价}" withString:[NSString stringWithFormat:@"%@", [self reviseString:self.shopData.cost]]];
////        replacingStrLink = [replacingStrLink stringByReplacingOccurrencesOfString:@"{券后价}" withString:[NSString stringWithFormat:@"%@", [self reviseString:self.shopData.price]]];
////        replacingStrLink = [replacingStrLink stringByReplacingOccurrencesOfString:@"{券额}" withString:[NSString stringWithFormat:@"%@", [self reviseString:self.shopData.coupon]]];
////        replacingStrLink = [replacingStrLink stringByReplacingOccurrencesOfString:@"{佣金}" withString:[NSString stringWithFormat:@"%@", [self reviseString:self.shopData.normalCommission]]];
////         replacingStrLink = [replacingStrLink stringByReplacingOccurrencesOfString:@"\r" withString:@""];
////        replacingStrLink = [replacingStrLink stringByReplacingOccurrencesOfString:@"{推荐内容}" withString:self.shopData.desc?self.shopData.desc:@""];
//     //   replacingStrLink = [replacingStrLink stringByReplacingOccurrencesOfString:@"\r" withString:@""];
//      //  replacingStrLink = [replacingStrLink stringByReplacingOccurrencesOfString:self.emptyrecommend withString:@""];
//    }
//    else{
//
////       replacingStrWenAn = [replacingStrWenAn stringByReplacingOccurrencesOfString:@"{淘口令}" withString:self.taoKouLin];
////       replacingStrWenAn = [replacingStrWenAn stringByReplacingOccurrencesOfString:@"{短链接}" withString:self.shareshortlink];
////        replacingStrWenAn = [replacingStrWenAn stringByReplacingOccurrencesOfString:@"{标题}" withString:self.shopData.shortname];
////        replacingStrWenAn = [replacingStrWenAn stringByReplacingOccurrencesOfString:@"{原价}" withString:[NSString stringWithFormat:@"%.2f", [self.shopData.shopprice doubleValue]]];
////        replacingStrWenAn = [replacingStrWenAn stringByReplacingOccurrencesOfString:@"{券后价}" withString:[NSString stringWithFormat:@"%.2f", [self.shopData.shopprice doubleValue] - [self.shopData.coupondenomination doubleValue]]];
////        replacingStrWenAn = [replacingStrWenAn stringByReplacingOccurrencesOfString:@"{券额}" withString:[NSString stringWithFormat:@"%.0f", [self.shopData.coupondenomination doubleValue]]];
////        replacingStrWenAn = [replacingStrWenAn stringByReplacingOccurrencesOfString:@"{佣金}" withString:[NSString stringWithFormat:@"%.2f", [self.shopData.commission doubleValue]]];
////         replacingStrWenAn = [replacingStrWenAn stringByReplacingOccurrencesOfString:@"\r" withString:@""];
////        replacingStrWenAn = [replacingStrWenAn stringByReplacingOccurrencesOfString:@"{推荐内容}" withString:self.shopData.recommended?self.shopData.recommended:@""];
////       // replacingStrWenAn = [replacingStrWenAn stringByReplacingOccurrencesOfString:@"\r" withString:@""];
////        if (self.shopData.recommended.length == 0 || [self.shopData.recommended isEqualToString:@"(null)"]) {
////             replacingStrWenAn = [replacingStrWenAn stringByReplacingOccurrencesOfString:@"\n-------------\n" withString:@""];
////        }
////
////              replacingStrPwd = [replacingStrPwd stringByReplacingOccurrencesOfString:@"{淘口令}" withString:self.taoKouLin];
////              replacingStrPwd = [replacingStrPwd stringByReplacingOccurrencesOfString:@"{短链接}" withString:self.shareshortlink];
////               replacingStrPwd = [replacingStrPwd stringByReplacingOccurrencesOfString:@"{标题}" withString:self.shopData.shortname];
////               replacingStrPwd = [replacingStrPwd stringByReplacingOccurrencesOfString:@"{原价}" withString:[NSString stringWithFormat:@"%.2f", [self.shopData.shopprice doubleValue]]];
////               replacingStrPwd = [replacingStrPwd stringByReplacingOccurrencesOfString:@"{券后价}" withString:[NSString stringWithFormat:@"%.2f", [self.shopData.shopprice doubleValue] - [self.shopData.coupondenomination doubleValue]]];
////               replacingStrPwd = [replacingStrPwd stringByReplacingOccurrencesOfString:@"{券额}" withString:[NSString stringWithFormat:@"%.0f", [self.shopData.coupondenomination doubleValue]]];
////               replacingStrPwd = [replacingStrPwd stringByReplacingOccurrencesOfString:@"{佣金}" withString:[NSString stringWithFormat:@"%.2f", [self.shopData.commission doubleValue]]];
////                replacingStrPwd = [replacingStrPwd stringByReplacingOccurrencesOfString:@"\r" withString:@""];
////               replacingStrPwd = [replacingStrPwd stringByReplacingOccurrencesOfString:@"{推荐内容}" withString:self.shopData.recommended?self.shopData.recommended:@""];
////             //  replacingStrPwd = [replacingStrPwd stringByReplacingOccurrencesOfString:@"\r" withString:@""];
////               replacingStrPwd = [replacingStrPwd stringByReplacingOccurrencesOfString:self.emptyrecommend withString:@""];
////
////
////             replacingStrLink = [replacingStrLink stringByReplacingOccurrencesOfString:@"{淘口令}" withString:self.taoKouLin];
////              replacingStrLink = [replacingStrLink stringByReplacingOccurrencesOfString:@"{短链接}" withString:self.shareshortlink];
////               replacingStrLink = [replacingStrLink stringByReplacingOccurrencesOfString:@"{标题}" withString:self.shopData.shortname];
////               replacingStrLink = [replacingStrLink stringByReplacingOccurrencesOfString:@"{原价}" withString:[NSString stringWithFormat:@"%.2f", [self.shopData.shopprice doubleValue]]];
////               replacingStrLink = [replacingStrLink stringByReplacingOccurrencesOfString:@"{券后价}" withString:[NSString stringWithFormat:@"%.2f", [self.shopData.shopprice doubleValue] - [self.shopData.coupondenomination doubleValue]]];
////               replacingStrLink = [replacingStrLink stringByReplacingOccurrencesOfString:@"{券额}" withString:[NSString stringWithFormat:@"%.0f", [self.shopData.coupondenomination doubleValue]]];
////               replacingStrLink = [replacingStrLink stringByReplacingOccurrencesOfString:@"{佣金}" withString:[NSString stringWithFormat:@"%.2f", [self.shopData.commission doubleValue]]];
////                replacingStrLink = [replacingStrLink stringByReplacingOccurrencesOfString:@"\r" withString:@""];
////               replacingStrLink = [replacingStrLink stringByReplacingOccurrencesOfString:@"{推荐内容}" withString:self.shopData.recommended?self.shopData.recommended:@""];
////            //   replacingStrLink = [replacingStrLink stringByReplacingOccurrencesOfString:@"\r" withString:@""];
////               replacingStrLink = [replacingStrLink stringByReplacingOccurrencesOfString:self.emptyrecommend withString:@""];
//
//
//    }
//
//
//
//
//     DMLog(@"replacingStrWenAn = %@\nreplacingStrPwd = %@\n replacingStrLink =%@",replacingStrWenAn, replacingStrPwd, replacingStrLink);
//
//
//
//     //   replacingStrLink = [replacingStrLink stringByReplacingOccurrencesOfString:@"{短链接}" withString:self.shareshortlink];
//
//    NSString *replacingStr = [NSString string];
//
//    if ([wenAnShareStyle isEqualToString:@"1"] && [pwdAndLinkStyle isEqualToString:@"0"]) {
//        replacingStr = [NSString stringWithFormat:@"%@", replacingStrWenAn];
//    }
//    if ([wenAnShareStyle isEqualToString:@"1"] && [pwdAndLinkStyle isEqualToString:@"2"]) {
//        replacingStr = [NSString stringWithFormat:@"%@\n-------------\n%@", replacingStrWenAn,replacingStrPwd];
//    }
//    if ([wenAnShareStyle isEqualToString:@"1"] && [pwdAndLinkStyle isEqualToString:@"3"]) {
//        replacingStr = [NSString stringWithFormat:@"%@\n-------------\n%@", replacingStrWenAn,replacingStrLink];
//    }
//    if ([wenAnShareStyle isEqualToString:@"0"] && [pwdAndLinkStyle isEqualToString:@"2"]) {
//        replacingStr = [NSString stringWithFormat:@"%@", replacingStrPwd];
//    }
//    if ([wenAnShareStyle isEqualToString:@"0"] && [pwdAndLinkStyle isEqualToString:@"3"]) {
//        replacingStr = [NSString stringWithFormat:@"%@", replacingStrLink];
//    }
//
//
//    DMLog(@"替换后 == %@", replacingStr);
//    return replacingStr;
//}
//
//- (void)clickShareChooseBtn:(UIButton *)btn{
//
//
//
//
//
//
//    NSString *ttStr = [NSString stringWithFormat:@"%@", btn.titleLabel.text];
//    NSString *shareStr = [NSString string];
//    if ([ttStr isEqualToString:@"商品文案"]) {
//         DMLog(@"dd == %@", btn.titleLabel.text);
//        if ([self.pwdAndlinkShareStyle isEqualToString:@"0"]) {
//
//        }
//        else{
//
//            if (btn.selected) {
//                self.wenAnShareStyle = @"0";
//                [btn setImage:[UIImage imageNamed:@"share_chooseBtn_no.png"] forState:0];
//            }else{
//                self.wenAnShareStyle = @"1";
//                [btn setImage:[UIImage imageNamed:@"share_chooseBtn_yes.png"] forState:0];
//            }
//
//            btn.selected = !btn.selected;
//
//        }
//
//
//    }
//    else if ([ttStr isEqualToString:@"淘口令"]){
//        DMLog(@"dd == %@", btn.titleLabel.text);
//        if ([self.wenAnShareStyle isEqualToString:@"1"] ) {
//
//            if ([self.pwdAndlinkShareStyle isEqualToString:@"3"]) {
//                if (btn.selected) {
//                    self.pwdAndlinkShareStyle = @"0";
//                    [btn setImage:[UIImage imageNamed:@"share_chooseBtn_no.png"] forState:0];
//                }else{
//                    self.pwdAndlinkShareStyle = @"2";
//                    [btn setImage:[UIImage imageNamed:@"share_chooseBtn_yes.png"] forState:0];
//                }
//
//                btn.selected = !btn.selected;
//
//                for (id view in self.shareChooseView.subviews ) {
//                    if ([view isKindOfClass:[UIButton class]]) {
//                        UIButton *btn = (UIButton *)view;
//                        if ([btn.titleLabel.text isEqualToString:@"下单链接"]) {
//                            [btn setImage:[UIImage imageNamed:@"share_chooseBtn_no.png"] forState:0];
//                            btn.selected = NO;
//                        }
//                    }
//
//                }
//
//
//
//            }
//            else{
//                if (btn.selected) {
//                    self.pwdAndlinkShareStyle = @"0";
//                    [btn setImage:[UIImage imageNamed:@"share_chooseBtn_no.png"] forState:0];
//                }else{
//                    self.pwdAndlinkShareStyle = @"2";
//                    [btn setImage:[UIImage imageNamed:@"share_chooseBtn_yes.png"] forState:0];
//                }
//
//                btn.selected = !btn.selected;
//
//            }
//
//
//        }
//        else{
//
//            if ([self.pwdAndlinkShareStyle isEqualToString:@"3"]) {
//                if (btn.selected) {
//                    self.pwdAndlinkShareStyle = @"0";
//                    [btn setImage:[UIImage imageNamed:@"share_chooseBtn_no.png"] forState:0];
//                }else{
//                    self.pwdAndlinkShareStyle = @"2";
//                    [btn setImage:[UIImage imageNamed:@"share_chooseBtn_yes.png"] forState:0];
//                }
//
//                btn.selected = !btn.selected;
//
//                for (id view in self.shareChooseView.subviews ) {
//                    if ([view isKindOfClass:[UIButton class]]) {
//                        UIButton *btn = (UIButton *)view;
//                        if ([btn.titleLabel.text isEqualToString:@"下单链接"]) {
//                            [btn setImage:[UIImage imageNamed:@"share_chooseBtn_no.png"] forState:0];
//                            btn.selected = NO;
//                        }
//                    }
//
//                }
//
//
//
//            }
//
//        }
//
//
//    }
//    else if ([ttStr isEqualToString:@"下单链接"]){
//          DMLog(@"dd == %@", btn.titleLabel.text);
//        if ([self.wenAnShareStyle isEqualToString:@"1"] ) {
//
//            if ([self.pwdAndlinkShareStyle isEqualToString:@"2"]) {
//                if (btn.selected) {
//                    self.pwdAndlinkShareStyle = @"0";
//                    [btn setImage:[UIImage imageNamed:@"share_chooseBtn_no.png"] forState:0];
//                }else{
//                    self.pwdAndlinkShareStyle = @"3";
//                    [btn setImage:[UIImage imageNamed:@"share_chooseBtn_yes.png"] forState:0];
//                }
//
//                btn.selected = !btn.selected;
//
//                for (id view in self.shareChooseView.subviews ) {
//                    if ([view isKindOfClass:[UIButton class]]) {
//                        UIButton *btn = (UIButton *)view;
//                        if ([btn.titleLabel.text isEqualToString:@"淘口令"]) {
//                            [btn setImage:[UIImage imageNamed:@"share_chooseBtn_no.png"] forState:0];
//                            btn.selected = NO;
//                        }
//                    }
//
//                }
//
//
//
//            }
//            else{
//                if (btn.selected) {
//                    self.pwdAndlinkShareStyle = @"0";
//                    [btn setImage:[UIImage imageNamed:@"share_chooseBtn_no.png"] forState:0];
//                }else{
//                    self.pwdAndlinkShareStyle = @"3";
//                    [btn setImage:[UIImage imageNamed:@"share_chooseBtn_yes.png"] forState:0];
//                }
//
//                btn.selected = !btn.selected;
//
//            }
//
//
//        }
//        else{
//
//
//            if ([self.pwdAndlinkShareStyle isEqualToString:@"2"]) {
//                if (btn.selected) {
//                    self.pwdAndlinkShareStyle = @"0";
//                    [btn setImage:[UIImage imageNamed:@"share_chooseBtn_no.png"] forState:0];
//                }else{
//                    self.pwdAndlinkShareStyle = @"3";
//                    [btn setImage:[UIImage imageNamed:@"share_chooseBtn_yes.png"] forState:0];
//                }
//
//                btn.selected = !btn.selected;
//
//                for (id view in self.shareChooseView.subviews ) {
//                    if ([view isKindOfClass:[UIButton class]]) {
//                        UIButton *btn = (UIButton *)view;
//                        if ([btn.titleLabel.text isEqualToString:@"淘口令"]) {
//                            [btn setImage:[UIImage imageNamed:@"share_chooseBtn_no.png"] forState:0];
//                            btn.selected = NO;
//                        }
//                    }
//
//                }
//
//
//            }
//
//
//        }
//
//
//    }
//
//    NSLog(@"wenAnShareStyle23 == %@pwdAndlinkShareStyle ==%@", self.wenAnShareStyle, self.pwdAndlinkShareStyle);
//    shareStr = [self setShareStrWithWenAnShareStyle:self.wenAnShareStyle pwdAndLinkStyle:self.pwdAndlinkShareStyle];
//
//    _contentTV.attributedText = [DMTextTool dm_changeLineSpace:3 str:shareStr];
//    _contentTV.font = [UIFont systemFontOfSize:FontSize(14)];
//    _contentTV.textColor = textMinorColor99;
//
//}
//
//
//- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//
//    [self.contentTV resignFirstResponder];
//
//}
//
//
//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
//
//    if ([text isEqualToString:@"\n"]) {
//        [self.contentTV resignFirstResponder];
//        return NO;
//    }
//
//    return YES;
//
//}
//
//
//
//-(UIImage *)CSImage:(UIImage *)img AddText:(NSString *)text
//{
//
//
//
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 375, 667)];
//    view.backgroundColor = allBackgroundColor;
//
//
//    //商品图片
//    UIImageView *goodsImageView = [[UIImageView alloc]init];
//    goodsImageView.frame = CGRectMake(10, 10, 375 - 20, 375 - 20 );
//    goodsImageView.contentMode = UIViewContentModeScaleAspectFill;
//    goodsImageView.image = img;
//    [view addSubview:goodsImageView];
//
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:goodsImageView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(7, 7)];
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.frame = goodsImageView.bounds;
//    maskLayer.path = maskPath.CGPath;
//    goodsImageView.layer.mask = maskLayer;
//
//
//    UIView *downView = [[UIView alloc]initWithFrame:CGRectMake(10, 10+375 - 20, 375 - 20, 160)];
//    downView.backgroundColor = [UIColor whiteColor];
//    [view addSubview:downView];
//
//
//    UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:downView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(7, 7)];
//    CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
//    maskLayer1.frame = downView.bounds;
//    maskLayer1.path = maskPath1.CGPath;
//    downView.layer.mask = maskLayer1;
//
//
//
//    //标题
//    UILabel *ttLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 375 - 40, 50)];
//    if ([self.type isEqualToString:@"superSearch"]) {
//
//        if ([self.superSearch.userType isEqualToString:@"淘宝"]) {
//            //淘宝色
//            ttLab.attributedText = [DMTextTool dm_addImage:[UIImage imageNamed:@"taobao.png"] bounds:CGRectMake(0, -2, 16, 16) index:0 str:[NSString stringWithFormat:@"  %@", self.superSearch.title] style:2];
//        }
//        else{
//            //天猫色
//            ttLab.attributedText = [DMTextTool dm_addImage:[UIImage imageNamed:@"tianmao.png"] bounds:CGRectMake(0, -2, 16, 16) index:0 str:[NSString stringWithFormat:@"  %@", self.superSearch.title] style:2];
//        }
//
//    }
//    else if ([self.type isEqualToString:@"rec"]){
//
//        if ([self.recommendData.platformtype isEqualToString:@"淘宝"]) {
//            //淘宝色
//            ttLab.attributedText = [DMTextTool dm_addImage:[UIImage imageNamed:@"taobao.png"] bounds:CGRectMake(0, -2, 16, 16) index:0 str:[NSString stringWithFormat:@"  %@", self.recommendData.goods[@"name"]] style:2];
//        }
//        else{
//            //天猫色
//            ttLab.attributedText = [DMTextTool dm_addImage:[UIImage imageNamed:@"tianmao.png"] bounds:CGRectMake(0, -2, 16, 16) index:0 str:[NSString stringWithFormat:@"  %@", self.recommendData.goods[@"name"]] style:2];
//        }
//
//    }
//    else if ([self.type isEqualToString:@"newHome"]){
//
//
//        NSString *shopType = [NSString stringWithFormat:@"%@", self.shopData.cpsType[@"code"]];
//
//        if ([shopType isEqualToString:@"tm"]) {
//
//            //天猫色
//            ttLab.attributedText = [DMTextTool dm_addImage:[UIImage imageNamed:@"tianmao.png"] bounds:CGRectMake(0, -2, 16, 16) index:0 str:[NSString stringWithFormat:@"  %@", self.shopData.name] style:2];
//        }
//        else{
//            //淘宝色
//           ttLab.attributedText = [DMTextTool dm_addImage:[UIImage imageNamed:@"taobao.png"] bounds:CGRectMake(0, -2, 16, 16) index:0 str:[NSString stringWithFormat:@"  %@", self.shopData.name] style:2];
//        }
//
//
//
//    }
//
//
//    else{
//        if ([self.shopData.platformtype isEqualToString:@"淘宝"]) {
//            //淘宝色
//             ttLab.attributedText = [DMTextTool dm_addImage:[UIImage imageNamed:@"taobao.png"] bounds:CGRectMake(0, -2, 16, 16) index:0 str:[NSString stringWithFormat:@"  %@", self.shopData.shopname?self.shopData.shopname:self.shopData.shortname] style:2];
//
//        }
//        else{
//            //天猫色
//
//            ttLab.attributedText = [DMTextTool dm_addImage:[UIImage imageNamed:@"tianmao.png"] bounds:CGRectMake(0, -2, 16, 16) index:0 str:[NSString stringWithFormat:@"  %@", self.shopData.shopname?self.shopData.shopname:self.shopData.shortname] style:2];
//        }
//
//    }
//
//    ttLab.textColor = textMinorColor33;
//    ttLab.font = [UIFont boldSystemFontOfSize:16];
//    ttLab.numberOfLines = 2;
//  //  ttLab.backgroundColor = [UIColor blueColor];
//    [downView addSubview:ttLab];
//
//
//
//    //购买人数
//
//    UILabel *sellCountLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 10+50+1, 150, 20)];
//    sellCountLab.font = [UIFont systemFontOfSize:12];
//    // sellCountLab.text = @"9999人已抢";
//    sellCountLab.textColor = textMinorColor99;
//    sellCountLab.adjustsFontSizeToFitWidth = YES;
//    [downView addSubview:sellCountLab];
//
//
//
//    if ([self.type isEqualToString:@"superSearch"]) {
//        NSString *soldNumStr = [[NSString alloc] init];
//        int soldNum = [[NSString stringWithFormat:@"%@", self.superSearch.volume] intValue];
//        if (soldNum > 10000) {
//            float bb = soldNum / 10000.0;
//            soldNumStr = [NSString stringWithFormat:@"%.2f万人已购买",bb];
//        }
//
//        else{
//
//            soldNumStr = [NSString stringWithFormat:@"%d人已购买",soldNum];
//        }
//
//        sellCountLab.text = soldNumStr;
//
//    }
//    else if ([self.type isEqualToString:@"rec"]){
//
//        NSString *soldNumStr = [[NSString alloc] init];
//        int soldNum = [[NSString stringWithFormat:@"%@", self.recommendData.goods[@"salesNum"]] intValue];
//        if (soldNum > 10000) {
//
//            float bb = soldNum / 10000.0;
//            soldNumStr = [NSString stringWithFormat:@"%.2f万人已购买",bb];
//
//        }
//        else{
//
//            soldNumStr = [NSString stringWithFormat:@"%d人已购买",soldNum];
//
//        }
//
//        sellCountLab.text = soldNumStr;
//
//    }
//
//    else if ([self.type isEqualToString:@"newHome"]){
//         NSString *soldNumStr = [[NSString alloc] init];
//         soldNumStr = [NSString stringWithFormat:@"%@人已购买",self.shopData.sales];
//          sellCountLab.text = soldNumStr;
//    }
//
//    else{
//
//        NSString *soldNumStr = [[NSString alloc] init];
//        int soldNum = [[NSString stringWithFormat:@"%@", self.shopData.shopmonthlysales] intValue];
//        if (soldNum > 10000) {
//
//            float bb = soldNum / 10000.0;
//            soldNumStr = [NSString stringWithFormat:@"%.2f万人已购买",bb];
//
//        }
//        else{
//
//            soldNumStr = [NSString stringWithFormat:@"%d人已购买",soldNum];
//
//        }
//
//        sellCountLab.text = soldNumStr;
//
//    }
//
//
//
//
//    //券后价
//
//    UILabel *newPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10+50+1+20+15, 120, 20)];
//    newPriceLabel.font = [UIFont systemFontOfSize:12];
//    newPriceLabel.textColor = DMColor;
//   // newPriceLabel.adjustsFontSizeToFitWidth = YES;
//    [downView addSubview:newPriceLabel];
//
//
//
//    NSString *quanHouPrice = [NSString string];
//    NSString *quanHouPriceStr = [NSString string];
//    if ([self.type isEqualToString:@"superSearch"]) {
//
//        NSString *couponStr  = [NSString string];
//         couponStr = [NSString stringWithFormat:@"%@", self.superSearch.couponAmount];
//        if ([couponStr integerValue] == 0) {
//            couponStr = @"0";
//        }
//        quanHouPriceStr = [NSString stringWithFormat:@"%.2f", [self.superSearch.zkFinalPrice doubleValue] - [couponStr doubleValue]];
//        quanHouPrice = [NSString stringWithFormat:@"券后价 ¥%.2f", [self.superSearch.zkFinalPrice doubleValue] - [couponStr doubleValue]];
//        newPriceLabel.attributedText = [DMTextTool dm_changeFont:24 color:DMColor range:NSMakeRange(5, quanHouPrice.length - 5) str:quanHouPrice];
//
//    }
//    else if ([self.type isEqualToString:@"rec"]){
//
//        quanHouPriceStr = [NSString stringWithFormat:@"%.2f", [self.recommendData.goods[@"price"] doubleValue] ];
//        quanHouPrice = [NSString stringWithFormat:@"券后价 ¥%@", quanHouPriceStr];
//        newPriceLabel.attributedText = [DMTextTool dm_changeFont:24 color:DMColor range:NSMakeRange(5, quanHouPrice.length - 5) str:quanHouPrice];
//
//    }
//    else if ([self.type isEqualToString:@"newHome"]){
//        quanHouPriceStr = [NSString stringWithFormat:@"%@", [self reviseString:self.shopData.price]];
//        quanHouPrice = [NSString stringWithFormat:@"券后价 ¥%@", quanHouPriceStr];
//            newPriceLabel.attributedText = [DMTextTool dm_changeFont:24 color:DMColor range:NSMakeRange(5, quanHouPrice.length - 5) str:quanHouPrice];
//    }
//
//    else{
//        quanHouPriceStr = [NSString stringWithFormat:@"%.2f", [self.shopData.shopprice doubleValue] - [self.shopData.coupondenomination doubleValue]];
//        quanHouPrice = [NSString stringWithFormat:@"券后价 ¥%.2f", [self.shopData.shopprice doubleValue] - [self.shopData.coupondenomination doubleValue]];
//        newPriceLabel.attributedText = [DMTextTool dm_changeFont:24 color:DMColor range:NSMakeRange(5, quanHouPrice.length - 5) str:quanHouPrice];
//    }
//
//
//    UIFont *font2 = [UIFont systemFontOfSize:24];
//    CGSize size = [quanHouPriceStr sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font2,NSFontAttributeName,nil]];
//    CGFloat newW = size.width;
//    CGFloat newWLast = ceilf(newW);
//    newPriceLabel.frame = CGRectMake(10, 10+50+1+20+15, newWLast+50, 20);
//  //  newPriceLabel.backgroundColor = [UIColor yellowColor];
//
//   //****原价
//
//    UILabel *oldPriceLab = [[UILabel alloc]initWithFrame:CGRectMake(10+newWLast+55, 10+50+1+20+17, 100, 20)];
//    oldPriceLab.font = [UIFont systemFontOfSize:12];
//    oldPriceLab.textColor = textMinorColor99;
//    oldPriceLab.adjustsFontSizeToFitWidth = YES;
//    [downView addSubview:oldPriceLab];
//
//    if ([self.type isEqualToString:@"superSearch"]) {
//        NSString *oldPrice = [[NSString alloc] init];
//        oldPrice  = [NSString stringWithFormat:@"原价 ¥%.2f", [self.superSearch.zkFinalPrice doubleValue]];
//        oldPriceLab.attributedText = [DMTextTool dm_deleteRange:NSMakeRange(0, oldPrice.length) str:oldPrice range2:NSMakeRange(0, 4)];
//
//    }
//    else if ([self.type isEqualToString:@"rec"]){
//
//        NSString *oldPrice = [[NSString alloc] init];
//        oldPrice  =[NSString stringWithFormat:@"原价 ¥%.2f", [self.recommendData.goods[@"cost"] doubleValue]];
//        oldPriceLab.attributedText = [DMTextTool dm_deleteRange:NSMakeRange(0, oldPrice.length) str:oldPrice range2:NSMakeRange(0, 4)];
//    }
//    else if ([self.type isEqualToString:@"newHome"]){
//        NSString *oldPrice = [[NSString alloc] init];
//        oldPrice  =[NSString stringWithFormat:@"原价 ¥%@", [self reviseString:self.shopData.cost]];
//        oldPriceLab.attributedText = [DMTextTool dm_deleteRange:NSMakeRange(0, oldPrice.length) str:oldPrice range2:NSMakeRange(0, 4)];
//    }
//
//    else{
//
//        NSString *oldPrice = [[NSString alloc] init];
//        oldPrice  =[NSString stringWithFormat:@"原价 ¥%.2f", [self.shopData.shopprice doubleValue]];
//        oldPriceLab.attributedText = [DMTextTool dm_deleteRange:NSMakeRange(0, oldPrice.length) str:oldPrice range2:NSMakeRange(0, 4)];
//
//    }
//
//
//
//
//
//    //券
// //
//    UIImageView *quanImgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10+50+1+20+15+20+10, 86, 21)];
//    quanImgView.image = [UIImage imageNamed:@"share_quanBack.png"];
//    [downView addSubview:quanImgView];
//
//    UILabel *quanTTLab = [[UILabel alloc]initWithFrame:CGRectMake(13, 10+50+1+20+15+20+10, 23, 21)];
//   // quanTTLab.backgroundColor = [UIColor blueColor];
//    quanTTLab.font = [UIFont systemFontOfSize:12];
//    quanTTLab.textColor = [UIColor whiteColor];
//    quanTTLab.text = @"券";
//    quanTTLab.textAlignment = NSTextAlignmentCenter;
//    [downView addSubview:quanTTLab];
//
//    UILabel *quanLab = [[UILabel alloc]initWithFrame:CGRectMake(42, 10+50+1+20+15+20+10, 48, 21)];
//   // quanLab.backgroundColor = [UIColor yellowColor];
//    quanLab.font = [UIFont systemFontOfSize:12];
//    quanLab.textColor = [UIColor whiteColor];
//    quanLab.textAlignment = NSTextAlignmentCenter;
//    quanLab.adjustsFontSizeToFitWidth = YES;
//    [downView addSubview:quanLab];
//
//    NSString *couponStr  = [NSString string];
//    if ([self.type isEqualToString:@"superSearch"]) {
//        couponStr = [NSString stringWithFormat:@"%.0f", [self.superSearch.couponAmount doubleValue]];
//        if ([couponStr integerValue] == 0) {
//            couponStr = @"0";
//        }
//    }
//    else if ([self.type isEqualToString:@"rec"]){
//         couponStr  = [NSString stringWithFormat:@"%.0f", [self.recommendData.goods[@"coupon"] doubleValue]];
//    }
//    else if ([self.type isEqualToString:@"newHome"]){
//         couponStr  = [NSString stringWithFormat:@"%.0f", [self.shopData.coupon doubleValue]];
//    }
//    else{
//         couponStr  = [NSString stringWithFormat:@"%.0f", [self.shopData.coupondenomination doubleValue]];
//    }
//
//    quanLab.text = [NSString stringWithFormat:@"%@元", couponStr];;
//
//
//     //二维码
//
//     DMLog(@"self.shareshortlink  = %@", self.shareshortlink);
//     //分享带二维码
//
//        NSString *erShareUrl = [NSString string];
//        if ([self.type isEqualToString:@"superSearch"]) {
//            erShareUrl = [NSString stringWithFormat:@"%@", self.shareshortlink];
//        }
//        else{
//            erShareUrl = [NSString stringWithFormat:@"%@", self.shareshortlink];
//        }
//
//     //    erShareUrl = @"http://t.7s181.cn/proshare.html?code=m0oKGr2YjMHOQM";
//        UIImage *erImg =  [ShareGoodsViewController qrImageForString:erShareUrl imageSize:84 logoImageSize:20];
//
//        UIImageView *erImgView = [[UIImageView alloc]init];
//        erImgView.frame= CGRectMake(375 - 20 - 12 - 84, 10+50+10-15, 84, 84);
//        erImgView.image = erImg;
//        [downView addSubview:erImgView];
//
//        // erImgView.backgroundColor = [UIColor yellowColor];
//
//
//        UILabel *erTipLab = [[UILabel alloc]init];
//        erTipLab.frame= CGRectMake(375 - 20 - 12 - 84, 10+50+10+84-15, 84, 15);
//        erTipLab.text = @"长按识别二维码";
//        erTipLab.textColor = textMinorColor99;
//        erTipLab.font = [UIFont systemFontOfSize:10];
//        erTipLab.textAlignment = NSTextAlignmentCenter;
//        [downView addSubview:erTipLab];
//
//
//
//
//
//
//
//    //推荐理由
//
//    if ([self.type isEqualToString:@"superSearch"] ) {
//
//        UIImageView *tipImgView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10+375 - 20+160+40, 375 - 40, 60)];
//        tipImgView.image = [UIImage imageNamed:@"share_tip.png"];
//        [view addSubview:tipImgView];
//
//    }
//    else if ([self.type isEqualToString:@"rec"]){
//
//        NSString *desc =[NSString stringWithFormat:@"%@", self.recommendData.goods[@"desc"]];
//        if (desc.length <6) {
//            UIImageView *tipImgView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10+375 - 20+160+40, 375 - 40, 60)];
//            tipImgView.image = [UIImage imageNamed:@"share_tip.png"];
//            [view addSubview:tipImgView];
//
//        }else{
//
//        UILabel *recommendTTLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10+375 - 20+160+28, 150, 20)];
//        recommendTTLabel.text = @"推荐理由";
//        recommendTTLabel.textColor = textMinorColor33;
//        recommendTTLabel.font = [UIFont systemFontOfSize:15];
//      //  recommendTTLabel.backgroundColor = [UIColor yellowColor];
//        [view addSubview:recommendTTLabel];
//
//
//
//        UILabel *recommendReasonLabel = [[UILabel alloc]init];
//
//
//        recommendReasonLabel.attributedText = [DMTextTool dm_changeLineSpace:3.0 str:desc];
//
//        recommendReasonLabel.textColor = textMinorColor;
//        recommendReasonLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12];
//        recommendReasonLabel.textAlignment = NSTextAlignmentLeft;
//        [recommendReasonLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
//       //  recommendReasonLabel.backgroundColor = [UIColor yellowColor];
//        recommendReasonLabel.numberOfLines = 0;
//        //recommendReasonLabel.backgroundColor = [UIColor yellowColor];
//        contentH = [self calculateRowHeight:desc fontSize:13];
//            if (contentH > 80) {
//                contentH = 80;
//            }
//        recommendReasonLabel.frame = CGRectMake(20, 10+375 - 20+160+30+20+5, 375 - 40, contentH);
//        recommendReasonLabel.adjustsFontSizeToFitWidth = YES;
//        [view addSubview:recommendReasonLabel];
//
//        }
//
//
//    }
//    else if ([self.type isEqualToString:@"newHome"]){
//           if (self.shopData.desc.length<6) {
//
//
//            UIImageView *tipImgView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10+375 - 20+160+40, 375 - 40, 60)];
//            tipImgView.image = [UIImage imageNamed:@"share_tip.png"];
//            [view addSubview:tipImgView];
//            }
//                 else{
//
//
//             UILabel *recommendTTLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10+375 - 20+160+28, 150, 20)];
//             recommendTTLabel.text = @"推荐理由";
//             recommendTTLabel.textColor = textMinorColor33;
//             recommendTTLabel.font = [UIFont systemFontOfSize:15];
//             [view addSubview:recommendTTLabel];
//
//
//
//             UILabel *recommendReasonLabel = [[UILabel alloc]init];
//
//             recommendReasonLabel.attributedText = [DMTextTool dm_changeLineSpace:3.0 str:[NSString stringWithFormat:@"%@", self.shopData.desc?self.shopData.desc:@""]];
//             recommendReasonLabel.textColor = textMinorColor;
//             recommendReasonLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12];
//             recommendReasonLabel.textAlignment = NSTextAlignmentLeft;
//             [recommendReasonLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
//            // recommendReasonLabel.backgroundColor = [UIColor whiteColor];
//             recommendReasonLabel.numberOfLines = 0;
//             //recommendReasonLabel.backgroundColor = [UIColor yellowColor];
//             contentH = [self calculateRowHeight:self.shopData.desc fontSize:13];
//                     if (contentH > 80) {
//                         contentH = 80;
//                     }
//             recommendReasonLabel.frame = CGRectMake(20, 10+375 - 20+160+30+20+5, 375 - 40, contentH);
//             recommendReasonLabel.adjustsFontSizeToFitWidth = YES;
//             [view addSubview:recommendReasonLabel];
//
//                 }
//    }
//    else{
//
//        if (self.shopData.recommended.length<6) {
//            UIImageView *tipImgView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10+375 - 20+160+40, 375 - 40, 60)];
//            tipImgView.image = [UIImage imageNamed:@"share_tip.png"];
//            [view addSubview:tipImgView];
//        }
//        else{
//
//
//    UILabel *recommendTTLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10+375 - 20+160+28, 150, 20)];
//    recommendTTLabel.text = @"推荐理由";
//    recommendTTLabel.textColor = textMinorColor33;
//    recommendTTLabel.font = [UIFont systemFontOfSize:15];
//    [view addSubview:recommendTTLabel];
//
//
//
//    UILabel *recommendReasonLabel = [[UILabel alloc]init];
//
//    recommendReasonLabel.attributedText = [DMTextTool dm_changeLineSpace:3.0 str:[NSString stringWithFormat:@"%@", self.shopData.recommended?self.shopData.recommended:@""]];
//    recommendReasonLabel.textColor = textMinorColor;
//    recommendReasonLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12];
//    recommendReasonLabel.textAlignment = NSTextAlignmentLeft;
//    [recommendReasonLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
//   // recommendReasonLabel.backgroundColor = [UIColor whiteColor];
//    recommendReasonLabel.numberOfLines = 0;
//    //recommendReasonLabel.backgroundColor = [UIColor yellowColor];
//    contentH = [self calculateRowHeight:self.shopData.recommended fontSize:13];
//            if (contentH > 80) {
//                contentH = 80;
//            }
//    recommendReasonLabel.frame = CGRectMake(20, 10+375 - 20+160+30+20+5, 375 - 40, contentH);
//    recommendReasonLabel.adjustsFontSizeToFitWidth = YES;
//    [view addSubview:recommendReasonLabel];
//
//        }
//
//   }
//
//
//
//
//
//   // view.frame = CGRectMake(0, 0, kScreenWidth, 155+goodsImageView.height+56+75 +15 + 25);
//
//
//    return [self convertViewToImage:view];
//
//}
//
//
//-(NSString *)reviseString:(NSString *)string{
//
///* 直接传入精度丢失有问题的Double类型*/
//
//    double conver = (double)[string doubleValue];
//    NSString *douStr = [NSString stringWithFormat:@"%f", conver];
//    NSDecimalNumber *decNum = [NSDecimalNumber decimalNumberWithString:douStr];
//
//
//return [decNum stringValue];
//
//}
//
//+ (UIImage *)qrImageForString:(NSString *)string imageSize:(CGFloat)Imagesize logoImageSize:(CGFloat)waterImagesize{
//
//
//    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
//    [filter setDefaults];
//    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
//    [filter setValue:data forKey:@"inputMessage"];//通过kvo方式给一个字符串，生成二维码
//    [filter setValue:@"M" forKey:@"inputCorrectionLevel"];//设置二维码的纠错水平，越高纠错水平越高，可以污损的范围越大
//    CIImage *outPutImage = [filter outputImage];//拿到二维码图片
//    return [[self alloc] createNonInterpolatedUIImageFormCIImage:outPutImage withSize:Imagesize waterImageSize:waterImagesize];
//
//
//}
//
//
//
//- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size waterImageSize:(CGFloat)waterImagesize{
//
//
//    CGRect extent = CGRectIntegral(image.extent);
//    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
//
//    // 1.创建bitmap;
//    size_t width = CGRectGetWidth(extent) * scale;
//    size_t height = CGRectGetHeight(extent) * scale;
//    //创建一个DeviceGray颜色空间
//    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
//    //CGBitmapContextCreate(void * _Nullable data, size_t width, size_t height, size_t bitsPerComponent, size_t bytesPerRow, CGColorSpaceRef  _Nullable space, uint32_t bitmapInfo)
//    //width：图片宽度像素
//    //height：图片高度像素
//    //bitsPerComponent：每个颜色的比特值，例如在rgba-32模式下为8
//    //bitmapInfo：指定的位图应该包含一个alpha通道。
//    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
//    CIContext *context = [CIContext contextWithOptions:nil];
//    //创建CoreGraphics image
//    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
//
//    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
//    CGContextScaleCTM(bitmapRef, scale, scale);
//    CGContextDrawImage(bitmapRef, extent, bitmapImage);
//
//    // 2.保存bitmap到图片
//    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
//    CGContextRelease(bitmapRef); CGImageRelease(bitmapImage);
//
//    //原图
//    UIImage *outputImage = [UIImage imageWithCGImage:scaledImage];
//    //给二维码加 logo 图
//    UIGraphicsBeginImageContextWithOptions(outputImage.size, NO, [[UIScreen mainScreen] scale]);
//    [outputImage drawInRect:CGRectMake(0,0 , size, size)];
//
////    //logo图
//    UIImage *waterimage = [UIImage imageNamed:@"DM_login.png"];
//    //把logo图画到生成的二维码图片上，注意尺寸不要太大（最大不超过二维码图片的%30），太大会造成扫不出来
//    [waterimage drawInRect:CGRectMake((size-waterImagesize)/2.0, (size-waterImagesize)/2.0, waterImagesize, waterImagesize)];
//
//    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return newPic;
//
//}
//
//
//
//-(UIImage*)convertViewToImage:(UIView*)v
//{
//    CGSize s = v.bounds.size;
//
//    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
//
//    CGContextRef context = UIGraphicsGetCurrentContext();
//
//    [v.layer renderInContext:context];
//
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//
//    v.layer.contents = nil;
//
//    return image;
//
//}
//
//
//- (void)clickOneShareViewOnShareGoodsVC:(UIGestureRecognizer *)sender{
//
//
//    DMLog(@"self.clickImgeArr == %@", self.clickImgeArr);
//    NSString *ttStr = [NSString string];
//    for (id view in sender.view.subviews) {
//        if ([view isKindOfClass:[UILabel class]]) {
//            UILabel *lab = (UILabel *)view;
//            ttStr = lab.text;
//        }
//    }
//
//
//    DMLog(@"ttStr == %@", ttStr);
//    self.shareStyle = ttStr;
//
//    if (self.clickImgeArr.count == 0) {
//        [self.clickImgeArr addObject:[UIImage imageNamed:@"onecell.png"]];
//    }
//
//    self.shareImgeArr = [NSMutableArray arrayWithArray:self.clickImgeArr];
//    //分享带二维码
//    UIImage *ii =  [self CSImage:self.clickImgeArr[0] AddText:@""];
//    if (ii) {
//          [self.shareImgeArr replaceObjectAtIndex:0 withObject:ii];
//    }
//
//    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//    pasteboard.string = [NSString stringWithFormat:@"%@", self.contentTV.text];
//
//    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setValue:[NSString stringWithFormat:@"%@", self.contentTV.text] forKey:@"dmjFuZhiNeiRong"];
//
//
//    if (sender.view.tag - 345 == 1) {
//        //朋友圈
//        if (self.shareImgeArr.count == 1) {
//
//            [TSShareHelper shareWithType:0 andController:self andItems:self.shareImgeArr andCompletion:^(TSShareHelper *shareHelper, BOOL success) {
//            }];
//        }
//        else{
//
//         [self saveNext];
//
////        PopView *popUpView = [[PopView alloc]init];
////        popUpView.vc = self;
////        [popUpView setVisualEffectViewWithView:self.view variety:@"分享到朋友圈"];
////        [popUpView setOpenPYQ:^(NSString *style) {
////            DMLog(@"点击打开朋友圈");
////            //创建一个url，这个url就是WXApp的url，记得加上：//
////            NSURL *url = [NSURL URLWithString:@"weixin://"];
////            //打开url
////            if (@available(iOS 10.0, *)) {
////
////                [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
////            }else{
////
////                [[UIApplication sharedApplication] openURL:url];
////            }
////        }];
//
////            [self.view addSubview:popUpView];
//
//        }
//
//    }
//    else if (sender.view.tag - 345 == 4){
//        //保存图片
//        [self saveNext];
//    }
//    else{
//
//       // [[YXAlertView shareInstance] showTipsToView:self.view message:[NSString stringWithFormat:@"文案已复制成功"] imageType:3];
//       //   [YJProgressHUD showMessage:@"文案已复制成功" inView:self.view];
//
//        [YJProgressHUD showMsgWithMsgStr:@"复制成功" imageName:@"copy_success.png" inview:self.view afterDelayTime:1.5];
//
//        [TSShareHelper shareWithType:0 andController:self andItems:self.shareImgeArr andCompletion:^(TSShareHelper *shareHelper, BOOL success) {
//        }];
//
//
//    }
//
//
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        // 异步 处理耗时操作的代码块...
//        //去分享商品
//        NSDictionary *urlDic = @{
//                                 @"type":@"shareshop",
//                                 };
//
//        [NetWorkManager  requestWithType:1 withUrlString:kURLWithGetfinishscore withParaments:urlDic withSuccessBlock:^(NSDictionary *responseObject) {
//
//            DMLog(@"呆萌币 签到数据 =  %@",  responseObject);
//            // *****
//            if ([responseObject[@"result"] isEqualToString:@"1"]) {
//
//
//            }
//
//            //*******
//        } withFailureBlock:^(NSError *error) {
//
//        } progress:^(float progress) {
//
//        }];
//
//    });
//
//
//
//
//
//
//
//}
//
//- (void)clickSaveImgButton:(UIButton *)sender{
//
//
//    if (self.clickImgeArr.count == 0) {
//        [self.clickImgeArr addObject:[UIImage imageNamed:@"onecell.png"]];
//    }
//    self.shareImgeArr = [NSMutableArray arrayWithArray:self.clickImgeArr];
//    //分享带二维码
//    UIImage *ii =  [self CSImage:self.clickImgeArr[0] AddText:@""];
//    if (ii) {
//        [self.shareImgeArr replaceObjectAtIndex:0 withObject:ii];
//        [self saveNext];
//    }
//
//
//}
//
//
//
//-(void)saveNext{
//
//
//
//
//    NSLog(@"self.shareImgeArr == %@   %@", self.shareImgeArr, self.clickImgeArr);
//
//    if (_shareImgeArr.count > 0) {
//        UIImage *image = [_shareImgeArr objectAtIndex:0];
//        UIImageWriteToSavedPhotosAlbum(image, self, @selector(savedPhotoImage:didFinishSavingWithError:contextInfo:), nil);
//    }
//    else {
//
//        if ([self.shareStyle isEqualToString:@"朋友圈"]) {
//
//        }else{
//
//           // [YJProgressHUD showSuccess:@"保存图片完成" inview:self.view];
//            [YJProgressHUD showMsgWithMsgStr:@"保存图片完成" imageName:@"copy_success.png" inview:self.view afterDelayTime:1.3];
//        }
//
//    }
//
//
//}
//
//-(void)savedPhotoImage:(UIImage*)image didFinishSavingWithError: (NSError *)error contextInfo: (void *)contextInfo {
//    if (error) {
//        //DMLog(@"%@", error.localizedDescription);
//    }
//    else {
//        if (_shareImgeArr.count > 0) {
//            [_shareImgeArr removeObjectAtIndex:0];
//            NSLog(@"self.shareImgeArr 删除后 == %@", _shareImgeArr);
//        }
//
//    }
//    [self saveNext];
//
//}
//
//
//- (void)clickMarkImageViewTap:(UIButton *)sender{
//
//    if (sender.tag - 789 >= self.allImgeArr.count) {
//        return;
//    }
//    if (self.allImgeArr.count==0) {
//        return;
//    }
//
//    if (!sender.selected) {
//
//        [sender setImage:[UIImage imageNamed:@"share_checked11.png"] forState:0];
//        [self.clickImgeArr addObject:self.allImgeArr[sender.tag - 789]];
//        sender.selected = !sender.selected;
//        _imgCountLab.text = [NSString stringWithFormat:@"已选%lu张", (unsigned long)self.clickImgeArr.count];
//
//        [self.shareTagArr addObject:[NSString stringWithFormat:@"%ld",sender.tag+210]];
//    }
//    else{
//
//
//
//        if (self.clickImgeArr.count > 1 && self.shareTagArr.count > 1) {
//
//            [sender setImage:[UIImage imageNamed:@"share_unchecked11.png"] forState:0];
//            UIImage *deleteImg = [[UIImage alloc]init];
//            for (UIImage *image in self.clickImgeArr) {
//
//
//                if ([image isEqual:self.allImgeArr[sender.tag - 789]]) {
//                    deleteImg = image;
//                    sender.selected = !sender.selected;
//                }
//            }
//
//            if (deleteImg) {
//                [self.clickImgeArr removeObject:deleteImg];
//                [self.shareTagArr removeObject:[NSString stringWithFormat:@"%ld",sender.tag+210]];
//            }
//
//
//
//            _imgCountLab.text = [NSString stringWithFormat:@"已选%lu张", (unsigned long)self.clickImgeArr.count];
//
//
//            for (UIView *view in self.shareImgScrollView.subviews) {
//
//                if ([view isKindOfClass:[UIImageView class]]) {
//                    UIImageView *imgView = (UIImageView *)view;
//
//                  //  NSLog(@"tagtagtagtag == %ld %ld  dd =%@", (long)imgView.tag, (long)[self.shareTagArr[0] integerValue], self.shareTagArr);
//
//                    if (imgView.tag == [self.shareTagArr[0] integerValue]) {
//                        index = imgView.tag - 999;
//
//                        for (UIView *view in imgView.subviews) {
//
//                            if ([view isKindOfClass:[UILabel class]]) {
//
//                                UILabel *lab = (UILabel *)view;
//                                lab.text = @"二维码推广图";
//                                lab.backgroundColor = DMColor;
//                            }
//                        }
//                    }
//                    else{
//
//                        for (UIView *view in imgView.subviews) {
//                            if ([view isKindOfClass:[UILabel class]]) {
//                                UILabel *lab = (UILabel *)view;
//                                lab.text = @"";
//                                lab.backgroundColor = [UIColor clearColor];
//                            }
//                        }
//
//                    }
//
//                }
//
//
//            }
//
//
//        }
//        else{
//            [[YXAlertView shareInstance] showAlert:@"温馨提示" message:@"最少选择一张图片" cancelTitle:nil titleArray:nil viewController:self confirm:^(NSInteger buttonTag) {
//
//            }];
//        }
//
//    }
//
//
//}
//
//- (void)clickCopyWenAnButton:(UIButton *)sender{
//    DMLog(@"复制文案 ");
//    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//    pasteboard.string =  [NSString stringWithFormat:@"%@", self.contentTV.text];
//
//    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setValue:[NSString stringWithFormat:@"%@", self.contentTV.text] forKey:@"dmjFuZhiNeiRong"];
//
//
//
//   // [[YXAlertView shareInstance] showTipsToView:self.view message:[NSString stringWithFormat:@"已复制到剪切板"] imageType:1];
//   // [YJProgressHUD showMessage:@"已复制到剪切板" inView:self.view];
//     [YJProgressHUD showMsgWithMsgStr:@"复制成功" imageName:@"copy_success.png" inview:self.view afterDelayTime:1.5];
//}
//
//
//
//- (void)clickShareImageView:(UIGestureRecognizer *)sender{
//
//    NSInteger index = sender.view.tag - 999;
//    DMLog(@"index == %ld", (long)index);
//
//    ShowImageVC *showImageVC = [[ShowImageVC alloc]init];
//    showImageVC.receivedImageArr = self.allImgeArr;
//    showImageVC.receivedIndex = index;
//    showImageVC.imageType = @"image";
//    showImageVC.modalPresentationStyle = 0;
//    dispatch_async(dispatch_get_main_queue(), ^{
//
//        [self.navigationController presentViewController:showImageVC animated:YES completion:^{
//        }];
//    });
//
//}
//
//- (CGFloat)calculateRowHeight:(NSString *)string fontSize:(NSInteger)fontSize{
//
//
//    NSDictionary *dic = @{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Medium" size:12],NSBaselineOffsetAttributeName:[NSNumber numberWithInteger:3]};//指定字号
//    CGRect rect = [string boundingRectWithSize:CGSizeMake((375 - 40), 0)/*计算高度要先指定宽度*/ options:NSStringDrawingUsesLineFragmentOrigin |
//                   NSStringDrawingUsesFontLeading attributes:dic context:nil];
//    return rect.size.height;
//
//
//
//}
//
//
//- (void)clickTipView:(UIGestureRecognizer *)sender{
//
//    NSDictionary *urlDic = @{
//                             @"type":@"6",
//                             };
//    [NetWorkManager  requestWithType:1 withUrlString:kURLWithGetmerchantweb withParaments:urlDic withSuccessBlock:^(NSDictionary *responseObject) {
//
//        DMLog(@"商品分享规则 =  %@",  responseObject);
//        // *****
//        if ([responseObject[@"result"] isEqualToString:@"1"]) {
//
//            NSArray *dataArr = (NSArray *)responseObject[@"data"];
//
//            if (dataArr.count > 0) {
//
//                NSDictionary *dict = dataArr[0];
//                NSString *url = [NSString stringWithFormat:@"%@", dict[@"url"]];
//                SkipWebVC *skipWebVC = [[SkipWebVC alloc]init];
//                skipWebVC.urlStr = url;
//                if (skipWebVC) {
//                    [self.navigationController pushViewController:skipWebVC animated:YES];
//                }
//
//
//            }
//
//        }
//
//        //*******
//    } withFailureBlock:^(NSError *error) {
//
//    } progress:^(float progress) {
//
//    }];
//
//}
//
//
//- (void)clickChangeImgButton:(UIButton *)sender{
//
//        UIWindow* window =  [UIApplication sharedApplication].keyWindow;
//
//
//        //实现模糊效果
//         self.visualEffectView = [[UIView alloc]init];
//        _visualEffectView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
//        _visualEffectView.backgroundColor = ColorMaker(0, 0, 0, 153);
//        _visualEffectView.tag = 9090;
//          [window addSubview:_visualEffectView];
//
//
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickPasteboardVisualEffectView:)];
//        [_visualEffectView addGestureRecognizer:tap];
//
//         self.allView = [[UIView alloc]init];
//         _allView.frame = CGRectMake(0, 0, 306, 481);
//         _allView.center = window.center;
//         _allView.tag = 9191;
//         _allView.backgroundColor = allBackgroundColor;
//         _allView.layer.masksToBounds = YES;
//         _allView.layer.cornerRadius = 8;
//          [window addSubview:_allView];
//
//
//         UIView *oneView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 306, 49)];
//         oneView.backgroundColor = [UIColor whiteColor];
//        UIBezierPath *maskPath111 = [UIBezierPath bezierPathWithRoundedRect:oneView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(8, 8)];
//        CAShapeLayer *maskLayer111 = [[CAShapeLayer alloc] init];
//        maskLayer111.frame = oneView.bounds;
//        maskLayer111.path = maskPath111.CGPath;
//        oneView.layer.mask = maskLayer111;
//        [_allView addSubview:oneView];
//
//    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    closeBtn.frame = CGRectMake(0, 0, 49, 49);
//    [closeBtn setImage:[UIImage imageNamed:@"share_change_close"] forState:0];
//    [closeBtn addTarget:self action:@selector(clickCloseButton:) forControlEvents:UIControlEventTouchUpInside];
//    [oneView addSubview:closeBtn];
//
//    UILabel *ttLab = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, 206, 49)];
//    ttLab.text = @"更换二维码主图";
//    ttLab.textColor = textMinorColor33;
//    ttLab.font = [UIFont systemFontOfSize:FontSize(14)];
//    ttLab.textAlignment = NSTextAlignmentCenter;
//    [oneView addSubview:ttLab];
//
//    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    saveBtn.frame = CGRectMake(247, 0, 59, 49);
//    [saveBtn setTitle:@"保存" forState:0];
//    [saveBtn setTitleColor:kUIColorFromRGB(0xFF2943) forState:0];
//    saveBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(14)];
//    [saveBtn addTarget:self action:@selector(clickChangeSaveButton:) forControlEvents:UIControlEventTouchUpInside];
//    [oneView addSubview:saveBtn];
//
//
//    self.lastImgView = [[UIImageView alloc]initWithFrame:CGRectMake(66, 58, 174, 310)];
//    [_allView addSubview:_lastImgView];
//
//
//
//          UIView *twoView = [[UIView alloc]initWithFrame:CGRectMake(0, 377, 306, 104)];
//            twoView.backgroundColor = [UIColor whiteColor];
//           UIBezierPath *maskPath222 = [UIBezierPath bezierPathWithRoundedRect:twoView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(8, 8)];
//           CAShapeLayer *maskLayer222 = [[CAShapeLayer alloc] init];
//           maskLayer222.frame = twoView.bounds;
//           maskLayer222.path = maskPath222.CGPath;
//           twoView.layer.mask = maskLayer222;
//           [_allView addSubview:twoView];
//
//
//      self.changeScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(12, 12, 282 , 80)];
//      _changeScrollView.contentSize = CGSizeMake(85*self.imgArr.count+0, 80);
//      _changeScrollView.showsHorizontalScrollIndicator = NO;
//      [twoView addSubview:_changeScrollView];
//
//    DMLog(@"self.shareTagArr == %@", self.shareTagArr);
//
//
//      for (int i = 0; i < self.allImgeArr.count; i ++) {
//
//
//
//          UIImageView *shareImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0 + 85 * i, 0, 80, 80)];
//          shareImgView.layer.masksToBounds = YES;
//          shareImgView.layer.cornerRadius = 5.0f;
//          shareImgView.tag = 679+i;
//
//          [_changeScrollView addSubview:shareImgView];
//
//          UIButton *markImgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//          markImgBtn.frame = CGRectMake(50, 2, 27, 27);
//          markImgBtn.tag = 579+i;
//
//
//          UILabel *ewmtgtLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, 80, 20)];
//          ewmtgtLab.textColor = [UIColor whiteColor];
//          ewmtgtLab.font = [UIFont systemFontOfSize:FontSize(11)];
//          ewmtgtLab.adjustsFontSizeToFitWidth = YES;
//          ewmtgtLab.textAlignment = NSTextAlignmentCenter;
//
//          ewmtgtLab.backgroundColor = [UIColor clearColor];
//          UIBezierPath *maskPath22 = [UIBezierPath bezierPathWithRoundedRect:ewmtgtLab.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
//          CAShapeLayer *maskLayer22 = [[CAShapeLayer alloc] init];
//          maskLayer22.frame = ewmtgtLab.bounds;
//          maskLayer22.path = maskPath22.CGPath;
//          ewmtgtLab.layer.mask = maskLayer22;
//          [shareImgView addSubview:ewmtgtLab];
//
//
//          shareImgView.image = self.allImgeArr[i];
//
//              if (i==index) {
//                //  [self.shareTagArr addObject:@"999"];
//
//                  [markImgBtn setImage:[UIImage imageNamed:@"share_checked11.png"] forState:0];
//                  markImgBtn.selected = YES;
//                  ewmtgtLab.text = @"二维码推广图";
//                  ewmtgtLab.backgroundColor = DMColor;
//
//                  _lastImgView.image =  [self CSImage:self.allImgeArr[i] AddText:@""];
//
//
//
////
////                  [self.allImgeArr replaceObjectAtIndex:0 withObject:self.imgArr[i]];
////                  [self.clickImgeArr addObject:self.allImgeArr[0]];
//
//
//
//              }
//              else{
//
//                  [markImgBtn setImage:[UIImage imageNamed:@"share_unchecked11.png"] forState:0];
//                  markImgBtn.selected = NO;
//
//
////                  shareImgView.image = self.imgArr[i];
////
////                  [self.allImgeArr replaceObjectAtIndex:i withObject:self.imgArr[i]];
//
//
//
//
//              }
//
//
//          markImgBtn.userInteractionEnabled = YES;
//          shareImgView.userInteractionEnabled = YES;
//          self.view.userInteractionEnabled = YES;
//
//
//          [markImgBtn addTarget:self action:@selector(clickChangeViewMarkImageViewTap:) forControlEvents:UIControlEventTouchUpInside];
//          [shareImgView addSubview:markImgBtn];
//
//
//
//
//
//
//      }
//
//
//
//
//
//}
//
//- (void)clickPasteboardVisualEffectView:(UIGestureRecognizer *)sender{
//
//        [self.visualEffectView removeFromSuperview];
//        [self.allView removeFromSuperview];
//
//}
//
//- (void)clickCloseButton:(UIButton *)sender{
//    [self.visualEffectView removeFromSuperview];
//    [self.allView removeFromSuperview];
//}
//
//- (void)clickChangeViewMarkImageViewTap:(UIButton *)sender{
//
//
//    if (sender.tag - 579 >= self.allImgeArr.count) {
//        return;
//    }
//    if (self.allImgeArr.count==0) {
//        return;
//    }
//
//    if (sender.tag - 579 == index) {
//        return;
//    }else{
//
//         for (UIView *view in self.changeScrollView.subviews) {
//
//             if ([view isKindOfClass:[UIImageView class]]) {
//
//                 UIImageView *imgView = (UIImageView *)view;
//
//                 if (imgView.tag == sender.tag+100) {
//                     index = imgView.tag - 679;
//
//                     _lastImgView.image =  [self CSImage:self.allImgeArr[index] AddText:@""];
//
//                     for (UIView *view in imgView.subviews) {
//
//                         if ([view isKindOfClass:[UILabel class]]) {
//
//                             UILabel *lab = (UILabel *)view;
//                             lab.text = @"二维码推广图";
//                             lab.backgroundColor = DMColor;
//                         }
//
//                         if ([view isKindOfClass:[UIButton class]]) {
//                             UIButton *btn = (UIButton *)view;
//                             [btn setImage:[UIImage imageNamed:@"share_checked11.png"] forState:0];
//                         }
//
//                     }
//                 }
//
//                 else{
//
//                     for (UIView *view in imgView.subviews) {
//                         if ([view isKindOfClass:[UILabel class]]) {
//                             UILabel *lab = (UILabel *)view;
//                             lab.text = @"";
//                             lab.backgroundColor = [UIColor clearColor];
//                         }
//                         if ([view isKindOfClass:[UIButton class]]) {
//                             UIButton *btn = (UIButton *)view;
//                              [btn setImage:[UIImage imageNamed:@"share_unchecked11.png"] forState:0];
//                         }
//                     }
//
//                 }
//
//             }
//
//
//         }
//
//
//
//    }
//
//
//
//
//}
//
//
//- (void)clickChangeSaveButton:(UIButton *)sender{
//
//    [self.visualEffectView removeFromSuperview];
//    [self.allView removeFromSuperview];
//
//
//
//
//    if ([self.clickImgeArr containsObject:self.allImgeArr[index]] == NO) {
//         [self.clickImgeArr insertObject:self.allImgeArr[index] atIndex:0];//如果没有就添加
//        [self.shareTagArr addObject:[NSString stringWithFormat:@"%ld",999+index]];
//    }
//    else{
//
//        if (self.clickImgeArr.count >1) {
//            [self.clickImgeArr exchangeObjectAtIndex:0 withObjectAtIndex:self.clickImgeArr.count-1];
//        }
//
//    }
//
//    _imgCountLab.text = [NSString stringWithFormat:@"已选%lu张", (unsigned long)self.clickImgeArr.count];
//
//
//             for (UIView *view in self.shareImgScrollView.subviews) {
//
//                 if ([view isKindOfClass:[UIImageView class]]) {
//                     UIImageView *imgView = (UIImageView *)view;
//
//                     if (imgView.tag - 999 == index) {
//                     //    [self.clickImgeArr insertObject:self.allImgeArr[index] atIndex:0];
//
//                         DMLog(@"%@---%ld", self.clickImgeArr, (long)index);
//
//
//
//                         for (UIView *view in imgView.subviews) {
//
//                             if ([view isKindOfClass:[UILabel class]]) {
//
//                                 UILabel *lab = (UILabel *)view;
//                                 lab.text = @"二维码推广图";
//                                 lab.backgroundColor = DMColor;
//                             }
//
//                             if ([view isKindOfClass:[UIButton class]]) {
//                                 UIButton *btn = (UIButton *)view;
//                                 [btn setImage:[UIImage imageNamed:@"share_checked11.png"] forState:0];
//                                 btn.selected = YES;
//                             }
//
//                         }
//                     }
//                     else{
//
//                         for (UIView *view in imgView.subviews) {
//                             if ([view isKindOfClass:[UILabel class]]) {
//                                 UILabel *lab = (UILabel *)view;
//                                 lab.text = @"";
//                                 lab.backgroundColor = [UIColor clearColor];
//                             }
//                         }
//
//                     }
//
//                 }
//
//
//             }
//
//
//
//
//
//}


@end
