//
//  YMHomeViewController.m
//  有美生活
//
//  Created by mac on 2021/6/22.
//

#import "YMHomeViewController.h"
#import "FLAnimatedImageView+WebCache.h"
#import "YXScrollView.h"
#import "YXScrollViewZero.h"
#import "DDGBannerScrollView.h"
#import "WMPageController.h"
#import "RankListVC.h"
#import <Masonry.h>
#import "YMSearchViewController.h"
#import "YXAlertView.h"
#import "YMScrollView.h"
#import "COINSViewController.h"
@interface YMHomeViewController ()<UIScrollViewDelegate,DDGBannerScrollViewDelegate, WMPageControllerDataSource,WMPageControllerDelegate>
{
    CGFloat jgScrollWidth;
}
@property (strong, nonatomic) UIView *searchView;
@property (strong, nonatomic) UIImageView *searchImgView11;
@property (strong, nonatomic) UILabel *searchTTLab11;
@property (strong, nonatomic) UIImageView *searchImgView22;
@property (strong, nonatomic) UILabel *searchTTLab22;
@property (strong, nonatomic)  UIScrollView *oneScrollView;
@property (nonatomic, strong) WMPageController *pageController;

@property (strong, nonatomic) NSArray *titleArr;
@property (strong, nonatomic) NSArray *oneIDArr;

@property (strong, nonatomic)UIView *pageView;
@property (strong, nonatomic)UIView *contentView;
@property (nonatomic ,strong)DDGBannerScrollView *bannerScrollView;
@property (strong, nonatomic)UIScrollView  *jgScrollView;

@end

@implementation YMHomeViewController

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

- (UIView *)contentView {
    if (!_contentView) {
        self.contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor clearColor];
    }
    return _contentView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=allBackgroundColor;
    
    
   
    //搜索框
    [self SetupView];
    
    [self scrollerView];
    
   
}
- (NSArray *)titleArr{
    if (!_titleArr) {
        self.titleArr = @[@"精选", @"猜你喜欢", @"女装", @"美妆", @"美食", @"男装", @"居家日用", @"女鞋", @"男鞋", @"箱包", @"数码家电", @"母婴", @"配饰", @"内衣", @"文娱车品.", @"户外运动"];
    }
    return _titleArr;
}

- (NSArray *)oneIDArr{
    if (!_oneIDArr) {
        self.oneIDArr = @[@"11", @"101", @"1", @"4", @"9", @"2", @"8", @"6", @"16", @"14", @"10", @"7", @"5", @"3", @"12", @"13"];
    }
    return _oneIDArr;
}
- (WMPageController *)pageController {
    
    if (!_pageController) {
        _pageController = [[WMPageController alloc] initWithViewControllerClasses:@[[RankListVC class],[RankListVC class],[RankListVC class]] andTheirTitles:@[@"tab1",@"tab2",@"tab3"]];
        _pageController.selectIndex=0;
        _pageController.delegate = self;
        _pageController.dataSource = self;
        _pageController.view.backgroundColor = [UIColor clearColor];
    }
    return _pageController;
    
}
#pragma mark 搜索栏下模块

