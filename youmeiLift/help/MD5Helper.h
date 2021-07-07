//
//  MD5Helper.h
//  KuaiJieCaiFu
//
//  Created by KuaiJie on 16/1/26.
//  Copyright © 2016年 KuaiJie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>



@interface MD5Helper : NSObject

+ (NSString *)md5Encrypt:(NSString *)aString;
+ (NSString *)md5EncryptDX:(NSString *)aString;

+ (NSString *)HMACMD5WithString:(NSString *)toEncryptStr WithKey:(NSString *)keyStr;

@end
