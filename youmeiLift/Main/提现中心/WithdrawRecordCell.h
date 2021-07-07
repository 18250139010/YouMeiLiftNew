//
//  WithdrawRecordCell.h
//  DaiMengJia
//
//  Created by 呆萌价 on 2017/12/12.
//  Copyright © 2017年 呆萌价. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WithdrawAlsData.h"
@interface WithdrawRecordCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (strong, nonatomic) IBOutlet UILabel *ttLab1;
@property (strong, nonatomic) IBOutlet UILabel *ttLab2;

@property (strong, nonatomic) IBOutlet UILabel *ttLab3;
@property (strong, nonatomic) IBOutlet UIView *oneView;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UIView *downView;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)configureWithdrawRecordCellWithData:(WithdrawAlsData *)data indexPath:(NSIndexPath *)indexPath count:(NSInteger )count type:(NSString *)type;
@end
