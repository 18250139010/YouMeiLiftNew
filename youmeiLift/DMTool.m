//
//  DMTool.m
//  DaiMengJia
//
//  Created by 呆萌价 on 2017/11/21.
//  Copyright © 2017年 呆萌价. All rights reserved.
//

#import "DMTool.h"

@implementation DMTool


+(NSString *)getArrayFilePath{
    //1.获取Documents 路径
    NSString *documentDilePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    //2.拼接上写入的文件路径
    NSString *filePath = [documentDilePath stringByAppendingPathComponent:@"array12.arr12"];
    return filePath;
}


+(NSString *)getNoWriteIDArrayFilePath{
    
    //1.获取Documents 路径
    NSString *documentDilePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    //2.拼接上写入的文件路径
     NSString *filePath = [documentDilePath stringByAppendingPathComponent:@"array.arr"];
  
     return filePath;

}


+ (NSDictionary*)dictionaryWithJsonString:(NSString*)jsonString
{

    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;

    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    
    if (err) {
        return nil;
    }
    
    return dic;
   
}


+(BOOL)checkUrl:(NSString *)url{
    
    
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", url]]]) {
    
            return YES;
            
        }
    
        return NO;
}
+ (void)networkRequestHaveVibration{
    
    if (@available(iOS 10.0, *)) {
        UIImpactFeedbackGenerator * impactLight = [[UIImpactFeedbackGenerator alloc]initWithStyle:UIImpactFeedbackStyleHeavy];
        [impactLight impactOccurred];
    } else {
        // Fallback on earlier versions
    }
    
}



@end
