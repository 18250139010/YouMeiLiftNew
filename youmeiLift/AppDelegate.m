//
//  AppDelegate.m
//  有美生活
//
//  Created by mac on 2021/6/22.
//

#import "AppDelegate.h"
#import "YMHomeViewController.h"
#import "YMInfoViewController.h"
#import "YMMainViewController.h"
#import "YMNavigationViewController.h"
#import "SDWebImageDownloader.h"
@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
//    self.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:tab];
    [self.window makeKeyAndVisible];
    
    YMHomeViewController * homeVC = [[YMHomeViewController alloc]init];
    YMNavigationViewController *homeNC = [[YMNavigationViewController alloc]initWithRootViewController:homeVC];
    homeVC.tabBarItem = [[UITabBarItem alloc]init];
    homeVC.tabBarItem.title = [NSString stringWithFormat:@"首页"];
    [homeVC.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    [homeVC.tabBarItem setImageInsets:UIEdgeInsetsMake(-2, 0, 2, 0)];
    homeVC.tabBarItem.image = [[UIImage imageNamed:@"YMBuy.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homeVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"YMBuy.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    YMInfoViewController *infoVC=[[YMInfoViewController alloc]init];
    YMNavigationViewController *infoNC = [[YMNavigationViewController alloc]initWithRootViewController:infoVC];
    infoVC.tabBarItem = [[UITabBarItem alloc]init];
    infoVC.tabBarItem.title = [NSString stringWithFormat:@"消息"];
    [infoVC.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    [infoVC.tabBarItem setImageInsets:UIEdgeInsetsMake(-2, 0, 2, 0)];
    infoVC.tabBarItem.image = [[UIImage imageNamed:@"Message.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    infoVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"Message.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    YMMainViewController *mainVC=[[YMMainViewController alloc]init];
    YMNavigationViewController *mainNC = [[YMNavigationViewController alloc]initWithRootViewController:mainVC];
    mainVC.tabBarItem = [[UITabBarItem alloc]init];
    mainVC.tabBarItem.title = [NSString stringWithFormat:@"我的"];
    [mainVC.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    [mainVC.tabBarItem setImageInsets:UIEdgeInsetsMake(-2, 0, 2, 0)];
    mainVC.tabBarItem.image = [[UIImage imageNamed:@"Message.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    mainVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"Message.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarController *_tabBarController = [[UITabBarController alloc]init];
    _tabBarController.viewControllers = @[homeNC, infoNC, mainNC];
    _tabBarController.tabBar.barTintColor = kUIColorFromRGB(0xf9f9f9);
    _tabBarController.tabBar.tintColor = DMColor;
    _tabBarController.selectedIndex = 0;
    _tabBarController.delegate = self;
    self.window.rootViewController = _tabBarController;
    
    
    //首页 tab 图标
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:@"https://alq-app.oss-cn-hangzhou.aliyuncs.com/dmj/appmenu/home.png"] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
            if (image) {
                UIImage *lastImg = [self image:image targetSize:CGSizeMake(23, 22)];
                homeVC.tabBarItem.image = [lastImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                
            }
        }];
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:@"https://alq-app.oss-cn-hangzhou.aliyuncs.com/dmj/appmenu/homeSelect.png"] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        if (image) {
            UIImage *lastImg = [self image:image targetSize:CGSizeMake(23, 22)];
            homeVC.tabBarItem.selectedImage = [lastImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            
        }
        
    }];
    
    //消息 tab 图标
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:@"https://alq-app.oss-cn-hangzhou.aliyuncs.com/dmj/appmenu/business.png"] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
         } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
             if (image) {
                 UIImage *lastImg = [self image:image targetSize:CGSizeMake(23, 22)];
                 infoVC.tabBarItem.image = [lastImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
             }
         }];
     [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:@"https://alq-app.oss-cn-hangzhou.aliyuncs.com/dmj/appmenu/businessSelect.png"] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
     } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
         if (image) {
             UIImage *lastImg = [self image:image targetSize:CGSizeMake(23, 22)];
             infoVC.tabBarItem.selectedImage = [lastImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
         }
     }];
    
    //我的 tab 图标
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:@"https://alq-app.oss-cn-hangzhou.aliyuncs.com/dmj/appmenu/user.png"] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
         } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
             if (image) {
                 UIImage *lastImg = [self image:image targetSize:CGSizeMake(23, 22)];
                 mainVC.tabBarItem.image = [lastImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
             }
         }];
     [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:@"https://alq-app.oss-cn-hangzhou.aliyuncs.com/dmj/appmenu/userSelect.png"] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
     } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
         if (image) {
             UIImage *lastImg = [self image:image targetSize:CGSizeMake(23, 22)];
             mainVC.tabBarItem.selectedImage = [lastImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
         }
     }];
    
    return YES;
}
- (UIImage*)image:(UIImage *)sourceImage targetSize:(CGSize)size{
        UIImage *newImage = nil;
        CGSize imageSize = sourceImage.size;
        CGFloat width = imageSize.width;
        CGFloat height = imageSize.height;
        CGFloat targetWidth = size.width;
        CGFloat targetHeight = size.height;
        CGFloat scaleFactor = 0.0;
        CGFloat scaledWidth = targetWidth;
        CGFloat scaledHeight = targetHeight;
        CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
        if(CGSizeEqualToSize(imageSize, size) == NO){
            CGFloat widthFactor = targetWidth / width;
            CGFloat heightFactor = targetHeight / height;
            if(widthFactor > heightFactor){
                scaleFactor = widthFactor;
            }
            else{
                scaleFactor = heightFactor;
            }
            scaledWidth = width * scaleFactor;
            scaledHeight = height * scaleFactor;
            if(widthFactor > heightFactor){
                thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
            }else if(widthFactor < heightFactor){
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
        }
        UIGraphicsBeginImageContextWithOptions(size, NO, 3.0);
        CGRect thumbnailRect = CGRectZero;
        thumbnailRect.origin = thumbnailPoint;
        thumbnailRect.size.width = scaledWidth;
        thumbnailRect.size.height = scaledHeight;
        [sourceImage drawInRect:thumbnailRect];
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        if(newImage == nil){
            DMLog(@"scale image fail");
        }
        UIGraphicsEndImageContext();
        return newImage;
}

#pragma mark - UISceneSession lifecycle

- (void)applicationWillResignActive:(UIApplication *)application {
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
}
- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
