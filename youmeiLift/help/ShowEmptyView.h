//
//  ShowEmptyView.h
//  DaiMengJia
//
//  Created by 呆萌价 on 2019/3/9.
//  Copyright © 2019年 呆萌价. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^AlertViewBlock)(NSInteger buttonTag);
typedef void(^TryAgainBlock)(NSInteger buttonTag);

@interface ShowEmptyView : UIView



- (instancetype)init;

//****
- (void)showeEmptyTipsToView:(UIView *)view
                       title:(NSString *)title
                     message:(NSString *)message
                   imageType:(NSString* )imageType
                    tryAgain:(TryAgainBlock)tryAgain;

- (void)remove;

@end

NS_ASSUME_NONNULL_END
