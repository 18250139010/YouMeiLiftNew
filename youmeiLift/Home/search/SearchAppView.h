//
//  SearchAppView.h
//  DaiMengJia
//
//  Created by 呆萌价 on 2018/3/31.
//  Copyright © 2018年 呆萌价. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SearchAppViewDelegate <NSObject>

- (void)chlickSearchAppView;

@end


@interface SearchAppView : UIView


@property (strong, nonatomic) UISearchBar *searchBar;


- (instancetype)init;
- (void)setUpSearchAppViewWithStyle:(NSString *)style;
- (void)setUpSearchAppViewWithArr:(NSMutableArray *)hotSearchArr;
- (void)setUpSearchHistoryViewWithArr:(NSMutableArray *)historyArr;
- (void)refreshSearchHistoryViewWithArr:(NSMutableArray *)historyArr;
- (void)refreshSearchAppViewWithStyle:(NSString *)style;
@property (nonatomic, copy) void (^passSearchName)(NSString *searchStr, NSString *type);


@property (nonatomic, copy) void (^passSearchNameOnTime)(NSString *searchStr);
@property (nonatomic, copy) void (^passAppSearchDict)(NSDictionary *dict);

@property (weak, nonatomic) id<SearchAppViewDelegate>delegate;

@end
