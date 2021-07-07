//
//  HomeGoodsDetailVC.m
//  DaiMengJia
//
//  Created by 呆萌价 on 2020/1/6.
//  Copyright © 2020 呆萌价. All rights reserved.
//

#import "HomeGoodsDetailVC.h"
#import "DMTool.h"
#import "HomeGoodsDetailShowView.h"
#import "ShareGoodsViewController.h"
#import "NetWorkManager.h"
//#import <AlibcTradeSDK/AlibcTradeSDK.h>
//#import "TouchTool.h"
#import <MJExtension.h>
#import <WebKit/WebKit.h>
#import "AppDelegate.h"
#import "YXAlertView.h"
#import <YJProgressHUD.h>
#import "ShowImageVC.h"
#import "MD5Helper.h"
#import "Masonry.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "DMTextTool.h"
//#import "LoginViewController.h"
//#import "MemberPromoteVC.h"
//#import "SelVideoViewController.h"
//#import "SkipWebVC.h"
#import "PopView.h"
//#import "SpecialWebVC.h"


//#import "SuperSearch.h"
//#import "SuperSearchData.h"
//#import "SuperSearchDataItem.h"
//
//#import "SuperSearchList.h"
//#import "OneHomeVC.h"
@interface HomeGoodsDetailVC ()<UIScrollViewDelegate, HomeGoodsDetailShowViewDelegate,AVPlayerViewControllerDelegate>


@property (strong, nonatomic) UIScrollView *detailScrollView;
@property (strong, nonatomic) HomeGoodsDetailShowView *goodsDetailView;

@property (strong, nonatomic) UIView *headerNavView;
@property (strong, nonatomic) NSMutableArray *headerUrlArr;
@property (strong, nonatomic) ShopData *detailShopData;

@property (strong, nonatomic) UIView *downView;

@property (strong, nonatomic) UILabel *spLab;
@property (strong, nonatomic) UIView *spMarkView;

@property (strong, nonatomic) UILabel *tjLab;
@property (strong, nonatomic) UIView *tjMarkView;

@property (strong, nonatomic) UILabel *xqLab;
@property (strong, nonatomic) UIView *xqMarkView;

@property (strong, nonatomic) UIButton *collectBtn;
@property (copy, nonatomic) NSString *collectType;
@property (copy, nonatomic) NSString *goUpDate;

//@property (strong, nonatomic) AlibcTradeTaokeParams *taokeParams;
@property (strong, nonatomic) NSMutableArray *noWiteIDArr;


@property (strong, nonatomic) UIImageView *runTopView;
@property (nonatomic, strong) PopView *sqPopUpView;

@property (copy, nonatomic) NSString *oldUserType;
@property (copy, nonatomic) NSString *nowUserType;
@property (copy, nonatomic)   NSString *superSearch_iscollection;
@property (copy, nonatomic)   NSString *superSearch_collectionID;
@end

@implementation HomeGoodsDetailVC


{
    AVPlayerViewController *aVPlayerViewController;
    AVAudioSession              *_session;
    AVPlayer                    *_player;
    NSInteger upDatecount;
    CGFloat tjHeight;
    CGFloat xqHeight;
    
}
- (NSMutableArray *)noWiteIDArr{
    if (_noWiteIDArr == nil) {
        self.noWiteIDArr = [NSMutableArray array];
    }
    return _noWiteIDArr;
}

- (UIImageView *)runTopView{
    
    if (!_runTopView) {
        self.runTopView =[[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth - 50, kScreenHeight - 50 - (iPhoneX?132:88), 35, 35)];
 //       _runTopView.backgroundColor = [UIColor clearColor];
//        _runTopView.layer.masksToBounds = YES;
//        _runTopView.layer.cornerRadius = 19;
    }
    return _runTopView;
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;


   // _playerController.showsPlaybackControls = true;

    [aVPlayerViewController.player pause];
    [aVPlayerViewController removeFromParentViewController];
    aVPlayerViewController.player  = nil;
    
    [aVPlayerViewController.player replaceCurrentItemWithPlayerItem:nil];
    
    if ([self.goUpDate isEqualToString:@"go"]) {
        
        [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self viewDidLoad];
        
        
    }
    
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
//    [YJProgressHUD hide];
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"changeDetailHight" object:nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"closeVideo" object:nil userInfo:nil];
    

    
}




