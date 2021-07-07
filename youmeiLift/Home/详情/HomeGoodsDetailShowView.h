//
//  HomeGoodsDetailShowView.h
//  DaiMengJia
//
//  Created by 呆萌价 on 2018/8/10.
//  Copyright © 2018年 呆萌价. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DDGBannerScrollView.h"
#import "ShopData.h"
#import <WebKit/WebKit.h>
//#import "SuperSearch.h"
//#import "SuperSearchData.h"
//#import "SuperSearchDataItem.h"

//#import "SuperSearchList.h"
#import "DMTool.h"
@protocol HomeGoodsDetailShowViewDelegate <NSObject>

- (void)chlickOpenMV;
- (void)clickYhqImgView;
- (void)goToUpdate;
- (void)clickDianPuView:(NSString *)sellerlink shopName:(NSString *)shopName;
- (void)chlickMoreLike;
@end


@interface HomeGoodsDetailShowView : UIView<UIScrollViewDelegate, WKNavigationDelegate, WKUIDelegate, DDGBannerScrollViewDelegate>



@property (strong, nonatomic) UIView *introduceView;
@property (strong, nonatomic) ShopData *shopData;
@property (strong, nonatomic) NSMutableArray *dataArr;
@property (nonatomic, copy) void (^clickOneLikeGoods)(ShopData *shopData, NSString *ratio , NSString *superratio, NSString *agentratio );
@property (nonatomic, copy) void (^clickHeaderOneImg)(NSInteger index);
@property (nonatomic, copy) void (^clickVdeoLink)(NSString *videoLink);
@property (assign, nonatomic) CGFloat height;


- (instancetype)init;

- (void)setUpGoodsDetailViewWithArr:(NSMutableArray *)imgArr videoLink:(NSString *)videoLink;
@property (weak, nonatomic) id<HomeGoodsDetailShowViewDelegate>delegate;

@property (strong, nonatomic) WKWebView *wkWeb;
@property (copy, nonatomic) NSString *timeStr;
@property (copy, nonatomic) NSString *ratio;
@property (copy, nonatomic) NSString *superratio;//店主比例
@property (copy, nonatomic) NSString *agentratio;

@property (copy, nonatomic) NSString *dianPuName;
@property (copy, nonatomic) NSString *dianPuUrl;
@property (copy, nonatomic) NSString *type;

@end