-(void)scrollerView{
    
#pragma mark 整体ScrollView
    self.oneScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, iPhoneX?90:66, kScreenWidth, kScreenHeight- (iPhoneX?90:66)-(iPhoneX?83:49) )];
    _oneScrollView.backgroundColor = [UIColor clearColor];
    _oneScrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight- (iPhoneX?90:66)-(iPhoneX?83:49)+132.5*BiLi+180*BiLi+74*BiLi);
    _oneScrollView.delegate = self;
    _oneScrollView.scrollEnabled = YES;
    _oneScrollView.showsVerticalScrollIndicator = YES;
    _oneScrollView.showsHorizontalScrollIndicator = YES;
    _oneScrollView.userInteractionEnabled=YES;
   [self.view addSubview:_oneScrollView];
    
    #pragma mark banner区

    
    NSMutableArray *array1 = [NSMutableArray arrayWithObjects:
                             @"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fwx1.sinaimg.cn%2Flarge%2F008fHVgdly4gqfhftvhl5j30u00iv40g.jpg&refer=http%3A%2F%2Fwx1.sinaimg.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1627028752&t=eadfa6c42d5eebb9b76828047ee51d0b",@"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimgres.quxiu.com%2Fquxiu%2F341%2F1703972-2021052312100560a9d59d41f11.jpg&refer=http%3A%2F%2Fimgres.quxiu.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1627028788&t=26e4bc5dcd05b65744c26924cd7e5047",@"https://img1.baidu.com/it/u=2917893129,3433599284&fm=26&fmt=auto&gp=0.jpg",nil];
    CGRect frame = CGRectMake(10, 0, kScreenWidth - 20, 132.5*BiLi);
    self.bannerScrollView = [DDGBannerScrollView cycleScrollViewWithFrame:frame delegate:self placeholderImage:[[YXAlertView shareInstance] CSPlaceholderImageWithWidth:kScreenWidth - 20 height:132.5*BiLi]];
    self.bannerScrollView.imageURLStringsGroup = array1;
     
    self.bannerScrollView.backgroundColor = [UIColor clearColor];
    self.bannerScrollView.pageControlAliment = DDGBannerScrollViewPageContolAlimentCenter;
    self.bannerScrollView.pageControlStyle = DDGBannerScrollViewPageControlHorizontal;
    self.bannerScrollView.pageDotColor = UIColor.whiteColor;
    self.bannerScrollView.currentPageDotColor = [UIColor yellowColor];
            self.bannerScrollView.layer.masksToBounds = YES;
            self.bannerScrollView.layer.cornerRadius = 7.0f;
    self.bannerScrollView.autoScrollTimeInterval = 4.5;
    self.bannerScrollView.pageControlBottomOffset = -5;
    self.bannerScrollView.pageControlRightOffset = -10;
    self.bannerScrollView.tag = 666;
    self.bannerScrollView.userInteractionEnabled = YES;
    
     [_oneScrollView addSubview:self.bannerScrollView];
    
    
    
