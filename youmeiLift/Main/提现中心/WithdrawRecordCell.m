//
//  WithdrawRecordCell.m
//  DaiMengJia
//
//  Created by 呆萌价 on 2017/12/12.
//  Copyright © 2017年 呆萌价. All rights reserved.
//

#import "WithdrawRecordCell.h"
#import "DMTool.h"

@implementation WithdrawRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *cellIdentifier = @"WithdrawRecordCell";
    WithdrawRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        if (cell == nil) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"WithdrawRecordCell" owner:nil options:nil] lastObject];
        }
        
    }
    
    return cell;
    
}


- (void)configureWithdrawRecordCellWithData:(WithdrawAlsData *)data indexPath:(NSIndexPath *)indexPath count:(NSInteger)count type:(NSString *)type{
    
    self.backgroundColor = [UIColor clearColor];
    
    UIView *downView0 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-24, 10)];
    downView0.backgroundColor = [UIColor whiteColor];
     [self.downView addSubview:downView0];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 9, kScreenWidth-54, 1)];
    lineView.backgroundColor = kUIColorFromRGB(0xEEEEEE);
    [self.downView addSubview:lineView];
    
    if (indexPath.row+1 == count) {
        lineView.backgroundColor = [UIColor clearColor];
        
        UIBezierPath *maskPath00 = [UIBezierPath bezierPathWithRoundedRect:downView0.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(8, 8)];
        CAShapeLayer *maskLayer00 = [[CAShapeLayer alloc] init];
        maskLayer00.frame = downView0.bounds;
        maskLayer00.path = maskPath00.CGPath;
        downView0.layer.mask = maskLayer00;
        
    }
    
    
    UIView *headerView0 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-24, 10)];
    headerView0.backgroundColor = [UIColor whiteColor];
    [self.headerView addSubview:headerView0];
    
    if (indexPath.row == 0) {
        
        UIBezierPath *maskPath00 = [UIBezierPath bezierPathWithRoundedRect:headerView0.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(8, 8)];
        CAShapeLayer *maskLayer00 = [[CAShapeLayer alloc] init];
        maskLayer00.frame = headerView0.bounds;
        maskLayer00.path = maskPath00.CGPath;
        headerView0.layer.mask = maskLayer00;
        
    }
    
    self.ttLab1.font = [UIFont systemFontOfSize:FontSize(15)];
    self.ttLab2.font = [UIFont systemFontOfSize:FontSize(13)];
    self.ttLab3.font = [UIFont systemFontOfSize:FontSize(13)];
    self.ttLab1.textColor = textMinorColor33;
    self.ttLab2.textColor = textMinorColor99;
    self.ttLab3.textColor = textMinorColor99;
    
    self.timeLabel.font = [UIFont systemFontOfSize:FontSize(13)];
    self.moneyLabel.font = [UIFont systemFontOfSize:FontSize(16)];
    self.statusLabel.font = [UIFont systemFontOfSize:FontSize(13)];
    self.timeLabel.textColor = textMinorColor99;
    self.moneyLabel.textColor = textMinorColor33;
    self.statusLabel.textColor = textMinorColor99;
    
    
    if ([type isEqualToString:@"淘宝平台提现"]) {
        
        self.timeLabel.text = [NSString stringWithFormat:@"%@", data.withdrawalstime];
        
        self.moneyLabel.text = [NSString stringWithFormat:@"¥ %@", data.withdrawalsmoney];
        
        NSString *statusStr = [NSString string];
        
//        if ([data.withdrawalsstatus isEqualToString:@"01"]) {
//            statusStr = @"待审核";
//        }else if ([data.withdrawalsstatus isEqualToString:@"02"]){
//            statusStr = @"审核通过";
//        }else if ([data.withdrawalsstatus isEqualToString:@"03"]){
//            statusStr = @"已拒绝";
//        }else if ([data.withdrawalsstatus isEqualToString:@"04"]){
//            statusStr = @"已打款";
//        }
//        else if ([data.withdrawalsstatus isEqualToString:@"05"]){
//            statusStr = @"打款失败";
//        }
        statusStr = [NSString stringWithFormat:@"%@", data.name];
        self.statusLabel.text = statusStr;
        
        
    }
    else if ([type isEqualToString:@"红包提现"]) {
        
        self.timeLabel.text = [NSString stringWithFormat:@"%@", data.withdrawalsTime];
        self.moneyLabel.text = [NSString stringWithFormat:@"¥ %@", data.amount];
             
        NSString *statusStr = [NSString stringWithFormat:@"%@", data.statusName];
        
        self.statusLabel.text = statusStr;
   
    }
    else{
        
        self.timeLabel.text = [NSString stringWithFormat:@"%@", data.createTime];
        
        self.moneyLabel.text = [NSString stringWithFormat:@"¥ %@", data.mny];
        
        
        self.statusLabel.text = [NSString stringWithFormat:@"¥ %@", data.stateName];
        
        
    }
    
    
    
    
    
}
@end
