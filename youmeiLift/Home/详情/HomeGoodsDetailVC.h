//
//  HomeGoodsDetailVC.h
//  DaiMengJia
//
//  Created by 呆萌价 on 2020/1/6.
//  Copyright © 2020 呆萌价. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeGoodsDetailVC : BaseViewController

@property (copy, nonatomic) NSString *shopDataID;
//@property (strong, nonatomic) ShopData *shopData;
@property (copy, nonatomic) NSString *shopID;
@property (copy, nonatomic) NSString *timeStr;
@property (copy, nonatomic) NSString *type;

@property (copy, nonatomic) NSString *source;
@property (copy, nonatomic) NSString *sourceId;


@end

NS_ASSUME_NONNULL_END