- (void)viewDidLoad {
    [super viewDidLoad];

    
   // [NetWorkManager setBaiChuan];
   
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.detailScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 55 +64)];
    _detailScrollView.contentSize = CGSizeMake(kScreenWidth, 1225);
   // _detailScrollView.backgroundColor = [UIColor yellowColor];
    _detailScrollView.delegate = self;
    _detailScrollView.showsVerticalScrollIndicator = NO;
    _detailScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_detailScrollView];
    
    if (@available(iOS 11.0, *)) {
        
        _detailScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _detailScrollView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
        _detailScrollView.scrollIndicatorInsets = _detailScrollView.contentInset;
        
    } else {
        
         self.detailScrollView.frame = CGRectMake(0, -20, kScreenWidth, kScreenHeight - 55 +64 +49 );
        
    }

    
    
    UIButton *backBtn0 = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn0 setImage:[UIImage imageNamed:@"YM_Back.png"] forState:0];
    backBtn0.frame = CGRectMake(7, 27+(iPhoneX?22:0), 30, 30);
   // [backBtn0 addTarget:self action:@selector(clickBackButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn0];
    
    UIButton *backBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn1.frame = CGRectMake(0, 20+(iPhoneX?22:0), 44, 44);
    [backBtn1 addTarget:self action:@selector(clickBackButton) forControlEvents:UIControlEventTouchUpInside];
    backBtn1.backgroundColor = [UIColor clearColor];
    backBtn1.userInteractionEnabled = YES;
    [self.view addSubview:backBtn1];
    
    self.headerNavView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, iPhoneX?88:64)];
    _headerNavView.backgroundColor = kUIColorFromRGB(0xF5F5F5);
    _headerNavView.alpha = 0;
    [self.view addSubview:_headerNavView];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:0];
    backBtn.frame = CGRectMake(7, 27+(iPhoneX?22:0), 30, 30);
    [backBtn addTarget:self action:@selector(clickBackButton) forControlEvents:UIControlEventTouchUpInside];
    [_headerNavView addSubview:backBtn];
    
    
    UIButton *backBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn2.frame = CGRectMake(0, 20+(iPhoneX?22:0), 44, 44);
    [backBtn2 addTarget:self action:@selector(clickBackButton) forControlEvents:UIControlEventTouchUpInside];
    backBtn2.backgroundColor = [UIColor clearColor];
    backBtn2.userInteractionEnabled = YES;
    [_headerNavView addSubview:backBtn2];
    
    
    self.spLab = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 210)/2.0, 20+(iPhoneX?22:0), 70, 42)];
    _spLab.text = @"商品";
    _spLab.textColor = kUIColorFromRGB(0xDF4042);
    _spLab.font = [UIFont systemFontOfSize:FontSize(18)];
    _spLab.textAlignment = NSTextAlignmentCenter;
    _spLab.userInteractionEnabled = YES;
    UITapGestureRecognizer *spTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickSpLab:)];
    [_spLab addGestureRecognizer:spTap];
    [_headerNavView addSubview:_spLab];
    
    
    self.spMarkView = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth - 210)/2.0 + 22.5, 20+(iPhoneX?22:0) + 42, 25, 2)];
    _spMarkView.backgroundColor = [UIColor redColor];
    [_headerNavView addSubview:_spMarkView];
    
    
    self.tjLab = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 210)/2.0+70, 20+(iPhoneX?22:0), 70, 43)];
    _tjLab.text = @"推荐";
    _tjLab.textColor = textMinorColor33;
    _tjLab.font = [UIFont systemFontOfSize:FontSize(18)];
    _tjLab.textAlignment = NSTextAlignmentCenter;
    _tjLab.userInteractionEnabled = YES;
    UITapGestureRecognizer *tjTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTjLab:)];
    [_tjLab addGestureRecognizer:tjTap];
    [_headerNavView addSubview:_tjLab];


    self.tjMarkView = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth - 210)/2.0 + 22.5 +70, 20+(iPhoneX?22:0) + 42, 25, 2)];
    _tjMarkView.backgroundColor = [UIColor whiteColor];
    [_headerNavView addSubview:_tjMarkView];
    
    
    
    self.xqLab = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 210)/2.0+70+70, 20+(iPhoneX?22:0), 70, 43)];
    _xqLab.text = @"详情";
    _xqLab.textColor = textMinorColor33;
    _xqLab.font = [UIFont systemFontOfSize:FontSize(18)];
    _xqLab.textAlignment = NSTextAlignmentCenter;
    _xqLab.userInteractionEnabled = YES;
    UITapGestureRecognizer *xqTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickXqLab:)];
    [_xqLab addGestureRecognizer:xqTap];
    [_headerNavView addSubview:_xqLab];
    
    
    self.xqMarkView = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth - 210)/2.0 + 22.5 +70+70, 20+(iPhoneX?22:0) + 42, 25, 2)];
    _xqMarkView.backgroundColor = [UIColor whiteColor];
    [_headerNavView addSubview:_xqMarkView];

    
    
    //***
    self.runTopView.image = [UIImage imageNamed:@"run_top.png"];
    UITapGestureRecognizer *teamTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickrunTopViewOnHomeVC:)];
    [_runTopView addGestureRecognizer:teamTap];
    _runTopView.userInteractionEnabled = YES;
    
    
    self.goodsDetailView = [[HomeGoodsDetailShowView alloc]init];
    _goodsDetailView.userInteractionEnabled = YES;
    self.view.userInteractionEnabled = YES;
//    [_goodsDetailView setTimeStr:self.timeStr];
//     [_goodsDetailView setType:self.type];
    _goodsDetailView.timeStr = self.timeStr;
    _goodsDetailView.type = self.type;
    _goodsDetailView.delegate = self;
    _goodsDetailView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [_goodsDetailView setUpGoodsDetailViewWithArr:nil videoLink:@"noData"];
    
    NSMutableArray *array = [NSMutableArray arrayWithObjects:
                             @"https://img1.baidu.com/it/u=2917893129,3433599284&fm=26&fmt=auto&gp=0.jpg",@"https://img1.baidu.com/it/u=2917893129,3433599284&fm=26&fmt=auto&gp=0.jpg",@"https://img1.baidu.com/it/u=2917893129,3433599284&fm=26&fmt=auto&gp=0.jpg",nil];
    
    __weak typeof(self) myself = self;

    [_goodsDetailView setClickOneLikeGoods:^(ShopData *shopData, NSString *ratio, NSString *superratio, NSString *agentratio) {
        
          HomeGoodsDetailVC *detailVC = [[HomeGoodsDetailVC alloc]init];
          detailVC.shopID = shopData.ID;
          detailVC.source = shopData.source;
          detailVC.sourceId = shopData.sourceId;
          if (detailVC) {
              [myself.navigationController pushViewController:detailVC animated:YES];
          }
        
    }];
    
    
    [_goodsDetailView setClickHeaderOneImg:^(NSInteger index) {
        
        if (self.headerUrlArr.count > 0) {
            
            ShowImageVC *showImageVC = [[ShowImageVC alloc]init];
            showImageVC.receivedImageArr = myself.headerUrlArr;
            showImageVC.receivedIndex = index;
            showImageVC.imageType = @"url";
            showImageVC.modalPresentationStyle = 0;
            dispatch_async(dispatch_get_main_queue(), ^{
                
            [myself.navigationController presentViewController:showImageVC animated:YES completion:^{
               
            }];
                
            });
        }
        
    }];
    
    
    [_detailScrollView addSubview:_goodsDetailView];

    
    
    //**** ***** ****** *****
    self.downView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 55 - (iPhoneX ? 34:0), kScreenWidth, 55+ (iPhoneX ? 34:0))];
    [self.view addSubview:_downView];
    
    [self setUpDownViewWithAllow:@"No"];
    //******66****
    
    
