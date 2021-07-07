//
//  MyFavoriteCell.m
//  YouMeiLift
//
//  Created by 有美生活 on 2021/6/22.
//  Copyright © 2021 有美生活. All rights reserved.
//

#import "RankListNewCell.h"
#import "UIImageView+WebCache.h"
#import "DMTool.h"
//#import "DMTextTool.h"
#import <Masonry.h>
#import "TABAnimated.h"
@implementation RankListNewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *cellIdentifier = @"RankListNewCell";
    RankListNewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        if (cell == nil) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"RankListNewCell" owner:nil options:nil] lastObject];
        }
        
    }
    
    return cell;
}


//- (void)setFrame:(CGRect)frame
//{
//    frame.origin.y += 10;
//    frame.size.height -= 15;
//    [super setFrame:frame];
//}
- (void)configureRankListNewCellWithShopData:(ShopData *)shopData withLabelStyle:(NSString *)labelStyle indexPath:(NSIndexPath *)indexPath{
    
    
    self.backgroundColor = [UIColor clearColor];
    self.allBackView.backgroundColor = [UIColor whiteColor];
    
        if (shopData.name.length == 0) {
            self.titleLab.text = @"";
            self.imgView.backgroundColor = kUIColorFromRGB(0xF5F7F9);
            self.hotImgView.image = [UIImage imageNamed:@""];
            self.xiaoliangLab.text = @"";
            self.xiaoliangLab.backgroundColor = [UIColor whiteColor];
            self.msqImgView.image = [UIImage imageNamed:@""];
            self.msqLab.text = @"";
            
            
            UIView *view1 = [[UIView alloc]init];
            view1.backgroundColor = kUIColorFromRGB(0xF5F7F9);
            [self.allBackView addSubview:view1];
            
            [view1 mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.allBackView.mas_top).offset(14);
                make.left.equalTo(self.imgView.mas_right).offset(10);
                make.size.mas_equalTo(CGSizeMake(15, 15));
            }];
            
            UIView *view2 = [[UIView alloc]init];
            view2.backgroundColor = kUIColorFromRGB(0xF5F7F9);
            [self.allBackView addSubview:view2];
            
            [view2 mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.allBackView.mas_top).offset(14);
                make.left.equalTo(view1.mas_right).offset(5);
                make.right.equalTo(self.allBackView.mas_right).offset(-24);
                make.height.mas_equalTo(15);
            }];
            
            UIView *view3 = [[UIView alloc]init];
            view3.backgroundColor = kUIColorFromRGB(0xF5F7F9);
            [self.allBackView addSubview:view3];
            
            [view3 mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.allBackView.mas_top).offset(35);
                make.left.equalTo(self.imgView.mas_right).offset(10);
                make.right.equalTo(self.allBackView.mas_right).offset(-44);
                make.height.mas_equalTo(15);
            }];
            
            UIView *view4 = [[UIView alloc]init];
            view4.backgroundColor = kUIColorFromRGB(0xF5F7F9);
            [self.allBackView addSubview:view4];
            
            [view4 mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.allBackView.mas_top).offset(55);
                make.left.equalTo(self.imgView.mas_right).offset(10);
                make.size.mas_equalTo(CGSizeMake(65, 15));
            }];
            
            UIView *view5 = [[UIView alloc]init];
            view5.backgroundColor = kUIColorFromRGB(0xF5F7F9);
            [self.allBackView addSubview:view5];
            
            [view5 mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.allBackView.mas_top).offset(55);
                make.left.equalTo(self.imgView.mas_right).offset(80);
                make.size.mas_equalTo(CGSizeMake(65, 15));
            }];
            
            return;
        }
    self.titleLab.font = [UIFont boldSystemFontOfSize:FontSize(14)];
    self.titleLab.textColor = textMinorColor33;
//    self.priceLab.font = [UIFont boldSystemFontOfSize:FontSize(14)];
    self.msqLab.font = [UIFont systemFontOfSize:FontSize(13)];
    self.msqLab.textColor = kUIColorFromRGB(0xB32424);
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", shopData.imageUrl]] placeholderImage:[UIImage imageNamed:@"onecell.png"] options:SDWebImageRetryFailed completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
      
        if (image) {
             // self.imgView.image = image;
            [UIView transitionWithView:_imgView duration:0.2 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                
                _imgView.image = image;
                
            } completion:nil];
            
        }else{
            self.imgView.image = [UIImage imageNamed:@"onecell.png"];
        }
        
        
    }];
    
    self.titleLab.text = [NSString stringWithFormat:@"%@", shopData.name?shopData.name:@""];
  
    
    
    
    
    UILabel *newPriceLab = [[UILabel alloc]init];
    newPriceLab.textColor = kUIColorFromRGB(0xF74141);
    newPriceLab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:FontSize(21)];