#pragma mark 金刚区
    NSMutableArray *jgOneArr = [NSMutableArray arrayWithObjects:
                             @"https://img1.baidu.com/it/u=2917893129,3433599284&fm=26&fmt=auto&gp=0.jpg",@"https://img1.baidu.com/it/u=2917893129,3433599284&fm=26&fmt=auto&gp=0.jpg",@"https://img1.baidu.com/it/u=2917893129,3433599284&fm=26&fmt=auto&gp=0.jpg",@"https://img1.baidu.com/it/u=2917893129,3433599284&fm=26&fmt=auto&gp=0.jpg",@"https://img1.baidu.com/it/u=2917893129,3433599284&fm=26&fmt=auto&gp=0.jpg",@"https://img1.baidu.com/it/u=2917893129,3433599284&fm=26&fmt=auto&gp=0.jpg",@"https://img1.baidu.com/it/u=2917893129,3433599284&fm=26&fmt=auto&gp=0.jpg",@"https://img1.baidu.com/it/u=2917893129,3433599284&fm=26&fmt=auto&gp=0.jpg",@"https://img1.baidu.com/it/u=2917893129,3433599284&fm=26&fmt=auto&gp=0.jpg",@"https://img1.baidu.com/it/u=2917893129,3433599284&fm=26&fmt=auto&gp=0.jpg",@"https://img1.baidu.com/it/u=2917893129,3433599284&fm=26&fmt=auto&gp=0.jpg",@"https://img1.baidu.com/it/u=2917893129,3433599284&fm=26&fmt=auto&gp=0.jpg",nil];
    
    
    UIView *zjView=[[UIView alloc]initWithFrame:CGRectMake(0, 132.5*BiLi+10, kScreenWidth, 180*BiLi)];
    zjView.backgroundColor=[UIColor whiteColor];
    [_oneScrollView addSubview:zjView];
    
    self.jgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 168*BiLi)];
    self.jgScrollView.delegate = self;
    self.jgScrollView.scrollEnabled = YES;
    self.jgScrollView.showsHorizontalScrollIndicator = NO;
    zjView.userInteractionEnabled = YES;
    [zjView addSubview:self.jgScrollView];
    
    UIView *pageBackView = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth - 28)/2.0, 166*BiLi, 28, 3)];
    pageBackView.backgroundColor = kUIColorFromRGB(0xE4E4E4);
    pageBackView.layer.masksToBounds = YES;
    pageBackView.layer.cornerRadius = 1;
    [zjView addSubview:pageBackView];
    
    self.pageView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 14, 3)];
    self.pageView.backgroundColor = kUIColorFromRGB(0xFCBF54);
    self.pageView.layer.masksToBounds = YES;
    self.pageView.layer.cornerRadius = 1;
    [pageBackView addSubview:self.pageView];
    
    
    
    jgScrollWidth=  27*BiLi + (53*BiLi+21*BiLi)*jgOneArr.count - 21*BiLi;
    for (int i = 0; i <jgOneArr.count; i ++) {
        UIView *newOneView = [[UIView alloc]initWithFrame:CGRectMake(13.5*BiLi + (53*BiLi+21*BiLi)*i, 6*BiLi, 53*BiLi, 78*BiLi)];
        
        [self.jgScrollView addSubview:newOneView];
        
        FLAnimatedImageView *oneImgView = [[FLAnimatedImageView alloc] initWithFrame:CGRectMake(0, 0, 53*BiLi, 53*BiLi)];
        [newOneView addSubview:oneImgView];
        
        UILabel *oneTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 55*BiLi, 53*BiLi, 14*BiLi)];
        oneTitleLabel.font = [UIFont systemFontOfSize:FontSize(12)];
        oneTitleLabel.textAlignment = NSTextAlignmentCenter;
        oneTitleLabel.textColor = textMinorColor33;
        [newOneView addSubview:oneTitleLabel];
        
        
          NSDictionary *oneDict = jgOneArr[i];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://img1.baidu.com/it/u=2917893129,3433599284&fm=26&fmt=auto&gp=0.jpg"]];
        [oneImgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"onecell.png"]];
        oneTitleLabel.text = [NSString stringWithFormat:@"123"];
        newOneView.tag = 676+i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapOneView:)];
        [newOneView addGestureRecognizer:tap];
        
        
    }
    
    self.jgScrollView.contentSize = CGSizeMake(27*BiLi + (53*BiLi+21*BiLi)*jgOneArr.count - 21*BiLi, 168*BiLi);
    
    for (int i = 0; i < jgOneArr.count; i ++) {
        
        UIView *newOneView = [[UIView alloc]initWithFrame:CGRectMake(13.5*BiLi + (53*BiLi+21*BiLi)*i, 90*BiLi, 53*BiLi, 78*BiLi)];
        [self.jgScrollView addSubview:newOneView];
        FLAnimatedImageView *oneImgView = [[FLAnimatedImageView alloc] initWithFrame:CGRectMake(0, 0, 53*BiLi, 53*BiLi)];
        [newOneView addSubview:oneImgView];
        
        
        UILabel *oneTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 55*BiLi, 53*BiLi, 14*BiLi)];
        oneTitleLabel.font = [UIFont systemFontOfSize:FontSize(12)];
        oneTitleLabel.textAlignment = NSTextAlignmentCenter;
        oneTitleLabel.textColor = textMinorColor33;
        [newOneView addSubview:oneTitleLabel];
        
        
       NSDictionary *oneDict = jgOneArr[i];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://img1.baidu.com/it/u=2917893129,3433599284&fm=26&fmt=auto&gp=0.jpg"]];
        [oneImgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"onecell.png"]];
        oneTitleLabel.text = [NSString stringWithFormat:@"456"];
        newOneView.tag = 676+i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapTwoView:)];
        [newOneView addGestureRecognizer:tap];
    }
    

    