//    [YJProgressHUD showCustomAnimation:@"加载中" withImgArry:nil inview:kWindow];
    

        //普通的 商品详情  *********

        NSDictionary *urlDic = @{
                               //2  @"userid":[[NSUserDefaults standardUserDefaults] objectForKey:@"userid"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"] :@"",
                                 @"shopid":self.shopID?self.shopID:@"0",
                                 @"source":self.source?self.source:@"0",
                                 @"sourceId":self.sourceId?self.sourceId:@"0",
                                 };
        
        self.headerUrlArr = [NSMutableArray array];
        [NetWorkManager requestWithType:0 withUrlString:kURLWithGetGoodsDetail withParaments:urlDic withSuccessBlock:^(NSDictionary *responseObject) {
            
//            [YJProgressHUD hide];
            
            DMLog(@"商品详情页 =  %@  %@",  responseObject, responseObject[@"msgstr"]);
            
            NSString *result = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
            
            if ([result isEqualToString:@"1"]) {
                
                NSDictionary *dataDict = (NSDictionary *)responseObject[@"data"];
                
                NSString *videoLink = [NSString stringWithFormat:@"%@", dataDict[@"videoUrl"]];
                
                NSArray *shoppiclist = [NSArray arrayWithArray:dataDict[@"imageList"]];
                
                
                
                self.headerUrlArr = [NSMutableArray arrayWithArray:shoppiclist];
                
                self.detailShopData = [ShopData mj_objectWithKeyValues:dataDict];
                _goodsDetailView.shopData = self.detailShopData;
                [_goodsDetailView setUpGoodsDetailViewWithArr:self.headerUrlArr videoLink:videoLink];
                
               [self setUpDownViewWithAllow:self.detailShopData.allow];
                
            }
            else{
                
                [[YXAlertView shareInstance] showAlert:@"温馨提示" message:responseObject[@"msgstr"] cancelTitle:nil titleArray:nil viewController:self confirm:^(NSInteger buttonTag) {
//                    [self.navigationController popViewControllerAnimated:YES];
                }];
                
            }
            
            
        } withFailureBlock:^(NSError *error) {
            
//            [YJProgressHUD hide];
            
        } progress:^(float progress) {
            
        }];
        
        
   
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeDetailHight:) name:@"changeDetailHight" object:nil];
    
    //********
    
    

    
    //注册通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeRecData:) name:@"changeRecData" object:nil];
    
}

//- (void)changeRecData:(NSNotification *)notification{
//    DMLog(@"淘宝授权 改变状态");
//
//
//
//    [_sqPopUpView removeFromSuperview];
//    [_sqPopUpView remove];
//    [_sqPopUpView removeFromSuperview];
//    [_sqPopUpView remove];
//    [_sqPopUpView removeFromSuperview];
//    [_sqPopUpView remove];
//
//
//
//
//}


- (void)clickBackButton{
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)changeDetailHight : (NSNotification *)notification{
    
    NSDictionary *userInfo = notification.userInfo;
    NSString *allHeight = userInfo[@"allHeight"];
    CGFloat webHeight = [allHeight floatValue];
    _goodsDetailView.frame = CGRectMake(0, 0, kScreenWidth, webHeight+(iPhoneX?24:0));
    _detailScrollView.contentSize = CGSizeMake(kScreenWidth, webHeight+(iPhoneX?24:0));

    NSString *tjHeightStr = userInfo[@"tjHeight"];
    tjHeight = [tjHeightStr floatValue] - (iPhoneX?88:64);
    
    NSString *xqHeightStr = userInfo[@"xqHeight"];
    xqHeight = [xqHeightStr floatValue] - (iPhoneX?88:64);
    
}



// ************
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    CGFloat maxOffsetY = 103;
    CGFloat offsetY = scrollView.contentOffset.y;
    self.headerNavView.alpha = offsetY/maxOffsetY;
     DMLog(@"tjHeight== %f   yyy = %f",tjHeight, offsetY);
    
    
    if (offsetY<tjHeight) {
        self.spMarkView.backgroundColor = [UIColor redColor];
        self.xqMarkView.backgroundColor = kUIColorFromRGB(0xF5F5F5);
        self.tjMarkView.backgroundColor = kUIColorFromRGB(0xF5F5F5);
        self.spLab.textColor = kUIColorFromRGB(0xDF4042);
        self.xqLab.textColor = textMinorColor33;
        self.tjLab.textColor = textMinorColor33;
        
          [_runTopView removeFromSuperview];
    }
    else if (offsetY>=tjHeight && offsetY <xqHeight){
        self.spMarkView.backgroundColor = kUIColorFromRGB(0xF5F5F5);
        self.tjMarkView.backgroundColor = [UIColor redColor];
        self.xqMarkView.backgroundColor = kUIColorFromRGB(0xF5F5F5);
        
        self.spLab.textColor = textMinorColor33;
        self.tjLab.textColor = kUIColorFromRGB(0xDF4042);
        self.xqLab.textColor = textMinorColor33;
    }else if (offsetY >= xqHeight){
        self.spMarkView.backgroundColor = kUIColorFromRGB(0xF5F5F5);
        self.tjMarkView.backgroundColor = kUIColorFromRGB(0xF5F5F5);
        self.xqMarkView.backgroundColor = [UIColor redColor];
        
        self.spLab.textColor = textMinorColor33;
        self.tjLab.textColor = textMinorColor33;
        self.xqLab.textColor = kUIColorFromRGB(0xDF4042);
        
         [self.view addSubview:_runTopView];
    }
    
    
    
    
    
    
    
    
    
}

