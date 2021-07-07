//
//  SearchAppView.m
//  DaiMengJia
//
//  Created by 呆萌价 on 2018/3/31.
//  Copyright © 2018年 呆萌价. All rights reserved.
//

#import "SearchAppView.h"
#import "Masonry.h"
#import "TagView.h"
#import "DMTool.h"

@interface SearchAppView ()<TagViewDelegate, UISearchBarDelegate>

@property (strong, nonatomic) UIScrollView *appScrollView;


@property (strong, nonatomic)  TagView *tagView;

@property (strong, nonatomic) UIView *historyView ;
@property (strong, nonatomic) NSMutableArray *historyArr;
@property (strong, nonatomic) UILabel *historyTTLab;
@property (strong, nonatomic) UIButton *historyDeleteBtn;
@property (copy, nonatomic) NSString *historyType;
@property (copy, nonatomic) NSString *type;

@end



@implementation SearchAppView

- (instancetype)init{
    
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        
     
        
    }
    
    return self;
}

- (void)refreshSearchAppViewWithStyle:(NSString *)style{
    
    
    
}

- (void)setUpSearchAppViewWithStyle:(NSString *)style{
    
    self.type = style;
    
    self.appScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width,  self.frame.size.height)];
    _appScrollView.backgroundColor = allBackgroundColor;
    _appScrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight);
    _appScrollView.showsVerticalScrollIndicator = NO;
    _appScrollView.showsHorizontalScrollIndicator = NO;
    UITapGestureRecognizer *appTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAppScrollView:)];
    [_appScrollView addGestureRecognizer:appTap];
    
    [self addSubview:self.appScrollView];
    
   
   
    
    UILabel *hotSearchLab = [[UILabel alloc]init];
    hotSearchLab.text = @"热门搜索";
    hotSearchLab.textColor = textMinorColor33;
    hotSearchLab.font = [UIFont boldSystemFontOfSize:FontSize(15)];
    [_appScrollView addSubview:hotSearchLab];
    
    [hotSearchLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_appScrollView.mas_top).offset(24);
        make.left.equalTo(_appScrollView.mas_left).offset(17);
    
        make.size.mas_equalTo(CGSizeMake(100, 16));
        
    }];
    
    
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






//热搜
- (void)setUpSearchAppViewWithArr:(NSMutableArray *)hotSearchArr{
    
    self.tagView = [[TagView alloc]initWithFrame:CGRectMake(5, 45, kScreenWidth - 10, 0)];

    _tagView.delegate = self;
   
    if ([self.type isEqualToString:@"FQA"]) {
         _tagView.hotFQAArr = hotSearchArr;
    }else{
         _tagView.hotArr = hotSearchArr;
    }
    _tagView.userInteractionEnabled = YES;
    [self.appScrollView addSubview:_tagView];
    
    
    
    
    
}



#pragma mark - CCTagViewDelegate
-(void)handleSelectTag:(NSString *)keyWord{
    
    
    DMLog(@"keyWord ---- %@",keyWord);
    self.passSearchName(keyWord,@"11");
}

- (void)handleSelectTagDict:(NSDictionary *)dict{
    
    NSString *ttStr = [NSString stringWithFormat:@"%@", dict[@"title"]];
    if (ttStr) {
        self.passSearchName(ttStr,@"00");
    }
    self.passAppSearchDict(dict);
}

- (void)clickSearchButton:(UIButton *)sender{
   
     NSString *trimedString = [self.searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (trimedString.length == 0) {
        DMLog(@"空");
    }
    else{
       
         self.passSearchName(trimedString,@"11");
    }
    
    [self.searchBar resignFirstResponder];
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{

    NSString *trimedString = [self.searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (trimedString.length == 0) {
       
        
    }
    else{
        
        self.passSearchName(trimedString,@"11");
    }
    
    
    // KJLog(@"开始搜索");
    [self.searchBar resignFirstResponder];
    
    
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{

     self.passSearchNameOnTime(searchBar.text);
    
}




- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    DMLog(@"cacacacacacac12231223");
    
      [self.searchBar resignFirstResponder];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(chlickSearchAppView)]) {
        [self.delegate chlickSearchAppView];
    }
    
}





- (void)clickAppScrollView:(UIGestureRecognizer *)sender{
    [self.searchBar resignFirstResponder];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(chlickSearchAppView)]) {
        [self.delegate chlickSearchAppView];
    }
}


