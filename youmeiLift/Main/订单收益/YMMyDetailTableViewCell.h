//
//  YMMyDetailTableViewCell.h
//  youmeiLift
//
//  Created by mac on 2021/7/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YMMyDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;
@property (weak, nonatomic) IBOutlet UILabel *timesLab;
@property (weak, nonatomic) IBOutlet UILabel *clearLab;


+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