- (void)clickSpLab:(UIGestureRecognizer *)sender{
    
    [self.detailScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
//    self.spMarkView.backgroundColor = [UIColor redColor];
//    self.tjMarkView.backgroundColor = [UIColor whiteColor];
//    self.xqMarkView.backgroundColor = [UIColor whiteColor];
//
//    self.spLab.textColor = textMinorColor33;
//    self.tjLab.textColor = textMinorColor;
//    self.xqLab.textColor = textMinorColor;
}

- (void)clickTjLab:(UIGestureRecognizer *)sender{
    [self.detailScrollView setContentOffset:CGPointMake(0, tjHeight) animated:YES];

}

- (void)clickXqLab:(UIGestureRecognizer *)sender{
    [self.detailScrollView setContentOffset:CGPointMake(0, xqHeight) animated:YES];

}


- (void)clickrunTopViewOnHomeVC:(UIGestureRecognizer *)sender{
    
    [self.detailScrollView setContentOffset:CGPointMake(0, 0) animated:YES];

    
}


//************
- (void)setUpDownViewWithAllow:(NSString *)allow{
    
    _downView.backgroundColor = [UIColor whiteColor];
    
     NSLog(@"type00 == %@---timeStr00 ==%@", self.type, self.timeStr);
    [_downView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if ([allow isEqualToString:@"No"]) {
        
        UIView *view1 = [[UIView alloc]init];
        view1.backgroundColor = placeholderColor;
        [_downView addSubview:view1];
        [view1 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_downView.mas_top).offset(13);
            make.left.equalTo(_downView.mas_left).offset(14);
            make.size.mas_equalTo(CGSizeMake(23, 23));
        }];
        
        UIView *view2 = [[UIView alloc]init];
        view2.backgroundColor = placeholderColor;
        [_downView addSubview:view2];
        [view2 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_downView.mas_top).offset(40);
            make.left.equalTo(_downView.mas_left).offset(14);
            make.size.mas_equalTo(CGSizeMake(23, 10));
        }];
        
        UIView *view3 = [[UIView alloc]init];
        view3.backgroundColor = placeholderColor;
        [_downView addSubview:view3];
        [view3 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_downView.mas_top).offset(13);
            make.left.equalTo(_downView.mas_left).offset(58);
            make.size.mas_equalTo(CGSizeMake(23, 23));
        }];
        
        UIView *view4 = [[UIView alloc]init];
        view4.backgroundColor = placeholderColor;
        [_downView addSubview:view4];
        [view4 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_downView.mas_top).offset(40);
            make.left.equalTo(_downView.mas_left).offset(58);
            make.size.mas_equalTo(CGSizeMake(23, 10));
        }];
        
        
        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        shareBtn.frame = CGRectMake(115, 8, (kScreenWidth-130)/2.0, 39);
       
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:shareBtn.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerTopLeft cornerRadii:CGSizeMake(19.5, 19.5)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = shareBtn.bounds;
        maskLayer.path = maskPath.CGPath;
        shareBtn.layer.mask = maskLayer;
        
        CAGradientLayer *gradient0 = [CAGradientLayer layer];
        gradient0.frame = shareBtn.bounds;
        gradient0.colors = [NSArray arrayWithObjects:
                           (id)kUIColorFromRGB(0xFBCA03).CGColor,
                           (id)kUIColorFromRGB(0xFF9606).CGColor,
                           nil];
        gradient0.startPoint = CGPointMake(0.2, 0.3);
        gradient0.endPoint = CGPointMake(0.8, 0.5);
        [shareBtn.layer addSublayer:gradient0];
        
        [_downView addSubview:shareBtn];
        
        UIButton *buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        buyBtn.frame = CGRectMake((kScreenWidth-130)/2.0 + 115, 8, (kScreenWidth-130)/2.0, 39);
       
       
        UIBezierPath *maskPath22 = [UIBezierPath bezierPathWithRoundedRect:buyBtn.bounds byRoundingCorners:UIRectCornerBottomRight | UIRectCornerTopRight cornerRadii:CGSizeMake(19.5, 19.5)];
        CAShapeLayer *maskLayer22 = [[CAShapeLayer alloc] init];
        maskLayer22.frame = buyBtn.bounds;
        maskLayer22.path = maskPath22.CGPath;
        buyBtn.layer.mask = maskLayer22;
        
        
            CAGradientLayer *gradient = [CAGradientLayer layer];
            gradient.frame = buyBtn.bounds;
            gradient.colors = [NSArray arrayWithObjects:
                               (id)kUIColorFromRGB(0xFD6E70).CGColor,
                               (id)kUIColorFromRGB(0xF8483F).CGColor,
                               nil];
            gradient.startPoint = CGPointMake(0.2, 0.3);
            gradient.endPoint = CGPointMake(0.8, 0.5);
            [buyBtn.layer addSublayer:gradient];
        [_downView addSubview:buyBtn];
        
    }
    else if ([allow isEqualToString:@"0"]) {
       
        //限时抢购不允许购买
        UILabel *tipLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 55)];
        tipLab.text = @"活动即将开始……";
        tipLab.textColor = [UIColor whiteColor];
        tipLab.textAlignment = NSTextAlignmentCenter;
        tipLab.font = [UIFont systemFontOfSize:FontSize(15)];
        tipLab.backgroundColor = kUIColorFromRGB(0x808080);
        [self.downView addSubview:tipLab];
        
    }
    else{
        
        UIButton *syBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        syBtn.frame = CGRectMake(10, 9, 39, 39);
        [syBtn setTitleColor:kUIColorFromRGB(0x444444) forState:0];
        [syBtn setTitle:@"首页" forState:0];
        [syBtn setImage:[UIImage imageNamed:@"YM_Shoping.png"] forState:0];
        //先设置按钮里面的内容居 中
        syBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        //设置文字居左 －>向左移35
        [syBtn setTitleEdgeInsets:UIEdgeInsetsMake(25, -24, 0, 0)];
        //设置图片居右 －>向右移30
        syBtn.imageEdgeInsets = UIEdgeInsetsMake(-18, 7, 0, 0);
        syBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(10)];
        [syBtn addTarget:self action:@selector(clickGoToHomeVCOnGoodsDetailVC:) forControlEvents:UIControlEventTouchUpInside];
        [_downView addSubview:syBtn];
        
        self.collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _collectBtn.frame = CGRectMake(8+50, 9, 39, 39);
        NSDictionary *urlDic1  =   @{
                                     @"shopid":self.shopID?self.shopID:@"",
                                     @"id":@"",
                                     };
           
           [NetWorkManager  requestWithType:1 withUrlString:kURLWithToIsCollection withParaments:urlDic1 withSuccessBlock:^(NSDictionary *responseObject) {
               
               DMLog(@"是否 收藏商品 =  %@  %@",  responseObject, responseObject[@"msgstr"]);
               
               NSString *result = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
               
               if ([result isEqualToString:@"1"]) {
                   
                    self.superSearch_iscollection = [NSString stringWithFormat:@"%@", responseObject[@"iscollection"]];
                    self.superSearch_collectionID = [NSString stringWithFormat:@"%@", responseObject[@"collectid"]];
                   
                   if ([self.superSearch_iscollection isEqualToString:@"1"]) {
                       
                       [_collectBtn setTitleColor:DMColor forState:0];
                       [_collectBtn setTitle:@"已收藏" forState:0];
                       [_collectBtn setImage:[UIImage imageNamed:@"YM_SCollection.png"] forState:0];
                       //先设置按钮里面的内容居 中
                       _collectBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
                       //设置文字居左 －>向左移35
                       [_collectBtn setTitleEdgeInsets:UIEdgeInsetsMake(25, -24, 0, 0)];
                       //设置图片居右 －>向右移30
                       _collectBtn.imageEdgeInsets = UIEdgeInsetsMake(-18, 8, 0, 0);
                       [_downView addSubview:_collectBtn];
                       
                       _collectBtn.selected = YES;
                       self.collectType = @"1";
                       
                   }else{
                       
                       [_collectBtn setTitleColor:kUIColorFromRGB(0x444444) forState:0];
                       [_collectBtn setTitle:@"收藏" forState:0];
                       [_collectBtn setImage:[UIImage imageNamed:@"YM_Collection.png"] forState:0];
                       
                       //先设置按钮里面的内容居 中
                       _collectBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
                       //设置文字居左 －>向左移35
                       [_collectBtn setTitleEdgeInsets:UIEdgeInsetsMake(25, -24, 0, 0)];
                       //设置图片居右 －>向右移30
                       _collectBtn.imageEdgeInsets = UIEdgeInsetsMake(-18, 7, 0, 0);
                       [_downView addSubview:_collectBtn];
                       
                       _collectBtn.selected = NO;
                       self.collectType = @"0";
                   }
                   
                   
               }
               else{
                   [_collectBtn setTitleColor:kUIColorFromRGB(0x444444) forState:0];
                   [_collectBtn setTitle:@"收藏" forState:0];
                   [_collectBtn setImage:[UIImage imageNamed:@"YM_Collection.png"] forState:0];
                   
                   //先设置按钮里面的内容居 中
                   _collectBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
                   //设置文字居左 －>向左移35
                   [_collectBtn setTitleEdgeInsets:UIEdgeInsetsMake(25, -24, 0, 0)];
                   //设置图片居右 －>向右移30
                   _collectBtn.imageEdgeInsets = UIEdgeInsetsMake(-18, 7, 0, 0);
                   [_downView addSubview:_collectBtn];
                   
                   _collectBtn.selected = NO;
                   self.collectType = @"0";
               }
               
           } withFailureBlock:^(NSError *error) {
               
               [_collectBtn setTitleColor:kUIColorFromRGB(0x444444) forState:0];
               [_collectBtn setTitle:@"收藏" forState:0];
               [_collectBtn setImage:[UIImage imageNamed:@"YM_SCollection.png"] forState:0];
               
               //先设置按钮里面的内容居 中
               _collectBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
               //设置文字居左 －>向左移35
               [_collectBtn setTitleEdgeInsets:UIEdgeInsetsMake(25, -24, 0, 0)];
               //设置图片居右 －>向右移30
               _collectBtn.imageEdgeInsets = UIEdgeInsetsMake(-18, 7, 0, 0);
               [_downView addSubview:_collectBtn];
               
               _collectBtn.selected = NO;
               self.collectType = @"0";
               
           } progress:^(float progress) {
               
           }];
        
        
        _collectBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(10)];
        [_collectBtn addTarget:self action:@selector(click_collectBtnOnGoodsDetailVC:) forControlEvents:UIControlEventTouchUpInside];
        
        
               UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
               shareBtn.frame = CGRectMake(115, 8, (kScreenWidth-130)/2.0, 39);
               
               
              // shareBtn.backgroundColor = [UIColor yellowColor];
               
               UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:shareBtn.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerTopLeft cornerRadii:CGSizeMake(19.5, 19.5)];
               CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
               maskLayer.frame = shareBtn.bounds;
               maskLayer.path = maskPath.CGPath;
               shareBtn.layer.mask = maskLayer;
               
               CAGradientLayer *gradient0 = [CAGradientLayer layer];
               gradient0.frame = shareBtn.bounds;
               gradient0.colors = [NSArray arrayWithObjects:
                                  (id)kUIColorFromRGB(0xFBCA03).CGColor,
                                  (id)kUIColorFromRGB(0xFF9606).CGColor,
                                  nil];
               gradient0.startPoint = CGPointMake(0.2, 0.3);
               gradient0.endPoint = CGPointMake(0.8, 0.5);
               [shareBtn.layer addSublayer:gradient0];
               
               
               NSString *shareMonStr = [NSString string];
               if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"login"] isEqualToString:@"login"] || [[NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"usertype"]] isEqualToString:@"3"] || [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userid"]] isEqualToString:@"96"] || [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userid"]] isEqualToString:@"1663189"]) {
                   shareMonStr = [NSString stringWithFormat:@"立即分享"];
                   shareBtn.titleLabel.textColor = [UIColor whiteColor];
                   shareBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:FontSize(15)];
                   [shareBtn setTitle:shareMonStr forState:0];
               }
               else{
                   shareMonStr = [NSString stringWithFormat:@"奖¥%@\n立即分享", self.detailShopData.normalCommission?self.detailShopData.normalCommission:@"0"];
                   shareBtn.titleLabel.numberOfLines = 2;
                   shareBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
                   shareBtn.titleLabel.textColor = [UIColor whiteColor];
                   shareBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:FontSize(15)];
                   [shareBtn setAttributedTitle:[DMTextTool dm_changeFont:FontSize(10) normalFont:FontSize(15) range:NSMakeRange(shareMonStr.length-4, 4) str:shareMonStr] forState:0];
                 //  [shareBtn setTitle:shareMonStr forState:0];
                   
               }
               
               
               
               [shareBtn setTitleColor:[UIColor whiteColor] forState:0];
               [shareBtn addTarget:self action:@selector(clickShareBtnOnGoodsDetailVC:) forControlEvents:UIControlEventTouchUpInside];
               
               [_downView addSubview:shareBtn];
               

               
               UIButton *buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
               buyBtn.frame = CGRectMake((kScreenWidth-130)/2.0 + 115, 8, (kScreenWidth-130)/2.0, 39);
              
              
               UIBezierPath *maskPath22 = [UIBezierPath bezierPathWithRoundedRect:buyBtn.bounds byRoundingCorners:UIRectCornerBottomRight | UIRectCornerTopRight cornerRadii:CGSizeMake(19.5, 19.5)];
               CAShapeLayer *maskLayer22 = [[CAShapeLayer alloc] init];
               maskLayer22.frame = buyBtn.bounds;
               maskLayer22.path = maskPath22.CGPath;
               buyBtn.layer.mask = maskLayer22;
               
               
                   CAGradientLayer *gradient = [CAGradientLayer layer];
                   gradient.frame = buyBtn.bounds;
                   gradient.colors = [NSArray arrayWithObjects:
                                      (id)kUIColorFromRGB(0xFD6E70).CGColor,
                                      (id)kUIColorFromRGB(0xF8483F).CGColor,
                                      nil];
                   gradient.startPoint = CGPointMake(0.2, 0.3);
                   gradient.endPoint = CGPointMake(0.8, 0.5);
                   [buyBtn.layer addSublayer:gradient];
               
               
              
             
                   
               
                 NSString *buyLabStr = [NSString string];

               
               if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"login"] isEqualToString:@"login"] || [[NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"usertype"]] isEqualToString:@"3"] || [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userid"]] isEqualToString:@"96"] || [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userid"]] isEqualToString:@"1663189"]) {
                   buyLabStr = [NSString stringWithFormat:@"立即下单"];
                   buyBtn.titleLabel.textColor = [UIColor whiteColor];
                   buyBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:FontSize(15)];
                   [buyBtn setTitle:buyLabStr forState:0];
               }
               else{
                 
                 buyLabStr = [NSString stringWithFormat:@"省¥%@\n马上购买", self.detailShopData.buySave?self.detailShopData.buySave:@"0"];
                 buyBtn.titleLabel.numberOfLines = 2;
                 buyBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
                 buyBtn.titleLabel.textColor = [UIColor whiteColor];
                 buyBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:FontSize(15)];
                 [buyBtn setAttributedTitle:[DMTextTool dm_changeFont:FontSize(10) normalFont:FontSize(15) range:NSMakeRange(buyLabStr.length-4, 4) str:buyLabStr] forState:0];
               }
               
               
               
               [buyBtn setTitleColor:[UIColor whiteColor] forState:0];
           
               buyBtn.userInteractionEnabled = YES;
               
               
           
               
               [buyBtn addTarget:self action:@selector(clickBuyButtonOnGoodsDetailVC:) forControlEvents:UIControlEventTouchUpInside];
               
                [_downView addSubview:buyBtn];
        
        
        
    }
    
    
}