//    newPriceLab.attributedText = [DMTextTool dm_changeFont:FontSize(12) color:kUIColorFromRGB(0xF74141) range:NSMakeRange(0, 2) str:[NSString stringWithFormat:@"¥ %@", shopData.price?shopData.price:@""]];
    newPriceLab.adjustsFontSizeToFitWidth = YES;
    [self.middleVew addSubview:newPriceLab];
    [newPriceLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.middleVew.mas_top).offset(0);
        make.left.equalTo(self.middleVew.mas_left).offset(0);
        make.height.mas_equalTo(30);
    }];
    
    
    //预估佣金
    NSString *jiangStr = [NSString string];
    NSString *quanStr = [NSString stringWithFormat:@"券%@元", shopData.coupon?shopData.coupon:@""];
    NSString *quanAndJiangStr = [NSString string];
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"login"] isEqualToString:@"noLogin"]) {
      
        quanAndJiangStr = [NSString stringWithFormat:@"  %@  ",quanStr];
    }
    else{
        
        if ([[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userid"]] isEqualToString:@"96"] || [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userid"]] isEqualToString:@"1663189"]) {
             quanAndJiangStr = [NSString stringWithFormat:@"  %@  ",quanStr];
        }
        else{
            
            if ([[NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"usertype"]] isEqualToString:@"3"] ) {
                       //代理用户
                       
                      quanAndJiangStr = [NSString stringWithFormat:@"  %@  ",quanStr];
                       
                       
                   }else{
                      
                       //预估佣金
                       jiangStr = [NSString stringWithFormat:@"奖%@元",  shopData.normalCommission?shopData.normalCommission:@""];
                      
                       quanAndJiangStr = [NSString stringWithFormat:@"  %@  |  %@  ", quanStr, jiangStr];
                       
                   }
            
        }
        
       
        
    }
    
    
    
    
    
    
    UILabel *quanAndJiangLab = [[UILabel alloc]init];
    quanAndJiangLab.font = [UIFont systemFontOfSize:FontSize(11)];
    quanAndJiangLab.textColor = DMColor;
    quanAndJiangLab.backgroundColor = ColorMaker(252, 242, 247, 255);
    quanAndJiangLab.layer.masksToBounds = YES;
    quanAndJiangLab.layer.cornerRadius = 9.0f;
    quanAndJiangLab.text = quanAndJiangStr;
    
    [self.middleVew addSubview:quanAndJiangLab];
    
    [quanAndJiangLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.middleVew.mas_top).offset(5);
        make.left.equalTo(newPriceLab.mas_right).offset(5);
        make.height.mas_equalTo(18);
    }];
    
    
    
   NSString *logo = [NSString stringWithFormat:@"%@", shopData.cpsType[@"logo"]];
    //天猫色
    [self.styleImgView sd_setImageWithURL:[NSURL URLWithString:logo]];
    
    //已售
    NSString *soldNumStr = [[NSString alloc] init];
    soldNumStr = [NSString stringWithFormat:@"    爆卖 %@ 件",shopData.sales?shopData.sales:@""];
    
    self.xiaoliangLab.font = [UIFont systemFontOfSize:FontSize(13)];
    self.xiaoliangLab.textColor = [UIColor whiteColor];
    self.xiaoliangLab.text = soldNumStr;
    
    if (indexPath.row == 0) {
        self.xiaoliangLab.backgroundColor = kUIColorFromRGB(0xFC4C0F);
    }
    else if (indexPath.row == 1){
        self.xiaoliangLab.backgroundColor = kUIColorFromRGB(0xFF2E55);
    }
    else if (indexPath.row == 2){
        self.xiaoliangLab.backgroundColor = kUIColorFromRGB(0xF6557B);
    }
    else {
        self.xiaoliangLab.backgroundColor = kUIColorFromRGB(0xFA5AA9);
    }
    

   
    if (indexPath.row < 10) {
        self.rankMarkImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"top_%ld.png", (long)indexPath.row+1]];
        if (indexPath.row >2) {
            
        }else{
            self.topH.constant = 3.0f;
            self.leftH.constant = 3.0f;
        }
        
    }else{
        self.rankMarkImgView.image = [UIImage imageNamed:@""];
    }
    

}


- (void)setShopData:(ShopData *)shopData{
    
    _shopData = shopData;
    if (_shopData.headClickState == 0) {
        
        
       
        
    }else{
        
        
        
    }
    
}


- (IBAction)clickShareButtonOnMyFavoriteCell:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickShareButton:)]) {
        [self.delegate clickShareButton:sender];
    }
    
}


- (IBAction)clickOneChooseButtonOnMyFavoriteCell:(UIButton *)sender {
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickOneChooseButtonOnMyFavoriteCell:)]) {
        [self.delegate clickOneChooseButtonOnMyFavoriteCell:sender];
    }
}



@end
