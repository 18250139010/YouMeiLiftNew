//
//  YMInvitationViewController.m
//  youmeiLift
//
//  Created by mac on 2021/7/5.
//

#import "YMInvitationViewController.h"

#import "DMTool.h"
#import <Masonry.h>
//#import "TouchTool.h"
#import "DMTextTool.h"
#import "TSShareHelper.h"
#import "NetWorkManager.h"
#import "YXAlertView.h"
#import "YJProgressHUD.h"
#import "DCCycleScrollView.h"
//#import <UShareUI/UShareUI.h>

#import "SDWebImageManager.h"
#import "SDWebImageDownloader.h"

#import "MJExtension.h"
#import "YMPosterdata.h"
#import "YMPosterdataItem.h"
#import "PopView.h"
@interface YMInvitationViewController ()<DCCycleScrollViewDelegate>
@property (strong, nonatomic) UIView *headerNavView;
@property (strong, nonatomic) NSMutableArray *shareImgeArr;
@property (copy, nonatomic) NSString *shareUrl;
@property (strong, nonatomic) NSMutableArray *imgNewArr;

@property (strong, nonatomic) NSMutableArray *dataArr;
@property (strong, nonatomic) YMPosterdata *posterData;

@end

@implementation YMInvitationViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)clickBackVC:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.shareImgeArr = [NSMutableArray array];
    self.imgNewArr = [NSMutableArray array];
    self.dataArr = [NSMutableArray array];
    
    self.shareImgeArr = [NSMutableArray arrayWithObjects:
                              @"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fwx1.sinaimg.cn%2Flarge%2F008fHVgdly4gqfhftvhl5j30u00iv40g.jpg&refer=http%3A%2F%2Fwx1.sinaimg.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1627028752&t=eadfa6c42d5eebb9b76828047ee51d0b",@"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimgres.quxiu.com%2Fquxiu%2F341%2F1703972-2021052312100560a9d59d41f11.jpg&refer=http%3A%2F%2Fimgres.quxiu.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1627028788&t=26e4bc5dcd05b65744c26924cd7e5047",@"https://img1.baidu.com/it/u=2917893129,3433599284&fm=26&fmt=auto&gp=0.jpg",nil];
    self.imgNewArr = [NSMutableArray arrayWithObjects:
                              @"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fwx1.sinaimg.cn%2Flarge%2F008fHVgdly4gqfhftvhl5j30u00iv40g.jpg&refer=http%3A%2F%2Fwx1.sinaimg.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1627028752&t=eadfa6c42d5eebb9b76828047ee51d0b",@"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimgres.quxiu.com%2Fquxiu%2F341%2F1703972-2021052312100560a9d59d41f11.jpg&refer=http%3A%2F%2Fimgres.quxiu.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1627028788&t=26e4bc5dcd05b65744c26924cd7e5047",@"https://img1.baidu.com/it/u=2917893129,3433599284&fm=26&fmt=auto&gp=0.jpg",nil];
    self.dataArr = [NSMutableArray arrayWithObjects:
                              @"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fwx1.sinaimg.cn%2Flarge%2F008fHVgdly4gqfhftvhl5j30u00iv40g.jpg&refer=http%3A%2F%2Fwx1.sinaimg.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1627028752&t=eadfa6c42d5eebb9b76828047ee51d0b",@"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimgres.quxiu.com%2Fquxiu%2F341%2F1703972-2021052312100560a9d59d41f11.jpg&refer=http%3A%2F%2Fimgres.quxiu.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1627028788&t=26e4bc5dcd05b65744c26924cd7e5047",@"https://img1.baidu.com/it/u=2917893129,3433599284&fm=26&fmt=auto&gp=0.jpg",nil];
    
   // self.navigationItem.title = @"????????????";
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, iPhoneX?88:64)];
    headerView.backgroundColor = ColorMaker(244, 244, 244, 255);
    [self.view addSubview:headerView];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setImage:[UIImage imageNamed:@"back"] forState:0];
    cancelBtn.frame = CGRectMake(10, 2+(iPhoneX?44:20), 40, 40);
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [cancelBtn addTarget:self action:@selector(clickBackVC:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:cancelBtn];
    
    UILabel *ttLab = [[UILabel alloc]initWithFrame:CGRectMake(0, iPhoneX?44:20, kScreenWidth, 44)];
    ttLab.text =  @"????????????";
    ttLab.textColor = textMinorColor33;
    ttLab.font = [UIFont systemFontOfSize:FontSize(18)];
    ttLab.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:ttLab];
    
    UIButton *yqsmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    yqsmBtn.frame = CGRectMake(kScreenWidth - 85, iPhoneX?44:20, 80, 44);
    [yqsmBtn setTitle:@"????????????" forState:0];
    [yqsmBtn setTitleColor:kUIColorFromRGB(0x343434) forState:0];
    yqsmBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize(15)];
    [yqsmBtn addTarget:self action:@selector(clickInviteDetail:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:yqsmBtn];
    
    

    
    
    self.view.backgroundColor = ColorMaker(244, 244, 244, 255);
    
    //*************
    UIImageView *downView = [[UIImageView alloc]init];
    downView.image = [UIImage imageNamed:@"invite_down.png"];
    downView.userInteractionEnabled = YES;
    [self.view addSubview:downView];
    
    [downView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.view.mas_bottom).offset(iPhoneX?0:0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(96+(iPhoneX?34:0));
    }];
    

    
    UIButton *sharePosterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sharePosterBtn.frame = CGRectMake(kScreenWidth - 115 - 46*BiLi, 40, 115, 44);
    [sharePosterBtn setBackgroundImage:[UIImage imageNamed:@"invite_shareHaiBaoBack"] forState:0];
    [sharePosterBtn setTitle:@"????????????" forState:0];
    [sharePosterBtn setTitleColor:textMinorColor33 forState:0];
    [sharePosterBtn setImage:[UIImage imageNamed:@"invite_shareHaiBao"] forState:0];
    sharePosterBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    //?????????????????????????????????   ???
    sharePosterBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    //?????????????????? ???>?????????  35
    [sharePosterBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 6, 0, 0)];
    //?????????????????? ???>?????????  30
    sharePosterBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -6, 0, 0);
    sharePosterBtn.userInteractionEnabled = YES;
    [sharePosterBtn addTarget:self action:@selector(clickSharePosterButtonOnShareInviteVC:) forControlEvents:UIControlEventTouchUpInside];
    [downView addSubview:sharePosterBtn];
    
    
    UIButton *shareAppBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareAppBtn.frame = CGRectMake(46*BiLi, 40, 115, 44);
    [shareAppBtn setBackgroundImage:[UIImage imageNamed:@"invite_shareLinkBack"] forState:0];
    [shareAppBtn setTitle:@"????????????" forState:0];
    [shareAppBtn setTitleColor:[UIColor whiteColor] forState:0];
    [shareAppBtn setImage:[UIImage imageNamed:@"invite_shareLink"] forState:0];
    shareAppBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    //?????????????????????????????????   ???
    shareAppBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    //?????????????????? ???>?????????  35
    [shareAppBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 6, 0, 0)];
    //?????????????????? ???>?????????  30
    shareAppBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -6, 0, 0);
     [shareAppBtn addTarget:self action:@selector(clickShareAppButtonOnShareInviteVC:) forControlEvents:UIControlEventTouchUpInside];
    [downView addSubview:shareAppBtn];
    
    
    UIView *posterView = [[UIView alloc]init];
    posterView.backgroundColor = ColorMaker(244, 244, 244, 255);
    [self.view addSubview:posterView];
    
    [posterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(10+(iPhoneX?88:64));
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.bottom.equalTo(downView.mas_top).offset(0);
    }];
    
    
    
    
  