- (void)click_collectBtnOnGoodsDetailVC:(UIButton *)sender{
    
    
//    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"login"] isEqualToString:@"login"] ) {
//        //没有登录
//        LoginViewController *loginVC = [[LoginViewController alloc]init];
//        loginVC.loginStyle = @"detail";
//        if (loginVC) {
//            [self.navigationController pushViewController:loginVC animated:YES];
//        }
//
//    }
//
//    else{
//        [YJProgressHUD showCustomAnimation:@"加载中" withImgArry:nil inview:kWindow];
        sender.userInteractionEnabled = NO;
    //
    if (!sender.selected) {
        
       
        
        
        NSDictionary *urlDic1 = @{
                      @"shopid":self.detailShopData.ID,
                      };
        
        [NetWorkManager  requestWithType:0 withUrlString:kURLWithToUserCollection withParaments:urlDic1 withSuccessBlock:^(NSDictionary *responseObject) {
            
            DMLog(@"收藏商品 =  %@  %@",  responseObject, responseObject[@"msgstr"]);
            
            NSString *result = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
            
            if ([result isEqualToString:@"1"]) {
                
                     
                [sender setTitleColor:DMColor forState:0];
                       [sender setTitle:@"已收藏" forState:0];
                       sender.selected = !sender.selected;
                       self.collectType = @"1";
                       
                       [_collectBtn setImage:[UIImage imageNamed:@"jpw_detail_collectYes.png"] forState:0];
                       //先设置按钮里面的内容居 中
                       _collectBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
                       //设置文字居左 －>向左移35
                       [_collectBtn setTitleEdgeInsets:UIEdgeInsetsMake(25, -24, 0, 0)];
                       //设置图片居右 －>向右移30
                       _collectBtn.imageEdgeInsets = UIEdgeInsetsMake(-18, 8, 0, 0);
                
            }
            
            sender.userInteractionEnabled = YES;
//            [YJProgressHUD hide];
            
        } withFailureBlock:^(NSError *error) {
            sender.userInteractionEnabled = YES;
//            [YJProgressHUD hide];
        } progress:^(float progress) {
            
        }];
        
        
    }
    else{
        
       
       
        
        
        NSDictionary *urlDic1 = @{
                                    @"shopid":self.detailShopData.ID,
                                    };
                      
                      
                      [NetWorkManager  requestWithType:1 withUrlString:kURLWithToUserCancleCollection withParaments:urlDic1 withSuccessBlock:^(NSDictionary *responseObject) {
                          
                          DMLog(@"取消收藏商品 =  %@  %@",  responseObject, responseObject[@"msgstr"]);
                          
                          NSString *result = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
                          
                          if ([result isEqualToString:@"1"]) {
                              
                              
                                  [sender setTitle:@"收藏" forState:0];
                                     [sender setTitleColor:kUIColorFromRGB(0x444444) forState:0];
                                     sender.selected = !sender.selected;
                                     self.collectType = @"0";
                                     
                                     [_collectBtn setImage:[UIImage imageNamed:@"jpw_detail_collectNo.png"] forState:0];
                                     //先设置按钮里面的内容居 中
                                     _collectBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
                                     //设置文字居左 －>向左移35
                                     [_collectBtn setTitleEdgeInsets:UIEdgeInsetsMake(25, -24, 0, 0)];
                                     //设置图片居右 －>向右移30
                                     _collectBtn.imageEdgeInsets = UIEdgeInsetsMake(-18, 7, 0, 0);
                              
                          }
                          
                          sender.userInteractionEnabled = YES;
//                          [YJProgressHUD hide];
                      } withFailureBlock:^(NSError *error) {
                          sender.userInteractionEnabled = YES;
//                          [YJProgressHUD hide];
                      } progress:^(float progress) {
                          
                      }];
        
               
        
        
        
        
    }
    
//    }
    
}


