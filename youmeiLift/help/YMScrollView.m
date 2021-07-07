//
//  YMScrollView.m
//  youmeiLift
//
//  Created by mac on 2021/6/23.
//

#import "YMScrollView.h"
#import "DMTool.h"
@implementation YMScrollView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
            UIView *view = gestureRecognizer.view;
             CGPoint offset = [(UIPanGestureRecognizer *)gestureRecognizer translationInView:view];
            if (offset.x < 0 || offset.x > 0) {
               return NO;
            }
        }
        if ([otherGestureRecognizer isKindOfClass:[UISwipeGestureRecognizer class]]) {
        }
        if ([otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
            UIView *view = otherGestureRecognizer.view;
            CGPoint offset = [(UIPanGestureRecognizer *)otherGestureRecognizer translationInView:view];
            if (offset.y - offset.x > -10) {
            }
        }
    return YES;
}

@end
