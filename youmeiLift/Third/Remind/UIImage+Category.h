//
//  UIImage+Category.h
//  YY
//
//  Created by yishanliang on 2017/4/25.
//  Copyright © 2017年 yishanliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Category)

+(UIImage *)scaleImage:(UIImage *)image toKb:(NSInteger)kb;
+ (UIImage *)compressImageQuality:(UIImage *)image toByte:(NSInteger)maxLength;

/**
 *  图片的压缩方法
 *
 *  @param sourceImg   要被压缩的图片
 *  @param defineWidth 要被压缩的尺寸(宽)
 *
 *  @return 被压缩的图片
 */
+(UIImage *)IMGCompressed:(UIImage *)sourceImg targetWidth:(CGFloat)defineWidth;

@end
