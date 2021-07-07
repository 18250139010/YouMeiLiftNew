

//
//  MD5Helper.m
//  KuaiJieCaiFu
//
//  Created by KuaiJie on 16/1/26.
//  Copyright © 2016年 KuaiJie. All rights reserved.
//

#import "MD5Helper.h"

@implementation MD5Helper

+ (NSString *)md5Encrypt:(NSString *)aString{
    
    const char *cStr = [aString UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}


+ (NSString *)md5EncryptDX:(NSString *)aString{
    
    const char *cStr = [aString UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] uppercaseString];
}



+ (NSString *)HMACMD5WithString:(NSString *)toEncryptStr WithKey:(NSString *)keyStr
{
    
    const char *cKey  = [keyStr cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [toEncryptStr cStringUsingEncoding:NSUTF8StringEncoding];
    const unsigned int blockSize = 64;
    char ipad[blockSize];
    char opad[blockSize];
    char keypad[blockSize];

    unsigned int keyLen = (int)strlen(cKey);
    CC_MD5_CTX ctxt;
    if (keyLen > blockSize) {
        CC_MD5_Init(&ctxt);
        CC_MD5_Update(&ctxt, cKey, keyLen);
        CC_MD5_Final((unsigned char *)keypad, &ctxt);
        keyLen = CC_MD5_DIGEST_LENGTH;
    }
    else {
        memcpy(keypad, cKey, keyLen);
    }

    memset(ipad, 0x36, blockSize);
    memset(opad, 0x5c, blockSize);

    int i;
    for (i = 0; i < keyLen; i++) {
        ipad[i] ^= keypad[i];
        opad[i] ^= keypad[i];
    }

    CC_MD5_Init(&ctxt);
    CC_MD5_Update(&ctxt, ipad, blockSize);
    CC_MD5_Update(&ctxt, cData, (int)strlen(cData));
    unsigned char md5[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(md5, &ctxt);

    CC_MD5_Init(&ctxt);
    CC_MD5_Update(&ctxt, opad, blockSize);
    CC_MD5_Update(&ctxt, md5, CC_MD5_DIGEST_LENGTH);
    CC_MD5_Final(md5, &ctxt);

    const unsigned int hex_len = CC_MD5_DIGEST_LENGTH*2+2;
    char hex[hex_len];
    for(i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        snprintf(&hex[i*2], hex_len-i*2, "%02X", md5[i]);
    }

    NSData *HMAC = [[NSData alloc] initWithBytes:hex length:strlen(hex)];
    NSString *hash = [[NSString alloc] initWithData:HMAC encoding:NSUTF8StringEncoding] ;

    
    
    
    
    
   
    return hash;
}

@end
