//
//  RankListVC.h
//  YouMeiLift
//
//  Created by 有美生活 on 2021/6/22.
//  Copyright © 2021 有美生活. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RankListVC : UIViewController

@property (copy, nonatomic) NSString *ID;
@property (copy, nonatomic) NSString *name;
@property (assign , nonatomic)int type;
@property (strong, nonatomic) UINavigationController *nav;

@end
