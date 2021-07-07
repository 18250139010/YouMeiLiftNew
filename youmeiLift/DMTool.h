//
//  DMTool.h
//  DaiMengJia
//
//  Created by 呆萌价 on 2017/11/21.
//  Copyright © 2017年 呆萌价. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "ShowEmptyView.h"
//#import "TaoBaoWebView.h"
//#import "YJProgressHUD.h"
//#import "NetWorkManager.h"
//#import "MJExtension.h"
//#import "DMTextTool.h"
//#import "DMGifHeader.h"
//#import "LoginViewController.h"
//#import "ExternalLinkWebVC.h"
//#import "JPWDetailVC.h"
//#import "OtherVC.h"
//#import "DDGBannerScrollView.h"
//#import "UIColor+MyExtension.h"
//#import "DDGHorizontalPageControl.h"
//#import "DDGAnimationPageControl.h"
//
//#import<JDSDK/KeplerApiManager.h>
//
//
//#import "WXApi.h"
//#import "CollegeVideoDetailVC.h"
//#import "CollegeTextDetailVC.h"
//#import <AlibabaAuthEntrance/ALBBSDK.h>
//#import <AlibabaAuthEntrance/ALBBCompatibleSession.h>
//#import <WindVaneCore/WVURLProtocolService.h>
//#import "HomeGoodsDetailVC.h"

@interface DMTool : NSObject

#define isexamine96All  [NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"isexamine96"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"isexamine96"]:@"0" ]




#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kWindow [UIApplication sharedApplication].keyWindow
#define kUserDefaults [NSUserDefaults standardUserDefaults]


#define NavigateHeight (KScreenHeight == 812.0 ? 88 : 64)

#define kHomeGoTopNotification          [NSString stringWithFormat:@"HomeGoTop"]
#define kHomeLeaveTopNotification       [NSString stringWithFormat:@"HomeLeaveTop"]
#define kWoDeShowGoTopNotification      [NSString stringWithFormat:@"WoDeShowGoTop"]
#define kWoDeShowLeaveTopNotification   [NSString stringWithFormat:@"WoDeShowLeaveTop"]

extern NSString *const kCDKAPIScheme;

//判断是否有刘海
#define kStatusBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height)
#define iPhoneX (kStatusBarHeight > 20.0f)

//  非iPhone X ：   顶部  40px(电池栏) + 88px(NavBar)  底部 98px(TabBar)
//     iPhone X：   顶部  88px(电池栏) + 88px(NavBar)  底部 98px(TabBar) + 68px(横线那一栏)

#define iPhoneXX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO) || ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO) || ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhoneXAddHeight (iPhoneX ? 44 :0)
#define iPhoneXAddHeight2 (iPhoneXX ? 44 :20)
#define STATUS_BAR_BIGGER_THAN_20 [UIApplication sharedApplication].statusBarFrame.size.height > iPhoneXAddHeight2

//判断iPHoneXr
#define iPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)



#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define BiLi kScreenWidth/375.0


#define iOS9Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.0f)


#define ColorMaker(r, g, b, a) [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:((a) / 255.0)]
// 颜色赋值
#define kUIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define allBackgroundColor  ColorMaker(245, 245, 245, 255)
#define halvingLineColor kUIColorFromRGB(0xfafafa)
#define DMColor kUIColorFromRGB(0xFF2741)
#define placeholderColor kUIColorFromRGB(0xF5F7F9)

#define textBlockColor kUIColorFromRGB(0x191919)
#define textGrayColor  kUIColorFromRGB(0xaaaaaa)
#define textPrimaryColor ColorMaker(0, 0, 0, 221) //黑色
#define textMinorColor kUIColorFromRGB(0x666666) //亚黑
#define textMinorColor99 kUIColorFromRGB(0x999999) //亚黑
#define textMinorColor33 kUIColorFromRGB(0x333333) //亚黑


#ifdef DEBUG
#define DMLog(format, ...) printf(" method: %s \n%s\n",   __PRETTY_FUNCTION__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String] );
#else
#define DMLog(format, ...);
#endif

// 版本号
#define VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#define APP_DOCUMENT                [NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#define DocumentPath(path)          [APP_DOCUMENT stringByAppendingPathComponent:path]


//**********
//正式
#define kGtAppId           @"5QcWsaOM417OyERuv6HDy8"
#define kGtAppKey          @"Q9OdWRHXm36rARbWF8Xfc9"
#define kGtAppSecret       @"RZtFmvqbRf8ACjgq67hXd3"

#define UMKey              @"5a72b43aa40fa354d0000067"  //友盟key
#define WXSecret           @"2aa10af3233ea131b865eb2b988022d9"  // 微信secret
#define WXKey              @"wxdb7bf37f83a88d19"  //微信key
#define QQSecret           @"SbFIrHt7t72L9PDT"  //QQsecret
#define QQKey              @"1106208197"   // QQkey

#define MD5LastStr       @"1axd@#hhjdxc"  //md5加密拼接
//#define MD5LastStr         @"1999@#dhjdxa"  //md5加密拼接  重构

#define tbNum               @"25826054"    //百川淘宝key
#define kdfKey              @"daimengjia"
#define QIYUKey              @"c863473f298a3f3a418f66f7a298311c"//网易七鱼key
#define JDKey                @"ea6662ccf341a06c4331fb313b3d8f41"//京东key
#define JDSecret             @"3485ce20743b47bfa308b9db9bde70e9"//京东Secret




#define ShanYanID            @"IatZ1qQw"//闪验ID
#define ShanYanKey           @"47EfYhpa"//闪验key

#define BXMediaKey            @"dmj-hdgj-IOS_ufhnzk"//小满广告
#define BXMediaSecretKey      @"E4V3rl4k11Egs318"//

#define BUAdSDKKey            @"5111934"//穿山甲
#define GDTAdSDKKey           @"1111024247"//广点通

#define JADSDKKey           @"119919"//京准通

#define xieYiHeader        @"http://www.shop.dmjvip.com"  //协议头部
#define xieYiHeader2        @"http://www.dmjvip.com"  //协议头部
#define userProtocol        @"http://www.dmhw1688.com/agreement/protocol.html"  //用户协议
#define privacyPolicy        @"http://www.dmhw1688.com/agreement/privacy.html"  //隐私政策

#define AppStoreUrl        @"https://itunes.apple.com/cn/app/id1351709091?mt=8" //下载地址
#define AppStoreLookupUrl  @"https://itunes.apple.com/cn/lookup?id=1351709091" //唤醒（改id即可）
#define AppStoreEvaluateUrl  @"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=1351709091&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8" //评价


