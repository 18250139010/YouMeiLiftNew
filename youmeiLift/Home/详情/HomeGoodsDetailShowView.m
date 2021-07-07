//
//  HomeGoodsDetailShowView.m
//  DaiMengJia
//
//  Created by 呆萌价 on 2018/8/10.
//  Copyright © 2018年 呆萌价. All rights reserved.
//

#import "HomeGoodsDetailShowView.h"
#import "DMTool.h"
#import "Masonry.h"
#import "DMTextTool.h"
#import "NetWorkManager.h"
#import "ShopItemsData.h"
#import <MJExtension.h>
#import "UIImageView+WebCache.h"
#import "EwenCopyLabel.h"

#import <YJProgressHUD.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>






@implementation HomeGoodsDetailShowView

{
    AVPlayerViewController *aVPlayerViewController;
     CGFloat wkWebHeight ;

    CGFloat titleLabH;
    CGFloat contentH;
    
    NSString *timerr;
    NSString *typee;
    
    BOOL haveQuan;
    BOOL haveuUpDate;
    BOOL haveuInvite;
    BOOL haveDesc;
    BOOL haveDianPu;
    BOOL haveDianPuPinFen;
    
    CGFloat height11 ;
}


- (instancetype)init{
    
    if (self = [super init]) {
        
      //  self.backgroundColor = ColorMaker(244, 244, 244, 255);
        //  self.backgroundColor = [UIColor blueColor];
    }
    
    return self;
}

- (void)closeVideo{
    
    [aVPlayerViewController.player pause];
    [aVPlayerViewController removeFromParentViewController];
    aVPlayerViewController.player  = nil;
    [aVPlayerViewController.player replaceCurrentItemWithPlayerItem:nil];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.x == kScreenWidth){
        [aVPlayerViewController.player pause];
    }else{
        [aVPlayerViewController.player play];
    }
    
}

-(void)setType:(NSString *)type{
    
    _type = type;
}
- (void)setTimeStr:(NSString *)timeStr{
    NSLog(@"timeStrtimeStr == %@", timeStr);
    timerr = timeStr;
     _timeStr = timeStr;
}