- (void)clickShareBtnOnGoodsDetailVC:(UIButton *)sender{
    
//    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"login"] isEqualToString:@"login"] ) {
//       //没有登录
//        LoginViewController *loginVC = [[LoginViewController alloc]init];
//        loginVC.loginStyle = @"detail";
//        if (loginVC) {
//            [self.navigationController pushViewController:loginVC animated:YES];
//        }
//
//    }
//
//    else{
    
//        [YJProgressHUD showCustomAnimation:@"加载中" withImgArry:nil inview:kWindow];
    
    
//        [TouchTool touchToShareTbGoodsWithShopData:self.detailShopData vc:self nav:self.navigationController];
    
//    }
    
}



- (void)clickBuyButtonOnGoodsDetailVC:(UIGestureRecognizer *)sender{
    
    DMLog(@"点击购买");
//    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"login"] isEqualToString:@"login"] ) {
//        //没有登录
//        LoginViewController *loginVC = [[LoginViewController alloc]init];
//         loginVC.loginStyle = @"detail";
//        if (loginVC) {
//            [self.navigationController pushViewController:loginVC animated:YES];
//        }
//
//    }
//    else{
        
//        if (![isexamine96All isEqualToString:@"1"]) {
//            WishTreePersonimAddressVC *vc=[[WishTreePersonimAddressVC alloc]init];
//            [self.navigationController pushViewController:vc animated:YES];
//        }else{
//
//
//        [YJProgressHUD showCustomAnimation:@"加载中" withImgArry:nil inview:kWindow];
//
////       [YJProgressHUD showMsgWithImage:@"" imageName:@"goToBuy.png" inview:self.view];
//        //去购买的时候 粘贴板的 内容清空 避免打开淘宝 时弹出 淘宝的淘口令识别 弹框
//        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//        pasteboard.string = [NSString stringWithFormat:@""];
//        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
//        [defaults setValue:[NSString stringWithFormat:@"," ] forKey:@"dmjFuZhiNeiRong"];
//
//           [self goToTaoBaoBuy];
//        }
//    }
    
}


