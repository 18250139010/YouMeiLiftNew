//
//  YXAlertView.m
//  DaiMengJia
//
//  Created by 呆萌价 on 2017/11/20.
//  Copyright © 2017年 呆萌价. All rights reserved.
//

#import "YXAlertView.h"
#import "DMTool.h"

#define RootVC  [[UIApplication sharedApplication] keyWindow].rootViewController


@interface YXAlertView ()

@property (nonatomic, copy) AlertViewBlock block;
@property (nonatomic, copy) TryAgainBlock tryAgainblock;

@property (nonatomic, strong)  UIView *allView;

@property (nonatomic, strong) UIView *visualEffectView;


@end

@implementation YXAlertView

+ (YXAlertView *)shareInstance {
    static YXAlertView *tools = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tools = [[self alloc] init];
    });
    return tools;
}


/**
 *  创建提示框
 *
 *  @param title        标题
 *  @param message      提示内容
 *  @param cancelTitle  取消按钮(无操作,为nil则只显示一个按钮)
 *  @param titleArray   标题字符串数组(为nil,默认为"确定")
 *  @param vc           VC
 *  @param confirm      点击确认按钮的回调
 */
- (void)showAlert:(NSString *)title
          message:(NSString *)message
      cancelTitle:(NSString *)cancelTitle
       titleArray:(NSArray *)titleArray
   viewController:(UIViewController *)vc
          confirm:(AlertViewBlock)confirm {
    //
    if (!vc) vc = RootVC;
    
    [self p_showAlertController:title message:message
                    cancelTitle:cancelTitle titleArray:titleArray
                 viewController:vc confirm:^(NSInteger buttonTag) {
                     if (confirm)confirm(buttonTag);
                 }];
    
}

- (void)showDMAlert:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle titleArray:(NSArray *)titleArray viewController:(UIViewController *)vc confirm:(AlertViewBlock)confirm{
    
    //实现模糊效果
     self.visualEffectView = [[UIView alloc] init];
     _visualEffectView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
     _visualEffectView.backgroundColor = ColorMaker(0, 0, 0, 153);
     [RootVC.view addSubview:_visualEffectView];
     
    
     
     
     self.allView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 303, 167)];
     _allView.backgroundColor = [UIColor whiteColor];
    _allView.layer.masksToBounds = YES;
    _allView.layer.cornerRadius = 8;
    _allView.center = _visualEffectView.center;
     [RootVC.view addSubview:_allView];
    
    
    UILabel *ttLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 24, 303, 18.5)];
    ttLab.text = title;
    ttLab.textColor = kUIColorFromRGB(0x222222);
  //  ttLab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:FontSize(20)];
    ttLab.font = [UIFont systemFontOfSize:FontSize(18)];
    ttLab.textAlignment = NSTextAlignmentCenter;
    [_allView addSubview:ttLab];
    
    UILabel *contentLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 45, 283, 67)];
    contentLab.textColor = textMinorColor99;
    contentLab.numberOfLines = 0;
    contentLab.font = [UIFont systemFontOfSize:FontSize(14)];
//    contentLab.attributedText = [DMTextTool dm_changeLineSpace:3 str:message];
    contentLab.textAlignment = NSTextAlignmentCenter;
    [_allView addSubview:contentLab];
    
    UIView *lineView0 = [[UIView alloc]initWithFrame:CGRectMake(0, 121.5, 303, 0.5)];
    lineView0.backgroundColor = kUIColorFromRGB(0xEEEEEE);
    [_allView addSubview:lineView0];
    
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleBtn.frame = CGRectMake(0, 122, 151, 45);
    [cancleBtn setTitle:cancelTitle forState:0];
    [cancleBtn setTitleColor:kUIColorFromRGB(0x000000) forState:0];
    cancleBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(18)];
    [cancleBtn addTarget:self action:@selector(clickCancleButton) forControlEvents:UIControlEventTouchUpInside];
    [_allView addSubview:cancleBtn];
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(151.5, 122, 0.5, 45)];
    lineView1.backgroundColor = kUIColorFromRGB(0xEEEEEE);
    [_allView addSubview:lineView1];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(152, 122, 151, 45);
    [sureBtn setTitle:@"确定" forState:0];
    [sureBtn setTitleColor:kUIColorFromRGB(0xF84B43) forState:0];
     sureBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(18)];
    [sureBtn addTarget:self action:@selector(clickSureButton) forControlEvents:UIControlEventTouchUpInside];
    [_allView addSubview:sureBtn];
    
    [self setBlock:^(NSInteger buttonTag) {
         
          confirm(buttonTag);
          
         
      }];
}
-(void)clickCancleButton{
    [_visualEffectView removeFromSuperview];
    [_allView removeFromSuperview];
    
}

