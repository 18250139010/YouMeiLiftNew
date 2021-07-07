//
//  OrderEndCell.m
//  DaiMengJia
//
//  Created by 呆萌价 on 2018/3/8.
//  Copyright © 2018年 呆萌价. All rights reserved.
//

#import "OrderEndCell.h"
#import "DMTool.h"
#import "DMTextTool.h"
#import "UIImageView+WebCache.h"
@implementation OrderEndCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *cellIdentifier = @"OrderEndCell";
    OrderEndCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        if (cell == nil) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderEndCell" owner:nil options:nil] lastObject];
        }
        
    }
    
    return cell;
}


- (void)configureOrderCellWithOrderData:(OrderData *)orderData{
   
    
    self.backgroundColor = [UIColor clearColor];
    
    //时间
    self.orderTimeLab.text = [NSString stringWithFormat:@"创建时间：%@", orderData.orderTime];
    self.orderTimeLab.textColor = textMinorColor;
    
    //状态

//
    
    self.orderStatusLab.text = [NSString stringWithFormat:@"%@", orderData.orderStatusName?orderData.orderStatusName:@""];
    self.orderStatusLab.backgroundColor = DMColor;
   
    if ([orderData.orderStatusName isEqualToString:@"已退款"] || [orderData.batStatus isEqualToString:@"0"] || [orderData.orderStatusName isEqualToString:@"已失效"]) {
        self.orderStatusLab.backgroundColor = kUIColorFromRGB(0xC6C6C6);
    }
    else if ([orderData.orderStatusName isEqualToString:@"已结算"] || [orderData.batStatus isEqualToString:@"3"]){
        self.orderStatusLab.backgroundColor = kUIColorFromRGB(0xFF9D3E);
    }
    

    
    self.orderStatusLab.adjustsFontSizeToFitWidth = YES;
    
    //图片
    [self.orderImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", orderData.thumbnailUrl]] placeholderImage:[UIImage imageNamed:@"onecell.png"] options:SDWebImageRetryFailed completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        if (image) {
            //  self.orderImgView.image = image;
            [UIView transitionWithView:_orderImgView duration:0.2 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                
                _orderImgView.image = image;
                
            } completion:nil];
            
        }else{
            self.orderImgView.image = [UIImage imageNamed:@"onecell.png"];
        }
        
    }];
    
    //标题
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:13];
    self.orderTitleLab.font = font;
    self.orderTitleLab.textColor = textMinorColor33;
    self.orderTitleLab.text = [NSString stringWithFormat:@"%@", orderData.goodsName?orderData.goodsName:@""];
    // self.orderTitleLab.adjustsFontSizeToFitWidth = YES;
    
    //订单编号
    self.orderNumLab.text = [NSString stringWithFormat:@"订单编号：%@", orderData.orderSn?orderData.orderSn:@""];
    self.orderNumLab.textColor = textMinorColor;
    
  
    self.orderFromeLab.backgroundColor = kUIColorFromRGB(0xFFF1EB);
    self.orderFromeLab.textColor = kUIColorFromRGB(0xFF5000);
    self.orderFromeLab.text = [NSString stringWithFormat:@"  订单来源：%@  ", orderData.sourceName?orderData.sourceName:@""];
  
    
    
    
   
    self.orderEndTimeLabHHH.constant = 0.001;
    self.orderEndTimeLab.text = @"";
 
   
    //价格
    NSString *priceStr =  [NSString stringWithFormat:@"共%@件商品 合计：¥%.2f",orderData.goodsQuantity, [orderData.orderAmount doubleValue]?[orderData.orderAmount doubleValue]:0.00];
    self.orderMoneyLab.textColor = textMinorColor33;
    self.orderMoneyLab.attributedText = [DMTextTool dm_changeBoldFont:16 color:textMinorColor33 range:NSMakeRange(10, priceStr.length - 10) str:priceStr];
    
    
    //我的奖励
    self.myEarnMonLab.textColor = kUIColorFromRGB(0xFF5000);
    self.myEarnMonLab.font = [UIFont boldSystemFontOfSize:12];
    self.myEarnMonLab.text = [NSString stringWithFormat:@"我的奖励%.2f", [orderData.commission doubleValue]?[orderData.commission doubleValue]:0.00];
    
    
    UIImageView *downImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth -24, 15)];
    downImgView.image = [UIImage imageNamed:@"order_down.png"];
    [self.downView addSubview:downImgView];
    
    
}


@end
