//
//  YXCollectionView.m
//  DaiMengJia
//
//  Created by 呆萌价 on 2020/4/7.
//  Copyright © 2020 呆萌价. All rights reserved.
//

#import "YXCollectionView.h"

@implementation YXCollectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
 
    
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
            
       
            UIView *view = gestureRecognizer.view;
      //  DMLog(@"viewviewPanGesture222 -- %@", view);
             CGPoint offset = [(UIPanGestureRecognizer *)gestureRecognizer translationInView:view];
     
            if (offset.x < 0 || offset.x > 0) {
               return NO;
            }
           
        }
        
        if ([otherGestureRecognizer isKindOfClass:[UISwipeGestureRecognizer class]]) {
          //    UIView *view = otherGestureRecognizer.view;
   //     DMLog(@"viewviewSwipeGesture222 -- %@", view);
           
        }
        if ([otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
            
            // DMLog(@"平移2222222");
            UIView *view = otherGestureRecognizer.view;
            CGPoint offset = [(UIPanGestureRecognizer *)otherGestureRecognizer translationInView:view];
            if (offset.y - offset.x > -10) {
             //   return YES;
            }
            
          
        }
    
    
    return YES;
}

@end