-(void)clickSureButton{
    [_visualEffectView removeFromSuperview];
    [_allView removeFromSuperview];
      self.block(666);
}

/**
 *  创建提示框(可变参数版)
 *
 *  @param title        标题
 *  @param message      提示内容
 *  @param cancelTitle  取消按钮(无操作,为nil则只显示一个按钮)
 *  @param vc           VC
 *  @param confirm      点击按钮的回调
 *  @param buttonTitles 按钮(为nil,默认为"确定",传参数时必须以nil结尾，否则会崩溃)
 */
- (void)showAlert:(NSString *)title
          message:(NSString *)message
      cancelTitle:(NSString *)cancelTitle
   viewController:(UIViewController *)vc
          confirm:(AlertViewBlock)confirm
     buttonTitles:(NSString *)buttonTitles, ... NS_REQUIRES_NIL_TERMINATION {
    
    // 读取可变参数里面的titles数组
    NSMutableArray *titleArray = [[NSMutableArray alloc] initWithCapacity:0];
    va_list list;
    if(buttonTitles) {
        //1.取得第一个参数的值(即是buttonTitles)
        [titleArray addObject:buttonTitles];
        //2.从第2个参数开始，依此取得所有参数的值
        NSString *otherTitle;
        va_start(list, buttonTitles);
        while ((otherTitle = va_arg(list, NSString*))) {
            [titleArray addObject:otherTitle];
        }
        va_end(list);
    }
    
    if (!vc) vc = RootVC;
    
    [self p_showAlertController:title message:message
                    cancelTitle:cancelTitle titleArray:titleArray
                 viewController:vc confirm:^(NSInteger buttonTag) {
                     if (confirm)confirm(buttonTag);
                 }];
    
}


/**
 *  创建菜单(Sheet)
 *
 *  @param title        标题
 *  @param message      提示内容
 *  @param cancelTitle  取消按钮(无操作,为nil则只显示一个按钮)
 *  @param titleArray   标题字符串数组(为nil,默认为"确定")
 *  @param vc           VC
 *  @param confirm      点击确认按钮的回调
 */
- (void)showSheet:(NSString *)title
          message:(NSString *)message
      cancelTitle:(NSString *)cancelTitle
       titleArray:(NSArray *)titleArray
   viewController:(UIViewController *)vc
          confirm:(AlertViewBlock)confirm {
    
    if (!vc) vc = RootVC;
    
    [self p_showSheetAlertController:title message:message cancelTitle:cancelTitle
                          titleArray:titleArray viewController:vc confirm:^(NSInteger buttonTag) {
                              if (confirm)confirm(buttonTag);
                          }];
}

/**
 *  创建菜单(Sheet 可变参数版)
 *
 *  @param title        标题
 *  @param message      提示内容
 *  @param cancelTitle  取消按钮(无操作,为nil则只显示一个按钮)
 *  @param vc           VC iOS8及其以后会用到
 *  @param confirm      点击按钮的回调
 *  @param buttonTitles 按钮(为nil,默认为"确定",传参数时必须以nil结尾，否则会崩溃)
 */
