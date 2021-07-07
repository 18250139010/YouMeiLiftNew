//
//  ShareGoodsViewController.h
//  DaiMengJia
//
//  Created by 呆萌价 on 2017/12/12.
//  Copyright © 2017年 呆萌价. All rights reserved.
//

#import "BaseViewController.h"
#import "ShopData.h"
//#import "SuperSearch.h"
//#import "RecommendData.h"
@interface ShareGoodsViewController : BaseViewController

@property (strong, nonatomic) NSMutableArray *imgArr;
@property (strong, nonatomic) ShopData *shopData;
@property (copy, nonatomic) NSString *taoKouLin;
@property (copy, nonatomic) NSString *sharelink;
@property (copy, nonatomic) NSString *shareshortlink;
@property (copy, nonatomic) NSString *type;
//@property (strong, nonatomic) SuperSearch *superSearch;
@property (copy, nonatomic) NSString *agentratio;
//@property (strong, nonatomic) RecommendData *recommendData;
@property (copy, nonatomic) NSString *rec_tjly;

@end
