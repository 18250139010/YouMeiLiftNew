//
//  YMNavigationViewController.m
//  youmeiLift
//
//  Created by mac on 2021/6/24.
//

#import "YMNavigationViewController.h"

@interface YMNavigationViewController ()

@end

@implementation YMNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{

    if (self.viewControllers.count >0) {
        
        viewController.hidesBottomBarWhenPushed = YES;
    }
   
    [super pushViewController:viewController animated:animated];
    
    // 修改tabBra的frame
    CGRect frame = self.tabBarController.tabBar.frame;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
    self.tabBarController.tabBar.frame = frame;
}

@end
