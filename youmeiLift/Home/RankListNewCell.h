//
//  MyFavoriteCell.h
//  YouMeiLift
//
//  Created by 有美生活 on 2021/6/22.
//  Copyright © 2021 有美生活. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopData.h"

@protocol MyFavoriteCellDelegate <NSObject>

- (void)clickShareButton:(UIButton *)sender;
- (void)clickOneChooseButtonOnMyFavoriteCell:(UIButton *)sender;

@end


@interface RankListNewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (weak, nonatomic) IBOutlet UILabel *quanLab;
@property (weak, nonatomic) IBOutlet UILabel *fanLab;
@property (weak, nonatomic) IBOutlet UILabel *jiageLab;
@property (weak, nonatomic) IBOutlet UILabel *yuanjiaLab;
@property (weak, nonatomic) IBOutlet UILabel *yishouLab;



@property (weak, nonatomic) IBOutlet UIImageView *styleImgView;


@property (weak, nonatomic) IBOutlet UILabel *xiaoliangLab;
@property (weak, nonatomic) IBOutlet UILabel *yuguLab;


@property (weak, nonatomic) IBOutlet UILabel *quanMonLab;
@property (weak, nonatomic) IBOutlet UIImageView *quanMonImgView;

@property (weak, nonatomic) IBOutlet UIImageView *rankMarkImgView;


@property (strong, nonatomic) IBOutlet UIView *allBackView;
@property (strong, nonatomic) IBOutlet UIView *middleVew;

@property (strong, nonatomic) IBOutlet UILabel *msqLab;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topH;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *leftH;


@property (strong, nonatomic) IBOutlet UIImageView *hotImgView;
@property (strong, nonatomic) IBOutlet UIImageView *msqImgView;



@property (strong, nonatomic) ShopData *shopData;

@property (weak, nonatomic) id<MyFavoriteCellDelegate>delegate;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)configureRankListNewCellWithShopData:(ShopData *)shopData withLabelStyle:(NSString *)labelStyle indexPath:(NSIndexPath *)indexPath;



@end
