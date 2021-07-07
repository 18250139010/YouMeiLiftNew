//
//  DMTextTool.m
//  DaiMengJia
//
//  Created by 呆萌价 on 2017/11/28.
//  Copyright © 2017年 呆萌价. All rights reserved.
//

#import "DMTextTool.h"
#import "DMTool.h"
@implementation DMTextTool

+ (NSMutableAttributedString *)dm_changeFont:(CGFloat )font normalFont:(CGFloat )normalFont range:(NSRange )range str:(NSString *)str{
  
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:str];
    [attrStr addAttribute:NSFontAttributeName
                    value:[UIFont systemFontOfSize:font]
                    range:range];
   
    if (font > normalFont) {
        [attrStr addAttribute:NSBaselineOffsetAttributeName value:@(0.36 * (font - normalFont)) range:range];
    }
    else{
        [attrStr addAttribute:NSBaselineOffsetAttributeName value:@(0.36 * (normalFont - font)) range:range];
    }

    
    return attrStr;
}

+ (NSMutableAttributedString *)dm_changeFont:(CGFloat )font range:(NSRange )range str:(NSString *)str{
  
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:str];
    [attrStr addAttribute:NSFontAttributeName
                    value:[UIFont systemFontOfSize:font]
                    range:range];
   
    

    
    return attrStr;
}


+(NSMutableAttributedString *)dm_changeFontName:(UIFont *)font range:(NSRange)range str:(NSString *)str{
  
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:str];
    [attrStr addAttribute:NSFontAttributeName
                    value:font
                    range:range];
    

    
    return attrStr;
}



+ (NSMutableAttributedString *)dm_changeFont:(CGFloat )font range:(NSRange )range lineSpacing:(CGFloat)lineSpacing str:(NSString *)str{
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:str];
    [attrStr addAttribute:NSFontAttributeName
                    value:[UIFont systemFontOfSize:font]
                    range:range];
    
    //设置行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:lineSpacing];
    [attrStr addAttribute:NSParagraphStyleAttributeName
                    value:paragraphStyle
                    range:NSMakeRange(0, attrStr.length)];
    
    
    return attrStr;
    
    
}


+(NSMutableAttributedString *)dm_changeFont:(CGFloat)font color:(UIColor *)color range:(NSRange)range str:(NSString *)str{
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:str];
    [attrStr addAttribute:NSFontAttributeName
                    value:[UIFont systemFontOfSize:font]
                    range:range];
    
    //设置 颜 色
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:color
                    range:range];
    
    
    //设置 行 间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:3];
    [attrStr addAttribute:NSParagraphStyleAttributeName
                    value:paragraphStyle
                    range:NSMakeRange(0, attrStr.length)];
    
    
    return attrStr;
    
    
}

+ (NSMutableAttributedString *)dm_changeFont:(CGFloat )font color:(UIColor *)color range:(NSRange )range lineSpacing:(CGFloat)lineSpacing str:(NSString *)str{
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:str];
    [attrStr addAttribute:NSFontAttributeName
                    value:[UIFont systemFontOfSize:font]
                    range:range];
    
    //设置 颜 色
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:color
                    range:range];
    
    
    //设置 行 间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:lineSpacing];
    [attrStr addAttribute:NSParagraphStyleAttributeName
                    value:paragraphStyle
                    range:NSMakeRange(0, attrStr.length)];
    
    
    return attrStr;
    
}


+(NSMutableAttributedString *)dm_changeFlashSaleFont:(CGFloat)font color:(UIColor *)color range:(NSRange)range str:(NSString *)str{
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:str];
    [attrStr addAttribute:NSFontAttributeName
                    value:[UIFont boldSystemFontOfSize:font]
                    range:range];
    
    //设置颜色
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:color
                    range:range];
    //设置行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:3];
    [attrStr addAttribute:NSParagraphStyleAttributeName
                    value:paragraphStyle
                    range:NSMakeRange(0, attrStr.length)];
    
    return attrStr;
    
}


