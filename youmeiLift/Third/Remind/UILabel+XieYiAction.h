//
//  UILabel+XieYiAction.h
//  DaiMengJia
//
//  Created by 呆萌价 on 2020/8/13.
//  Copyright © 2020 呆萌价. All rights reserved.
//



#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol DMAttributeTapActionDelegate <NSObject>
@optional
/**
 *  DMAttributeTapActionDelegate
 *
 *  @param string  点击的字符串
 *  @param range   点击的字符串range
 *  @param index 点击的字符在数组中的index
 */
- (void)dm_attributeTapReturnString:(NSString *)string
                              range:(NSRange)range
                              index:(NSInteger)index;
@end

@interface DMAttributeModel : NSObject

@property (nonatomic, copy) NSString *str;

@property (nonatomic, assign) NSRange range;

@end


@interface UILabel (XieYiAction)


/**
 *  是否打开点击效果，默认是打开
 */
@property (nonatomic, assign) BOOL enabledTapEffect;

/**
 *  给文本添加点击事件Block回调
 *
 *  @param strings  需要添加的字符串数组
 *  @param tapClick 点击事件回调
 */
- (void)dm_addAttributeTapActionWithStrings:(NSArray <NSString *> *)strings
                                 tapClicked:(void (^) (NSString *string , NSRange range , NSInteger index))tapClick;

/**
 *  给文本添加点击事件delegate回调
 *
 *  @param strings  需要添加的字符串数组
 *  @param delegate delegate
 */
- (void)dm_addAttributeTapActionWithStrings:(NSArray <NSString *> *)strings
                                   delegate:(id <DMAttributeTapActionDelegate> )delegate;



@end

NS_ASSUME_NONNULL_END