- (void)showSheet:(NSString *)title
          message:(NSString *)message
      cancelTitle:(NSString *)cancelTitle
   viewController:(UIViewController *)vc
          confirm:(AlertViewBlock)confirm
     buttonTitles:(NSString *)buttonTitles, ... NS_REQUIRES_NIL_TERMINATION {
    // 读取可变参数里面的titles数组
    NSMutableArray *titleArray = [[NSMutableArray alloc] initWithCapacity:0];
    va_list list;
    if(buttonTitles) {
        //1.取得第一个参数的值(即是buttonTitles)
        [titleArray addObject:buttonTitles];
        //2.从第2个参数开始，依此取得所有参数的值
        NSString *otherTitle;
        va_start(list, buttonTitles);
        while ((otherTitle= va_arg(list, NSString*))) {
            [titleArray addObject:otherTitle];
        }
        va_end(list);
    }
    
    if (!vc) vc = RootVC;
    
    // 显示菜单提示框
    [self p_showSheetAlertController:title message:message cancelTitle:cancelTitle
                          titleArray:titleArray viewController:vc confirm:^(NSInteger buttonTag) {
                              if (confirm)confirm(buttonTag);
                          }];
    
}

#pragma mark - ----------------内部方法------------------

//UIAlertController(iOS8及其以后)
- (void)p_showAlertController:(NSString *)title
                      message:(NSString *)message
                  cancelTitle:(NSString *)cancelTitle
                   titleArray:(NSArray *)titleArray
               viewController:(UIViewController *)vc
                      confirm:(AlertViewBlock)confirm {
    
    UIAlertController  *alert = [UIAlertController alertControllerWithTitle:title
                                                                    message:message
                                                             preferredStyle:UIAlertControllerStyleAlert];
    // 下面两行代码 是修改 title颜色和字体的代码
    //    NSAttributedString *attributedMessage = [[NSAttributedString alloc] initWithString:title attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0f], NSForegroundColorAttributeName:UIColorFrom16RGB(0x334455)}];
    //    [alert setValue:attributedMessage forKey:@"attributedTitle"];
    if (cancelTitle) {
        // 取消
        UIAlertAction  *cancelAction = [UIAlertAction actionWithTitle:cancelTitle
                                                                style:UIAlertActionStyleCancel
                                                              handler:^(UIAlertAction * _Nonnull action) {
                                                                  if (confirm)confirm(cancelIndex);
                                                              }];
        [alert addAction:cancelAction];
    }
    // 确定操作
    if (!titleArray || titleArray.count == 0) {
        UIAlertAction  *confirmAction = [UIAlertAction actionWithTitle:@"确定"
                                                                 style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction * _Nonnull action) {
                                                                   if (confirm)confirm(0);
                                                               }];
        
        [alert addAction:confirmAction];
    } else {
        
        for (NSInteger i = 0; i<titleArray.count; i++) {
            UIAlertAction  *action = [UIAlertAction actionWithTitle:titleArray[i]
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * _Nonnull action) {
                                                                if (confirm)confirm(i);
                                                            }];
            // [action setValue:UIColorFrom16RGB(0x00AE08) forKey:@"titleTextColor"]; // 此代码 可以修改按钮颜色
            [alert addAction:action];
        }
    }
    
    [vc presentViewController:alert animated:YES completion:nil];
    
}


// ActionSheet的封装
- (void)p_showSheetAlertController:(NSString *)title
                           message:(NSString *)message
                       cancelTitle:(NSString *)cancelTitle
                        titleArray:(NSArray *)titleArray
                    viewController:(UIViewController *)vc
                           confirm:(AlertViewBlock)confirm {
    
    UIAlertController *sheet = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    if (!cancelTitle) cancelTitle = @"取消";
    // 取消
    UIAlertAction  *cancelAction = [UIAlertAction actionWithTitle:cancelTitle
                                                            style:UIAlertActionStyleCancel
                                                          handler:^(UIAlertAction * _Nonnull action) {
                                                              if (confirm)confirm(cancelIndex);
                                                          }];
    [sheet addAction:cancelAction];
    
    if (titleArray.count > 0) {
        for (NSInteger i = 0; i<titleArray.count; i++) {
            UIAlertAction  *action = [UIAlertAction actionWithTitle:titleArray[i]
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * _Nonnull action) {
                                                                if (confirm)confirm(i);
                                                            }];
            [sheet addAction:action];
        }
    }
    
    [vc presentViewController:sheet animated:YES completion:nil];
}


