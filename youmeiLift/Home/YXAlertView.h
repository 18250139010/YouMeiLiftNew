//
//  YXAlertView.h
//  DaiMengJia
//
//  Created by 呆萌价 on 2017/11/20.
//  Copyright © 2017年 呆萌价. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define cancelIndex    (-1)

typedef void(^AlertViewBlock)(NSInteger buttonTag);
typedef void(^TryAgainBlock)(NSInteger buttonTag);

@interface YXAlertView : NSObject

+(YXAlertView *)shareInstance;

/**
 *  创建提示框
 *
 *  @param title        标题
 *  @param message      提示内容
 *  @param cancelTitle  取消按钮(无操作,为nil则只显示一个按钮)
 *  @param titleArray   标题字符串数组(为nil,默认为"确定")
 *  @param vc           VC iOS8及其以后会用到
 *  @param confirm      点击按钮的回调(取消按钮的Index是cancelIndex -1)
 */
- (void)showAlert:(NSString *)title
          message:(NSString *)message
      cancelTitle:(NSString *)cancelTitle
       titleArray:(NSArray *)titleArray
   viewController:(UIViewController *)vc
          confirm:(AlertViewBlock)confirm;

/**
 *  创建提示框(可变参数版)
 *
 *  @param title        标题
 *  @param message      提示内容
 *  @param cancelTitle  取消按钮(无操作,为nil则只显示一个按钮)
 *  @param vc           VC iOS8及其以后会用到
 *  @param confirm      点击按钮的回调(取消按钮的Index是cancelIndex -1)
 *  @param buttonTitles 按钮(为nil,默认为"确定",传参数时必须以nil结尾，否则会崩溃)
 */
- (void)showAlert:(NSString *)title
          message:(NSString *)message
      cancelTitle:(NSString *)cancelTitle
   viewController:(UIViewController *)vc
          confirm:(AlertViewBlock)confirm
     buttonTitles:(NSString *)buttonTitles, ... NS_REQUIRES_NIL_TERMINATION;

/**
 *  创建菜单(Sheet)
 *
 *  @param title        标题
 *  @param message      提示内容
 *  @param cancelTitle  取消按钮(无操作,为nil则只显示一个按钮)
 *  @param titleArray   标题字符串数组(为nil,默认为"确定")
 *  @param vc           VC iOS8及其以后会用到
 *  @param confirm      点击确认按钮的回调(取消按钮的Index是cancelIndex -1)
 */
- (void)showSheet:(NSString *)title
          message:(NSString *)message
      cancelTitle:(NSString *)cancelTitle
       titleArray:(NSArray *)titleArray
   viewController:(UIViewController *)vc
          confirm:(AlertViewBlock)confirm;

/**
 *  创建菜单(Sheet 可变参数版)
 *
 *  @param title        标题
 *  @param message      提示内容
 *  @param cancelTitle  取消按钮(无操作,为nil则只显示一个按钮)
 *  @param vc           VC
 *  @param confirm      点击按钮的回调(取消按钮的Index是cancelIndex -1)
 *  @param buttonTitles 按钮(为nil,默认为"确定",传参数时必须以nil结尾，否则会崩溃)
 */
- (void)showSheet:(NSString *)title
          message:(NSString *)message
      cancelTitle:(NSString *)cancelTitle
   viewController:(UIViewController *)vc
          confirm:(AlertViewBlock)confirm
     buttonTitles:(NSString *)buttonTitles, ... NS_REQUIRES_NIL_TERMINATION ;

//****
- (void)showTipsToView:(UIView *)view
          message:(NSString *)message
            imageType:(NSInteger )imageType;

//****

- (void)remove;



- (void)showDMAlert:(NSString *)title
       message:(NSString *)message
   cancelTitle:(NSString *)cancelTitle
    titleArray:(NSArray *)titleArray
viewController:(UIViewController *)vc
       confirm:(AlertViewBlock)confirm;

- (UIImage *)CSPlaceholderImageWithWidth:(CGFloat )width height:(CGFloat )height;


@end
