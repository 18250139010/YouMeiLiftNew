//
//  ViewController.m
//  有美生活
//
//  Created by mac on 2021/6/22.
//

#import "ViewController.h"
#import "FLAnimatedImageView+WebCache.h"

@interface ViewController ()
@property (strong, nonatomic) UIView *searchView;
@property (strong, nonatomic) UIImageView *searchImgView11;
@property (strong, nonatomic) UILabel *searchTTLab11;
@property (strong, nonatomic) UIImageView *searchImgView22;
@property (strong, nonatomic) UILabel *searchTTLab22;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self SetupView];
    
}
-(void)SetupView{
    UIView *homeView=[[UIView alloc]initWithFrame:CGRectMake(0,0 , WIDTH, 200)];
    homeView.backgroundColor=[UIColor redColor];
    [self.view addSubview:homeView];
    

    //金币
    FLAnimatedImageView *dmbImgView = [[FLAnimatedImageView alloc] initWithFrame:CGRectMake(kScreenWidth-40, 7+(iPhoneX?44:20), 30, 30)];
    [dmbImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://dmjvip.oss-cn-shenzhen.aliyuncs.com/dmj/mengbi.gif"]] placeholderImage:[UIImage imageNamed:@"onecell.png"]];


    UITapGestureRecognizer *dmbTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clicklxkfButtonOnHomeVC:)];
    [dmbImgView addGestureRecognizer: dmbTap];
    dmbImgView.userInteractionEnabled = YES;
    [homeView addSubview:dmbImgView];
    


    //搜索框
    self.searchView = [[UIView alloc]init];
    _searchView.frame = CGRectMake(10, 5.5+(iPhoneX?44:20), kScreenWidth - 10-40, 32);
    _searchView.backgroundColor =kUIColorFromRGB(0xFFFFFF);
    _searchView.layer.masksToBounds = YES;
    _searchView.layer.cornerRadius = 16.0f;
    
    UITapGestureRecognizer *searchTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickSearchButtonOnHomeVC:)];
    _searchView.userInteractionEnabled = YES;
    [_searchView addGestureRecognizer:searchTap];
    [homeView addSubview:_searchView];
    
    self.searchImgView11 = [[UIImageView alloc]initWithFrame:CGRectMake(10+13, 15+(iPhoneX?44:20), 13, 13)];
    _searchImgView11.image = [UIImage imageNamed:@"home_newSearch_light.png"];
    _searchImgView11.alpha = 1;
    [homeView addSubview:_searchImgView11];
    
    
    self.searchTTLab11 = [[UILabel alloc]initWithFrame:CGRectMake(10+13+20, 15+(iPhoneX?44:20), kScreenWidth - 60, 13)];
    _searchTTLab11.text = @"搜商品标题 领优惠券拿返现";
    _searchTTLab11.font = [UIFont systemFontOfSize:13];
    _searchTTLab11.textColor = textMinorColor;
    _searchTTLab11.alpha = 1;
    [homeView addSubview:_searchTTLab11];
       

    
    
    
}

@end