//搜索历史
- (void)setUpSearchHistoryViewWithArr:(NSMutableArray *)historyArr{
    
    
   
    
    if (historyArr.count > 0) {
        self.historyType = @"yess";
   
    self.historyArr = [NSMutableArray arrayWithArray:historyArr];
    self.historyTTLab = [[UILabel alloc]init];
    _historyTTLab.text = @"历史搜索";
    _historyTTLab.font = [UIFont boldSystemFontOfSize:FontSize(15)];
    _historyTTLab.textColor = textMinorColor33;
    [_appScrollView addSubview:_historyTTLab];
    
    
    [_historyTTLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_tagView.mas_bottom).offset(20);
        make.left.equalTo(_appScrollView.mas_left).offset(20);
       
        make.size.mas_equalTo(CGSizeMake(100, 20));
        
    }];
    
    
    self.historyDeleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
 
    [_historyDeleteBtn setImage:[UIImage imageNamed:@"historySearch_delete.png"] forState:0];
    [_historyDeleteBtn setTitleColor:textGrayColor forState:0];
    _historyDeleteBtn.titleLabel.font =[UIFont systemFontOfSize:FontSize(14)];
       _historyDeleteBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_historyDeleteBtn addTarget:self action:@selector(clickAllDeleteButtonOnHistoryView:) forControlEvents:UIControlEventTouchUpInside];
    [_appScrollView addSubview:_historyDeleteBtn];
 

    [_historyDeleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_tagView.mas_bottom).offset(16);
        make.left.equalTo(_appScrollView.mas_right).offset(kScreenWidth - 55);
        
        make.size.mas_equalTo(CGSizeMake(30, 30));
        
    }];
    
    
    self.historyView = [[UIView alloc]init];
    [_appScrollView addSubview:_historyView];
 
    [_historyView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_historyDeleteBtn.mas_bottom).offset(0);
        make.left.equalTo(_appScrollView.mas_right).offset(0);
       
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 53*(historyArr.count/4) +160));
        
    }];
    
        
        int height ;
           
           
        
    
         TagView *tagView = [[TagView alloc]initWithFrame:CGRectMake(5, 0, kScreenWidth-10, 0)];
       
        tagView.delegate = self;
        tagView.arr = historyArr;
        tagView.userInteractionEnabled = YES;
        [self.historyView addSubview:tagView];
    
    
        height   = 105+self.tagView.frame.size.height +60 +  tagView.frame.size.height ;
            
              
              
              
              if (height > kScreenHeight-41-(iPhoneX?88:64)) {
                  _appScrollView.contentSize = CGSizeMake(kScreenWidth, height);
                  [_historyView mas_updateConstraints:^(MASConstraintMaker *make) {
                                           make.size.mas_equalTo(CGSizeMake(kScreenWidth, height));
                                       }];
              }
              else{
                  _appScrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight-41-(iPhoneX?88:64));
                  [_historyView mas_updateConstraints:^(MASConstraintMaker *make) {
                                           make.size.mas_equalTo(CGSizeMake(kScreenWidth, height));
                                       }];
              }
    
  
    }else{
        self.historyType = @"nooo";
    }
   
}