- (void)cycleScrollView:(DDGBannerScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    DMLog(@"index 点击== %ld", (long)index);
    
   
     self.clickHeaderOneImg(index);
}
- (void)setUpGoodsDetailViewWithArr:(NSMutableArray *)imgArr videoLink:(NSString *)videoLink{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeVideo) name:@"closeVideo" object:nil];
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if ([videoLink isEqualToString:@"noData"]) {
        
        self.backgroundColor = allBackgroundColor;
        
        UIView *imgView = [[UIView alloc]init];
        imgView.backgroundColor = placeholderColor;
        [self addSubview:imgView];
        [imgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(0);
            make.left.equalTo(self.mas_left).offset(0);
            make.size.mas_equalTo(CGSizeMake(kScreenWidth, kScreenWidth));
        }];
        
        UIView *goodsView = [[UIView alloc]init];
        goodsView.backgroundColor = [UIColor whiteColor];
        [self addSubview:goodsView];
        [goodsView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(kScreenWidth);
            make.left.equalTo(self.mas_left).offset(0);
            make.size.mas_equalTo(CGSizeMake(kScreenWidth, 176));
        }];
        
        
        UIView *view1 = [[UIView alloc]init];
        view1.backgroundColor = placeholderColor;
        [goodsView addSubview:view1];
        [view1 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(goodsView.mas_top).offset(15);
            make.left.equalTo(goodsView.mas_left).offset(11);
            make.size.mas_equalTo(CGSizeMake(94, 21));
        }];
        
        UIView *view2 = [[UIView alloc]init];
        view2.backgroundColor = placeholderColor;
        [goodsView addSubview:view2];
        [view2 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(goodsView.mas_top).offset(15);
            make.left.equalTo(goodsView.mas_left).offset(110);
            make.size.mas_equalTo(CGSizeMake(72, 21));
        }];
        
        UIView *view3 = [[UIView alloc]init];
        view3.backgroundColor = placeholderColor;
        [goodsView addSubview:view3];
        [view3 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(goodsView.mas_top).offset(57);
            make.left.equalTo(goodsView.mas_left).offset(11);
            make.size.mas_equalTo(CGSizeMake(21, 21));
        }];
        
        UIView *view4 = [[UIView alloc]init];
        view4.backgroundColor = placeholderColor;
        [goodsView addSubview:view4];
        [view4 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(goodsView.mas_top).offset(57);
            make.left.equalTo(goodsView.mas_left).offset(40);
            make.size.mas_equalTo(CGSizeMake(kScreenWidth - 51, 21));
        }];
        
        UIView *view5 = [[UIView alloc]init];
        view5.backgroundColor = placeholderColor;
        [goodsView addSubview:view5];
        [view5 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(goodsView.mas_top).offset(83);
            make.left.equalTo(goodsView.mas_left).offset(11);
            make.size.mas_equalTo(CGSizeMake(210, 21));
        }];
        
        UIView *view6 = [[UIView alloc]init];
        view6.backgroundColor = placeholderColor;
        view6.layer.masksToBounds = YES;
        view6.layer.cornerRadius = 8;
        [goodsView addSubview:view6];
        [view6 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(goodsView.mas_top).offset(115);
            make.left.equalTo(goodsView.mas_left).offset(11);
            make.size.mas_equalTo(CGSizeMake(kScreenWidth - 22, 49));
        }];
        
        UIView *storeView = [[UIView alloc]init];
        storeView.backgroundColor = [UIColor whiteColor];
        [self addSubview:storeView];
        [storeView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(goodsView.mas_bottom).offset(10);
            make.left.equalTo(self.mas_left).offset(0);
            make.size.mas_equalTo(CGSizeMake(kScreenWidth, 39));
        }];
        
        
        UIView *view7 = [[UIView alloc]init];
        view7.backgroundColor = placeholderColor;
        [storeView addSubview:view7];
        [view7 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(storeView.mas_top).offset(12);
            make.left.equalTo(storeView.mas_left).offset(11);
            make.size.mas_equalTo(CGSizeMake(29, 15));
        }];
        
        UIView *view8 = [[UIView alloc]init];
        view8.backgroundColor = placeholderColor;
        [storeView addSubview:view8];
        [view8 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(storeView.mas_top).offset(12);
            make.left.equalTo(storeView.mas_left).offset(69);
            make.size.mas_equalTo(CGSizeMake(45, 15));
        }];
        
        return;
    }
    
    self.backgroundColor = [UIColor whiteColor];
    
    CGRect frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth);
    DDGBannerScrollView *goodsPageView = [DDGBannerScrollView cycleScrollViewWithFrame:frame delegate:self placeholderImage:[UIImage imageNamed:@"onecell.png"]];
     goodsPageView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
     goodsPageView.imageURLStringsGroup = imgArr;
     
     goodsPageView.backgroundColor = allBackgroundColor;
     goodsPageView.pageControlAliment = DDGBannerScrollViewPageContolAlimentCenter;
     goodsPageView.pageControlStyle = DDGBannerScrollViewPageControlHorizontal;
     goodsPageView.pageDotColor = UIColor.whiteColor;
     goodsPageView.currentPageDotColor = DMColor;
     goodsPageView.autoScrollTimeInterval = 2;
     goodsPageView.pageControlBottomOffset = -5;
     goodsPageView.pageControlRightOffset = -10;
     goodsPageView.tag = 5151;
     goodsPageView.userInteractionEnabled = YES;
     [self addSubview:goodsPageView];
    
    
    
    
    
    if (videoLink.length > 6) {
        
        UIImageView *openMVImgView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth - 80, kScreenWidth - 80, 55, 55)];
        openMVImgView.image = [UIImage imageNamed:@"video_open.png"];;
        openMVImgView.userInteractionEnabled = YES;
        [self addSubview:openMVImgView];
        
        UITapGestureRecognizer *openMVTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickOpenMVImgView:)];
        [openMVImgView addGestureRecognizer:openMVTap];
        
    }
    
    //*** 呆萌会员升级店主提示 ***
    UIImageView *updateTipView = [[UIImageView alloc]init];
    updateTipView.userInteractionEnabled = YES;
    [self addSubview:updateTipView];
    
    [updateTipView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(kScreenWidth);
        make.left.equalTo(self.mas_left).offset(12);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 24, 0));
    }];
    
    haveuUpDate = NO;

    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"login"] isEqualToString:@"login"]) {

        if ([[NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"usertype"]] isEqualToString:@"2"] ){
   
              haveuUpDate = YES;
            updateTipView.image = [UIImage imageNamed:@"detail_update.png"];


            [updateTipView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.mas_top).offset(kScreenWidth);
                make.left.equalTo(self.mas_left).offset(0);
                make.size.mas_equalTo(CGSizeMake(kScreenWidth, 34));
            }];
            
            UITapGestureRecognizer *updateTip = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickUpdateTipView:)];
            [updateTipView addGestureRecognizer:updateTip];
            updateTipView.userInteractionEnabled = YES;

            UIButton *goUpdateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [goUpdateBtn setBackgroundImage:[UIImage imageNamed:@"detail_goUpdate.png"] forState:0];
            [goUpdateBtn addTarget:self action:@selector(clickGoUpdateButton:) forControlEvents:UIControlEventTouchUpInside];
            [goUpdateBtn setTitle:@"去升级" forState:0];
            [goUpdateBtn setTitleColor:kUIColorFromRGB(0x47301E) forState:0];
            goUpdateBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:FontSize(11)];
            [updateTipView addSubview:goUpdateBtn];
            [goUpdateBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(updateTipView.mas_top).offset(4);
                make.right.equalTo(updateTipView.mas_right).offset(-10);
                make.size.mas_equalTo(CGSizeMake(58, 26));
            }];
            
            
            UILabel *updateTTLab = [[UILabel alloc]init];
            updateTTLab.textColor = kUIColorFromRGB(0xF3EBA6);
            NSString *tipStr = [NSString stringWithFormat:@"最高可获得奖励%@元",self.shopData.upCommission?self.shopData.upCommission:@""];
            updateTTLab.text = tipStr;
             updateTTLab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:FontSize(12)];
            [updateTipView addSubview:updateTTLab];

            [updateTTLab mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(updateTipView.mas_top).offset(2);
                make.left.equalTo(updateTipView.mas_left).offset(93*BiLi);
                make.height.mas_equalTo(30);
            }];

        }
        
    }

    
    UILabel *priceLabel = [[UILabel alloc]init];
    NSString *priceStr = [NSString stringWithFormat:@"¥ %@", self.shopData.price];
    priceLabel.textColor = kUIColorFromRGB(0xEE2325);
    priceLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:FontSize(29)];
    priceLabel.attributedText = [DMTextTool dm_changeFont:FontSize(18)  range:NSMakeRange(0, 2) str:priceStr];
    [priceLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
     [self addSubview:priceLabel];
    [priceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    
        make.top.equalTo(updateTipView.mas_bottom).offset(17);
        make.left.equalTo(self.mas_left).offset(12);
        make.height.mas_equalTo(24);
    
    }];
    
        //****
        UILabel *oldPriceLabel = [[UILabel alloc]init];
        NSString *couponStr  = [NSString stringWithFormat:@"¥%@",  [self reviseString:self.shopData.cost]];
        oldPriceLabel.textColor = textMinorColor;
        oldPriceLabel.font = [UIFont systemFontOfSize:FontSize(11)];
        oldPriceLabel.attributedText = [DMTextTool dm_deleteRange:NSMakeRange(0, couponStr.length) str:couponStr];
        [self addSubview:oldPriceLabel];
    
    
        [oldPriceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(updateTipView.mas_bottom).offset(18);
            make.left.equalTo(priceLabel.mas_right).offset(6.5);
            make.height.mas_equalTo(8.5);
        }];
    
        UILabel *qhjLab = [[UILabel alloc]init];
        qhjLab.textColor = kUIColorFromRGB(0xEE2325);
        qhjLab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:FontSize(11)];
        qhjLab.text = @"券后";
        [self addSubview:qhjLab];
    
        [qhjLab mas_remakeConstraints:^(MASConstraintMaker *make) {
    
            make.top.equalTo(oldPriceLabel.mas_bottom).offset(2);
            make.left.equalTo(priceLabel.mas_right).offset(6.5);
            make.height.mas_equalTo(10.5);
        }];
    
        UIImageView *incomeImgView = [[UIImageView alloc]init];
    
    
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"login"] isEqualToString:@"noLogin"] || [[NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"usertype"]] isEqualToString:@"3"]||[[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userid"]] isEqualToString:@"96"] || [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userid"]] isEqualToString:@"1663189"]) {
                incomeImgView.image = [UIImage imageNamed:@""];
        }else{
                incomeImgView.image = [UIImage imageNamed:@"jpw_detail_jl"];
    
        }
    
    
        [self addSubview:incomeImgView];
    
    
        [incomeImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(updateTipView.mas_bottom).offset(18);
            make.left.equalTo(oldPriceLabel.mas_right).offset(8.5);
            make.size.mas_equalTo(CGSizeMake(78.5, 23));
        }];
    
    
           //****
        UILabel *incomeLabel = [[UILabel alloc]init];
    
        incomeLabel.textColor = kUIColorFromRGB(0x99520f);
        incomeLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:FontSize(11)];
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"login"] isEqualToString:@"noLogin"] || [[NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"usertype"]] isEqualToString:@"3"]||[[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userid"]] isEqualToString:@"96"] || [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userid"]] isEqualToString:@"1663189"]) {
                incomeLabel.text = @"";
        }else{
            NSString *incomeStr  = [NSString stringWithFormat:@"奖 ¥%@", self.shopData.normalCommission ?self.shopData.normalCommission:@"0.00"];
                incomeLabel.text = incomeStr;
        }
       // incomeLabel.backgroundColor = [UIColor blueColor];
        incomeLabel.textAlignment = NSTextAlignmentCenter;
    
        [self addSubview:incomeLabel];
    
    
        [incomeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(updateTipView.mas_bottom).offset(18);
              make.left.equalTo(oldPriceLabel.mas_right).offset(18.5);
               make.size.mas_equalTo(CGSizeMake(68.5, 23));
           }];
               
    
