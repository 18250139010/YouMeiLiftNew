//
//  PopView.h
//  youmeiLift
//
//  Created by mac on 2021/6/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PopView : UIView
@property (nonatomic, strong) UIView *visualEffectView;
@property (nonatomic, strong) UIView *allView;

- (void)setUpregistMnyViewToView:(UIView *)upperView dmb:(NSString *)dmbStr;
- (void)setUpregistChaiViewToView:(UIView *)upperView;
@property (nonatomic, copy) void (^clickOkButtonRegisterView)(void);

//红包规则明细
- (void)setUpDailyRedGuiZeWithStr:(NSString *)guiZeStr;

@end

NS_ASSUME_NONNULL_END
