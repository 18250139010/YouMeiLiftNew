//
//  YMMyDetailTableViewCell.m
//  youmeiLift
//
//  Created by mac on 2021/7/5.
//

#import "YMMyDetailTableViewCell.h"

@implementation YMMyDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *cellIdentifier = @"YMMyDetailTableViewCell";
    YMMyDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        if (cell == nil) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"YMMyDetailTableViewCell" owner:nil options:nil] lastObject];
        }
        
    }
    
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