//
    //*** 邀请好友赚钱提示 ***
    UIImageView *inviteView = [[UIImageView alloc]init];
    inviteView.userInteractionEnabled = YES;
    [self addSubview:inviteView];

    [inviteView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(priceLabel.mas_bottom).offset(17);
        make.left.equalTo(self.mas_left).offset(12);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 24, 0));
    }];

    haveuInvite = NO;
    if ([isexamine96All isEqualToString:@"0"]) {
        
        haveuInvite = YES;

        inviteView.image = [UIImage imageNamed:@"detail_inviteBlack.png"];
        
        [inviteView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(priceLabel.mas_bottom).offset(17);
            make.left.equalTo(self.mas_left).offset(12);
            make.size.mas_equalTo(CGSizeMake(kScreenWidth - 24, 32));
        }];
        
        UITapGestureRecognizer *inviteTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickInviteView:)];
        [inviteView addGestureRecognizer:inviteTap];
        inviteView.userInteractionEnabled = YES;
        
        UIButton *inviteToBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [inviteToBtn setImage:[UIImage imageNamed:@"detail_inviteTo.png"] forState:0];
        [inviteToBtn addTarget:self action:@selector(clickGoToInviteButton:) forControlEvents:UIControlEventTouchUpInside];
        [inviteView addSubview:inviteToBtn];
        [inviteToBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(inviteView.mas_top).offset(10.5);
            make.right.equalTo(inviteView.mas_right).offset(-11);
            make.size.mas_equalTo(CGSizeMake(7.5, 11.5));
        }];
        
        
        UIButton *inviteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [inviteBtn setTitle:@"立即邀请" forState:0];
        [inviteBtn setTitleColor:textMinorColor forState:0];
        inviteBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:FontSize(12)];
        [inviteBtn addTarget:self action:@selector(clickGoToInviteButton:) forControlEvents:UIControlEventTouchUpInside];
        [inviteView addSubview:inviteBtn];
        
        [inviteBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(inviteView.mas_top).offset(3);
            make.right.equalTo(inviteToBtn.mas_left).offset(-5);
            make.height.mas_equalTo(26);
        }];
        
        
        UIImageView *tipImgView = [[UIImageView alloc]init];
        tipImgView.image = [UIImage imageNamed:@"detail_upTip"];
        [inviteView addSubview:tipImgView];
        [tipImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(inviteView.mas_top).offset(5);
            make.left.equalTo(inviteView.mas_left).offset(12);
            make.size.mas_equalTo(CGSizeMake(24.5, 22));
        }];
        
        
        
        
        UILabel *inviteTTLab = [[UILabel alloc]init];
        inviteTTLab.textColor = textMinorColor33;
        NSString *tipStr = [NSString stringWithFormat:@"每邀请一位好友奖励¥%@元",self.shopData.upCommission?self.shopData.upCommission:@""];
        inviteTTLab.attributedText = [DMTextTool dm_changeFont:FontSize(12) color:kUIColorFromRGB(0xEE2325) range:NSMakeRange(9, tipStr.length - 9) str:tipStr];
        inviteTTLab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:FontSize(12)];
        [inviteView addSubview:inviteTTLab];
        
        [inviteTTLab mas_remakeConstraints:^(MASConstraintMaker *make) {
           make.top.equalTo(inviteView.mas_top).offset(0);
            make.left.equalTo(inviteView.mas_left).offset(44);
            make.height.mas_equalTo(32);
        }];
        
    }


        EwenCopyLabel *titleLabel = [[EwenCopyLabel alloc]init];
        NSString *nameStr = [NSString stringWithFormat:@"    %@ ", self.shopData.name];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.textColor = textMinorColor33;
        titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:FontSize(17)];
     //   titleLabel.backgroundColor = [UIColor yellowColor];
        titleLabel.numberOfLines = 2;
        titleLabel.attributedText = [DMTextTool dm_changeLineSpace:2 str:nameStr];
        titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
        [self addSubview:titleLabel];

        [titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {

            make.top.equalTo(inviteView.mas_bottom).offset(haveuInvite?15:0);
            make.left.equalTo(self.mas_left).offset(12);
            make.right.equalTo(self.mas_right).offset(-12);
           // make.height.mas_equalTo(42);

        }];
    
        titleLabH = [self calculateTitleLabHeight:nameStr fontSize:FontSize(17)];
    
        UIImageView *typeImgView = [[UIImageView alloc]init];
        NSString *logo = [NSString stringWithFormat:@"%@", self.shopData.cpsType[@"logo"]];
        //天猫色
        [typeImgView sd_setImageWithURL:[NSURL URLWithString:logo]];

        [self addSubview:typeImgView];

        [typeImgView mas_remakeConstraints:^(MASConstraintMaker *make) {

              make.top.equalTo(inviteView.mas_bottom).offset(haveuInvite?20:5);
              make.left.equalTo(self.mas_left).offset(12);
              make.size.mas_equalTo(CGSizeMake(15, 15));

      }];
    
      //优惠券
        UIImageView *yhqImgView = [[UIImageView alloc]init];
        [self addSubview:yhqImgView];
    
        haveQuan = NO;
        [yhqImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLabel.mas_bottom).offset(15);
            make.left.equalTo(self.mas_left).offset(12);
            make.right.equalTo(self.mas_right).offset(-12);
            make.height.mas_equalTo(0);
        }];
    
    
    
    if (![self.shopData.hasCoupon isEqualToString:@"0"]&& ![[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userid"]] isEqualToString:@"50"]&& [isexamine96All isEqualToString:@"1"]) {
        yhqImgView.image = [UIImage imageNamed:@"detail_yhq.png"];

             haveQuan = YES;
            [yhqImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            
                    make.top.equalTo(titleLabel.mas_bottom).offset(15);
                    make.left.equalTo(self.mas_left).offset(12);
                    make.right.equalTo(self.mas_right).offset(-12);
                    make.height.mas_equalTo(54);
            
            }];
    
        UILabel *yhqMoneyLab = [[UILabel alloc]init];
        NSString *yhqMoneyStr = [NSString string];
        NSString *moneyStr = [self reviseString:self.shopData.coupon];
        yhqMoneyStr = [NSString stringWithFormat:@"¥%@", moneyStr];
        yhqMoneyLab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:FontSize(24)];
        yhqMoneyLab.attributedText = [DMTextTool dm_changeFontName:[UIFont fontWithName:@"PingFangSC-Medium" size:FontSize(18)] range:NSMakeRange(0, 1) str:yhqMoneyStr];
        yhqMoneyLab.textColor = [UIColor whiteColor];
        [yhqImgView addSubview:yhqMoneyLab];
        [yhqMoneyLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(yhqImgView.mas_top).offset(10);
            make.left.equalTo(yhqImgView.mas_left).offset(14.5);
            make.height.mas_equalTo(18);
        }];
            
        UILabel *yhqTTLab = [[UILabel alloc]init];
        yhqTTLab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:FontSize(13)];
        yhqTTLab.text = @"优惠券";
        yhqTTLab.textColor = [UIColor whiteColor];
        [yhqImgView addSubview:yhqTTLab];
        [yhqTTLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(yhqImgView.mas_top).offset(15.5);
            make.left.equalTo(yhqMoneyLab.mas_right).offset(5.5);
            make.height.mas_equalTo(13);
        }];
            
        UILabel *yhqTimeLab = [[UILabel alloc]init];
        yhqTimeLab.font = [UIFont systemFontOfSize:FontSize(10)];
        NSDictionary *couponInfoDict = (NSDictionary *)self.shopData.couponInfoDict;
        NSString *yhqTimeStr = [NSString string];
        yhqTimeStr = [NSString stringWithFormat:@"使用期限：%@-%@", couponInfoDict[@"startTime"]?couponInfoDict[@"startTime"]:@"", couponInfoDict[@"endTime"]?couponInfoDict[@"endTime"]:@""];
        yhqTimeLab.text = yhqTimeStr;
        yhqTimeLab.textColor = [UIColor whiteColor];
        [yhqImgView addSubview:yhqTimeLab];
        [yhqTimeLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(yhqImgView.mas_top).offset(35.5);
            make.left.equalTo(yhqImgView.mas_left).offset(14.5);
            make.height.mas_equalTo(9.5);
        }];
            

        if ([self.shopData.allow isEqualToString:@"0"]) {
            yhqImgView.userInteractionEnabled = NO;
        }
        else{
            yhqImgView.userInteractionEnabled = YES;
        }
            
        UITapGestureRecognizer *yhqImgTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickYhqImgViewOnGoodsDetailShowView:)];
        [yhqImgView addGestureRecognizer:yhqImgTap];
    
       
        }
       
    
       //推荐语
    
       UIView *recLineView = [[UIView alloc]init];
       
       [self addSubview:recLineView];
      
       [recLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(yhqImgView.mas_bottom).offset(haveQuan?13:0);
            make.left.equalTo(self.mas_left).offset(0);
            make.size.mas_equalTo(CGSizeMake(kScreenWidth, 0));
        }];
    
    
        UIView *recView = [[UIView alloc]init];
        [self addSubview:recView];
       
        [recView mas_remakeConstraints:^(MASConstraintMaker *make) {
             make.top.equalTo(recLineView.mas_bottom).offset(0);
             make.left.equalTo(self.mas_left).offset(0);
             make.size.mas_equalTo(CGSizeMake(kScreenWidth, 0));
         }];
      
         haveDesc = NO;
       if (self.shopData.desc.length > 0) {
           haveDesc = YES;
           
           recLineView.backgroundColor = allBackgroundColor;
           [recLineView mas_updateConstraints:^(MASConstraintMaker *make) {
               make.size.mas_equalTo(CGSizeMake(kScreenWidth, 10));
           }];
           
           [recView mas_updateConstraints:^(MASConstraintMaker *make) {
               make.size.mas_equalTo(CGSizeMake(kScreenWidth, 60));
           }];
           
           UIImageView *markImgView = [[UIImageView alloc]init];
           markImgView.image = [UIImage imageNamed:@"detail_item_mark"];
           [recView addSubview:markImgView];
           
           [markImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
               make.top.equalTo(recView.mas_top).offset(14.5);
               make.left.equalTo(recView.mas_left).offset(11.5);
               make.size.mas_equalTo(CGSizeMake(2, 12));
           }];
           
           UILabel *markTTLab = [[UILabel alloc]init];
           markTTLab.text = @"推荐语";
           markTTLab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:FontSize(12)];
           markTTLab.textColor = textMinorColor;
           [recView addSubview:markTTLab];
           
           [markTTLab mas_remakeConstraints:^(MASConstraintMaker *make) {
               make.top.equalTo(recView.mas_top).offset(14.5);
               make.left.equalTo(recView.mas_left).offset(18);
               make.height.mas_equalTo(11.5);
           }];
           
           
            EwenCopyLabel *recommendReasonLabel = [[EwenCopyLabel alloc]init];
           
            recommendReasonLabel.attributedText = [DMTextTool dm_changeLineSpace:3.0 str:[NSString stringWithFormat:@"%@", self.shopData.desc]];
            recommendReasonLabel.textColor = textMinorColor33;
            recommendReasonLabel.font =[UIFont fontWithName:@"PingFangSC-Medium" size:FontSize(12)];
           recommendReasonLabel.textAlignment = NSTextAlignmentLeft;
           [recommendReasonLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
           // recommendReasonLabel.backgroundColor = [UIColor yellowColor];
            recommendReasonLabel.numberOfLines = 0;
           
            contentH = [self calculateRowHeight:self.shopData.desc fontSize:FontSize(12)];
           
            [self addSubview:recommendReasonLabel];
           
            [recommendReasonLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
           
                make.top.equalTo(recView.mas_top).offset(9.4);
                make.left.equalTo(recView.mas_left).offset(74);
                make.size.mas_equalTo(CGSizeMake(kScreenWidth -90, contentH));
           
            }];
           
           [recView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(kScreenWidth, contentH+18));
            }];
           
           
       }
    
    
    
    //销量
    
     UIView *salesLineView = [[UIView alloc]init];
     salesLineView.backgroundColor = allBackgroundColor;
     [self addSubview:salesLineView];
    
     [salesLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
          make.top.equalTo(recView.mas_bottom).offset(0);
          make.left.equalTo(self.mas_left).offset(0);
          make.size.mas_equalTo(CGSizeMake(kScreenWidth, 10));
      }];
    
     UIView *salesView = [[UIView alloc]init];
     [self addSubview:salesView];
          
     [salesView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(salesLineView.mas_bottom).offset(0);
        make.left.equalTo(self.mas_left).offset(0);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 44));
     }];
    
    UIImageView *salesMarkImgView = [[UIImageView alloc]init];
    salesMarkImgView.image = [UIImage imageNamed:@"detail_item_mark"];
    [salesView addSubview:salesMarkImgView];
    
    [salesMarkImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(salesView.mas_top).offset(16.5);
        make.left.equalTo(salesView.mas_left).offset(11.5);
        make.size.mas_equalTo(CGSizeMake(2, 12));
    }];
    
    UILabel *salesMarkTTLab = [[UILabel alloc]init];
    salesMarkTTLab.text = @"销量";
    salesMarkTTLab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:FontSize(12)];
    salesMarkTTLab.textColor = textMinorColor;
    [salesView addSubview:salesMarkTTLab];
    
    [salesMarkTTLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(salesView.mas_top).offset(16.5);
        make.left.equalTo(salesView.mas_left).offset(18);
        make.height.mas_equalTo(11.5);
    }];


    UILabel *salesLabel = [[UILabel alloc]init];

    NSString *soldNumStr = [[NSString alloc] init];
    soldNumStr = [NSString stringWithFormat:@"月销%@",self.shopData.sales];
    salesLabel.text = soldNumStr;
    salesLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:FontSize(12)];
    salesLabel.textColor = textMinorColor33;
    [self addSubview:salesLabel];
    [salesLabel mas_remakeConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(salesView.mas_top).offset(0);
        make.left.equalTo(self.mas_left).offset(74);
        make.height.mas_equalTo(44);

    }];

    //店铺信息
       UIView *storeLineView = [[UIView alloc]init];
       [self addSubview:storeLineView];
      
       [storeLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(salesView.mas_bottom).offset(0);
            make.left.equalTo(self.mas_left).offset(0);
            make.size.mas_equalTo(CGSizeMake(kScreenWidth, 0));
        }];
    
    
        UIView *storeView = [[UIView alloc]init];
        [self addSubview:storeView];
       
        [storeView mas_remakeConstraints:^(MASConstraintMaker *make) {
             make.top.equalTo(storeLineView.mas_bottom).offset(0);
             make.left.equalTo(self.mas_left).offset(0);
             make.size.mas_equalTo(CGSizeMake(kScreenWidth, 0));
         }];
           
         haveDianPu = NO;
         haveDianPuPinFen = NO;
      if ([self.shopData.hasShop isEqualToString:@"1"]) {
           
          haveDianPu = YES;
          
           storeLineView.backgroundColor = allBackgroundColor;
           [storeLineView mas_updateConstraints:^(MASConstraintMaker *make) {
               make.size.mas_equalTo(CGSizeMake(kScreenWidth, 10));
           }];
           
           [storeView mas_updateConstraints:^(MASConstraintMaker *make) {
               make.size.mas_equalTo(CGSizeMake(kScreenWidth, 88));
           }];
          
           NSString *logo = [NSString stringWithFormat:@"%@", self.shopData.shopInfo[@"logo"]];
            UIImageView *storeImgView = [[UIImageView alloc]init];
            [storeImgView sd_setImageWithURL:[NSURL URLWithString:logo] placeholderImage:[UIImage imageNamed:@"onecell"]];
            [storeView addSubview:storeImgView];
          
            [storeImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(storeView.mas_top).offset(15);
                make.left.equalTo(storeView.mas_left).offset(13);
                make.size.mas_equalTo(CGSizeMake(28.5, 28.5));
            }];
          
             NSDictionary *shopInfoDict = (NSDictionary *)self.shopData.shopInfo;
          
            self.dianPuUrl = [NSString stringWithFormat:@"%@", shopInfoDict[@"url"]];
            self.dianPuName = [NSString stringWithFormat:@"%@", shopInfoDict[@"name"]];
          
            UILabel *storeNameLab = [[UILabel alloc]init];
            storeNameLab.text = [NSString stringWithFormat:@"%@", shopInfoDict[@"name"]];
            storeNameLab.textColor = textMinorColor33;
            storeNameLab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:FontSize(14)];
            [storeView addSubview:storeNameLab];
          
             [storeNameLab mas_remakeConstraints:^(MASConstraintMaker *make) {
          
                  make.top.equalTo(storeView.mas_top).offset(22.5);
                  make.left.equalTo(storeImgView.mas_right).offset(11);
                  make.height.mas_equalTo(13.5);
              }];
          

          
          if (self.dianPuUrl.length > 7) {
              
            UIImageView *toRightImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"detail_store_to.png"]];
            [storeView addSubview:toRightImgView];
              
            [toRightImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(storeView.mas_top).offset(24.5);
                make.right.equalTo(storeView.mas_right).offset(-12);
                make.size.mas_equalTo(CGSizeMake(4.5, 8.5));
            }];
              
            UILabel *toDianPuLab = [[UILabel alloc]init];
            toDianPuLab.text = @"店铺逛逛";
            toDianPuLab.textColor = textMinorColor33;
            toDianPuLab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:FontSize(12)];
            toDianPuLab.textAlignment = NSTextAlignmentRight;
            [storeView addSubview:toDianPuLab];
              
            [toDianPuLab mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(storeView.mas_top).offset(23);
                make.right.equalTo(toRightImgView.mas_left).offset(-7);
                make.height.mas_equalTo(11.5);
            }];
              
            UIView *dianPuView = [[UIView alloc]init];
            [storeView addSubview:dianPuView];
            UITapGestureRecognizer *dianPuTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickDianPuView:)];
            [dianPuView addGestureRecognizer:dianPuTap];
              
            [dianPuView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(storeView.mas_top).offset(13);
                make.right.equalTo(self.mas_right).offset(-12);
                make.size.mas_equalTo(CGSizeMake(100, 32));
            }];
            
              
          }
          
            UIView *gradeView = [[UIView alloc]init];
         // gradeView.backgroundColor = allBackgroundColor;
            [storeView addSubview:gradeView];
          
            [gradeView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(storeView.mas_top).offset(64);
                make.left.equalTo(storeView.mas_left).offset(0);
                make.size.mas_equalTo(CGSizeMake(kScreenWidth, 12));
            }];
          
          
            NSMutableArray *ttArr = [NSMutableArray array];
            NSMutableArray *contrastArr = [NSMutableArray array];
            NSArray *evaluates = (NSArray *)shopInfoDict[@"evaluates"];
           
          if (evaluates.count == 0) {
              
              [storeView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_equalTo(CGSizeMake(kScreenWidth, 58));
                }];
              
          }
          else{
              
              haveDianPuPinFen = YES;
            for (NSDictionary *dict in evaluates) {
                NSString *project = [NSString stringWithFormat:@"%@ %@", dict[@"project"], dict[@"score"]];
                [ttArr addObject:project];
                NSString *contrast = [NSString stringWithFormat:@"%@", dict[@"contrastStr"]];
                [contrastArr addObject:contrast];
            }
          
            for (int i = 0; i < contrastArr.count; i++) {
          
                UIView *oneView = [[UIView alloc]initWithFrame:CGRectMake(15+ ((kScreenWidth - (69*BiLi+17)*3 - 30)/2.0 + (69*BiLi+17)  )*i, 0, 69*BiLi+5+12, 12)];
               // oneView.backgroundColor = [UIColor yellowColor];
                [gradeView addSubview:oneView];
          
                UILabel *ttLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 69*BiLi, 12)];
                NSString *ttStr = [NSString stringWithFormat:@"%@",ttArr[i]];
               // ttLab.backgroundColor = [UIColor yellowColor];
                ttLab.textColor = textMinorColor99;
                ttLab.font = [UIFont systemFontOfSize:FontSize(11)];
                if ([ttStr hasSuffix:@" "]) {
                    ttLab.text = ttStr;
                }else{
                    ttLab.attributedText = [DMTextTool dm_changeFont:FontSize(11) color:kUIColorFromRGB(0xD0323D) range:NSMakeRange(ttStr.length - 3, 3) lineSpacing:0 str:ttStr];
                }
                
                ttLab.textAlignment = NSTextAlignmentCenter;
               // ttLab.adjustsFontSizeToFitWidth = YES;
                [oneView addSubview:ttLab];
          
                UILabel *markLab = [[UILabel alloc]initWithFrame:CGRectMake(69*BiLi+5, 0, 12, 12)];
                markLab.text = contrastArr[i];
                markLab.textColor = kUIColorFromRGB(0xFD3B41);
                markLab.font = [UIFont systemFontOfSize:9];
                markLab.backgroundColor = kUIColorFromRGB(0xF3F3F3);
                markLab.layer.masksToBounds = YES;
                markLab.layer.cornerRadius = 1;
                markLab.textAlignment = NSTextAlignmentCenter;
               // markLab.adjustsFontSizeToFitWidth = YES;
                [oneView addSubview:markLab];

          
            }
          
          }
       }
    
    
    
    
    //猜你喜欢。宝宝推荐
    
       
       
        UIView *likeLineView = [[UIView alloc]init];
        likeLineView.backgroundColor = allBackgroundColor;
        [self addSubview:likeLineView];
       
        [likeLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
             make.top.equalTo(storeView.mas_bottom).offset(0);
             make.left.equalTo(self.mas_left).offset(0);
             make.size.mas_equalTo(CGSizeMake(kScreenWidth, 10));
         }];
       
        UIView *likeView = [[UIView alloc]init];
        [self addSubview:likeView];
             
        [likeView mas_remakeConstraints:^(MASConstraintMaker *make) {
           make.top.equalTo(likeLineView.mas_bottom).offset(0);
           make.left.equalTo(self.mas_left).offset(0);
           make.size.mas_equalTo(CGSizeMake(kScreenWidth, 43.5+(110*BiLi +73)*2));
        }];
       
       UIImageView *likeMarkImgView = [[UIImageView alloc]init];
       likeMarkImgView.image = [UIImage imageNamed:@"detail_item_mark"];
       [likeView addSubview:likeMarkImgView];
       
       [likeMarkImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
           make.top.equalTo(likeView.mas_top).offset(14);
           make.left.equalTo(likeView.mas_left).offset(11.5);
           make.size.mas_equalTo(CGSizeMake(2, 12));
       }];
       
       UILabel *likeMarkTTLab = [[UILabel alloc]init];
       likeMarkTTLab.text = @"宝贝推荐";
       likeMarkTTLab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:FontSize(12)];
       likeMarkTTLab.textColor = textMinorColor;
       [likeView addSubview:likeMarkTTLab];
       
       [likeMarkTTLab mas_remakeConstraints:^(MASConstraintMaker *make) {
           make.top.equalTo(likeView.mas_top).offset(14);
           make.left.equalTo(likeView.mas_left).offset(18);
           make.height.mas_equalTo(11.5);
       }];
    
    
      UIImageView *likeMoreImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"detail_store_to.png"]];
      [likeView addSubview:likeMoreImgView];
                   
      [likeMoreImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(likeView.mas_top).offset(16);
            make.right.equalTo(likeView.mas_right).offset(-12);
            make.size.mas_equalTo(CGSizeMake(4.5, 8.5));
      }];
                   
      UILabel *toDianPuLab = [[UILabel alloc]init];
      toDianPuLab.text = @"查看更多";
      toDianPuLab.textColor = textMinorColor33;
      toDianPuLab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:FontSize(12)];
      toDianPuLab.textAlignment = NSTextAlignmentRight;
      [likeView addSubview:toDianPuLab];
                   
      [toDianPuLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(likeView.mas_top).offset(14.5);
            make.right.equalTo(likeMoreImgView.mas_left).offset(-7);
            make.height.mas_equalTo(11.5);
      }];
                   
        UIView *likeMoreView = [[UIView alloc]init];
        [likeView addSubview:likeMoreView];
    
        UITapGestureRecognizer *likeMoreTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickLikeMoreView:)];
        [likeMoreView addGestureRecognizer:likeMoreTap];
                   
        [likeMoreView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(likeView.mas_top).offset(4);
            make.right.equalTo(self.mas_right).offset(-12);
            make.size.mas_equalTo(CGSizeMake(100, 32));
        }];
        
        NSDictionary *urlDic = @{
    
    
                                    @"startindex":@"1",
                                    @"searchtime":@"",
                                    @"pagesize":@"10",
                                    @"material":@"",
                                    @"shopid":self.shopData.ID,
    
                                    };
    
           [NetWorkManager requestWithType:1 withUrlString:kURLWithGetGoodsListTbMaterial withParaments:urlDic withSuccessBlock:^(NSDictionary *responseObject) {
    
               DMLog(@"详情 猜你喜欢 =  %@  %@",  responseObject, responseObject[@"msgstr"]);
    
               NSString *result = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
               [YJProgressHUD hide];
    
               if ([result isEqualToString:@"1"]) {
    
                   self.dataArr = [NSMutableArray array];
    
                   ShopItemsData *itemData = [ShopItemsData mj_objectWithKeyValues:responseObject];
    
                   for (ShopData *shopData in itemData.data) {
                        [self.dataArr addObject:shopData];
                       
                       if (self.dataArr.count == 6) {
                            break ;
                        }
                       
                    }
                   
                  
    
                   NSLog(@"self.dataArr.count == %lu", (unsigned long)self.dataArr.count);
    
                  
    
                              for (int i = 0 ; i < self.dataArr.count; i++) {
    
                                  ShopData *shopData = self.dataArr[i];
    
                                //  DMLog(@"233**== %@", oneShopData.shopmainpic);
    
                                  UIView *oneView = [[UIView alloc]initWithFrame:CGRectMake(12 + (110*BiLi+10.5) *(i%3) , 43.5+(110*BiLi +73)*(i/3), 110*BiLi, 110*BiLi +73 )];
                                //  oneView.backgroundColor = [UIColor yellowColor];
                                  [likeView addSubview:oneView];
    
    
                                  UIImageView *oneImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 110*BiLi, 110*BiLi )];
                                  oneImgView.layer.masksToBounds = YES;
                                  oneImgView.layer.cornerRadius = 4.0f;
                                  //oneImgView.image = [UIImage imageNamed:@"onecell.png"];
                                  [oneImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", shopData.imageUrl]] placeholderImage:[UIImage imageNamed:@"onecell.png"] options:SDWebImageRetryFailed completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                                      if (image) {
    
                                          // oneImgView.image = image;
                                          [UIView transitionWithView:oneImgView duration:0.2 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
    
                                              oneImgView.image = image;
    
                                          } completion:nil];
    
                                      }else{
                                          oneImgView.image = [UIImage imageNamed:@"onecell.png"];
                                      }
    
    
                                  }];
    
    
                                  UITapGestureRecognizer *imgTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImgTapOnGoodsDetailView:)];
                                  [oneImgView addGestureRecognizer:imgTap];
                                  oneImgView.tag = 222+i;
    
                                  oneImgView.userInteractionEnabled = YES;
                                  oneView.userInteractionEnabled = YES;
                                
                                  self.userInteractionEnabled = YES;
                                  [oneView addSubview:oneImgView];
                                  
    
                                  UILabel *oneTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 110*BiLi +7 , 110*BiLi, 11.5)];
                                  oneTitleLabel.text = [NSString stringWithFormat:@"%@", shopData.name];
                                  oneTitleLabel.textColor = textMinorColor33;
                                  oneTitleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:FontSize(12)];
                                  [oneView addSubview:oneTitleLabel];
    
                                  UILabel *priceLabel = [[UILabel alloc]init];
                                  priceLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:FontSize(12)];
                                  priceLabel.textColor = kUIColorFromRGB(0xEE2325);
                                  NSString *priceStrOne = [NSString stringWithFormat:@"¥%@ 券后", [self reviseString:shopData.price]];
                                  priceLabel.attributedText = [DMTextTool dm_changeFontName:[UIFont fontWithName:@"PingFangSC-Regular" size:FontSize(11)] range:NSMakeRange(priceStrOne.length - 2, 2) str:priceStrOne];
                                  [oneView addSubview:priceLabel];
    
                                  [priceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                                      make.top.equalTo(oneTitleLabel.mas_bottom).offset(5.5);
                                      make.left.equalTo(oneView.mas_left).offset(2);
                                      make.height.mas_equalTo(12.5);
                                  }];
                                  
                                  UIImageView *likeQuanImgView = [[UIImageView alloc]init];
                                  likeQuanImgView.image = [UIImage imageNamed:@"detail_like_quan"];
                                  [oneView addSubview:likeQuanImgView];
                                  
                                  [likeQuanImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
                                      make.top.equalTo(oneTitleLabel.mas_bottom).offset(23.5);
                                      make.left.equalTo(oneView.mas_left).offset(1);
                                      make.size.mas_equalTo(CGSizeMake(49.5, 16));
                                  }];
                                  
                                  UILabel *quanLab = [[UILabel alloc]init];
                                  quanLab.textColor = [UIColor whiteColor];
                                  quanLab.font = [UIFont systemFontOfSize:FontSize(10)];
                                  quanLab.text = [NSString stringWithFormat:@"%@元", shopData.coupon];
                                  quanLab.textAlignment = NSTextAlignmentCenter;
                                  
                                  [oneView addSubview:quanLab];
                                  [quanLab mas_remakeConstraints:^(MASConstraintMaker *make) {
                                      make.top.equalTo(oneTitleLabel.mas_bottom).offset(23.5);
                                      make.left.equalTo(oneView.mas_left).offset(1);
                                      make.size.mas_equalTo(CGSizeMake(49.5, 16));
                                  }];
    
      
                                     UILabel *likeIncomeLabel = [[UILabel alloc]init];
                                     likeIncomeLabel.textColor = kUIColorFromRGB(0xFC1041);
                                     likeIncomeLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:FontSize(10)];
                                     likeIncomeLabel.textAlignment = NSTextAlignmentCenter;
                                      [self addSubview:likeIncomeLabel];
                                     
                                     [likeIncomeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                                            make.top.equalTo(oneTitleLabel.mas_bottom).offset(23.5);
                                            make.left.equalTo(quanLab.mas_right).offset(4.5);
                                            make.height.mas_equalTo(16);
                                    }];
                                  
                                      if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"login"] isEqualToString:@"noLogin"] || [[NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"usertype"]] isEqualToString:@"3"]||[[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userid"]] isEqualToString:@"96"] || [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userid"]] isEqualToString:@"1663189"]) {
                                            likeIncomeLabel.text = @"";
                                        }else{
                                            NSString *incomeStr  = [NSString stringWithFormat:@"奖%@    ", shopData.normalCommission ?shopData.normalCommission:@"0.00"];
                                            likeIncomeLabel.text = incomeStr;
                                            
                                            likeIncomeLabel.layer.masksToBounds = YES;
                                            likeIncomeLabel.layer.cornerRadius = 2;
                                            likeIncomeLabel.layer.borderWidth = 0.5;
                                            likeIncomeLabel.layer.borderColor = kUIColorFromRGB(0xFC564B).CGColor;
                                            
                                        }
                                  
                                        
    
                              }
    
    
               }
               else{
    
               }
    
    
           } withFailureBlock:^(NSError *error) {
               [YJProgressHUD hide];
    
    
    
           } progress:^(float progress) {
    
           }];
    
    
    
    
   // likeView.backgroundColor = [UIColor yellowColor];

                 UIView *webLineView = [[UIView alloc]init];
                 webLineView.backgroundColor = allBackgroundColor;
                 [self addSubview:webLineView];
                
                 [webLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
                      make.top.equalTo(likeView.mas_bottom).offset(0);
                      make.left.equalTo(self.mas_left).offset(0);
                      make.size.mas_equalTo(CGSizeMake(kScreenWidth, 10));
                  }];
    
             [self layoutIfNeeded];
       
    
    
         UIImageView *webImgView = [[UIImageView alloc]init];
          webImgView.image = [UIImage imageNamed:@"detail_item_mark"];
          [self addSubview:webImgView];
          
          [webImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
              make.top.equalTo(webLineView.mas_bottom).offset(16.5);
              make.left.equalTo(self.mas_left).offset(11.5);
              make.size.mas_equalTo(CGSizeMake(2, 12));
          }];
          
          UILabel *webMarkTTLab = [[UILabel alloc]init];
          webMarkTTLab.text = @"宝贝详情";
          webMarkTTLab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:FontSize(12)];
          webMarkTTLab.textColor = textMinorColor;
          [self addSubview:webMarkTTLab];
          
          [webMarkTTLab mas_remakeConstraints:^(MASConstraintMaker *make) {
              make.top.equalTo(webLineView.mas_bottom).offset(16.5);
              make.left.equalTo(self.mas_left).offset(18);
              make.height.mas_equalTo(11.5);
          }];
    
    
    
     height11 = webLineView.frame.origin.y;

    //self.backgroundColor = [UIColor yellowColor];

         self.wkWeb = [[WKWebView alloc]initWithFrame:CGRectMake(0, height11+54, kScreenWidth, kScreenHeight)];
        _wkWeb.navigationDelegate = self;
         _wkWeb.scrollView.showsVerticalScrollIndicator = NO;
        _wkWeb.scrollView.scrollEnabled = NO;
   

      // dispatch_async(dispatch_get_global_queue(0, 0), ^{
            //  处理耗时操作的代码块...
            NSString *urlStr = [NSString stringWithFormat:@"%@%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"detailUrl"], self.shopData.ID];

            NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];

            [self.wkWeb loadRequest:urlRequest];

            [self.wkWeb.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
           [self addSubview:self.wkWeb];
     //    });


    
}

