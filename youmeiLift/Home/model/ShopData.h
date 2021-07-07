//
//  ShopData.h
//  DaiMengJia
//
//  Created by 呆萌价 on 2017/12/22.
//  Copyright © 2017年 呆萌价. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopData : NSObject

@property (copy, nonatomic) NSString *couponcount;
@property (copy, nonatomic) NSString *coupondenomination;
@property (copy, nonatomic) NSString *couponend;
@property (copy, nonatomic) NSString *couponid;
@property (copy, nonatomic) NSString *couponlink;
@property (copy, nonatomic) NSString *couponresidue;
@property (copy, nonatomic) NSString *couponstart;
@property (copy, nonatomic) NSString *ID;
@property (copy, nonatomic) NSString *precommission;
@property (copy, nonatomic) NSString *shopclassone;
@property (copy, nonatomic) NSString *shopclasstwo;
@property (copy, nonatomic) NSString *shopid;
@property (copy, nonatomic) NSString *shoplink;
@property (copy, nonatomic) NSString *shopmainpic;
@property (copy, nonatomic) NSString *shopmonthlysales;
@property (copy, nonatomic) NSString *shopname;
@property (copy, nonatomic) NSString *shopprice;
@property (copy, nonatomic) NSString *taobaolink;
@property (copy, nonatomic) NSString *platformtype;
@property (copy, nonatomic) NSString *videolink;
@property (copy, nonatomic) NSString *couponpromotionlink;
@property (copy, nonatomic) NSString *iscollection;
@property (copy, nonatomic) NSString *sharelink;
@property (copy, nonatomic) NSString *shareshortlink;
@property (copy, nonatomic) NSString *collectid;
@property (copy, nonatomic) NSString *collectId;
@property (copy, nonatomic) NSString *recommended;
@property (copy, nonatomic) NSString *iseffective;
@property (copy, nonatomic) NSString *isEffective;

@property (copy, nonatomic) NSString *shortname;

//头部 选中状态
@property (nonatomic, assign) NSInteger headClickState;
@property (copy, nonatomic) NSString *shopimages;
//是否允许抢购
@property (copy, nonatomic) NSString *isallow;
@property (copy, nonatomic) NSString *allow;
@property (copy, nonatomic) NSString *twohournum;
@property (copy, nonatomic) NSString *daynum;
@property (copy, nonatomic) NSString *superprecommission;//店主预估佣金
@property (copy, nonatomic) NSString *sellername;
@property (copy, nonatomic) NSArray *shoppiclist;
//观看人数
@property (copy, nonatomic) NSString *num;
@property (copy, nonatomic) NSString *sellerlink;//店铺地址

@property (copy, nonatomic) NSArray *imageList;


//****************
@property (copy, nonatomic) NSString *abroad;
@property (copy, nonatomic) NSString *cate_id;
@property (copy, nonatomic) NSString *cate_name;
@property (copy, nonatomic) NSString *flagship;
@property (copy, nonatomic) NSString *freight;
@property (copy, nonatomic) NSString *gold;
@property (copy, nonatomic) NSString *goods_id;
@property (copy, nonatomic) NSString *goods_name;
@property (copy, nonatomic) NSString *goods_url;
@property (copy, nonatomic) NSString *guid_content;
@property (copy, nonatomic) NSString *jhs;
@property (copy, nonatomic) NSString *pic;

@property (copy, nonatomic) NSString *price_after_coupons;
@property (copy, nonatomic) NSString *price_coupons;
@property (copy, nonatomic) NSString *quan_expired_time;
@property (copy, nonatomic) NSString *rate;

@property (copy, nonatomic) NSString *tmall;
@property (copy, nonatomic) NSString *tqg;

@property (copy, nonatomic) NSString *commissionType;
@property (copy, nonatomic) NSString *couponEndTime;
@property (copy, nonatomic) NSString *couponId;
@property (copy, nonatomic) NSString *couponInfo;
@property (copy, nonatomic) NSString *couponRemainCount;
@property (copy, nonatomic) NSString *couponStartTime;
@property (copy, nonatomic) NSString *couponTotalCount;
@property (copy, nonatomic) NSString *includeDxjh;
@property (copy, nonatomic) NSString *includeMkt;
@property (copy, nonatomic) NSString *infoDxjh;
@property (copy, nonatomic) NSString *itemUrl;
@property (copy, nonatomic) NSString *numIid;
@property (copy, nonatomic) NSString *pictUrl;
@property (copy, nonatomic) NSString *provcity;
@property (copy, nonatomic) NSString *reservePrice;
@property (copy, nonatomic) NSString *sellerId;
@property (copy, nonatomic) NSString *shopTitle;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *tkTotalCommi;
@property (copy, nonatomic) NSString *tkTotalSales;
@property (copy, nonatomic) NSString *userType;
@property (copy, nonatomic) NSString *volume;
@property (copy, nonatomic) NSString *zkFinalPrice;
@property (copy, nonatomic) NSArray *smallImages;
@property (copy, nonatomic) NSString *itemId;



//2.9.0
@property (copy, nonatomic) NSString *agentCommission;
@property (copy, nonatomic) NSString *commission;//分享时候取的佣金
@property (copy, nonatomic) NSString *commissionRate;
@property (copy, nonatomic) NSString *cost;
@property (copy, nonatomic) NSString *coupon;
@property (copy, nonatomic) NSDictionary *cpsType;
@property (copy, nonatomic) NSArray *descImages;
@property (copy, nonatomic) NSString *discount;
@property (copy, nonatomic) NSString *hasBrand;
@property (copy, nonatomic) NSString *hasCoupon;

@property (copy, nonatomic) NSString *imageUrl;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *normalCommission;
@property (copy, nonatomic) NSString *price;
@property (copy, nonatomic) NSString *sales;
@property (copy, nonatomic) NSString *source;
@property (copy, nonatomic) NSString *sourceId;
@property (copy, nonatomic) NSString *thumb;
@property (copy, nonatomic) NSString *upCommission;
@property (copy, nonatomic) NSString *videoUrl;
@property (copy, nonatomic) NSDictionary *couponInfoDict;

@property (copy, nonatomic) NSString *desc;
@property (copy, nonatomic) NSString *hasShop;
@property (copy, nonatomic) NSDictionary *shopInfo;

@property (copy, nonatomic) NSString *buySave;

@property (copy, nonatomic) NSString *save;
@property (copy, nonatomic) NSString *postcouponprice;

@property (copy, nonatomic) NSString *dateTime;
@property (copy, nonatomic) NSString *footPrintId;

@property (copy, nonatomic) NSString *rankingNum;

@end