// **** 头部 ***
#define dmjapis @"https://www.dmhw1688.com/DMJAPPS/apps/"
#define WWWUrl [NSString stringWithFormat:@"%@",dmjapis]
#define dmjapiNew @"https://micro.dmhw1688.com/weixin/" //CPS正式


//测试
//#define ceshi @"http://192.168.0.152:11991/DMJAPPS/apps/"
//#define WWWUrl [NSString stringWithFormat:@"%@",ceshi]
//#define dmjapiNew @"https://micro.dmhw1688.com/weixin/" //CPS测试


//#define ceshi @"http://192.168.0.146:11991/DMJAPPS/apps/"
//#define WWWUrl [NSString stringWithFormat:@"%@",ceshi]
//#define dmjapiNew @"http://192.168.0.146:11931/weixin/" //钟山


//重构
//#define ceshi @"http://wx.mi.dmjvip.com/DMJAPPS/apps/"
//#define WWWUrl [NSString stringWithFormat:@"%@",ceshi]
//#define dmjapiNew @"http://wx.mi.dmjvip.com/weixin/" //CPS测试

#define KaiFa @"0" //1测试版，0发布版


// 推广吗登录
#define kURLWithLoginByPromoCode [NSString stringWithFormat:@"%@%@",WWWUrl,@"loginbyextengid"]
// 查询手机号是否存在
#define kURLWithUserByPhone [NSString stringWithFormat:@"%@%@",WWWUrl,@"userbyphone"]
// 微信手机号绑定
#define kURLWithWXBindPhone [NSString stringWithFormat:@"%@%@",WWWUrl,@"wxbindphone"]
// 版本号
#define kURLWithGetVersion [NSString stringWithFormat:@"%@%@",WWWUrl,@"getversion"]
// 签到
#define kURLWithSignIn [NSString stringWithFormat:@"%@%@",WWWUrl,@"usersign"]

// 是否绑定微信
#define kURLWithWXIsbinding [NSString stringWithFormat:@"%@%@",WWWUrl,@"wxisbinding"]
// 获取用户信息
#define kURLWithUserInfo [NSString stringWithFormat:@"%@%@",WWWUrl,@"getuserinfo"]
// 获取QQ
#define kURLWithContactQQ [NSString stringWithFormat:@"%@%@",WWWUrl,@"contactqq"]

// 获取个人销售信息
#define kURLWithUserAcount [NSString stringWithFormat:@"%@%@",WWWUrl,@"getuseracountex"]
// 用户信息修改
#define kURLWithUserInfoEdit [NSString stringWithFormat:@"%@%@",WWWUrl,@"userinfoedit"]
// 获取推广数据
#define kURLWithGetTeamStatistics [NSString stringWithFormat:@"%@%@",WWWUrl,@"getteamstatistics"]


//获取我的团队
#define kURLWithMyTeam [NSString stringWithFormat:@"%@%@",WWWUrl,@"getmyteam"]
//a级代理
#define kURLWithATeam [NSString stringWithFormat:@"%@%@",WWWUrl,@"getateam"]
//a级代理
#define kURLWithBTeam [NSString stringWithFormat:@"%@%@",WWWUrl,@"getbteam"]
//获取我的粉丝
#define kURLWithMyFans [NSString stringWithFormat:@"%@%@",WWWUrl,@"getmyfans"]


//获取团队粉丝数量
#define kURLWithGetMyTFCount [NSString stringWithFormat:@"%@%@",WWWUrl,@"getmytfcount"]


//获取提现相关信息
#define kURLWithWithdrawAls [NSString stringWithFormat:@"%@%@",WWWUrl,@"getwithdrawals"]
//绑定支付宝账号
#define kURLWithAddUserAliippay [NSString stringWithFormat:@"%@%@",WWWUrl,@"usersetalipay"]
//修改支付宝账号
#define kURLWithUpDateAliippay [NSString stringWithFormat:@"%@%@",WWWUrl,@"updatealipay"]
//获取提现相关信息
#define kURLWithWithdrawStatus [NSString stringWithFormat:@"%@%@",WWWUrl,@"getwithdrawalstatus"]
//提现申请
#define kURLWithwWithdrawAlsreq [NSString stringWithFormat:@"%@%@",WWWUrl,@"withdrawalsreq"]
// 我的收藏
#define kURLWithGetUserCollection [NSString stringWithFormat:@"%@%@",WWWUrl,@"getusercollection"]
// 收藏商品
#define kURLWithToUserCollection [NSString stringWithFormat:@"%@%@",WWWUrl,@"usercollection"]
// 收藏商品
#define kURLWithToIsCollection [NSString stringWithFormat:@"%@%@",WWWUrl,@"iscollection"]
// 批量获取高佣链接
#define kURLWithGetHighComm [NSString stringWithFormat:@"%@%@",WWWUrl,@"gethighcomm"]

// 详情页   领券购买
#define kURLWithGetCouponlink [NSString stringWithFormat:@"%@%@",WWWUrl,@"getcouponlink"]

// 详情页   获取高佣链接(分享时候请求)
#define kURLWithGetHighComm [NSString stringWithFormat:@"%@%@",WWWUrl,@"gethighcomm"]


// 取消收藏商品
#define kURLWithToUserCancleCollection [NSString stringWithFormat:@"%@%@",WWWUrl,@"usercanclecollection"]
// 批量取消收藏商品
#define kURLWithToUserBatCancleCollection [NSString stringWithFormat:@"%@%@",WWWUrl,@"userbatcanclecollection"]
// 添加足迹
#define kURLWithToUserFootPrint [NSString stringWithFormat:@"%@%@",WWWUrl,@"userfootprint"]
// 我的足迹
#define kURLWithGetUserFootPrint [NSString stringWithFormat:@"%@%@",WWWUrl,@"getuserfootprint"]



// 所有足迹id
#define kURLWithGertAllUserFootPrint [NSString stringWithFormat:@"%@%@",WWWUrl,@"gertalluserfootprint"]


// 获取商品分享设置
#define kURLWithGetShopShare [NSString stringWithFormat:@"%@%@",WWWUrl,@"getshopshare"]
// 设置商品分享设置
#define kURLWithSetShopShare [NSString stringWithFormat:@"%@%@",WWWUrl,@"setshopshare"]
// 获取图片分享模式设置
#define kURLWithGetShareModel [NSString stringWithFormat:@"%@%@",WWWUrl,@"getsharemodel"]
// 获取图片分享模式设置
#define kURLWithSetShareModel [NSString stringWithFormat:@"%@%@",WWWUrl,@"setsharemodel"]
// 获取分享预先设置内容模式
#define kURLWithGetappset [NSString stringWithFormat:@"%@%@",WWWUrl,@"getappset"]