- (void)dealloc {
    
    [self.wkWeb.scrollView removeObserver:self forKeyPath:@"contentSize" context:nil];
    
}


- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    
    if (object == self.wkWeb.scrollView && [keyPath isEqual:@"contentSize"]) {
        // we are here because the contentSize of the WebView's scrollview changed.
        
        UIScrollView *scrollView = self.wkWeb.scrollView;
      //  DMLog(@"New contentSize: %f x %f", scrollView.contentSize.width, scrollView.contentSize.height);
        
        wkWebHeight = scrollView.contentSize.height;
        
        CGFloat tjHeight = kScreenWidth+59.5+(haveuUpDate?32:0)+(haveuUpDate?(15+titleLabH):titleLabH)+(haveQuan?69:0)+(haveDesc?(10+contentH+18):13)+54+(haveDianPu?(haveDianPuPinFen?108:78):0);
        
        self.wkWeb.frame = CGRectMake(0, height11+54, kScreenWidth, scrollView.contentSize.height);

        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeDetailHight" object:nil userInfo:@{@"allHeight":[NSString stringWithFormat:@"%.0f", (height11+54+wkWebHeight)], @"tjHeight":[NSString stringWithFormat:@"%.0f", tjHeight],@"xqHeight":[NSString stringWithFormat:@"%.0f", height11]}];

    }
    
}


- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    DMLog(@"图文加载完成 %@", webView.URL);

    
}




- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    
    DMLog(@"图文加载error  %@", error);
    
}



- (void)clickImgTapOnGoodsDetailView:(UIGestureRecognizer *)sender{
    
    ShopData *shopData = self.dataArr[sender.view.tag - 222];
    
    self.clickOneLikeGoods(shopData, self.ratio, self.superratio, self.agentratio );
    
}

- (CGFloat)calculateRowHeight:(NSString *)string fontSize:(NSInteger)fontSize{
    
    
    NSDictionary *dic = @{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Medium" size:FontSize(12)],NSBaselineOffsetAttributeName:[NSNumber numberWithInteger:3]};//指定字号
    CGRect rect = [string boundingRectWithSize:CGSizeMake((kScreenWidth-90), 0)/*计算高度要先指定宽度*/ options:NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return rect.size.height;
    
}
- (CGFloat)calculateTitleLabHeight:(NSString *)string fontSize:(NSInteger)fontSize{
    
    
    NSDictionary *dic = @{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Medium" size:FontSize(17)],NSBaselineOffsetAttributeName:[NSNumber numberWithInteger:2]};//指定字号
    CGRect rect = [string boundingRectWithSize:CGSizeMake((kScreenWidth-24), 0)/*计算高度要先指定宽度*/ options:NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return rect.size.height;
    
}


//淘宝详情
- (void)clickTBDetailView:(UIGestureRecognizer *)sender{
    DMLog(@"淘宝详情");
    
    
    
    
    
}


- (void)clickOpenMVImgView:(UIGestureRecognizer *)sender{
    
    DMLog(@"点击 播放按钮");
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(chlickOpenMV)]) {
        [self.delegate chlickOpenMV];
        
    }
    
    
    
    
}



- (void)clickYhqImgViewOnGoodsDetailShowView:(UIGestureRecognizer *)sender{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickYhqImgView)]) {
        [self.delegate clickYhqImgView];
        
    }
    
}


