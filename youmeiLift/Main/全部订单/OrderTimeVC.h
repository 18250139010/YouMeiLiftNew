//
//  OrderTimeVC.h
//  DaiMengJia
//
//  Created by 呆萌价 on 2018/5/15.
//  Copyright © 2018年 呆萌价. All rights reserved.
//

#import "BaseViewController.h"

@interface OrderTimeVC : BaseViewController
@property (nonatomic, copy) void (^passStartTimeAndEndTime)(NSString *startTime, NSString* endTime);
@end