// 获取帮助中心列表
#define kURLWithGetHelpList [NSString stringWithFormat:@"%@%@",WWWUrl,@"gethelplist"]
// 根据分类获取帮助中心列表
#define kURLWithGetHelpListByType [NSString stringWithFormat:@"%@%@",WWWUrl,@"gethelplistbytype"]
// 获取问题详情
#define kURLWithGetHelpDeatil [NSString stringWithFormat:@"%@%@",WWWUrl,@"gethelpdetail"]

// 申请代理
#define kURLWithAgentreq [NSString stringWithFormat:@"%@%@",WWWUrl,@"agentreq"]
// 用户反馈
#define kURLWithUserFeedBack [NSString stringWithFormat:@"%@%@",WWWUrl,@"userfeedback"]
// 我的订单／团队订单
#define kURLWithGetShopOrderID [NSString stringWithFormat:@"%@%@",WWWUrl,@"getshoporderid"]


// 设置客服
#define kURLWithSetCustomServer [NSString stringWithFormat:@"%@%@",WWWUrl,@"setcustomserver"]
// 获取客服
#define kURLWithGetCustomServer [NSString stringWithFormat:@"%@%@",WWWUrl,@"getcustomserver"]
// 获取上级客服
#define kURLWithGetUpCustomServer [NSString stringWithFormat:@"%@%@",WWWUrl,@"getupcustomserver"]

////////// *******  *******

// 获取首页 类目
#define kURLWithHomePage [NSString stringWithFormat:@"%@%@",WWWUrl,@"gethomepage"]
// 获取首页一级目录
#define kURLWithHomeFirstItem [NSString stringWithFormat:@"%@%@",WWWUrl,@"getshopclassone"]

// 获取分类中的。一级目录
#define kURLWithHomeFirstItemAll [NSString stringWithFormat:@"%@%@",WWWUrl,@"getshopclassoneall"]
// 获取二级目录
#define kURLWithHomeSecondItem [NSString stringWithFormat:@"%@%@",WWWUrl,@"getshopclasstwo"]

// 获取所有的 二级目录
#define kURLWithHomeSecondItemAll [NSString stringWithFormat:@"%@%@",WWWUrl,@"getshopclasstwoall"]


// 获取类目的广告
#define kURLWithGetAdvertisement [NSString stringWithFormat:@"%@%@",WWWUrl,@"getadvertisement"]

// 商品类目-帅选等
#define kURLWithShopSearchByClass [NSString stringWithFormat:@"%@%@",WWWUrl,@"shopsearchbyclass"]

// 获取 热搜字段
#define kURLWithGetKeyWord [NSString stringWithFormat:@"%@%@",WWWUrl,@"getkeyword"]
// 商品类目-搜索
#define kURLWithShopSearchByKeyWord [NSString stringWithFormat:@"%@%@",WWWUrl,@"shopsearchbykeyword"]

// 商品类目-标签
#define kURLWithShopSearchByLable [NSString stringWithFormat:@"%@%@",WWWUrl,@"shopsearchbylable"]

// 商品类目-根据id -- 商品中间页
#define kURLWithShopSearchByID [NSString stringWithFormat:@"%@%@",WWWUrl,@"shopsearchbyid"]

// 商品类目-猜你喜欢
#define kURLWithShopSearchByYouLike [NSString stringWithFormat:@"%@%@",WWWUrl,@"shopsearchbyyoulike"]
// 商品-获取淘宝口令
#define kURLWithGetTpwd [NSString stringWithFormat:@"%@%@",WWWUrl,@"gettpwd"]
// 商品-获取淘宝PID
#define kURLWithGetPID [NSString stringWithFormat:@"%@%@",WWWUrl,@"getpid"]


// 获取 抢购时间段
#define kURLWithGetFlashSaleTime [NSString stringWithFormat:@"%@%@",WWWUrl,@"getflashsaletime"]
// 获取 限时抢购 商品
#define kURLWithGetShopFlashSale [NSString stringWithFormat:@"%@%@",WWWUrl,@"shopflashsale"]

// 获取 限时抢购 商品 详情页
#define kURLWithGetShopFlashSaleByID [NSString stringWithFormat:@"%@%@",WWWUrl,@"shopflashsalebyid"]
// 获取 店铺信息
#define kURLWithGetSellInfo [NSString stringWithFormat:@"%@%@",WWWUrl,@"getsellinfo"]





// ***********************
// 我的-短信请求
#define kURLWithGetSmsCode [NSString stringWithFormat:@"%@%@",WWWUrl,@"getsmscode"]
// 我的-手机注册
#define kURLWithUserRegister [NSString stringWithFormat:@"%@%@",WWWUrl,@"userregister"]
// 我的-手机注册微信
#define kURLWithUserSetPwd [NSString stringWithFormat:@"%@%@",WWWUrl,@"usersetpwd"]

// 我的-手机登录
#define kURLWithLoginByPhone [NSString stringWithFormat:@"%@%@",WWWUrl,@"loginbyphone"]
#define kURLWithLoginBySMS [NSString stringWithFormat:@"%@%@",WWWUrl,@"loginbysmscode"]

#define kURLWithLoginByWX [NSString stringWithFormat:@"%@%@",WWWUrl,@"loginbywx"]


// 我的-修改密码
#define kURLWithUserPwdEdit [NSString stringWithFormat:@"%@%@",WWWUrl,@"userpwdedit"]
// 我的-重置密码
#define kURLWithUserPassWordReset [NSString stringWithFormat:@"%@%@",WWWUrl,@"userpasswordreset"]
/////  ///// ****** **每日推荐**** **


//  获取每日推荐
#define kURLWithGetRecommment [NSString stringWithFormat:@"%@%@",WWWUrl,@"getrecommment"]
#define kURLWithGetMarketing [NSString stringWithFormat:@"%@%@",WWWUrl,@"getmarketing"]

/////  ///// ****** ****** **

// 发现--所有晒单
#define kURLWithGetAllBask [NSString stringWithFormat:@"%@%@",WWWUrl,@"getallbask"]

// 发现--我的晒单
#define kURLWithGetMyBask [NSString stringWithFormat:@"%@%@",WWWUrl,@"getmybask"]


// 发现--获取用户晒单呆萌币
#define kURLWithGetUserBaskScore [NSString stringWithFormat:@"%@%@",WWWUrl,@"getuserbaskscore"]