//点击升级店主
- (void)clickGoUpdateButton:(UIButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(goToUpdate)]) {
        [self.delegate goToUpdate];
        
    }
}
- (void)clickUpdateTipView:(UIGestureRecognizer *)sender{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(goToUpdate)]) {
        [self.delegate goToUpdate];
    }
}

//点击店铺
- (void)clickDianPuView:(UIGestureRecognizer *)sender{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickDianPuView:shopName:)]) {
        [self.delegate clickDianPuView:self.dianPuUrl shopName:self.dianPuName];
        
    }
    
}

//查看更多
- (void)clickLikeMoreView:(UIGestureRecognizer *)sender{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(chlickMoreLike)]) {
           [self.delegate chlickMoreLike];
           
       }
    
}



-(NSString *)reviseString:(NSString *)string{

/* 直接传入精度丢失有问题的Double类型*/

    double conver = (double)[string doubleValue];
    NSString *douStr = [NSString stringWithFormat:@"%f", conver];
    NSDecimalNumber *decNum = [NSDecimalNumber decimalNumberWithString:douStr];
    

return [decNum stringValue];

}

- (void)clickInviteView:(UIGestureRecognizer *)sender{
    
}

- (void)clickGoToInviteButton:(UIButton *)sender{
    
}

@end