//    [YJProgressHUD showCustomAnimation:@"?????????" withImgArry:nil inview:kWindow];
    
    // **********
    
    [NetWorkManager  requestWithType:1 withUrlString:kURLWithAppShare withParaments:nil withSuccessBlock:^(NSDictionary *responseObject) {
        
        DMLog(@"??????????????? =  %@",  responseObject);
        
        NSString *result = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
        
        if ([result isEqualToString:@"2"]) {
            
            
            self.shareUrl = [NSString stringWithFormat:@"https://img1.baidu.com/it/u=2917893129,3433599284&fm=26&fmt=auto&gp=0.jpg"];
//            self.inviteNum = [NSString stringWithFormat:@"%@", responseObject[@"extensionid"]];
            
            
            NSArray *posterdataArr = (NSArray *)responseObject[@"posterdata"];

            YMPosterdataItem *dataItem = [YMPosterdataItem mj_objectWithKeyValues:responseObject];
            for (YMPosterdata *data in dataItem.posterdata) {
                [self.dataArr addObject:data];
                [_imgNewArr addObject:[UIImage imageNamed:@"onecell"]];
            }
            
           
            
            NSMutableArray *arr = [NSMutableArray array];
            
            for (int i = 0; i < posterdataArr.count ;i ++) {
                NSDictionary *urlDic = posterdataArr[i];
                NSString *imgUrl = [NSString stringWithFormat:@"%@", self.dataArr];
                [arr addObject:imgUrl];
            }
            
         //   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                DCCycleScrollView *banner = [DCCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 10+(iPhoneX?40:0), kScreenWidth, DMInt(464*BiLi)) shouldInfiniteLoop:YES imageGroups:self.dataArr];
               
                banner.erStr = self.shareUrl;
                banner.inviteNum = self.inviteNum;
                banner.autoScroll = NO;
                banner.isZoom = YES;
                banner.itemSpace = 0;
                banner.imgCornerRadius = 7;
                banner.itemWidth = DMInt(260*BiLi);
                banner.delegate = self;
                banner.bannerImageViewContentMode = 1;
                [posterView addSubview:banner];
                
         //   });
            
//                [YJProgressHUD hide];

            
        }
//        else{
//
//            [YJProgressHUD hide];
//            [[YXAlertView shareInstance] showAlert:@"????????????" message:responseObject[@"msgstr"] cancelTitle:nil titleArray:nil viewController:self confirm:^(NSInteger buttonTag) {
//                [self.navigationController popViewControllerAnimated:YES];
//            }];
//
//        }
        
    } withFailureBlock:^(NSError *error) {
//        [YJProgressHUD hide];
    } progress:^(float progress) {
        
    }];
    
    
    
}