// 发现--获取用户晒单呆萌币明细
#define kURLWithGetUserBaskScoreDetail [NSString stringWithFormat:@"%@%@",WWWUrl,@"getuserbaskscoredetail"]
// 发现--晒单排行 呆萌币排行 月排行
#define kURLWithGetBaskRanking [NSString stringWithFormat:@"%@%@",WWWUrl,@"getbaskranking"]

// 发现--用户点赞
#define kURLWithGetUserBaskLike [NSString stringWithFormat:@"%@%@",WWWUrl,@"userbasklike"]
// 发现--晒单详情
#define kURLWithGetAllBaskDetail [NSString stringWithFormat:@"%@%@",WWWUrl,@"getallbaskdetail"]

// 发现--用户点赞
#define kURLWithUserBaskLike [NSString stringWithFormat:@"%@%@",WWWUrl,@"userbasklike"]

/////  ///// ****** ****** **

//直播间

#define kURLWithGetOnLineAddr [NSString stringWithFormat:@"%@%@",WWWUrl,@"getonlineaddr"]


//消息中心
#define kURLWithGetNewMessage [NSString stringWithFormat:@"%@%@",WWWUrl,@"getnewmessage"]

//消息中心分类列表
#define kURLWithGetMessageDetail [NSString stringWithFormat:@"%@%@",WWWUrl,@"getmessagedetail"]

//未读消息个数
#define kURLWithGetNewMessageCount [NSString stringWithFormat:@"%@%@",WWWUrl,@"getnewmessagecnt"]

//更新状态
#define kURLWithSetMessageStatusByType [NSString stringWithFormat:@"%@%@",WWWUrl,@"setmessagestatusbytype"]


//是否弹出邀请码框
#define kURLWithAppIsPop [NSString stringWithFormat:@"%@%@",WWWUrl,@"appispop"]

//呆萌币总览
#define kURLWithScoreOverView [NSString stringWithFormat:@"%@%@",WWWUrl,@"scoreoverview"]
//呆萌币明细查询
#define kURLWithScoreDetail [NSString stringWithFormat:@"%@%@",WWWUrl,@"scoredetail"]
//呆萌币兑换
#define kURLWithConverTibilitySocre [NSString stringWithFormat:@"%@%@",WWWUrl,@"convertibilitysocre"]

//分享中间页
#define kURLWithAppShare [NSString stringWithFormat:@"%@%@",WWWUrl,@"appshare"]

//获取分佣比例
#define kURLWithGetRatio [NSString stringWithFormat:@"%@%@",WWWUrl,@"getratio"]

+(NSString *)getArrayFilePath;
+(NSString *)getNoWriteIDArrayFilePath;
+ (NSDictionary*)dictionaryWithJsonString:(NSString*)jsonString;
+ (BOOL)checkUrl:(NSString *)url;
+ (void)networkRequestHaveVibration;


//获取下级代理数量
#define kURLWithGetagentcnt [NSString stringWithFormat:@"%@%@",WWWUrl,@"getagentcnt"]
//获取店主晋升条件
#define kURLWithGetupfranchiserct [NSString stringWithFormat:@"%@%@",WWWUrl,@"getupfranchiserct"]
//升级为店主
#define kURLWithUpfranchiser [NSString stringWithFormat:@"%@%@",WWWUrl,@"upfranchiser"]
//升级为店主申请状态查询
#define kURLWithGetupfranchiser [NSString stringWithFormat:@"%@%@",WWWUrl,@"getupfranchiser"]

//获取下级店主数量
#define kURLWithGetfranchisercnt [NSString stringWithFormat:@"%@%@",WWWUrl,@"getfranchisercnt"]
//获取合伙人晋升条件
#define kURLWithGetuppartnerct [NSString stringWithFormat:@"%@%@",WWWUrl,@"getuppartnerct"]
//升级为合伙人
#define kURLWithUppartner [NSString stringWithFormat:@"%@%@",WWWUrl,@"uppartner"]

//超级搜
#define kURLWithOptional [NSString stringWithFormat:@"%@%@",WWWUrl,@"optional"]

//  商品排行榜的标题文字
#define kURLWithGetRankingsName [NSString stringWithFormat:@"%@%@",WWWUrl,@"getrankingsname"]




//a超级搜

#define kURLWithGetOptional [NSString stringWithFormat:@"%@%@",WWWUrl,@"optional"]
//搜索词联想
#define kURLWithGetSearcThinkList [NSString stringWithFormat:@"%@%@",WWWUrl,@"getSearchThinkList"]

//是否绑定公众号
#define kURLWithSubscribe [NSString stringWithFormat:@"%@%@",WWWUrl,@"subscribe"]
//微信提现
#define kURLWithTransferApply [NSString stringWithFormat:@"%@%@",WWWUrl,@"transferApply"]
//获取公众号二维码图片和公众号
#define kURLWithGetWechetAbout [NSString stringWithFormat:@"%@%@",WWWUrl,@"getWechetAbout"]

//多商品分享数据补充和高佣连接生成
#define kURLWithGetShopShareByIds [NSString stringWithFormat:@"%@%@",WWWUrl,@"getShopShareByIds"]


// 获取app底部菜单

#define kURLWithGetMenu [NSString stringWithFormat:@"%@%@",WWWUrl,@"getmenu"]




//  弹框广告
//#define kURLWithGetFrameadv [NSString stringWithFormat:@"%@%@",WWWUrl,@"getframeadv"]
#define kURLWithGetFrameadv [NSString stringWithFormat:@"%@%@",WWWUrl,@"getNewframeAdv"]
#define kURLWithGetNewframeAdv [NSString stringWithFormat:@"%@%@",WWWUrl,@"getNewframeAdv"]


