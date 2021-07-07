//
//  OrderEndCell.h
//  DaiMengJia
//
//  Created by 呆萌价 on 2018/3/8.
//  Copyright © 2018年 呆萌价. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderData.h"

@interface OrderEndCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UIImageView *orderImgView;

@property (strong, nonatomic) IBOutlet UILabel *orderTitleLab;
@property (strong, nonatomic) IBOutlet UILabel *orderNumLab;
@property (strong, nonatomic) IBOutlet UILabel *orderFromeLab;
@property (strong, nonatomic) IBOutlet UILabel *orderEndTimeLab;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *orderEndTimeLabHHH;

@property (strong, nonatomic) IBOutlet UILabel *orderMoneyLab;
@property (strong, nonatomic) IBOutlet UILabel *orderStatusLab;
@property (strong, nonatomic) IBOutlet UILabel *orderTimeLab;
@property (strong, nonatomic) IBOutlet UIView *downView;
@property (strong, nonatomic) IBOutlet UILabel *myEarnMonLab;


+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)configureOrderCellWithOrderData:(OrderData *)orderData;



@end
