//
//  OrderData.h
//  DaiMengJia
//
//  Created by 呆萌价 on 2018/1/30.
//  Copyright © 2018年 呆萌价. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderData : NSObject
@property (copy, nonatomic) NSString *createtime;
@property (copy, nonatomic) NSString *settletime;
@property (copy, nonatomic) NSString *paymentamount;
@property (copy, nonatomic) NSString *shopmainpic;
@property (copy, nonatomic) NSString *shopname;
@property (copy, nonatomic) NSString *orderid;
@property (copy, nonatomic) NSString *orderstatus;
@property (copy, nonatomic) NSString *prediction;
@property (copy, nonatomic) NSString *settlementamount;
@property (copy, nonatomic) NSString *forecastincome;
@property (copy, nonatomic) NSString *advertisingname;
@property (copy, nonatomic) NSString *ratio;
@property (copy, nonatomic) NSString *shopid;
@property (copy, nonatomic) NSString *commission;
@property (copy, nonatomic) NSString *accounttime;
@property (copy, nonatomic) NSString *shopnum;
@property (copy, nonatomic) NSString *ID;
@property (copy, nonatomic) NSString *source;
@property (copy, nonatomic) NSString *sourceId;

//新增 已推
@property (copy, nonatomic) NSString *rankingNum;
@property (copy, nonatomic) NSString *imageUrl;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *price;
@property (copy, nonatomic) NSString *cost;
@property (copy, nonatomic) NSString *coupon;
@property (copy, nonatomic) NSString *shortName;



//拼多多等
@property (copy, nonatomic) NSString *batStatus;
@property (copy, nonatomic) NSString *batTime;
//@property (copy, nonatomic) NSString *commission;
@property (copy, nonatomic) NSString *commissionRate;
@property (copy, nonatomic) NSDictionary *cpsType;
@property (copy, nonatomic) NSString *createTime;
@property (copy, nonatomic) NSString *goodsId;
@property (copy, nonatomic) NSString *goodsName;
@property (copy, nonatomic) NSString *goodsPrice;
@property (copy, nonatomic) NSString *goodsQuantity;
@property (copy, nonatomic) NSString *orderAmount;
@property (copy, nonatomic) NSString *orderDate;
@property (copy, nonatomic) NSString *orderSn;
@property (copy, nonatomic) NSString *orderStatus;
@property (copy, nonatomic) NSString *orderStatusName;
@property (copy, nonatomic) NSString *orderTime;
@property (copy, nonatomic) NSString *orderType;
@property (copy, nonatomic) NSString *parentOrderSn;
@property (copy, nonatomic) NSString *promotionAmount;
@property (copy, nonatomic) NSString *promotionRate;
@property (copy, nonatomic) NSString *sourceLevel;
@property (copy, nonatomic) NSString *sourceName;
@property (copy, nonatomic) NSString *thumbnailUrl;
@property (copy, nonatomic) NSString *topUserId;
@property (copy, nonatomic) NSString *updateTime;
@property (copy, nonatomic) NSString *userId;
@property (copy, nonatomic) NSString *userRate;
@property (copy, nonatomic) NSString *userRateLevel;

@property (copy, nonatomic) NSString *settleTime;
@property (copy, nonatomic) NSString *receiveTime;

@property (copy, nonatomic) NSString *isbj;


@property (copy, nonatomic) NSString *agentCommission;

@property (copy, nonatomic) NSString *accountTime;


@property (copy, nonatomic) NSString *normalCommission;
@property (copy, nonatomic) NSString *save;
@property (copy, nonatomic) NSString *discount;
@end