//  官方活动
#define kURLWithActivitychain [NSString stringWithFormat:@"%@%@",WWWUrl,@"activitychain"]
//  查询推广吗
#define kURLWithFindbyextensionid [NSString stringWithFormat:@"%@%@",WWWUrl,@"findbyextensionid"]
//  呆萌头条
#define kURLWithGetDmjhot [NSString stringWithFormat:@"%@%@",WWWUrl,@"getdmjhot"]
//  今日节省金额
#define kURLWithGetSavemny [NSString stringWithFormat:@"%@%@",WWWUrl,@"getsavemny"]
// 消息中心 爆款推荐 商品消息
#define kURLWithGetburstingshop [NSString stringWithFormat:@"%@%@",WWWUrl,@"getburstingshop"]
// 大家都在领
#define kURLWithGetvouchers [NSString stringWithFormat:@"%@%@",WWWUrl,@"getvouchers"]
// 上传 个推 cid
#define kURLWithAddCid [NSString stringWithFormat:@"%@%@",WWWUrl,@"setcid"]
// 点击分享上传
#define kURLWithRecommclick [NSString stringWithFormat:@"%@%@",WWWUrl,@"recommclick"]
// 查询微信绑定
#define kURLWithIsbindwx [NSString stringWithFormat:@"%@%@",WWWUrl,@"isbindwx"]
// 微信绑定 解绑
#define kURLWithUsersetwx [NSString stringWithFormat:@"%@%@",WWWUrl,@"usersetwx"]
// 首页下的滚动消息
#define kURLWithGetsysmessage [NSString stringWithFormat:@"%@%@",WWWUrl,@"getsysmessage"]
// 获取我的推广图标
#define kURLWithGetpromotionico  [NSString stringWithFormat:@"%@%@",WWWUrl,@"getpromotionico"]
// 获取我的服务图标
#define kURLWithGetserviceico   [NSString stringWithFormat:@"%@%@",WWWUrl,@"getserviceico"]
// 旧手机号验证
#define kURLWithOldphoneverifica   [NSString stringWithFormat:@"%@%@",WWWUrl,@"oldphoneverifica"]
// 旧手机号验证
#define kURLWithSetnewphone   [NSString stringWithFormat:@"%@%@",WWWUrl,@"setnewphone"]
// 商品品牌获取
#define kURLWithGetShopBrand   [NSString stringWithFormat:@"%@%@",WWWUrl,@"getshopbrand"]

//设置分享中间页下载APP提示
#define kURLWithSetdomainapp   [NSString stringWithFormat:@"%@%@",WWWUrl,@"setdomainapp"]

//获取分享中间页下载APP提示设置

#define kURLWithGetdomainapp   [NSString stringWithFormat:@"%@%@",WWWUrl,@"getdomainapp"]


//获取H5集合
#define kURLWithGetmerchantweb   [NSString stringWithFormat:@"%@%@",WWWUrl,@"getmerchantweb"]



//获取主题商品 title 图片
#define kURLWithGetapptopic   [NSString stringWithFormat:@"%@%@",WWWUrl,@"getapptopic"]


//我的团队-新增数据
#define kURLWithGetmyteamtoday   [NSString stringWithFormat:@"%@%@",WWWUrl,@"getmyteamtoday"]
// 我的团队-团队总数据
#define kURLWithGetmyteamhistory   [NSString stringWithFormat:@"%@%@",WWWUrl,@"getmyteamhistory"]
//我的团队-团队明细
#define kURLWithGetmyteamhistorydetail   [NSString stringWithFormat:@"%@%@",WWWUrl,@"getmyteamhistorydetail"]
//我的团队-今天明细
#define kURLWithGetmyteamtodaydetail   [NSString stringWithFormat:@"%@%@",WWWUrl,@"getmyteamtodaydetail"]

//购物车查券
#define kURLWithGetcartprivilege   [NSString stringWithFormat:@"%@%@",WWWUrl,@"getcartprivilege"]




//验货直播 商品列表
#define kURLWithGetroom   [NSString stringWithFormat:@"%@%@",WWWUrl,@"getroom"]
#define kURLWithGetroomdetail   [NSString stringWithFormat:@"%@%@",WWWUrl,@"getroomdetail"]
#define kURLWithAddroomlike   [NSString stringWithFormat:@"%@%@",WWWUrl,@"addroomlike"]

//卡多分token
#define kURLWithGetCreditToken   [NSString stringWithFormat:@"%@%@",WWWUrl,@"getCreditToken"]


//猜你喜欢
#define kURLWithGetShopsearchbyyoulike   [NSString stringWithFormat:@"%@%@",WWWUrl,@"shopyoulike"]

//猜你喜欢
#define kURLWithGetConvertshop   [NSString stringWithFormat:@"%@%@",WWWUrl,@"convertshop"]

//个人中心图标
#define kURLWithGetappico   [NSString stringWithFormat:@"%@%@",WWWUrl,@"getappico"]


//呆萌币首页
#define kURLWithGetinitscore   [NSString stringWithFormat:@"%@%@",WWWUrl,@"initscore"]

//呆萌币签到等操作
#define kURLWithGetfinishscore   [NSString stringWithFormat:@"%@%@",WWWUrl,@"finishscore"]

//下级首购奖励领取
#define kURLWithGetchildfristbuy   [NSString stringWithFormat:@"%@%@",WWWUrl,@"getchildfristbuy"]

//自己首购奖励领取
#define kURLWithGetfristbuy   [NSString stringWithFormat:@"%@%@",WWWUrl,@"getfristbuy"]

//兑换呆萌币
#define kURLWithExchangescore   [NSString stringWithFormat:@"%@%@",WWWUrl,@"exchangescore"]
//呆萌币明细
#define kURLWithScorerecord   [NSString stringWithFormat:@"%@%@",WWWUrl,@"scorerecord"]
//获取冻结现金
#define kURLWithGetfrozenmny   [NSString stringWithFormat:@"%@%@",WWWUrl,@"getfrozenmny"]
//提现 现金
#define kURLWithWithdrawal   [NSString stringWithFormat:@"%@%@",WWWUrl,@"withdrawal"]
//奖金 明细
#define kURLWithScoreaccount   [NSString stringWithFormat:@"%@%@",WWWUrl,@"scoreaccount"]

//团队上级信息
#define kURLWithGetparentuserinfo   [NSString stringWithFormat:@"%@%@",WWWUrl,@"getparentuserinfo"]




//运营推广 审批列表
#define kURLWithGetMerchantReqList   [NSString stringWithFormat:@"%@%@",WWWUrl,@"merchantReqList"]
//运营推广 审批
#define kURLWithGetMerchantReqApprove   [NSString stringWithFormat:@"%@%@",WWWUrl,@"merchantReqApprove"]
//运营推广 已开通
#define kURLWithGetExtensionMerchantList   [NSString stringWithFormat:@"%@%@",WWWUrl,@"extensionMerchantList"]
//商务合作
#define kURLWithGetbusinessCooperation   [NSString stringWithFormat:@"%@%@",WWWUrl,@"businessCooperation"]


// **** 头部 ***
#define WWWNewUrl [NSString stringWithFormat:@"%@",dmjapiNew]
//登录接口获取token
#define kURLWithGetLoginToken   [NSString stringWithFormat:@"%@%@",WWWNewUrl,@"cps/user/dmjLogin"]

