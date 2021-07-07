//
//  DMTextTool.h
//  DaiMengJia
//
//  Created by 呆萌价 on 2017/11/28.
//  Copyright © 2017年 呆萌价. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DMTextTool : NSObject

// 改变某个范围内的字号
+ (NSMutableAttributedString *)dm_changeFont:(CGFloat )font normalFont:(CGFloat )normalFont range:(NSRange )range str:(NSString *)str;
+ (NSMutableAttributedString *)dm_changeFont:(CGFloat )font  range:(NSRange )range str:(NSString *)str;

+(NSMutableAttributedString *)dm_changeFontName:(UIFont *)font range:(NSRange)range str:(NSString *)str;

+ (NSMutableAttributedString *)dm_changeFont:(CGFloat )font range:(NSRange )range lineSpacing:(CGFloat)lineSpacing str:(NSString *)str;


// 删除某个范围内的文字（中划线）
+ (NSMutableAttributedString *)dm_deleteRange:(NSRange )range str:(NSString *)str;

//插入图片
+ (NSMutableAttributedString *)dm_addImage:(UIImage *)image bounds:(CGRect )bounds index:(NSInteger )index str:(NSString *)str style:(NSInteger )style;

//调整行 行间距
+ (NSMutableAttributedString *)dm_changeLineSpace:(CGFloat )lineSpace str:(NSString *)str;

// 改变某个范围内的字号 和颜色
+ (NSMutableAttributedString *)dm_changeFont:(CGFloat )font color:(UIColor *)color range:(NSRange )range str:(NSString *)str;

// 改变某个范围内的字号 和颜色233
+ (NSMutableAttributedString *)dm_changeFont:(CGFloat )font color:(UIColor *)color range:(NSRange )range lineSpacing:(CGFloat)lineSpacing str:(NSString *)str;

// 改变某个范围内的字号 和颜色
+ (NSMutableAttributedString *)dm_changeBoldFont:(CGFloat )font color:(UIColor *)color range:(NSRange )range str:(NSString *)str;
//限时抢购字体
+(NSMutableAttributedString *)dm_changeFlashSaleFont:(CGFloat)font color:(UIColor *)color range:(NSRange)range str:(NSString *)str;


// 改变 每日推荐界面 推荐理由
+ (NSDictionary *)dm_changeRecommendReasonStr:(NSString *)str range:(NSRange )range;

+ (NSMutableAttributedString *)dm_deleteRange:(NSRange )range str:(NSString *)str range2:(NSRange )range2;



+ (NSMutableAttributedString *)dm_addImage:(UIImage *)image bounds:(CGRect )bounds index:(NSInteger)index str:(NSString *)str color:(UIColor *)color colorRange:(NSRange)range;


@end
