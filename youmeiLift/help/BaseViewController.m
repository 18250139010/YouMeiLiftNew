//
//  BaseViewController.m
//  DaiMengJia
//
//  Created by 呆萌价 on 2017/11/21.
//  Copyright © 2017年 呆萌价. All rights reserved.
//

#import "BaseViewController.h"
#import "DMTool.h"
//#import "YJProgressHUD.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    UIView *backbBtnview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];

    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(13, 10, 18, 24)];
    if (@available(iOS 13.0, *)) {
        imgView.frame = CGRectMake(13, 10, 18, 24);
    } else {
        imgView.frame = CGRectMake(13, 10, 18, 24);
    }
    
    imgView.image = [UIImage imageNamed:@"navBack.png"];
    [backbBtnview addSubview:imgView];
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:backbBtnview];
    
    self.navigationItem.leftBarButtonItem =  left;
    
    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickBackButtonView:)];
    [backbBtnview addGestureRecognizer:backTap];
    
    self.navigationController.navigationBar.tintColor = [UIColor darkTextColor];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:FontSize(18)],NSForegroundColorAttributeName:textMinorColor33};
    self.view.backgroundColor = [UIColor whiteColor];
    
}


- (void)clickBackButtonView:(UIGestureRecognizer *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];

}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   // self.tabBarController.tabBar.hidden = YES;
 
    [self.navigationController.navigationBar setShadowImage:[self createImageWithColor:halvingLineColor]];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
 //  self.tabBarController.tabBar.hidden = NO;
//    [YJProgressHUD hide];
}

- (UIImage *)createImageWithColor:(UIColor *)color{
    
    CGRect rect = CGRectMake(0.0f,0.0f,1.0f,1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context =UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *theImage =UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return theImage;
    
}




@end