//拼多多类目接口
#define kURLWithGetPDDCatList   [NSString stringWithFormat:@"%@%@",WWWNewUrl,@"cps/business/pdd/getCatList"]
//拼多多类目广告
#define kURLWithGetPDDMainAdvList   [NSString stringWithFormat:@"%@%@",WWWNewUrl,@"cps/business/pdd/getMainAdvList"]
//拼多多类目商品查询
#define kURLWithGetPDDCat   [NSString stringWithFormat:@"%@%@",WWWNewUrl,@"cps/business/pdd/cat"]
//拼多多类目搜索
#define kURLWithGetPDDQuery   [NSString stringWithFormat:@"%@%@",WWWNewUrl,@"cps/business/pdd/query"]
//拼多多类我的订单
#define kURLWithGetPDDSelfOrderList   [NSString stringWithFormat:@"%@%@",WWWNewUrl,@"cps/business/pdd/getSelfOrderList"]
//拼多多类团队订单
#define kURLWithGetPDDTeamOrderList   [NSString stringWithFormat:@"%@%@",WWWNewUrl,@"cps/business/pdd/getTeamOrderList"]
//拼多多频道查询
#define kURLWithGetPDDChannel   [NSString stringWithFormat:@"%@%@",WWWNewUrl,@"cps/business/pdd/channel"]
//拼多多主题查询
#define kURLWithGetPDDTheme   [NSString stringWithFormat:@"%@%@",WWWNewUrl,@"cps/business/pdd/theme"]

//拼多多根据商品ID查询
#define kURLWithGetPDDByGoodsId   [NSString stringWithFormat:@"%@%@",WWWNewUrl,@"cps/business/pdd/getByGoodsId"]
//拼多多根据商品ID查询
#define kURLWithGetPDDgenByGoodsId   [NSString stringWithFormat:@"%@%@",WWWNewUrl,@"cps/business/pdd/genByGoodsId"]
//拼多多取消收藏
#define kURLWithGetPDDUnCollectGoodsById   [NSString stringWithFormat:@"%@%@",WWWNewUrl,@"cps/business/pdd/unCollectGoodsById"]
//拼多多收藏
#define kURLWithGetPDDCollectGoodsById   [NSString stringWithFormat:@"%@%@",WWWNewUrl,@"cps/business/pdd/collectGoodsById"]


//唯品会类目接口
#define kURLWithGetWphCatList   [NSString stringWithFormat:@"%@%@",WWWNewUrl,@"cps/business/wph/getCatList"]
//唯品会类目广告
#define kURLWithGetWphMainAdvList   [NSString stringWithFormat:@"%@%@",WWWNewUrl,@"cps/business/wph/getMainAdvList"]
//唯品会类目商品查询
#define kURLWithGetWphCat   [NSString stringWithFormat:@"%@%@",WWWNewUrl,@"cps/business/wph/cat"]
//唯品会类目搜索
#define kURLWithGetWphQuery   [NSString stringWithFormat:@"%@%@",WWWNewUrl,@"cps/business/wph/query"]
//唯品会我的订单
#define kURLWithGetWphSelfOrderList   [NSString stringWithFormat:@"%@%@",WWWNewUrl,@"cps/business/wph/getSelfOrderList"]
//唯品会团队订单
#define kURLWithGetWphTeamOrderList   [NSString stringWithFormat:@"%@%@",WWWNewUrl,@"cps/business/wph/getTeamOrderList"]
//唯品会频道查询
#define kURLWithGetWphChannel   [NSString stringWithFormat:@"%@%@",WWWNewUrl,@"cps/business/wph/channel"]
//唯品会主题查询
#define kURLWithGetWphTheme   [NSString stringWithFormat:@"%@%@",WWWNewUrl,@"cps/business/wph/theme"]
//唯品会根据商品ID查询
#define kURLWithGetWphByGoodsId   [NSString stringWithFormat:@"%@%@",WWWNewUrl,@"cps/business/wph/getByGoodsId"]
//唯品会根据商品ID查询
#define kURLWithGetWphgenByGoodsId   [NSString stringWithFormat:@"%@%@",WWWNewUrl,@"cps/business/wph/genByGoodsId"]
//唯品会取消收藏
#define kURLWithGetWphUnCollectGoodsById   [NSString stringWithFormat:@"%@%@",WWWNewUrl,@"cps/business/wph/unCollectGoodsById"]
//唯品会收藏
#define kURLWithGetWphCollectGoodsById   [NSString stringWithFormat:@"%@%@",WWWNewUrl,@"cps/business/wph/collectGoodsById"]


//收益总览
#define kURLWithGetProfitSum   [NSString stringWithFormat:@"%@%@",WWWUrl,@"getProfitSum"]


//获取平台提现信息
#define kURLWithGetExtractInfo   [NSString stringWithFormat:@"%@%@",WWWNewUrl,@"cps/user/getExtractInfo"]
//用户 平台提现操作
#define kURLWiteExtract   [NSString stringWithFormat:@"%@%@",WWWNewUrl,@"cps/user/extract"]
//用户 提现记录
#define kURLWiteGetExtractList   [NSString stringWithFormat:@"%@%@",WWWNewUrl,@"cps/user/getExtractList"]
//获取平台总览收益
#define kURLWiteGetProfitViewInfo   [NSString stringWithFormat:@"%@%@",WWWNewUrl,@"cps/user/getProfitViewInfo"]
//获取平台总览收益
#define kURLWiteGetProfitCpsInfo   [NSString stringWithFormat:@"%@%@",WWWNewUrl,@"cps/user/getProfitCpsInfo"]

//获取小程序图片
#define kURLWiteWxaGetImage   [NSString stringWithFormat:@"%@%@",WWWNewUrl,@"wxa/getImageBase64"]

// 获取商品收藏列表
#define kURLWithGetCpsGoodsCollect [NSString stringWithFormat:@"%@%@",WWWNewUrl,@"cps/user/getCpsGoodsCollect"]
// 批量取消收藏
#define kURLWithDelCpsGoodsCollect [NSString stringWithFormat:@"%@%@",WWWNewUrl,@"cps/user/delCpsGoodsCollect"]

// 批量取消收藏
#define kURLWithGenAdvUrl [NSString stringWithFormat:@"%@%@",WWWNewUrl,@"cps/business/xxx/genAdvUrl"]


//2.9.0


//首页全部接口
#define kURLWithGetHomeInit   [NSString stringWithFormat:@"%@%@",WWWUrl,@"homeInit"]


// 首页底部列表，猜你喜欢接口
#define kURLWithGetGoodsListTbMaterial   [NSString stringWithFormat:@"%@%@",WWWUrl,@"goodsList/tbMaterial"]
// 首页底部列表，猜你喜欢接口
#define kURLWithGetGoodsDetail   [NSString stringWithFormat:@"%@%@",WWWUrl,@"goodsDetail"]

