//
//  DMGifHeader.m
//  DaiMengJia
//
//  Created by 呆萌价 on 2019/6/4.
//  Copyright © 2019年 呆萌价. All rights reserved.
//

#import "DMGifHeader.h"

@implementation DMGifHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



- (void)prepare {
    [super prepare];
    //GIF数据
  
    NSMutableArray *imageArr = [NSMutableArray array];
    
    for (int i =1 ; i < 9; i++) {

        //for循环得到图片

         UIImage *_image = [UIImage imageNamed:[NSString stringWithFormat:@"YouZhengHaoPinLoging_%d.png",i]];
//        //将得到的图片添加到数组
        [imageArr addObject:_image];

     
    }
   
    
    NSMutableArray *imageArr2 = [NSMutableArray array];
    
    for (int i =1 ; i < 9; i++) {

        //for循环得到图片

         UIImage *_image = [UIImage imageNamed:[NSString stringWithFormat:@"YouZhengHaoPinLoging_%d.png",i]];
//        //将得到的图片添加到数组
        [imageArr2 addObject:_image];

     
    }
    
    
    //普通状态
    [self setImages:imageArr forState:MJRefreshStateIdle];
    //即将刷新状态
    [self setImages:imageArr forState:MJRefreshStatePulling];
    //正在刷新状态
    [self setImages:imageArr2 forState:MJRefreshStateRefreshing];
    
}

#pragma mark - 实现父类的方法
- (void)placeSubviews {
    [super placeSubviews];
    //隐藏状态显示文字
    self.stateLabel.hidden = YES;
    //隐藏更新时间文字
    self.lastUpdatedTimeLabel.hidden = YES;
}



@end
