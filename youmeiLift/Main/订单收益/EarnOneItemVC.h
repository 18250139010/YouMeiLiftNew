//
//  EarnOneItemVC.h
//  DaiMengJia
//
//  Created by 呆萌价 on 2018/5/11.
//  Copyright © 2018年 呆萌价. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "StatisticalItem.h"
//#import "StatisticalData.h"
@interface EarnOneItemVC : UIViewController
//@property (strong, nonatomic)  StatisticalItem *statisticalItem;
//@property (strong, nonatomic)  StatisticalData *statisticalData;
@property (copy, nonatomic) NSString *type;
@property (assign, nonatomic) NSInteger index;
@property (copy, nonatomic) NSString *cpsTypeStr;
@property (strong, nonatomic) UINavigationController *nav;
@end