- (void)refreshSearchHistoryViewWithArr:(NSMutableArray *)historyArr{
    
    if ([self.historyType isEqualToString:@"nooo"]) {
        
        if (historyArr.count > 0) {
            
            self.historyType = @"yess";

               self.historyArr = [NSMutableArray arrayWithArray:historyArr];
               self.historyTTLab = [[UILabel alloc]init];
               _historyTTLab.text = @"历史搜索";
               _historyTTLab.font = [UIFont boldSystemFontOfSize:FontSize(15)];
               _historyTTLab.textColor = textMinorColor33;
               [_appScrollView addSubview:_historyTTLab];
               
               
               [_historyTTLab mas_makeConstraints:^(MASConstraintMaker *make) {
                   
                   make.top.equalTo(_tagView.mas_bottom).offset(20);
                   make.left.equalTo(_appScrollView.mas_left).offset(20);
                   
                   make.size.mas_equalTo(CGSizeMake(100, 20));
                   
               }];
               
               
               self.historyDeleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
               
             
               [_historyDeleteBtn setImage:[UIImage imageNamed:@"historySearch_delete.png"] forState:0];
               [_historyDeleteBtn setTitleColor:textGrayColor forState:0];
               _historyDeleteBtn.titleLabel.font =[UIFont systemFontOfSize:FontSize(14)];
                  _historyDeleteBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
               [_historyDeleteBtn addTarget:self action:@selector(clickAllDeleteButtonOnHistoryView:) forControlEvents:UIControlEventTouchUpInside];
               [_appScrollView addSubview:_historyDeleteBtn];
            

               [_historyDeleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                   
                   make.top.equalTo(_tagView.mas_bottom).offset(16);
                   make.left.equalTo(_appScrollView.mas_right).offset(kScreenWidth - 55);
                 
                
                   make.size.mas_equalTo(CGSizeMake(30, 30));
                   
               }];
            
            
            self.historyView = [[UIView alloc]init];
              [_appScrollView addSubview:_historyView];
      
              [_historyView mas_makeConstraints:^(MASConstraintMaker *make) {
                  
                  make.top.equalTo(_historyDeleteBtn.mas_bottom).offset(0);
                  make.left.equalTo(_appScrollView.mas_right).offset(0);
                
                  make.size.mas_equalTo(CGSizeMake(kScreenWidth, 53*(historyArr.count/4) +160));
                  
              }];
            
            int height ;
                        
                        
                     
                 
                      TagView *tagView = [[TagView alloc]initWithFrame:CGRectMake(5, 0, kScreenWidth-10, 0)];
                    
                     tagView.delegate = self;
                     tagView.arr = historyArr;
                     tagView.userInteractionEnabled = YES;
                     [self.historyView addSubview:tagView];
            
            
            height   = 105+self.tagView.frame.size.height +60 +  tagView.frame.size.height ;
                       
                         
                         
                         
                         if (height > kScreenHeight-41-(iPhoneX?88:64)) {
                             _appScrollView.contentSize = CGSizeMake(kScreenWidth, height);
                             [_historyView mas_updateConstraints:^(MASConstraintMaker *make) {
                                                      make.size.mas_equalTo(CGSizeMake(kScreenWidth, height));
                                                  }];
                         }
                         else{
                             _appScrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight-41-(iPhoneX?88:64));
                             [_historyView mas_updateConstraints:^(MASConstraintMaker *make) {
                                                      make.size.mas_equalTo(CGSizeMake(kScreenWidth, height));
                                                  }];
                         }
            
            
        }else{
            self.historyType = @"nooo";
        }
        
        
    }else{
      
        [self.historyView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
                     [_historyView mas_makeConstraints:^(MASConstraintMaker *make) {
                         
                         make.top.equalTo(_historyDeleteBtn.mas_bottom).offset(0);
                         make.left.equalTo(_appScrollView.mas_right).offset(0);
                        
                         make.size.mas_equalTo(CGSizeMake(kScreenWidth, 53*(historyArr.count/4) +160));
                         
                     }];
                   
                   int height ;
                               
                              
                        
                             TagView *tagView = [[TagView alloc]initWithFrame:CGRectMake(5, 0, kScreenWidth-10, 0)];
                            // _tagView.backgroundColor = [UIColor yellowColor];
                            tagView.delegate = self;
                            tagView.arr = historyArr;
                            tagView.userInteractionEnabled = YES;
                            [self.historyView addSubview:tagView];
        
        
        height   = 105+self.tagView.frame.size.height +60 +  tagView.frame.size.height ;
                   
                     
                     
                     
                     if (height > kScreenHeight-41-(iPhoneX?88:64)) {
                         _appScrollView.contentSize = CGSizeMake(kScreenWidth, height);
                         [_historyView mas_updateConstraints:^(MASConstraintMaker *make) {
                                                  make.size.mas_equalTo(CGSizeMake(kScreenWidth, height));
                                              }];
                     }
                     else{
                         _appScrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight-41-(iPhoneX?88:64));
                         [_historyView mas_updateConstraints:^(MASConstraintMaker *make) {
                                                  make.size.mas_equalTo(CGSizeMake(kScreenWidth, height));
                                              }];
                     }
        
        
    }
    
    
    
    
    
    
}