- (void)clickYhqImgView{
    
//    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"login"] isEqualToString:@"login"] ) {
//        //没有登录
//        LoginViewController *loginVC = [[LoginViewController alloc]init];
//         loginVC.loginStyle = @"detail";
//        if (loginVC) {
//            [self.navigationController pushViewController:loginVC animated:YES];
//        }
//
//    }
//
//    else{
//
        //去购买的时候 粘贴板的 内容清空 避免打开淘宝 时弹出 淘宝的淘口令识别 弹框
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
         pasteboard.string = [NSString stringWithFormat:@""];
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        [defaults setValue:[NSString stringWithFormat:@"," ] forKey:@"dmjFuZhiNeiRong"];
        
        
//    [YJProgressHUD showMsgWithImage:@"" imageName:@"goToBuy.png" inview:self.view];
        
        [self goToTaoBaoBuy];
    
    

//    }
    
}

- (void)goToTaoBaoBuy{
    
//    [TouchTool touchToBuyTbGoodsWithShopData:self.detailShopData vc:self nav:self.navigationController];
    
    
   
    
}


- (void)chlickOpenMV{
    

   
    
//    SelVideoViewController *videoVC = [[SelVideoViewController alloc]init];
//    videoVC.videoUrlStr = [NSString stringWithFormat:@"%@", self.detailShopData.videoUrl];
//  //  [self.navigationController pushViewController:videoVC animated:YES];
//
//    videoVC.modalPresentationStyle = 0;
//    [self.navigationController presentViewController:videoVC animated:NO completion:^{
//
//    }];
    
    
}