- (void)clickBackButton{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickInviteDetail:(UIButton *)sender{
    //????????????
    PopView *popView = [[PopView alloc]init];
    [popView setUpDailyRedGuiZeWithStr:@"123"];
    [self.view addSubview:popView];
}


//?????????????????????
-(void)cycleScrollView:(DCCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
}

- (void)cycleScrollView:(DCCycleScrollView *)cycleScrollView scrollItemAtIndex:(NSInteger)index image:(UIImage *)image{
    
    if (image) {
        self.shareImgeArr = [NSMutableArray arrayWithObject:image];
    }
    
    self.posterData = self.dataArr[index];
}



-(UIImage *)CSImage:(UIImage *)img AddText:(NSString *)text index:(NSUInteger )index
{
    
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 375, 667)];
    imageView.image = img;
    
    
    UIView *erView = [[UIView alloc]initWithFrame:CGRectMake(125, 451, 129, 129)];
    erView.backgroundColor = [UIColor whiteColor];
    erView.layer.masksToBounds = YES;
    erView.layer.cornerRadius = 8.0f;
    [imageView addSubview:erView];
    
    
    
    
    //??????????????????
    UIImage *erImg =  [YMInvitationViewController qrImageForString:[NSString stringWithFormat:@"%@", self.shareUrl] imageSize:77 logoImageSize:0];
    UIImageView *erImgView = [[UIImageView alloc]initWithFrame:CGRectMake(12, 12 , 104, 104)];
    erImgView.image = erImg;
    [erView addSubview:erImgView];
    
    UILabel *ttLab = [[UILabel alloc]initWithFrame:CGRectMake(125, 451+129+6, 129, 20)];
    ttLab.text = @"?????? ????????? ??????";
    ttLab.textColor = [UIColor whiteColor];
    ttLab.font = [UIFont systemFontOfSize:17];
    ttLab.textAlignment = NSTextAlignmentCenter;
    ttLab.adjustsFontSizeToFitWidth = YES;
    [imageView addSubview:ttLab];
    
    UILabel *inviteNumLab = [[UILabel alloc]initWithFrame:CGRectMake(141, 451+129+6+20+6, 99, 24)];
    inviteNumLab.text = [NSString stringWithFormat:@"%@",self.inviteNum];
    inviteNumLab.backgroundColor = [UIColor whiteColor];
    inviteNumLab.textColor = textMinorColor33;
    inviteNumLab.font = [UIFont systemFontOfSize:17];
    inviteNumLab.textAlignment = NSTextAlignmentCenter;
    inviteNumLab.adjustsFontSizeToFitWidth = YES;
    inviteNumLab.layer.masksToBounds = YES;
    inviteNumLab.layer.cornerRadius = 12;
    [imageView addSubview:inviteNumLab];
    
    
    
    return [self convertViewToImage:imageView];
    
    
}