- (void)clickOneDeleteButtonOnHistoryView:(UIButton *)sender{
    DMLog(@"dddddd %ld", (long)sender.tag);
    [self.historyArr removeObjectAtIndex:sender.tag - 778];
    if ([self.type isEqualToString:@"FQA"]) {
        [NSKeyedArchiver archiveRootObject:self.historyArr toFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"history_college.archive"]];
        [[self.historyView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }else{
        [NSKeyedArchiver archiveRootObject:self.historyArr toFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"history.archive"]];
        [[self.historyView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }

    
    
    if (self.historyArr.count == 0) {
        [self.historyDeleteBtn removeFromSuperview];
        [self.historyTTLab removeFromSuperview];
    }
    
    
    int height = 120+self.tagView.frame.size.height +60 +  53*self.historyArr.count +20;
    
    if (height > kScreenHeight) {
        _appScrollView.contentSize = CGSizeMake(kScreenWidth, height);
        
    }
    else{
        _appScrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight);
    }
    
    
    for (int i = 0; i < self.historyArr.count; i++) {
        
        UIView *oneView = [[UIView alloc]initWithFrame:CGRectMake(0, 0 + 41*i, kScreenWidth, 41)];
        
        UILabel *ttLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, kScreenWidth - 60, 20)];
        ttLab.text = self.historyArr[i];
        ttLab.font = [UIFont systemFontOfSize:FontSize(14)];
        ttLab.textColor = textMinorColor;
        [oneView addSubview:ttLab];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(10, 40, kScreenWidth-20, 1)];
        lineView.backgroundColor = halvingLineColor;
        [oneView addSubview:lineView];
        
        
        UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [deleteBtn setImage:[UIImage imageNamed:@"search_delete.png"] forState:0];
        deleteBtn.frame = CGRectMake(kScreenWidth-40, 5, 30, 30);
        [deleteBtn addTarget:self action:@selector(clickOneDeleteButtonOnHistoryView:) forControlEvents:UIControlEventTouchUpInside];
        deleteBtn.tag = 778+i;
        [oneView addSubview:deleteBtn];
        
        [_historyView addSubview:oneView];
    }
    
    
}


- (void)clickAllDeleteButtonOnHistoryView:(UIButton *)sender{
    
     [self.historyArr removeAllObjects];

    if ([self.type isEqualToString:@"FQA"]) {
        [NSKeyedArchiver archiveRootObject:self.historyArr toFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"history_college.archive"]];
    }else{
        [NSKeyedArchiver archiveRootObject:self.historyArr toFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"history.archive"]];
    }
    
     _appScrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight);
    [self.historyDeleteBtn removeFromSuperview];
    [self.historyTTLab removeFromSuperview];
    [[self.historyView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    
    
}




//点击某个 搜索历史
- (void)clickOneViewOnSearchAppView:(UIGestureRecognizer *)sender{
    
    DMLog(@"dddddd");
    UILabel *lab = (UILabel *)sender.view;
    
    DMLog(@"%@", lab.text);
    NSString *trimedString = [lab.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (trimedString.length == 0) {
        
        
    }
    else{
        
        self.passSearchName(trimedString,@"11");
    }
    
    
    // KJLog(@"开始搜索");
    [self.searchBar resignFirstResponder];
}



@end
