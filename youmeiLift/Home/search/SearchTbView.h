//
//  SearchTbView.h
//  DaiMengJia
//
//  Created by 呆萌价 on 2020/1/8.
//  Copyright © 2020 呆萌价. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SearchTbViewDelegate <NSObject>

- (void)chlickSearchTbView;
- (void)chlickVideoView;

@end
NS_ASSUME_NONNULL_BEGIN

@interface SearchTbView : UIView

@property (strong, nonatomic) UISearchBar *searchBar;
- (instancetype)init;
- (void)setUpSearchTBViewWithImgStr:(NSString *)ImgStr videoStr:(NSString *)videoStr;
- (void)setUpSearchTBViewWithArr:(NSMutableArray *)hotSearchArr;
- (void)setUpTBSearchHistoryViewWithArr:(NSMutableArray *)historyArr;
- (void)refreshTBSearchHistoryViewWithArr:(NSMutableArray *)historyArr;
- (void)refreshTBSearchAppViewWithStyle:(NSString *)style;
@property (nonatomic, copy) void (^passTBSearchName)(NSString *searchStr, NSString *type);
@property (nonatomic, copy) void (^passTBSearchNameOnTime)(NSString *searchStr);
@property (weak, nonatomic) id<SearchTbViewDelegate>delegate;


@property (nonatomic, copy) void (^passTBSearchDict)(NSDictionary *dict);


@end

NS_ASSUME_NONNULL_END