// 大牌精选类目数据
#define kURLWithGetCategorys   [NSString stringWithFormat:@"%@%@",WWWUrl,@"categorys"]
// 品牌信息logo列表（大牌专场）
#define kURLWithGetBrandInfoList   [NSString stringWithFormat:@"%@%@",WWWUrl,@"brandInfoList"]
// 品牌以及商品列表（大牌专场）
#define kURLWithGetBrandAndGoodsList   [NSString stringWithFormat:@"%@%@",WWWUrl,@"brandAndGoodsList"]
// 品牌以及商品列表（大牌专场）
#define kURLWithGetSingleBrand   [NSString stringWithFormat:@"%@%@",WWWUrl,@"singleBrand"]
// 品牌以及商品列表（大牌专场）
#define kURLWithGetGoodsPromotion  [NSString stringWithFormat:@"%@%@",WWWUrl,@"goodsPromotion"]
// 蒙圈，营销素材分类
#define kURLWithGetmarketingtype  [NSString stringWithFormat:@"%@%@",WWWUrl,@"getmarketingtype"]

//3.0.0 商学院
//
#define kURLWithgetCollegeInit  [NSString stringWithFormat:@"%@%@",WWWUrl,@"getCollegeInit"]
// 列表
#define kURLWithGetArticleContentData  [NSString stringWithFormat:@"%@%@",WWWUrl,@"getArticleContentData"]
// 详情
#define kURLWithGetArticleContent  [NSString stringWithFormat:@"%@%@",WWWUrl,@"getArticleContent"]
// 详情内容点赞
#define kURLWithGetLikeArticleContent  [NSString stringWithFormat:@"%@%@",WWWUrl,@"likeArticleContent"]
// 详情内容取消点赞
#define kURLWithGetUnlikeArticleContent  [NSString stringWithFormat:@"%@%@",WWWUrl,@"unlikeArticleContent"]
// 获取分享内容
#define kURLWithGetShareArticleContent  [NSString stringWithFormat:@"%@%@",WWWUrl,@"shareArticleContent"]
// 获取商学院历史记录
#define kURLWithGetArticleContentRecord  [NSString stringWithFormat:@"%@%@",WWWUrl,@"getArticleContentRecord"]

// 商品推荐一键发圈
#define kURLWithGetSendCircle  [NSString stringWithFormat:@"%@%@",WWWUrl,@"sendCircle"]
// 营销素材一键发圈
#define kURLWithGetSendCircleMarketing  [NSString stringWithFormat:@"%@%@",WWWUrl,@"sendCircleMarketing"]

// 获取商学院历史记录
#define kURLWithGetHomeImgClick  [NSString stringWithFormat:@"%@%@",WWWUrl,@"homeImgClick"]

// 一键转链
#define kURLWithGetConvertTextToGoods  [NSString stringWithFormat:@"%@%@",WWWUrl,@"convertTextToGoods"]


// 3.2.0
//京拼唯 详情页的猜你喜欢

// 获取商学院历史记录
#define kURLWithGetRecommendByGoodsId  [NSString stringWithFormat:@"%@%@",WWWNewUrl,@"cps/business/xxx/getRecommendByGoodsId"]


// 获取商学院历史记录
#define kURLWithGetSelfOrderList  [NSString stringWithFormat:@"%@%@",WWWNewUrl,@"cps/business/xxx/getSelfOrderList"]
// 获取商学院历史记录
#define kURLWithGetTeamOrderList  [NSString stringWithFormat:@"%@%@",WWWNewUrl,@"cps/business/xxx/getTeamOrderList"]

//京东类目广告
#define kURLWithGetOtherMainAdvList   [NSString stringWithFormat:@"%@%@",WWWNewUrl,@"cps/business/xxx/getMainAdvList"]
//京东类目接口
#define kURLWithGetOtherCatList   [NSString stringWithFormat:@"%@%@",WWWNewUrl,@"cps/business/xxx/getCatList"]
//京东类目商品查询
#define kURLWithGetOtherCat   [NSString stringWithFormat:@"%@%@",WWWNewUrl,@"cps/business/xxx/cat"]
//京东根据商品ID查询
#define kURLWithGetOthergenByGoodsId   [NSString stringWithFormat:@"%@%@",WWWNewUrl,@"cps/business/xxx/genByGoodsId"]
//京东频道查询
#define kURLWithGetOtherChannel   [NSString stringWithFormat:@"%@%@",WWWNewUrl,@"cps/business/xxx/channel"]
//京东主题查询
#define kURLWithGetOtherTheme   [NSString stringWithFormat:@"%@%@",WWWNewUrl,@"cps/business/xxx/theme"]
//京东取消收藏
#define kURLWithGetOtherUnCollectGoodsById   [NSString stringWithFormat:@"%@%@",WWWNewUrl,@"cps/business/xxx/unCollectGoodsById"]
//京东收藏
#define kURLWithGetOtherCollectGoodsById   [NSString stringWithFormat:@"%@%@",WWWNewUrl,@"cps/business/xxx/collectGoodsById"]
//京东根据商品ID查询
#define kURLWithGetOtherByGoodsId   [NSString stringWithFormat:@"%@%@",WWWNewUrl,@"cps/business/xxx/getByGoodsId"]
//京东类目搜索
#define kURLWithGetOtherQuery   [NSString stringWithFormat:@"%@%@",WWWNewUrl,@"cps/business/xxx/query"]
//京东类我的订单
#define kURLWithGetOtherSelfOrderList   [NSString stringWithFormat:@"%@%@",WWWNewUrl,@"cps/business/xxx/getSelfOrderList"]
//京东类团队订单
#define kURLWithGetOtherTeamOrderList   [NSString stringWithFormat:@"%@%@",WWWNewUrl,@"cps/business/xxx/getTeamOrderList"]

//京东 主题页广告
#define kURLWithGetOtherInitMain    [NSString stringWithFormat:@"%@%@",WWWNewUrl,@"cps/business/xxx/initMain"]

//3.3.0

// 获取萌圈爆款推荐类目
#define kURLWithGetrecommmenttype  [NSString stringWithFormat:@"%@%@",WWWUrl,@"getrecommmenttype"]


#define kURLWithGetRankingType  [NSString stringWithFormat:@"%@%@",WWWUrl,@"hdk/getRankingType"]
#define kURLWithGetRankingList  [NSString stringWithFormat:@"%@%@",WWWUrl,@"hdk/getRankingList"]