+ (UIImage *)qrImageForString:(NSString *)string imageSize:(CGFloat)Imagesize logoImageSize:(CGFloat)waterImagesize{
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];//??????kvo??????????????????????????????????????????
    [filter setValue:@"M" forKey:@"inputCorrectionLevel"];//???????????????????????????????????????????????????????????????????????????????????????
    CIImage *outPutImage = [filter outputImage];//?????????????????????
    return [[self alloc] createNonInterpolatedUIImageFormCIImage:outPutImage withSize:Imagesize waterImageSize:waterImagesize];
}

- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size waterImageSize:(CGFloat)waterImagesize{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.??????bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    //????????????DeviceGray????????????
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    //CGBitmapContextCreate(void * _Nullable data, size_t width, size_t height, size_t bitsPerComponent, size_t bytesPerRow, CGColorSpaceRef  _Nullable space, uint32_t bitmapInfo)
    //width?????????????????????
    //height?????????????????????
    //bitsPerComponent???????????????????????????????????????rgba-32????????????8
    //bitmapInfo????????????????????????????????????alpha?????????
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    //??????CoreGraphics image
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.??????bitmap?????????
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef); CGImageRelease(bitmapImage);
    
    //??????
    UIImage *outputImage = [UIImage imageWithCGImage:scaledImage];
    //??????????????? logo ???
    UIGraphicsBeginImageContextWithOptions(outputImage.size, NO, [[UIScreen mainScreen] scale]);
    [outputImage drawInRect:CGRectMake(0,0 , size, size)];
    //    //logo???
    //    UIImage *waterimage = [UIImage imageNamed:@"icon_imgApp"];
    //    //???logo???????????????????????????????????????????????????????????????????????????????????????????????????%30?????????????????????????????????
    //    [waterimage drawInRect:CGRectMake((size-waterImagesize)/2.0, (size-waterImagesize)/2.0, waterImagesize, waterImagesize)];
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newPic;
}



-(UIImage*)convertViewToImage:(UIView*)v
{
    CGSize s = v.bounds.size;
    
    
    
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [v.layer renderInContext:context];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    v.layer.contents = nil;
    return image;
    
}


//????????????
- (void)clickSharePosterButtonOnShareInviteVC:(UIButton *)sender{
    
   
    if (self.shareImgeArr.count > 0) {
        
//        [YJProgressHUD showCustomAnimation:@"?????????" withImgArry:nil inview:kWindow];
//
//        [YJProgressHUD hide];
        
        [TSShareHelper shareWithType:0 andController:self andItems:self.shareImgeArr andCompletion:^(TSShareHelper *shareHelper, BOOL success) {
            
        }];
     
       
        
    }
    
    else{
        
        [[YXAlertView shareInstance] showAlert:@"????????????" message:@"?????????????????????????????????" cancelTitle:nil titleArray:nil viewController:self confirm:^(NSInteger buttonTag) {
            
        }];
        
        
    }
    

}

//??????app
- (void)clickShareAppButtonOnShareInviteVC:(UIButton *)sender{
    
    [self shareApp];
    
    
    
}


- (void)shareApp{
    
    
//      [TouchTool shareToWxWithShareType:@"shareMessage" title:@"???????????????????????????" description:@"?????????????????????????????????????????????????????????????????????1?????????????????????1????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????" image:[UIImage imageNamed:@"DM_login.png"] url:self.shareUrl vc:self nav:self.navigationController requestType:@""];
    
    
    
}



- (void)clickOneShareViewOnMyPosterVC:(UIGestureRecognizer *)sender{
    
    
    [TSShareHelper shareWithType:0 andController:self andItems:self.shareImgeArr andCompletion:^(TSShareHelper *shareHelper, BOOL success) {
        
    }];
    
    
}

//???????????????
- (void)clickInviteButtonCopyInviteNum:(UIButton *)sender{
    DMLog(@"ddddddd");
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = [NSString stringWithFormat:@"%@", self.inviteNum ? self.inviteNum:([[NSUserDefaults standardUserDefaults] objectForKey:@"extensionid"]?[[NSUserDefaults standardUserDefaults] objectForKey:@"extensionid"]:@"")];

 
//    [YJProgressHUD showMsgWithMsgStr:@"????????????" imageName:@"copy_success.png" inview:self.view afterDelayTime:1.5];
}



@end
