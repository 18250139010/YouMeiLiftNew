//
//  YMintegralTableViewCell.m
//  youmeiLift
//
//  Created by mac on 2021/6/29.
//

#import "YMintegralTableViewCell.h"

@implementation YMintegralTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *cellIdentifier = @"YMintegralTableViewCell";
    YMintegralTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YMintegralTableViewCell" owner:nil options:nil] lastObject];
    }
    
    
    
    return cell;
    
}
- (void)configureDmDetailCellDmDetailDataItem:(TMIntegralData *)item style:(nonnull NSString *)style {
    
    self.backgroundColor = [UIColor whiteColor];
  
    
    if ([style isEqualToString:@"我的积分"]) {
        self.dmTitleLab.textColor = textMinorColor33;
        self.dmTitleLab.font = [UIFont systemFontOfSize:FontSize(12)];
        self.dmTitleLab.text = [NSString stringWithFormat:@"%@", item.name?item.name:@""];
        
        self.timeLab.textColor = textMinorColor;
        self.timeLab.font = [UIFont systemFontOfSize:FontSize(10)];
        self.timeLab.text = [NSString stringWithFormat:@"%@", item.createtime?item.createtime:@""];
        
        self.countNumLab.textColor = textMinorColor33;
        self.countNumLab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:FontSize(15)];
        self.countNumLab.text = [NSString stringWithFormat:@"%@", item.score?item.score:@""];
    }
    else if ([style isEqualToString:@"红包金额"]){
        self.dmTitleLab.textColor = textMinorColor33;
        self.dmTitleLab.font = [UIFont systemFontOfSize:FontSize(12)];
        self.dmTitleLab.text = [NSString stringWithFormat:@"%@", item.name?item.name:@""];
        
        self.timeLab.textColor = textMinorColor;
        self.timeLab.font = [UIFont systemFontOfSize:FontSize(10)];
        self.timeLab.text = [NSString stringWithFormat:@"%@", item.createtime?item.createtime:@""];
        
        self.countNumLab.textColor = textMinorColor33;
        self.countNumLab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:FontSize(15)];
        self.countNumLab.text = [NSString stringWithFormat:@"%@", item.mny?item.mny:@""];
    }
   
    
    
    
}

@end
