//
//  YMPosterdataItem.h
//  youmeiLift
//
//  Created by mac on 2021/7/5.
//

#import <Foundation/Foundation.h>
#import "YMPosterdata.h"
NS_ASSUME_NONNULL_BEGIN

@interface YMPosterdataItem : NSObject
@property (strong, nonatomic) NSMutableArray <YMPosterdata *> *posterdata;
@property (copy, nonatomic) NSString *msgstr;
@property (assign, nonatomic) NSInteger result;
@property (copy, nonatomic) NSString *appsharelink;

@end

NS_ASSUME_NONNULL_END