//3.5.0
#define kURLWithLoginbysy  [NSString stringWithFormat:@"%@%@",WWWUrl,@"loginbysy"]
//3.5.1
#define kURLWithWriteOffUserCancelInit  [NSString stringWithFormat:@"%@%@",WWWUrl,@"userCancelInit"]
#define kURLWithWriteOffUserCancel  [NSString stringWithFormat:@"%@%@",WWWUrl,@"userCancel"]
#define kURLWithWxbindphonebysy  [NSString stringWithFormat:@"%@%@",WWWUrl,@"wxbindphonebysy"]

//3.6.0
#define kURLWithPDDIsBindAuth  [NSString stringWithFormat:@"%@%@",WWWNewUrl,@"cps/business/pdd/isBindAuth"]
#define kURLWithCpsGoodsFootprint  [NSString stringWithFormat:@"%@%@",WWWNewUrl,@"cps/user/getCpsGoodsFootprint"]

//3.6.2
#define kURLWithGetSuperCategory  [NSString stringWithFormat:@"%@%@",WWWUrl,@"dtk/getSuperCategory"]
#define kURLWithGetSuperGoodsList  [NSString stringWithFormat:@"%@%@",WWWUrl,@"dtk/getSearchGoodsList"]

//3.7.0

//足迹
#define kURLWithGetNewUserFootPrint  [NSString stringWithFormat:@"%@%@",WWWUrl,@"getUserFootPrintNew"]

//删除足迹
#define kURLWithGetDelFootPrint  [NSString stringWithFormat:@"%@%@",WWWUrl,@"delFootPrint"]
#define kURLWithGetJPWDelFootPrint  [NSString stringWithFormat:@"%@%@",WWWNewUrl,@"cps/user/delCpsGoodsFootPrint"]

//收藏
#define kURLWithGetNewUserCollection  [NSString stringWithFormat:@"%@%@",WWWUrl,@"getUserCollectionNew"]


//3.7.2
//闪电玩地址
#define kURLWithGetAuthorizationLink  [NSString stringWithFormat:@"%@%@",WWWUrl,@"sdw/getAuthorizationLink"]
//淘宝 我的榜单/团队榜单
#define kURLWithGetOrderRankingList [NSString stringWithFormat:@"%@%@",WWWUrl,@"getOrderRankingList"]

//3.7.3
//京东 我的榜单
#define kURLWithGetCpsSelfOrderRanking [NSString stringWithFormat:@"%@%@",WWWNewUrl,@"cps/business/xxx/getSelfOrderRanking"]
//京东 团队榜单
#define kURLWithGetCpsTeamOrderRanking [NSString stringWithFormat:@"%@%@",WWWNewUrl,@"cps/business/xxx/getTeamOrderRanking"]
//爆款推荐新接口
#define kURLWithGetRecommendType [NSString stringWithFormat:@"%@%@",WWWUrl,@"getRecommendType"]
//爆款推荐新接口
#define kURLWithGetRecommendNew [NSString stringWithFormat:@"%@%@",WWWUrl,@"getRecommend"]
//3.8.2
//穿山甲广告
#define kURLWithGetcsjframeadv  [NSString stringWithFormat:@"%@%@",WWWUrl,@"getcsjframeadv"]

//3.9.0
//穿山甲广告
#define kURLWithGetFrameAdvThird  [NSString stringWithFormat:@"%@%@",WWWUrl,@"getFrameAdvThird"]

//3.9.1
#define kURLWithGetRedPackage  [NSString stringWithFormat:@"%@%@",WWWUrl,@"redpackage/initRedPackage"]

#define kURLWithGetrReceiveRedPackage  [NSString stringWithFormat:@"%@%@",WWWUrl,@"redpackage/receiveRedPackage"]
//总的领取的红包记录
#define kURLWithGetRedPackageRecord  [NSString stringWithFormat:@"%@%@",WWWUrl,@"redpackage/getRedPackageRecord"]
//红包提现详情
#define kURLWithGetRedPackageWithdrawalsInfo  [NSString stringWithFormat:@"%@%@",WWWUrl,@"redpackage/getWithdrawalsInfo"]
//红包提现
#define kURLWithGetRedPackageWithdrawals  [NSString stringWithFormat:@"%@%@",WWWUrl,@"redpackage/withdrawals"]
//红包提现记录
#define kURLWithGetRedPackageWithdrawalRecord  [NSString stringWithFormat:@"%@%@",WWWUrl,@"redpackage/withdrawalRecord"]
//红包领取记录
#define kURLWithGetRedPackageRecordByHour  [NSString stringWithFormat:@"%@%@",WWWUrl,@"redpackage/getRedPackageRecordByHour"]
//红包广告获取
#define kURLWithGetRedAdvertisement  [NSString stringWithFormat:@"%@%@",WWWUrl,@"redpackage/getadvertisement"]


//3.9.2
//邀请好友获得金额

#define kURLWithGetMerchantScore  [NSString stringWithFormat:@"%@%@",WWWUrl,@"getMerchantScore"]
//获取日历列表
#define kURLWithGetUserTakeoutRemind  [NSString stringWithFormat:@"%@%@",WWWUrl,@"getUserTakeoutRemind"]
//操作日历列表状态
#define kURLWithSaveUserTakeoutRemind  [NSString stringWithFormat:@"%@%@",WWWUrl,@"saveUserTakeoutRemind"]

//3.9.3
//视频带货 类目列表
#define kURLWithGetPageTrillCategoryList  [NSString stringWithFormat:@"%@%@",WWWUrl,@"trill/getPageTrillCategoryList"]
//视频带货 列表
#define kURLWithGetPageTrillList  [NSString stringWithFormat:@"%@%@",WWWUrl,@"trill/getPageTrillList"]
//视频带货 详情
#define kURLWithGetTrillDetail  [NSString stringWithFormat:@"%@%@",WWWUrl,@"trill/getTrillDetail"]
//点赞
#define kURLWithGetAddTrillLike  [NSString stringWithFormat:@"%@%@",WWWUrl,@"trill/addTrillLike"]
//获取点赞收藏状态
#define kURLWithGetTrillLikeAndCollectStatus  [NSString stringWithFormat:@"%@%@",WWWUrl,@"trill/getTrillLikeAndCollectStatus"]

//开屏广告成功上传信息
#define kURLWithGethandleAdvThirdUser  [NSString stringWithFormat:@"%@%@",WWWUrl,@"handleAdvThirdUser"]



#define SDDownloaderHeaderValue @"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/bmp,image/x-bmp,*/*;q=0.8"

+(NSString *)reviseString:(NSString *)string;

@end
