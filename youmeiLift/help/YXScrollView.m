//
//  YXScrollView.m
//  DaiMengJia
//
//  Created by 呆萌价 on 2018/1/23.
//  Copyright © 2018年 呆萌价. All rights reserved.
//

#import "YXScrollView.h"
#import "YXScrollViewTwo.h"
#import "YXCollectionView.h"
#import "HomeView.h"
@implementation YXScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
  
    
    
    
    if ([otherGestureRecognizer.view isKindOfClass:[YXScrollViewTwo class]] || [otherGestureRecognizer.view isKindOfClass:[YXCollectionView class]] || [otherGestureRecognizer.view isKindOfClass:[HomeView class]]) {
        return NO;
    }
    
    
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
            
       
            UIView *view = gestureRecognizer.view;
             CGPoint offset = [(UIPanGestureRecognizer *)gestureRecognizer translationInView:view];
     
            if (offset.x < 0 || offset.x > 0) {
             //   return NO;
            }
           
        }
        
        if ([otherGestureRecognizer isKindOfClass:[UISwipeGestureRecognizer class]]) {
               
                
      
           
        }
        if ([otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
            
            // DMLog(@"平移2222222");
            UIView *view = otherGestureRecognizer.view;
            CGPoint offset = [(UIPanGestureRecognizer *)otherGestureRecognizer translationInView:view];
            if (offset.y - offset.x > -10) {
             //   return YES;
            }
            
            
//            if (offset.y < 0 || offset.y > 0) {
//                return NO;
//            }
        }
    
    
    return YES;
}


@end