- (void)showTipsToView:(UIView *)view message:(NSString *)message imageType:(NSInteger)imageType{
    
    if (imageType == 999) {
        
        UIView *showView = [[UIView alloc]initWithFrame:CGRectMake(0, 160, kScreenWidth, 40)];
       // showView.backgroundColor = allBackgroundColor;
        showView.layer.masksToBounds = YES;
        showView.layer.cornerRadius = 5.0f;
        
        UIWindow* window =  [UIApplication sharedApplication].keyWindow;
        
        UILabel *ttLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, kScreenWidth-60, 40)];
        ttLabel.text = message;
        ttLabel.backgroundColor = allBackgroundColor;
        ttLabel.font = [UIFont systemFontOfSize:FontSize(13)];
        ttLabel.textAlignment = NSTextAlignmentCenter;
        ttLabel.numberOfLines = 0;
        [showView addSubview:ttLabel];
        
        
       // showView.center = view.center;
        [window addSubview:showView];
        
        ttLabel.textColor = textMinorColor;
        
        CATransition * transion = [CATransition animation];
        // transion.type = @"push";//设置动画方式
        // transion.subtype = @"fromRight";//设置动画从那个方向开始
        [showView.layer addAnimation:transion forKey:nil];//给Label.layer 添加动画
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(),^{
            [showView removeFromSuperview];
        });//这句话的意思是1.5秒后，把label移出视图

        
        
    }
    else{
    
    UIView *showView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 120, 70)];
    showView.backgroundColor = ColorMaker(249, 249, 249, 255);
    showView.layer.masksToBounds = YES;
    showView.layer.cornerRadius = 5.0f;
//    showView.center = view.center;
//    [view addSubview:showView];
    
    
    UIWindow* window =  [UIApplication sharedApplication].keyWindow;
//    [window addSubview:showView];

    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(50, 10, 20, 20)];
    [showView addSubview:imgView];
    
    UILabel *ttLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 25, 100, 40)];
    ttLabel.text = message;
    ttLabel.font = [UIFont systemFontOfSize:10];
    ttLabel.textAlignment = NSTextAlignmentCenter;
    ttLabel.numberOfLines = 0;
    [showView addSubview:ttLabel];
    
    
    
    
    switch (imageType) {
        case 0:
            imgView.image = [UIImage imageNamed:@"main_WH.png"];
            showView.center = window.center;
            [window addSubview:showView];
            ttLabel.textColor = textMinorColor;

            break;
            
        case 1:
            imgView.image = [UIImage imageNamed:@"news_time.png"];
            showView.center = window.center;
            [window addSubview:showView];
            ttLabel.textColor = textMinorColor;

            break;
        case 2:
            imgView.image = [UIImage imageNamed:@"news_time.png"];
            showView.center = window.center;
            showView.backgroundColor = ColorMaker(55, 44, 44, 255);
            [window addSubview:showView];
            ttLabel.textColor = [UIColor whiteColor];

            break;
            
        case 3:
            imgView.image = [UIImage imageNamed:@"main_TS.png"];
            showView.center = window.center;
            [window addSubview:showView];
            ttLabel.textColor = textMinorColor;
            
            break;
        default:
            break;
    }
    
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
//    [UIView setAnimationDuration:4.0];
//    [UIView setAnimationDelegate:self];
//    showView.alpha = 0.0;
//    [UIView commitAnimations];
    
    
    CATransition * transion = [CATransition animation];
   // transion.type = @"push";//设置动画方式
   // transion.subtype = @"fromRight";//设置动画从那个方向开始
    [showView.layer addAnimation:transion forKey:nil];//给Label.layer 添加动画
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(),^{
        [showView removeFromSuperview];
    });//这句话的意思是1.5秒后，把label移出视图

    
    }
        
        
}






- (void)clickEmptyImageView:(UIGestureRecognizer *)sender{
    self.block(233);
}

- (void)remove{
    [_allView removeFromSuperview];
}



-(UIImage *)CSPlaceholderImageWithWidth:(CGFloat)width height:(CGFloat)height
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    view.backgroundColor = [UIColor whiteColor];
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake((width- height)/2.0, 0, height, height)];
    imgView.image = [UIImage imageNamed:@"onecell"];
    [view addSubview:imgView];
   
     return [self convertViewToImage:view];
}

-(UIImage*)convertViewToImage:(UIView*)v
{
    CGSize s = v.bounds.size;
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [v.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    v.layer.contents = nil;
    return image;
    
}




@end