#pragma mark banner区
    NSMutableArray *array = [NSMutableArray arrayWithObjects:
                             @"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fwx1.sinaimg.cn%2Flarge%2F008fHVgdly4gqfhftvhl5j30u00iv40g.jpg&refer=http%3A%2F%2Fwx1.sinaimg.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1627028752&t=eadfa6c42d5eebb9b76828047ee51d0b",@"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimgres.quxiu.com%2Fquxiu%2F341%2F1703972-2021052312100560a9d59d41f11.jpg&refer=http%3A%2F%2Fimgres.quxiu.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1627028788&t=26e4bc5dcd05b65744c26924cd7e5047",@"https://img1.baidu.com/it/u=2917893129,3433599284&fm=26&fmt=auto&gp=0.jpg",nil];
    CGRect framm = CGRectMake(10, 132.5*BiLi+198, kScreenWidth - 20, 74*BiLi);
    DDGBannerScrollView *goodsPageView = [DDGBannerScrollView cycleScrollViewWithFrame:framm delegate:self placeholderImage:[[YXAlertView shareInstance] CSPlaceholderImageWithWidth:kScreenWidth - 20 height:74*BiLi]];
       goodsPageView.imageURLStringsGroup = array;
     
     goodsPageView.backgroundColor = [UIColor clearColor];
     goodsPageView.pageControlAliment = DDGBannerScrollViewPageContolAlimentCenter;
     goodsPageView.pageControlStyle = DDGBannerScrollViewPageControlHorizontal;
     goodsPageView.pageDotColor = UIColor.whiteColor;
     goodsPageView.currentPageDotColor = DMColor;
     goodsPageView.autoScrollTimeInterval = 4.5;
     goodsPageView.pageControlBottomOffset = -5;
     goodsPageView.pageControlRightOffset = -10;
     goodsPageView.tag = 5151;
     goodsPageView.userInteractionEnabled = YES;
    
     [_oneScrollView addSubview:goodsPageView];
    
    
    
    
#pragma mark 猜你喜欢
 

    
    UIView *contentView = [UIView new];
    contentView.frame = CGRectMake(0,132.5*BiLi+198+74*BiLi, kScreenWidth, kScreenHeight - (iPhoneX?80:64));
    contentView.backgroundColor = allBackgroundColor;
    [_oneScrollView addSubview:contentView];
    
    
    [contentView addSubview:_contentView];
    
    UIView *contentTwoView=[[UIView alloc]init];
    contentTwoView.frame=CGRectMake(10, 132.5*BiLi+198+74*BiLi+40, kScreenWidth-20, 74);
    contentTwoView.backgroundColor=[UIColor whiteColor];
    contentTwoView.layer.masksToBounds = YES;
    contentTwoView.layer.cornerRadius = 7.0f;
    [_oneScrollView addSubview:contentTwoView];
    
    
    for (int i = 0; i < 6; i ++) {
        UIView *newOneView = [[UIView alloc]initWithFrame:CGRectMake(5*BiLi + (35*BiLi+26*BiLi)*i, 5*BiLi, 35*BiLi, 35*BiLi)];
        [contentTwoView addSubview:newOneView];
       
        FLAnimatedImageView *oneImgView = [[FLAnimatedImageView alloc] initWithFrame:CGRectMake(5, 5, 35*BiLi, 35*BiLi)];
        [newOneView addSubview:oneImgView];
        
        
        UILabel *oneTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 45*BiLi, 35*BiLi, 14*BiLi)];
        oneTitleLabel.font = [UIFont systemFontOfSize:FontSize(12)];
        oneTitleLabel.textAlignment = NSTextAlignmentCenter;
        oneTitleLabel.textColor = textMinorColor33;
        [newOneView addSubview:oneTitleLabel];
        
        
       NSDictionary *oneDict = jgOneArr[i];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://img1.baidu.com/it/u=2917893129,3433599284&fm=26&fmt=auto&gp=0.jpg"]];
        [oneImgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"onecell.png"]];
        oneTitleLabel.text = [NSString stringWithFormat:@"456"];
        newOneView.tag = 676+i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapTwoView:)];
        [newOneView addGestureRecognizer:tap];
    }
    
    //return;

   
    
    
    [contentView addSubview:self.pageController.view];
    
    
    
    
