//
//  KeFuSetViewController.m
//  DaiMengJia
//
//  Created by 呆萌价 on 2017/12/5.
//  Copyright © 2017年 呆萌价. All rights reserved.
//

#import "KeFuSetViewController.h"
#import "DMTool.h"
//#import "AFNetworking.h"
#import "YXAlertView.h"
//#import "NetWorkManager.h"
#import "UIImageView+WebCache.h"
@interface KeFuSetViewController ()<UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *tipLab;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topHeight;


@property (weak, nonatomic) IBOutlet UITextField *kfNumTF;
@property (strong, nonatomic) UIImage *kfImage;
@property (copy, nonatomic) NSString *wxNum;
@property (copy, nonatomic) NSString *wxImgStr;
@end

@implementation KeFuSetViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)clickBackButtonView:(UIGestureRecognizer *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = ColorMaker(244, 244, 244, 255);
    
   
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, iPhoneX?88:64)];
    headerView.backgroundColor = ColorMaker(244, 244, 244, 255);
    [self.view addSubview:headerView];
    
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setImage:[UIImage imageNamed:@"back"] forState:0];
    cancelBtn.frame = CGRectMake(10, 2+(iPhoneX?44:20), 40, 40);
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [cancelBtn addTarget:self action:@selector(clickBackButtonView:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:cancelBtn];
    

    UILabel *ttLab = [[UILabel alloc]initWithFrame:CGRectMake(0, iPhoneX?44:20, kScreenWidth, 44)];
    ttLab.text = self.type;
    ttLab.textColor = textMinorColor33;
    ttLab.font = [UIFont systemFontOfSize:FontSize(18)];
    ttLab.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:ttLab];
    self.view.backgroundColor = ColorMaker(244, 244, 244, 255);
    
    
    self.kfNumTF.delegate = self;
    _kfNumTF.returnKeyType = UIReturnKeyDone;
//    _kfNumTF.backgroundColor = kUIColorFromRGB(0xEEEEEE);
    _kfNumTF.textColor = textMinorColor33;
    _kfNumTF.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
    _kfNumTF.leftViewMode = UITextFieldViewModeAlways;
    
  
    if ([self.type isEqualToString:@"客服设置"]) {
        _kfNumTF.placeholder = @"请输入您要作为客服的微信号";
        self.tipLab.text = @"注意：设置成功后，该微信号将通过专属客服页面展示给您的下级，方便下级与您取得联系；若不设置，则默认显示合伙人的客服微信号";
    }
    else if ([self.type isEqualToString:@"填写微信号"]){
        _kfNumTF.placeholder = @"请填写微信号";
        self.tipLab.text = @"注意：与呆萌价业务或品牌冲突的昵称，呆萌价将有权收回";
    }
    self.tipLab.textColor = textMinorColor99;
    self.tipLab.font = [UIFont systemFontOfSize:FontSize(14)];
    self.tipLab.numberOfLines = 0;

   // self.view.backgroundColor = [UIColor yellowColor];
    // 获取客服设置
    self.topHeight.constant = iPhoneX?58:58;
    if (@available(iOS 11.0, *)) {
        
    } else {
        //  self.automaticallyAdjustsScrollViewInsets = NO;
        self.topHeight.constant = iPhoneX?58:78;
    }

//
    
    self.sureBtn.backgroundColor = kUIColorFromRGB(0xDBDBDB);
    [self.sureBtn setTitleColor:textMinorColor99 forState:0];
    
     [self.kfNumTF addTarget:self action:@selector(textFiledChanged:) forControlEvents:UIControlEventEditingChanged];
    
    
}



- (void)textFiledChanged:(UITextField *)tf{
    
    if (tf.text.length > 0) {
        self.sureBtn.backgroundColor = kUIColorFromRGB(0xFC0F3C);
        [self.sureBtn setTitleColor:[UIColor whiteColor] forState:0];
    }
    
}


- (IBAction)clickSureButtonOnSetKfVC:(UIButton *)sender {
    
//    if ([self.type isEqualToString:@"客服设置"]) {
//
//        if (self.kfNumTF.text.length == 0) {
//            [[YXAlertView shareInstance] showAlert:@"温馨提示" message:@"请输入微信号" cancelTitle:nil titleArray:nil viewController:self confirm:^(NSInteger buttonTag) {
//
//            }];
//            return;
//        }
//
//
//        NSDictionary *urlDic = @{
//
//                                 @"wxcode":self.kfNumTF.text,
//                                 @"wxqrcode":@"",
//
//                                 };
//
//        [NetWorkManager  requestWithType:1 withUrlString:kURLWithSetCustomServer withParaments:urlDic withSuccessBlock:^(NSDictionary *responseObject) {
//
//            DMLog(@"客服设置 =  %@ %@",  responseObject, responseObject[@"msgstr"]);
//            if ([[NSString stringWithFormat:@"%@", responseObject[@"result"]] isEqualToString:@"1"]) {
//                [[YXAlertView shareInstance] showAlert:@"温馨提示" message:@"设置成功" cancelTitle:nil titleArray:nil viewController:self confirm:^(NSInteger buttonTag) {
//                    [self.navigationController popViewControllerAnimated:YES];
//                }];
//
//            }
//
//            else{
//
//                [[YXAlertView shareInstance] showAlert:@"温馨提示" message:responseObject[@"msgstr"] cancelTitle:nil titleArray:nil viewController:self confirm:^(NSInteger buttonTag) {
//                }];
//
//            }
//
//        } withFailureBlock:^(NSError *error) {
//
//        } progress:^(float progress) {
//
//        }];
//
//
//    }
//    else if ([self.type isEqualToString:@"修改昵称"]){
//
//        if (self.kfNumTF.text.length == 0) {
//
//            [[YXAlertView shareInstance] showAlert:@"温馨提示" message:@"请输入用户名" cancelTitle:nil titleArray:nil viewController:self confirm:^(NSInteger buttonTag) {
//            }];
//        }
//        else{
//
//            NSDictionary *urlDic = @{
//
//                                     @"userpicurl":@"",
//                                     @"username":self.kfNumTF.text,
//                                     };
//
//            //修改个人资料，此处只做修改 头像
//            [NetWorkManager  requestWithType:1 withUrlString:kURLWithUserInfoEdit withParaments:urlDic withSuccessBlock:^(NSDictionary *responseObject) {
//
//                DMLog(@"用户名设置 =  %@ %@",  responseObject, responseObject[@"msgstr"]);
//                if ([[NSString stringWithFormat:@"%@", responseObject[@"result"]] isEqualToString:@"1"]) {
//
//
//                    [[YXAlertView shareInstance] showAlert:@"温馨提示" message:@"设置成功" cancelTitle:nil titleArray:nil viewController:self confirm:^(NSInteger buttonTag) {
//                           [self.navigationController popViewControllerAnimated:YES];
//                    }];
//
//                }
//
//                else{
//
//                    [[YXAlertView shareInstance] showAlert:@"温馨提示" message:responseObject[@"msgstr"] cancelTitle:nil titleArray:nil viewController:self confirm:^(NSInteger buttonTag) {
//                    }];
//
//                }
//
//            } withFailureBlock:^(NSError *error) {
//
//            } progress:^(float progress) {
//
//            }];
//
//        }
//
//    }
    
    
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.kfNumTF resignFirstResponder];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.kfNumTF resignFirstResponder];
    return YES;
}

@end
