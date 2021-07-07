//
//  YMSearchViewController.m
//  youmeiLift
//
//  Created by mac on 2021/6/23.
//

#import "YMSearchViewController.h"
#import "SearchTbView.h"
#import "SearchAppView.h"
@interface YMSearchViewController ()<UIScrollViewDelegate , UISearchBarDelegate, SearchAppViewDelegate,SearchTbViewDelegate>
@property (strong, nonatomic) UIButton *searchAppBtn;
@property (strong, nonatomic) UIButton *searchAllBtn;

@property (strong, nonatomic) UIView *searchAppView;





@property (strong, nonatomic) UIScrollView *searchScrollView;

@property (strong, nonatomic) NSMutableArray *historyArr;

@property (copy, nonatomic) NSString *ratio;
@property (copy, nonatomic) NSString *superratio;
@property (copy, nonatomic) NSString *agentratio;

@property (strong, nonatomic) SearchAppView *appView;
@property (strong, nonatomic) SearchTbView *tbView;

@property (strong, nonatomic) UIScrollView *thinkScrollView;


@property (copy, nonatomic) NSString *style;

@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) UIView *headerBtnView;

@property (strong, nonatomic) UIView *markView;
@property (assign, nonatomic) NSInteger index;
@property (copy, nonatomic) NSString *videoUrlStr;
@end

@implementation YMSearchViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    
     self.historyArr = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"history.archive"]]];
     
     
     
     self.navigationController.navigationBarHidden = YES;
     
    
         [self.appView refreshSearchHistoryViewWithArr:self.historyArr];
         [self.tbView refreshTBSearchHistoryViewWithArr:self.historyArr];
     
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    
    self.navigationController.navigationBarHidden = NO;
    
    self.pushType = @"000";
   // self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.view.backgroundColor = allBackgroundColor;
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 67+(iPhoneX?24:0))];
    navView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navView];
    
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setImage:[UIImage imageNamed:@"back"] forState:0];
    cancelBtn.frame = CGRectMake(10, 2+(iPhoneX?44:20), 40, 40);
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [cancelBtn addTarget:self action:@selector(clickCancelBtnOnSearchVC:) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:cancelBtn];
    
    
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(50, 7+(iPhoneX?44:20), kScreenWidth - 70-40, 30)];
    _searchBar.placeholder = @"搜索商品名或黏贴宝贝标题";
    _searchBar.delegate = self;
    _searchBar.layer.cornerRadius = 15.0f;
    _searchBar.layer.masksToBounds = YES;
    
    UIOffset offect = {10, 0};
    _searchBar.searchTextPositionAdjustment = offect;

    [_searchBar becomeFirstResponder];// 一开始 进来 就处于编辑状态
    [_searchBar setBarStyle:UIBarStyleDefault];
    
    [navView addSubview:self.searchBar];
    // kUIColorFromRGB(0xe5e8e8)
    UIImage* searchBarBg = [self GetImageWithColor:ColorMaker(245, 245, 245, 255) andHeight:255.0f];
    //设置背景图片
    [_searchBar setBackgroundImage:searchBarBg];
    //设置背景色
    [_searchBar setBackgroundColor:ColorMaker(245, 245, 245, 255)];
    //设置文本框背景
    [_searchBar setSearchFieldBackgroundImage:searchBarBg forState:UIControlStateNormal];
    
    [self.searchBar setImage:[UIImage imageNamed:@"YMSearch.png"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    
    [_searchBar setImage:[UIImage imageNamed:@"back.png"] forSearchBarIcon:UISearchBarIconClear state:UIControlStateNormal];
    [_searchBar setPositionAdjustment:UIOffsetMake(5, 0) forSearchBarIcon:UISearchBarIconClear];
    
    
    UIButton *serachBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [serachBtn setTitle:@"搜索" forState:0];
    [serachBtn setTitleColor:textMinorColor forState:0];
    serachBtn.frame = CGRectMake(kScreenWidth - 50, 2+(iPhoneX?44:20), 40, 40);
    serachBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [serachBtn addTarget:self action:@selector(clickCancelBtnOnSearchVC:) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:serachBtn];
    
    
   
    
    
    
}
- (UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height
{
    CGRect r= CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
    
}
- (void)clickCancelBtnOnSearchVC:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];

}
- (void)chlickSearchAppView{
     [self.searchBar resignFirstResponder];
}

- (void)chlickSearchTbView{
     [self.searchBar resignFirstResponder];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.searchBar resignFirstResponder];
}


@end