- (void)buttonClick{
    DMLog(@"dddddddddddddd");
}

- (void)playerViewControllerDidStartPictureInPicture:(AVPlayerViewController *)playerViewController{
    
    DMLog(@"11111111");
}

- (void)playerViewController:(AVPlayerViewController *)playerViewController restoreUserInterfaceForPictureInPictureStopWithCompletionHandler:(void (^)(BOOL))completionHandler{
    
    DMLog(@"2222222");
}


- (void)cancelPendingPrerolls{
    DMLog(@"3333333");
    
}

//升级店主

- (void)goToUpdate{
    
    
    if (upDatecount == 1) {
          return;
      }
      upDatecount = 1;
    
    
    
    NSDictionary *urlDic = @{
                             @"type":@"2",
                             };
    [NetWorkManager  requestWithType:1 withUrlString:kURLWithGetmerchantweb withParaments:urlDic withSuccessBlock:^(NSDictionary *responseObject) {
        
        DMLog(@"获取会员升级店主h5地址 =  %@",  responseObject);
        // *****
        if ([responseObject[@"result"] isEqualToString:@"1"]) {
            
            NSArray *dataArr = (NSArray *)responseObject[@"data"];
            DMLog(@"会员升级店主h5dataArr == %@",dataArr);
            if (dataArr.count > 0) {
                
                 self.goUpDate = @"go";
//                NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
//                [defaults setValue:@"5" forKey:@"usertype"];
                
                
                NSDictionary *dict = dataArr[0];
                NSString *url = [NSString stringWithFormat:@"%@", dict[@"url"]];
//                SkipWebVC *skipWebVC = [[SkipWebVC alloc]init];
//                skipWebVC.urlStr = url;
//                skipWebVC.popType = @"noo";
//                if (skipWebVC) {
//                    [self.navigationController pushViewController:skipWebVC animated:YES];
//                }
                
                
            }
            else{
                

                self.goUpDate = @"go";
                
                
                //代理升级店主
//                MemberPromoteVC *memberPromoteVC = [[MemberPromoteVC alloc]init];
//                memberPromoteVC.memberStyle = @"franchisee";
//                memberPromoteVC.aNewUsertype = [NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"usertype"]];
//                // memberPromoteVC.username = self.userInfo.username;
//                if (memberPromoteVC) {
//                    [self.navigationController pushViewController:memberPromoteVC animated:YES];
//                }
            }
        }
        else{
            
            
            
        }
        upDatecount = 0;
        //*******
    } withFailureBlock:^(NSError *error) {
         upDatecount = 0;
    } progress:^(float progress) {
        
    }];
    
}


- (void)clickGoToHomeVCOnGoodsDetailVC:(UIButton *)sender{

   
//    self.navigationController.tabBarController.hidesBottomBarWhenPushed=NO;
//    self.navigationController.tabBarController.selectedIndex=0;  //0
  
//    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    [appDelegate.wmTabBar changeTabBarAtIndex:0];
    
//    [self.navigationController popToRootViewControllerAnimated:NO];
    
}


- (void)clickDianPuView:(NSString *)sellerlink shopName:(NSString *)shopName{
    
    
//    SpecialWebVC *webVC = [[SpecialWebVC alloc]init];
//    webVC.urlStr = sellerlink;
//
//    webVC.titleStr = shopName;
//    if (webVC) {
//        [self.navigationController pushViewController:webVC animated:YES];
//    }
}

- (void)chlickMoreLike{
    
//    OneHomeVC *oneHomeVC = [[OneHomeVC alloc]init];
//     oneHomeVC.shopid = self.detailShopData.ID;
//    oneHomeVC.style = @"detail";
//     oneHomeVC.nav = self.navigationController;
//     if (oneHomeVC) {
//         [self.navigationController pushViewController:oneHomeVC animated:YES];
//     }
}

@end
