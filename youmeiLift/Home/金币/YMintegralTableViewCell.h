//
//  YMintegralTableViewCell.h
//  youmeiLift
//
//  Created by mac on 2021/6/29.
//

#import <UIKit/UIKit.h>
#import "TMIntegralData.h"
NS_ASSUME_NONNULL_BEGIN

@interface YMintegralTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *dmTitleLab;
@property (strong, nonatomic) IBOutlet UILabel *timeLab;
@property (strong, nonatomic) IBOutlet UILabel *countNumLab;
@property (weak, nonatomic) IBOutlet UIView *contenView;
@property (weak, nonatomic) IBOutlet UIView *xianView;


+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)configureDmDetailCellDmDetailDataItem:(TMIntegralData*)item style:(NSString *)style;
@end

NS_ASSUME_NONNULL_END