#pragma mark  悬浮Tab
    UIView *YMView=[[UIView alloc]initWithFrame:CGRectMake(10, kScreenHeight-156, 138, 40)];
    
    UIColor *color = [UIColor blackColor];
    color = [color colorWithAlphaComponent:0.8];
    YMView.backgroundColor = color;
    YMView.layer.cornerRadius = 8;
    YMView.layer.masksToBounds = YES;
    [self.view addSubview:YMView];
    

    UIButton *TabBtn=[[UIButton alloc]init];
    TabBtn.tag=101;
    [TabBtn setImage:[UIImage imageNamed:@"YMBuy"] forState:UIControlStateNormal];
    [TabBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [YMView addSubview:TabBtn];
    
    [TabBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(YMView.mas_top).offset(8);
        make.left.equalTo(YMView.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    
    UIView *XView=[[UIView alloc]init];
    XView.backgroundColor=[UIColor whiteColor];
    [YMView addSubview:XView];
    [XView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(YMView.mas_top).offset(8);
        make.left.equalTo(TabBtn.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(1, 25));
    }];
    
    UIButton *TabBtn1=[[UIButton alloc]init];
    TabBtn1.tag=102;
    [TabBtn1 setImage:[UIImage imageNamed:@"Message"] forState:UIControlStateNormal];
    [TabBtn1 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [YMView addSubview:TabBtn1];
    
    [TabBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(YMView.mas_top).offset(8);
        make.left.equalTo(XView.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    
    UIView *XView1=[[UIView alloc]init];
    XView1.backgroundColor=[UIColor whiteColor];
    [YMView addSubview:XView1];
    [XView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(YMView.mas_top).offset(8);
        make.left.equalTo(TabBtn1.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(1, 25));
    }];
    
    
    UIButton *TabBtn2=[[UIButton alloc]init];
    TabBtn2.tag=103;
    [TabBtn2 setImage:[UIImage imageNamed:@"YMShape"] forState:UIControlStateNormal];
    [TabBtn2 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [YMView addSubview:TabBtn2];
    
    [TabBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(YMView.mas_top).offset(8);
        make.left.equalTo(XView1.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    
}

#pragma mark -----ScrollView

- (void)cycleScrollView:(DDGBannerScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    DMLog(@"index 点击== %ld", (long)index);
    
}

- (void)cycleScrollView:(DDGBannerScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
   DMLog(@"index 滚动== %ld", (long)index);
  
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.pageView.frame = CGRectMake(self.jgScrollView.contentOffset.x*14 /(jgScrollWidth - kScreenWidth), 0, 14, 3);
}
 
#pragma mark -----弹窗Tab
-(void)buttonAction :(UIButton *)sender{
    NSLog(@"%ld",(long)sender.tag);
    
    
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
    _searchView.frame = CGRectMake(10, 5.5+(iPhoneX?44:20), kScreenWidth - 10-50, 32);
    _searchView.backgroundColor =kUIColorFromRGB(0xFFFFFF);
    _searchView.layer.masksToBounds = YES;
    _searchView.layer.cornerRadius = 16.0f;
    
    UITapGestureRecognizer *searchTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickSearchButtonOnHomeVC:)];
    _searchView.userInteractionEnabled = YES;
    [_searchView addGestureRecognizer:searchTap];
    [homeView addSubview:_searchView];
    
    self.searchImgView11 = [[UIImageView alloc]initWithFrame:CGRectMake(10+13, 15+(iPhoneX?44:20), 13, 13)];
    _searchImgView11.image = [UIImage imageNamed:@"YMSearch.png"];
    _searchImgView11.alpha = 1;
    [homeView addSubview:_searchImgView11];
    
    
    self.searchTTLab11 = [[UILabel alloc]initWithFrame:CGRectMake(10+13+20, 15+(iPhoneX?44:20), kScreenWidth - 60, 13)];
    _searchTTLab11.text = @"搜商品标题 领优惠券拿返现";
    _searchTTLab11.font = [UIFont systemFontOfSize:13];
    _searchTTLab11.textColor = textMinorColor;
    _searchTTLab11.alpha = 1;
    [homeView addSubview:_searchTTLab11];
       
    
}
//金币
- (void)clicklxkfButtonOnHomeVC:(UIGestureRecognizer *)sender{
    DMLog(@"金币");
    COINSViewController *jinbiVC=[[COINSViewController alloc]init];
    [self.navigationController pushViewController:jinbiVC animated:YES];
}
//搜索框
-(void)clickSearchButtonOnHomeVC:(UIGestureRecognizer *)sender{
    
    YMSearchViewController *searchVC = [[YMSearchViewController alloc]init];
    
    [self.navigationController pushViewController:searchVC animated:YES];
}
//金刚区第一行
-(void)OnTapOneView:(UIGestureRecognizer *)sender{
    DMLog(@"第一排%ld",sender.view.tag - 676);
}
//金刚区第二行
-(void)OnTapTwoView:(UIGestureRecognizer *)sender{
    DMLog(@"第二排%ld",sender.view.tag - 676);
}


#pragma mark -----WMP
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    
    pageController.menuViewStyle = WMMenuViewStyleLine;
    pageController.titleSizeSelected = FontSize(17);
    pageController.titleSizeNormal = FontSize(16);
    pageController.selectIndex=0;
    pageController.titleColorSelected = kUIColorFromRGB(0xFF0134);
    pageController.titleColorNormal = textMinorColor33;
    pageController.scrollEnable = NO;
    pageController.progressViewIsNaughty = YES;
    pageController.progressHeight = 3.0f;
    NSMutableArray *withArr = [NSMutableArray array];
    NSMutableArray *itemWidthArr = [NSMutableArray array];
    
    
        
        for (int i = 0; i < self.titleArr.count; i++) {
            NSString *oneStr = [NSString stringWithFormat:@"%@", self.titleArr[i]];
            if (oneStr.length == 2) {
                [withArr addObject:@"20"];
                [itemWidthArr addObject:@"55"];
            }
            else if (oneStr.length == 1){
                [withArr addObject:@"15"];
                [itemWidthArr addObject:@"35"];
            }
            else if (oneStr.length == 3){
                [withArr addObject:@"35"];
                [itemWidthArr addObject:@"65"];
            }
            else if (oneStr.length == 4){
                [withArr addObject:@"45"];
                [itemWidthArr addObject:@"80"];
            }
            else{
                [withArr addObject:@"55"];
                [itemWidthArr addObject:@"100"];
            }
        }
        
        pageController.progressViewWidths = withArr;
        pageController.itemsWidths = itemWidthArr;
        
        return self.titleArr.count;

 
    
}
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    
    return [NSString stringWithFormat:@"%@", self.titleArr[index]];
    
}
- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    
    DMLog(@"0000000");
    
    RankListVC *myOrderOneVC = [[RankListVC alloc]init];
//    myOrderOneVC.type = self.type;
    myOrderOneVC.nav = self.navigationController;
    myOrderOneVC.type = pageController.selectIndex;
//    myOrderOneVC.orderstarttime = self.startTime;
//    myOrderOneVC.orderendtime = self.endTime;
//    myOrderOneVC.nav = self.navigationController;
//    myOrderOneVC.styleTitle = self.navTitle;
//    myOrderOneVC.rateStr = self.rateStr;
    
     myOrderOneVC.view.backgroundColor = [UIColor clearColor];
    
    return myOrderOneVC;
    
}
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    
    
    CGFloat leftMargin = pageController.showOnNavigationBar ? 50 : 10;
    
    return CGRectMake(leftMargin,0*BiLi , self.view.frame.size.width - 2*leftMargin, 35);
    
}


- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    
    contentView.backgroundColor = [UIColor clearColor];
    return CGRectMake(0, 114*BiLi , self.view.frame.size.width, self.view.frame.size.height );
    
}

@end
