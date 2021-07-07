//
//  ShopItemsData.h
//  DaiMengJia
//
//  Created by 呆萌价 on 2017/12/22.
//  Copyright © 2017年 呆萌价. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShopData.h"
@interface ShopItemsData : NSObject
@property (strong, nonatomic) NSMutableArray <ShopData *> *shopdata;
@property (copy, nonatomic) NSString *msgstr;
@property (assign, nonatomic) NSInteger result;
@property (assign, nonatomic) NSInteger shopcount;
@property (copy, nonatomic) NSString *searchtime;
@property (strong, nonatomic) NSMutableArray <ShopData *> *data;
@end
