//
//  WithdrawAlsDataItem.h
//  DaiMengJia
//
//  Created by 呆萌价 on 2018/1/30.
//  Copyright © 2018年 呆萌价. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WithdrawAlsData.h"
@interface WithdrawAlsDataItem : NSObject
@property (strong, nonatomic) NSMutableArray <WithdrawAlsData *> *withdrawalsdata;
@property (strong, nonatomic) NSMutableArray <WithdrawAlsData *> *data;
@property (strong, nonatomic) NSMutableArray <WithdrawAlsData *> *redPackageRecords;
@property (copy, nonatomic) NSString *msgstr;
@property (copy, nonatomic) NSString *result;
@end
