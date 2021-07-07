//
//  UIImage+Category.m
//  YY
//
//  Created by yishanliang on 2017/4/25.
//  Copyright © 2017年 yishanliang. All rights reserved.
//

#import "UIImage+Category.h"

@implementation UIImage (Category)


+(UIImage *)scaleImage:(UIImage *)image toKb:(NSInteger)kb{
 

    if (!image) {
        return image;
    }
    if (kb<1) {
        return image;
    }
    
    kb*=1024;
    
 

    
    CGFloat compression = 1.0f;
    CGFloat maxCompression = 0.1f;
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    
    
  

    while ([imageData length] > kb && compression > maxCompression) {
        
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(image, compression);

    }
    
    
   
    UIImage *compressedImage = [UIImage imageWithData:imageData];
    
  
   

    return compressedImage;
    
    
}







+ (UIImage *)compressImageQuality:(UIImage *)image toByte:(NSInteger)maxLength {
    
  //  DMLog(@"开始2222");
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    
   

    if (data.length < maxLength) return image;
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 4; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
   

    UIImage *resultImage = [UIImage imageWithData:data];
 

    return resultImage;
}


+(UIImage *)IMGCompressed:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth
{
    
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        
        NSAssert(!newImage,@"图片压缩失败");
    }
    
    UIGraphicsEndImageContext();
    return newImage;
}

@end
