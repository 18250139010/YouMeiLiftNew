//
//  EwenCopyLabel.m
//  SuoMusicStudent
//
//  Created by apple on 2016/10/20.
//  Copyright © 2016年 suomusic. All rights reserved.
//

#import "EwenCopyLabel.h"
#define UIColorRGB(x,y,z,a) [UIColor colorWithRed:x/255.0 green:y/255.0 blue:z/255.0 alpha:a]
#import <YJProgressHUD.h>
@implementation EwenCopyLabel

-(BOOL)canBecomeFirstResponder {
    return YES;
}

// 可以响应的方法
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(newFunc)) {
        return YES;
    }
    return NO;
}

//针对于响应方法的实现
-(void)copy:(id)sender {
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string = self.text;
}

//UILabel默认是不接收事件的，我们需要自己添加touch事件
-(void)attachTapHandler {
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *touch = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self addGestureRecognizer:touch];
}

//绑定事件
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self attachTapHandler];
        [[NSNotificationCenter defaultCenter] addObserverForName:UIMenuControllerWillHideMenuNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
            self.backgroundColor = [UIColor clearColor];
        }];
    }
    return self;
}

-(void)awakeFromNib {
    [super awakeFromNib];
    [self attachTapHandler];
}

-(void)handleTap:(UIGestureRecognizer*) recognizer {
    if (recognizer.state == UIGestureRecognizerStateEnded) {
       
        return;
    }else if (recognizer.state == UIGestureRecognizerStateBegan){
      
        [self becomeFirstResponder];
      //  self.backgroundColor = UIColorRGB(236, 236, 236, 1.0);
        UIMenuItem * item = [[UIMenuItem alloc]initWithTitle:@"复制" action:@selector(newFunc)];
        [[UIMenuController sharedMenuController] setTargetRect:self.frame inView:self.superview];
        [UIMenuController sharedMenuController].menuItems = @[item];
        [UIMenuController sharedMenuController].menuVisible = YES;
    }
}

-(void)newFunc{
    NSString *temp = [self.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string = [NSString stringWithFormat:@"%@", temp];
 
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:[NSString stringWithFormat:@"%@", temp] forKey:@"dmjFuZhiNeiRong"];
    UIWindow* window =  [UIApplication sharedApplication].keyWindow;
//    [YJProgressHUD showMsgWithMsgStr:@"复制成功" imageName:@"copy_success.png" inview:window afterDelayTime:1.5];
}




@end