+ (NSMutableAttributedString *)dm_changeBoldFont:(CGFloat)font color:(UIColor *)color range:(NSRange)range str:(NSString *)str{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:str];
    [attrStr addAttribute:NSFontAttributeName
                    value:[UIFont boldSystemFontOfSize:font]
                    range:range];
    
    //设置颜色
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:color
                    range:range];
    //设置行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:5];
    [attrStr addAttribute:NSParagraphStyleAttributeName
                    value:paragraphStyle
                    range:NSMakeRange(0, attrStr.length)];
    
    return attrStr;
}



+ (NSMutableAttributedString *)dm_addImage:(UIImage *)image bounds:(CGRect )bounds index:(NSInteger)index str:(NSString *)str color:(UIColor *)color colorRange:(NSRange)range{
    
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    // 创建一个文字附件对象
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.image = image;  //设置图片源
    textAttachment.bounds = bounds;  //设置图片位置和大小
    // 将文字附件转换成属性字符串
    NSAttributedString *attachmentAttrStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
    // 将转换成属性字符串插入到目标字符串
    [attrStr insertAttributedString:attachmentAttrStr atIndex:index];
    
    
    //设置颜色
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:color
                    range:range];
    
   
    return attrStr;
}






+ (NSMutableAttributedString *)dm_deleteRange:(NSRange)range str:(NSString *)str{
   
    
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:str];
    [attrStr addAttribute:NSStrikethroughStyleAttributeName
                    value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle)
                    range:range];
 
    
    return attrStr;
}


+(NSMutableAttributedString *)dm_deleteRange:(NSRange)range str:(NSString *)str range2:(NSRange)range2{
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:str];
   
    
    [attrStr addAttribute:NSFontAttributeName
                    value:[UIFont systemFontOfSize:FontSize(12)]
                    range:range2];
    
    [attrStr addAttribute:NSStrikethroughStyleAttributeName
                    value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle)
                    range:range];
    
    return attrStr;
    
}


+ (NSMutableAttributedString *)dm_addImage:(UIImage *)image bounds:(CGRect )bounds index:(NSInteger)index str:(NSString *)str style:(NSInteger)style{
    
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    // 创建一个文字附件对象
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.image = image;  //设置图片源
    textAttachment.bounds = bounds;  //设置图片位置和大小
    // 将文字附件转换成属性字符串
    NSAttributedString *attachmentAttrStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
    // 将转换成属性字符串插入到目标字符串
    [attrStr insertAttributedString:attachmentAttrStr atIndex:index];
    
    if (style == 2) {
        //设置行间距
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        [paragraphStyle setLineSpacing:4];
        [attrStr addAttribute:NSParagraphStyleAttributeName
                        value:paragraphStyle
                        range:NSMakeRange(0, attrStr.length)];
    }
    if (style == 3) {
           //设置行间距
           NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
           [paragraphStyle setLineSpacing:2];
           [attrStr addAttribute:NSParagraphStyleAttributeName
                           value:paragraphStyle
                           range:NSMakeRange(0, attrStr.length)];
       }
    
    return attrStr;
}



+(NSMutableAttributedString *)dm_changeLineSpace:(CGFloat)lineSpace str:(NSString *)str{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:str];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attrStr addAttribute:NSParagraphStyleAttributeName
                    value:paragraphStyle
                    range:NSMakeRange(0, attrStr.length)];
    
    return attrStr;
}


+ (NSDictionary *)dm_changeRecommendReasonStr:(NSString *)str range:(NSRange )range{
   
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:str];
    
    //设置颜色
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:DMColor
                    range:range];
    //设置行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:3];
    paragraphStyle.tailIndent = -22;
    paragraphStyle.headIndent = 10;
    paragraphStyle.firstLineHeadIndent = 10;
    [attrStr addAttribute:NSParagraphStyleAttributeName
                    value:paragraphStyle
                    range:NSMakeRange(0, attrStr.length)];
    
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:FontSize(14)], NSParagraphStyleAttributeName:paragraphStyle, NSKernAttributeName:@1.5f
                          };
    CGSize size = [str boundingRectWithSize:CGSizeMake(kScreenWidth - 55 - 15 - 20,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
  
  
    
    NSDictionary *dict = @{
                          @"attributed" : attrStr,
                          @"height" : [NSString stringWithFormat:@"%.2f", size.height]
                          };
    
    return dict;
    
}





@end
