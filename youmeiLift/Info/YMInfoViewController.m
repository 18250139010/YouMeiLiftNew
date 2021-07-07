//
//  YMInfoViewController.m
//  有美生活
//
//  Created by mac on 2021/6/22.
//

#import "YMInfoViewController.h"
#import <Masonry.h>
@interface YMInfoViewController ()

@end

@implementation YMInfoViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    
    self.navigationController.navigationBarHidden = YES;
    // self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    
    self.navigationController.navigationBarHidden = NO;
    // self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=allBackgroundColor;
    
    
    UIView *HeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    HeaderView.backgroundColor=[UIColor colorWithRed:248/255.0 green:66/255.0 blue:102/255.0 alpha:1];
    [self.view addSubview:HeaderView];
    
    [self layoutMultiLine];
}
-(void)layoutMultiLine{
    
        //多行布局 要考虑换行的问题
        CGFloat marginX =10;  //按钮距离左边和右边的距离
        CGFloat marginY =1;  //距离上下边缘距离
        CGFloat toTop =200;  //按钮距离顶部的距离
        CGFloat gapX =10;    //左右按钮之间的距离
        CGFloat gapY =10;    //上下按钮之间的距离
        NSInteger col =2;    //这里只布局5列
        NSInteger count =6;  //这里先设置布局任意个按钮
    
    
        CGFloat viewWidth = self.view.bounds.size.width;  //视图的宽度
        CGFloat viewHeight = self.view.bounds.size.height;  //视图的高度
    CGFloat itemWidth = (viewWidth - marginX *2- (col -1)*gapX)/col*1.0f;  //根据列数 和 按钮之间的间距 这些参数基本可以确定要平铺的按钮的宽度
        CGFloat itemHeight = 49;  //按钮的高度可以根据情况设定 这里设置为相等
    UIButton*last =nil;  //上一个按钮
        //准备工作完毕 既可以开始布局了
        for(int i =0; i < count; i++) {
                UIButton*item = [self buttonCreat];
                [item setTitle:@(i).stringValue forState:UIControlStateNormal];
                [self.view addSubview:item];
        
        
                //布局
                [item mas_makeConstraints:^(MASConstraintMaker*make) {
            
            
                        //宽高是固定的，前面已经算好了
                        make.width.mas_equalTo(itemWidth);
                        make.height.mas_equalTo(itemHeight);
            
            
                        //topTop距离顶部的距离，单行不用考虑太多，多行，还需要计算距离顶部的距离
            
                        //计算距离顶部的距离 --- 根据换行
            
                        CGFloat top = toTop + marginY + (i/col)*(itemHeight+gapY);
            
                        make.top.mas_offset(top);
            
                        if (!last || (i%col) == 0) {  //last为nil  或者(i%col) == 0 说明换行了 每行的第一个确定它距离左边边缘的距离
                
                                make.left.mas_offset(marginX);
                
                
                
                            }else{
                    
                                    //第二个或者后面的按钮 距离前一个按钮右边的距离都是gap个单位
                    
                                    make.left.mas_equalTo(last.mas_right).mas_offset(gapX);
                    
                                }
            
                    }];
        
                last = item;
        
            }
    
}

#pragma mark - Private

-(UIButton*)buttonCreat{
    
        UIButton*item = [[UIButton alloc]init];
    
        item.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0f];
    
        item.titleLabel.font = [UIFont systemFontOfSize:16];
    
        [item setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
        return item;
    
}

@end
