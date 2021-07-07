//
//  NetWorkManager.m
//  DaiMengJia
//
//  Created by 呆萌价 on 2017/11/20.
//  Copyright © 2017年 呆萌价. All rights reserved.
//


#define  BASE_URL      @""
//#import "LoginViewController.h"
#import "NetWorkManager.h"
#import <CommonCrypto/CommonDigest.h>
#import "AFNetworkActivityIndicatorManager.h"
#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVAssetExportSession.h>
#import <AVFoundation/AVMediaFormat.h>
#import "UIImage+Category.h"
//#import <AlibcTradeSDK/AlibcTradeSDK.h>
#import "MD5Helper.h"
#import "DMTool.h"

#import "YJProgressHUD.h"
//#import <GTSDK/GeTuiSdk.h>     // GetuiSdk头文件应
#import <AdSupport/AdSupport.h>
@implementation NetWorkManager


#pragma mark - shareManager
/**
 *  获得全局唯一的网络请求实例单例方法
 *
 *  @return 网络请求类的实例
 */

+(instancetype)shareManager
{
    static NetWorkManager * manager = nil;
    
//    static dispatch_once_t onceToken;
//
//    dispatch_once(&onceToken, ^{
    
        manager = [[self alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
        
 //   });
    
    return manager;
}


+(void)setBaiChuan{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        //阿里百川 初始化
        // 百川平台基础SDK初始化，加载并初始化各个业务能力插件
//        [[AlibcTradeSDK sharedInstance] asyncInitWithSuccess:^{
//            DMLog(@"阿里百川初始化成功");
//
//        } failure:^(NSError *error) {
//            DMLog(@"阿里百川初始化失败Init233233 failed: %@", error.description);
//        }];
//
//        //    // 开发阶段打开日志开关，方便排查错误信息
//        //    //默认调试模式打开日志,release关闭,可以不调用下面的函数
//        [[AlibcTradeSDK sharedInstance] setDebugLogOpen:YES];
        
    });
    
    
}

#pragma mark - 重写initWithBaseURL
/**
 *
 *
 *  @param url baseUrl
 *
 *  @return 通过重写夫类的initWithBaseURL方法,返回网络请求类的实例
 */
-(instancetype)initWithBaseURL:(NSURL *)url{
    
    if (self = [super initWithBaseURL:url]) {
        
        //#warning 可根据具体情况进行设置
        NSAssert(url,@"您需要为您的请求设置baseUrl");
        
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
        
        /**设置请求超时时间*/
        self.requestSerializer.timeoutInterval = 120;
        
        /**设置相应的缓存策略*/
        
        self.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        
        /**分别设置请求以及相应的序列化器*/
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
        
    
        self.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        AFJSONResponseSerializer * response = [AFJSONResponseSerializer serializer];
  
        response.removesKeysWithNullValues = YES;
        
        self.responseSerializer = response;
        
        [self.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
      
        
        [self.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"Authorization"] forHTTPHeaderField:@"Authorization"];
        
        /**设置可接受的类型*/
        [self.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/plain",@"application/json",@"text/json",@"text/javascript",@"text/html",@"image/bmp", nil ]];
       
        self.requestSerializer.timeoutInterval = 120;
        
    }
    
    return self;
}

#pragma mark - 网络请求的类方法---get/post
/**
 *  网络请求的实例方法
 *
 *  @param type         get / post
 *  @param urlString    请求的地址
 *  @param paraments    请求的参数
 *  @param successBlock 请求成功的回调
 *  @param failureBlock 请求失败的回调
 */

+(void)requestWithType:(HttpRequestType)type withUrlString:(NSString *)urlString withParaments:(id)paraments withSuccessBlock:(requestSuccess)successBlock withFailureBlock:(requestFailure)failureBlock progress:(downloadProgress)progress {
       
   
    NSDictionary *urlDic  = [NSDictionary dictionary];
    if ( [urlString isEqualToString:kURLWithSetCustomServer] || [urlString isEqualToString:kURLWithUserFeedBack] || [urlString isEqualToString:kURLWithUserInfoEdit] || [urlString isEqualToString:@"http://img01.taobaocdn.com:80/tfscom/TB16_qrIKL2gK0jSZFmXXc7iXXa"] ) {
        
        urlDic = (NSDictionary *)paraments;
        NSDate *senddate = [NSDate date];
        NSString *date2 = [NSString stringWithFormat:@"%ld", (long)[senddate timeIntervalSince1970]];
        NSMutableDictionary *urlDict = [@{
                                         @"devversion":[NSString stringWithFormat:@"%@", VERSION],
                                         @"devtype":@"01",
                                         @"merchantid":[[NSUserDefaults standardUserDefaults] objectForKey:@"merchantid"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"merchantid"]:@"2",
                                         @"reqttime":date2,
                                         @"userid":[[NSUserDefaults standardUserDefaults] objectForKey:@"userid"]?[[NSUserDefaults standardUserDefaults] objectForKey:@"userid"]:@"43",
                                         @"apiversion":@"24",
                                         @"device_type":@"IDFA",
                                         @"device_encrypt":@"MD5",
                                         @"device_value": [MD5Helper md5Encrypt:[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString]]
                                         } mutableCopy];
        
        [urlDict addEntriesFromDictionary:urlDic];
        
        urlDic = [NSDictionary dictionaryWithDictionary:urlDict];
        
        //晒单上传图片时 不做md5签名
        DMLog(@"不签名 不签名");
        
    }
    else{
         urlDic =  [self signToDic:paraments];
         DMLog(@"请求参数：%@",urlDic)
    }
    DMLog(@"请求URL： %@%@",BASE_URL,urlString);
    
    switch (type) {
            
        case HttpRequestTypeGet:
        {
            
            [[NetWorkManager shareManager] GET:urlString parameters:urlDic headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                 progress(downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                DMLog(@"header1122112211220 == %@", [NetWorkManager shareManager].requestSerializer.HTTPRequestHeaders);
                              
                NSDictionary *dict = (NSDictionary *)responseObject;
                NSString *code = [NSString stringWithFormat:@"%@", dict[@"code"]];
                
                if ([urlString containsString:@"cps/"]  && [code isEqualToString:@"501"]) {
                   
                    DMLog(@"code == %@", code);
                    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"login"] isEqualToString:@"login"] ) {
                        
                        UIWindow* window =  [UIApplication sharedApplication].keyWindow;
                        UITabBarController *tab = (UITabBarController *)window.rootViewController;
                        UINavigationController *nav = tab.viewControllers[tab.selectedIndex];
                        
//                        LoginViewController *loginVC = [[LoginViewController alloc]init];
//                        if (loginVC) {
//                            [nav pushViewController:loginVC animated:YES];
//                        }
                    }
                    else{
                        
                           NSDictionary *urlDic2 = @{
                                                      @"userid":[[NSUserDefaults standardUserDefaults] objectForKey:@"userid"],
                                                      };
                        
                            [NetWorkManager  requestWithType:0 withUrlString:kURLWithGetLoginToken withParaments:urlDic2 withSuccessBlock:^(NSDictionary *responseObject) {
                                
                                DMLog(@"获取登录token00 =  %@ %@",  responseObject, responseObject[@"message"]);
                               
                               
                                NSString *result = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
                                if ([result isEqualToString:@"1"]) {
                                  
                                    NSString *code = [NSString stringWithFormat:@"%@", responseObject[@"code"]];
                                   
                                    if ([code isEqualToString:@"200"]) {
                                        
                                       NSDictionary *dataDict = (NSDictionary *)responseObject[@"data"];
                                      
                                        NSString *token = [NSString stringWithFormat:@"%@", dataDict[@"token"]];
                                        
                                        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                                        [defaults setValue:token forKey:@"Authorization"];
                                        
                                        NSString *microId = [NSString stringWithFormat:@"%@", dataDict[@"microId"]];
                                        [defaults setValue:microId forKey:@"microId"];
                                        
                                        NSString *wechatMicroId = [NSString stringWithFormat:@"%@", dataDict[@"wechatMicroId"]];
                                        [defaults setValue:wechatMicroId forKey:@"wechatMicroId"];
                                        
                                    }
                                    
                                }
                                
                                //*******
                            } withFailureBlock:^(NSError *error) {
                                
                                DMLog(@"获取登录token11 =  %@",  error);
                                
                            } progress:^(float progress) {
                                
                            }];
                        
                        successBlock(responseObject);
                    }
                    
                }else{
                   successBlock(responseObject);
                }
                
                   
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 failureBlock(error);
            }];

            break;
        }
        case HttpRequestTypePost:
        {
            
            [[NetWorkManager shareManager] POST:urlString parameters:urlDic headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
                 progress(uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                DMLog(@"header112211221122 == %@", [NetWorkManager shareManager].requestSerializer.HTTPRequestHeaders);
                           NSDictionary *dict = (NSDictionary *)responseObject;
                               NSString *code = [NSString stringWithFormat:@"%@", dict[@"code"]];
                               
                               if ([urlString containsString:@"cps/"]  && [code isEqualToString:@"501"]) {
                                  
                                   DMLog(@"code == %@", code);
                                   if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"login"] isEqualToString:@"login"] ) {
                                       
                                       UIWindow* window =  [UIApplication sharedApplication].keyWindow;
                                       UITabBarController *tab = (UITabBarController *)window.rootViewController;
                                       UINavigationController *nav = tab.viewControllers[tab.selectedIndex];
                                       
//                                       LoginViewController *loginVC = [[LoginViewController alloc]init];
//                                       if (loginVC) {
//                                           [nav pushViewController:loginVC animated:YES];
//                                       }
                                   }
                                   else{
                                       
                                       
                                          NSDictionary *urlDic2 = @{
                                                                     @"userid":[[NSUserDefaults standardUserDefaults] objectForKey:@"userid"],
                                                                     };
                                       
                                           [NetWorkManager  requestWithType:0 withUrlString:kURLWithGetLoginToken withParaments:urlDic2 withSuccessBlock:^(NSDictionary *responseObject) {
                                               
                                               DMLog(@"获取登录token00 =  %@ %@",  responseObject, responseObject[@"message"]);
                                              
                                              
                                               NSString *result = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
                                               if ([result isEqualToString:@"1"]) {
                                                 
                                                   NSString *code = [NSString stringWithFormat:@"%@", responseObject[@"code"]];
                                                  
                                                   if ([code isEqualToString:@"200"]) {
                                                       
                                                      NSDictionary *dataDict = (NSDictionary *)responseObject[@"data"];
                                                     
                                                       NSString *token = [NSString stringWithFormat:@"%@", dataDict[@"token"]];
                                                       
                                                       NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                                                       [defaults setValue:token forKey:@"Authorization"];
                                                       
                                                       NSString *microId = [NSString stringWithFormat:@"%@", dataDict[@"microId"]];
                                                       [defaults setValue:microId forKey:@"microId"];
                                                       
                                                       NSString *wechatMicroId = [NSString stringWithFormat:@"%@", dataDict[@"wechatMicroId"]];
                                                       [defaults setValue:wechatMicroId forKey:@"wechatMicroId"];
                                                       
                                                   }
                                                   
                                               }
                                               
                                               
                                               //*******
                                           } withFailureBlock:^(NSError *error) {
                                               
                                               DMLog(@"获取登录token11 =  %@",  error);
                                               
                                           } progress:^(float progress) {
                                               
                                           }];
                                       
                                       successBlock(responseObject);
                                   }
                                   
                               }else{
                                  successBlock(responseObject);
                               }
                               
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  failureBlock(error);
            }];

        }
    }
}


+(void)aa:(NSString *)error{
    AFNetworkReachabilityManager * manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                DMLog(@"网络状态未知");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                DMLog(@"没有网络");
              
                break;
            case  AFNetworkReachabilityStatusReachableViaWWAN:
                DMLog(@"3G|4G蜂窝移动网络");
               
                 [NetWorkManager setBaiChuan];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                DMLog(@"WIFI网络45");
                [NetWorkManager setBaiChuan];
                
               
                
              [[NSNotificationCenter defaultCenter] postNotificationName:@"openNet" object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"openNet111" object:nil];
                
                break;
            default:
                break;
        }
    }];
    [manager startMonitoring];
}


/**
 *  网络请求的实例方法 - (带缓存)
 *
 *  @param type         get / post
 *  @param urlString    请求的地址
 *  @param paraments    请求的参数
 *  @param successBlock 请求成功的回调
 *  @param failureBlock 请求失败的回调
 */

+(void)requestWithType:(HttpRequestType)type withUrlString:(NSString *)urlString withParaments:(id)paraments jsonCacheBlock:(requestCache)jsonCache withSuccessBlock:(requestSuccess)successBlock withFailureBlock:(requestFailure)failureBlock progress:(downloadProgress)progress{
    
    NSDictionary *responsedic = [NetWorkManager cacheJsonWithURL:urlString];
    
    if (responsedic!=nil) { //获取缓存
        
        jsonCache([NetWorkManager cacheJsonWithURL:urlString]);
    }
    
    DMLog(@"请求URL： %@%@",BASE_URL,urlString);
    DMLog(@"请求参数：%@",paraments);
    
    switch (type) {
            
        case HttpRequestTypeGet:
        {
            
            
            [[NetWorkManager shareManager] GET:urlString parameters:paraments headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                progress(downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                successBlock(responseObject);
                
                [NetWorkManager saveJsonResponseToCacheFile:responseObject andURL:urlString];
                
                DMLog(@"Get请求结果：%@",responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failureBlock(error);
                               
                DMLog(@"Error结果：%@",error);
            }];
            
            

            
            break;
        }
            
        case HttpRequestTypePost:
        {
            
            [[NetWorkManager shareManager] POST:urlString parameters:paraments headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
                 progress(uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                DMLog(@"Post请求结果：%@",responseObject);
                
                successBlock(responseObject);
                
                [NetWorkManager saveJsonResponseToCacheFile:responseObject andURL:urlString];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failureBlock(error);
                               
                DMLog(@"Error结果：%@",error);
            }];
            
            

        }
    }
}




#pragma mark - 多图上传
/**
 *  上传图片
 *
 *  @param operations   上传图片等预留参数---视具体情况而定 可移除
 *  @param imageArray   上传的图片数组
 *  @parm width      图片要被压缩到的宽度
 *  @param urlString    上传的url---请填写完整的url
 *  @param successBlock 上传成功的回调
 *  @param failureBlock 上传失败的回调
 *  @param progress     上传进度
 *
 */
+(void)uploadImageWithOperations:(NSDictionary *)operations withImageArray:(NSArray *)imageArray withtargetWidth:(CGFloat )width withUrlString:(NSString *)urlString withSuccessBlock:(requestSuccess)successBlock withFailurBlock:(requestFailure)failureBlock withUpLoadProgress:(uploadProgress)progress;
{
    //1.创建管理者对象
    
    DMLog(@"请求URL： %@%@",BASE_URL,urlString);
    
    urlString = [NSString stringWithFormat:@"%@%@",BASE_URL,urlString];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:urlString parameters:operations headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSUInteger i = 0 ;
            
            /**出于性能考虑,将上传图片进行压缩*/
            for (UIImage * image in imageArray) {
                
                //image的分类方法
                UIImage *  resizedImage =  [UIImage IMGCompressed:image targetWidth:width];
                
        
                
                NSData * imgData = UIImageJPEGRepresentation(resizedImage, .5);
                
                // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
                // 要解决此问题，
                // 可以在上传时使用当前的系统事件作为文件名
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                // 设置时间格式
                formatter.dateFormat = @"yyyyMMddHHmmss";
                NSString *str = [formatter stringFromDate:[NSDate date]];
                NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
                NSString *name = [NSString stringWithFormat:@"image_%ld.png",(long)i];
                
                //将得到的二进制图片拼接到表单中 /** data,指定上传的二进制流;name,服务器端所需参数名*/
                [formData appendPartWithFileData:imgData name:name fileName:fileName mimeType:@"image/png"];
                
                i++;
            }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
         progress(uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         failureBlock(error);
    }];
    
    

}



#pragma mark - 视频上传

/**
 *  视频上传
 *
 *  @param operations   上传视频预留参数---视具体情况而定 可移除
 *  @param videoPath    上传视频的本地沙河路径
 *  @param urlString     上传的url
 *  @param successBlock 成功的回调
 *  @param failureBlock 失败的回调
 *  @param progress     上传的进度
 */

+(void)uploadVideoWithOperaitons:(NSDictionary *)operations withVideoPath:(NSString *)videoPath withUrlString:(NSString *)urlString withSuccessBlock:(requestSuccess)successBlock withFailureBlock:(requestFailure)failureBlock withUploadProgress:(uploadProgress)progress
{
    
    
    /**获得视频资源*/
    
    AVURLAsset * avAsset = [AVURLAsset assetWithURL:[NSURL URLWithString:videoPath]];
    
    /**压缩*/
    
    
    AVAssetExportSession  *  avAssetExport = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPreset640x480];
    
    /**创建日期格式化器*/
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
    
    /**转化后直接写入Library---caches*/
    
    NSString *  videoWritePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingString:[NSString stringWithFormat:@"/output-%@.mp4",[formatter stringFromDate:[NSDate date]]]];
    
    
    avAssetExport.outputURL = [NSURL URLWithString:videoWritePath];
    
    
    avAssetExport.outputFileType =  AVFileTypeMPEG4;
    
    
    [avAssetExport exportAsynchronouslyWithCompletionHandler:^{
        
        
        switch ([avAssetExport status]) {
                
                
            case AVAssetExportSessionStatusCompleted:
            {
                
                AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
                
                
                [manager POST:urlString parameters:operations headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                    //获得沙盒中的视频内容
                                       
                                       [formData appendPartWithFileURL:[NSURL fileURLWithPath:videoWritePath] name:@"write you want to writre" fileName:videoWritePath mimeType:@"video/mpeg4" error:nil];
                } progress:^(NSProgress * _Nonnull uploadProgress) {
                      progress(uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    successBlock(responseObject);
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    failureBlock(error);
                                      
                }];
                

                
                
                
                
                
                break;
            }
            default:
                break;
        }
    }];
}

#pragma mark - 文件下载

/**
 *  文件下载
 *
 *  @param operations   文件下载预留参数---视具体情况而定 可移除
 *  @param savePath     下载文件保存路径
 *  @param urlString        请求的url
 *  @param successBlock 下载文件成功的回调
 *  @param failureBlock 下载文件失败的回调
 *  @param progress     下载文件的进度显示
 */

+(void)downLoadFileWithOperations:(NSDictionary *)operations withSavaPath:(NSString *)savePath withUrlString:(NSString *)urlString withSuccessBlock:(requestSuccess)successBlock withFailureBlock:(requestFailure)failureBlock withDownLoadProgress:(downloadProgress)progress
{
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    
    [manager downloadTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] progress:^(NSProgress * _Nonnull downloadProgress) {
        
        progress(downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        return  [NSURL URLWithString:savePath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        if (error) {
            
            failureBlock(error);
        }
        
    }];
    
}


#pragma mark -  取消所有的网络请求
/**
 *  取消所有的网络请求
 *  a finished (or canceled) operation is still given a chance to execute its completion block before it iremoved from the queue.
 */

+(void)cancelAllRequest{
    
    [[NetWorkManager shareManager].operationQueue cancelAllOperations];
}

#pragma mark -   取消指定的url请求
/**
 *  取消指定的url请求
 *
 *  @param requestType 该请求的请求类型
 *  @param string      该请求的完整url
 */

+(void)cancelHttpRequestWithRequestType:(NSString *)requestType requestUrlString:(NSString *)string{
    NSError * error;
    
    /**根据请求的类型 以及 请求的url创建一个NSMutableURLRequest---通过该url去匹配请求队列中是否有该url,如果有的话 那么就取消该请求*/
    
    NSString * urlToPeCanced = [[[[NetWorkManager shareManager].requestSerializer requestWithMethod:requestType URLString:string parameters:nil error:&error] URL] path];
    
    
    for (NSOperation * operation in [NetWorkManager shareManager].operationQueue.operations) {
        
        //如果是请求队列
        if ([operation isKindOfClass:[NSURLSessionTask class]]) {
            
            //请求的类型匹配
            BOOL hasMatchRequestType = [requestType isEqualToString:[[(NSURLSessionTask *)operation currentRequest] HTTPMethod]];
            
            //请求的url匹配
            
            BOOL hasMatchRequestUrlString = [urlToPeCanced isEqualToString:[[[(NSURLSessionTask *)operation currentRequest] URL] path]];
            
            //两项都匹配的话  取消该请求
            if (hasMatchRequestType&&hasMatchRequestUrlString) {
                
                [operation cancel];
                
            }
        }
    }
}




#pragma mark - 缓存处理 方法
+(BOOL)saveJsonResponseToCacheFile:(id)jsonResponse andURL:(NSString *)URL{
    
    NSDictionary *json = jsonResponse;
    
    NSString *path = [self cacheFilePathWithURL:URL];
    
    YYCache *cache = [[YYCache alloc] initWithPath:path];
    
    if(json!=nil)
    {
        BOOL state = [cache containsObjectForKey:URL];
        
        [cache setObject:json forKey:URL];
        
        if(state){
            
            DMLog(@"缓存写入/更新成功");
        }
        
        return state;
    }
    
    return NO;
}


+(id )cacheJsonWithURL:(NSString *)URL{
    
    id cacheJson;
    
    NSString *path = [self cacheFilePathWithURL:URL];
    
    YYCache *cache = [[YYCache alloc] initWithPath:path];
    
    BOOL state = [cache containsObjectForKey:URL];
    
    if(state){
        
        cacheJson = [cache objectForKey:URL];
    }
    
    return cacheJson;
}

+ (NSString *)cacheFilePathWithURL:(NSString *)URL {
    
    NSString *pathOfLibrary = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [pathOfLibrary stringByAppendingPathComponent:@"bcwYYCache"];
    
    [self checkDirectory:path];//check路径
    
    //文件名
    NSString *cacheFileNameString = [NSString stringWithFormat:@"URL:%@ AppVersion:%@",URL,[self appVersionString]];
    NSString *cacheFileName = [self md5StringFromString:cacheFileNameString];
    path = [path stringByAppendingPathComponent:cacheFileName];
    
    //   DDMLog(@"缓存 path = %@",path);
    
    return path;
}

+(void)checkDirectory:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    if (![fileManager fileExistsAtPath:path isDirectory:&isDir]) {
        [self createBaseDirectoryAtPath:path];
    } else {
        if (!isDir) {
            NSError *error = nil;
            [fileManager removeItemAtPath:path error:&error];
            [self createBaseDirectoryAtPath:path];
        }
    }
}

+ (void)createBaseDirectoryAtPath:(NSString *)path {
    __autoreleasing NSError *error = nil;
    [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES
                                               attributes:nil error:&error];
    if (error) {
        DMLog(@"create cache directory failed, error = %@", error);
    } else {
        
        [self addDoNotBackupAttribute:path];
    }
}

+ (void)addDoNotBackupAttribute:(NSString *)path {
    NSURL *url = [NSURL fileURLWithPath:path];
    NSError *error = nil;
    [url setResourceValue:[NSNumber numberWithBool:YES] forKey:NSURLIsExcludedFromBackupKey error:&error];
    if (error) {
        DMLog(@"error to set do not backup attribute, error = %@", error);
    }
}

+ (NSString *)md5StringFromString:(NSString *)string {
    
    if(string == nil || [string length] == 0)  return nil;
    
    const char *value = [string UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString;
}

+ (NSString *)appVersionString {
    
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}


+ (NSDictionary *)signToDic:(NSDictionary *)dict{
    
    //[[NSUserDefaults standardUserDefaults] objectForKey:@"merchantid"]
    
   

    
    NSString * loginStr = [NSString string];
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"login"] isEqualToString:@"login"]) {
        loginStr = @"1";
    }
    else{
         loginStr = @"0";
    }
    
    NSDate *senddate = [NSDate date];
    NSString *date2 = [NSString stringWithFormat:@"%ld", (long)[senddate timeIntervalSince1970]];
    
    
    NSMutableDictionary *urlDic = [@{
                                     @"devversion":[NSString stringWithFormat:@"%@", VERSION],
                                     @"devtype":@"01",
                                     @"merchantid":[[NSUserDefaults standardUserDefaults] objectForKey:@"merchantid"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"merchantid"]:@"2",
                                     @"reqttime":date2,
                                     @"userid":[[NSUserDefaults standardUserDefaults] objectForKey:@"userid"]?[[NSUserDefaults standardUserDefaults] objectForKey:@"userid"]:@"43",
                                     @"islogin":loginStr,
                                     @"apiversion":@"24",
                                     @"device_type":@"IDFA",
                                     @"device_encrypt":@"MD5",
                                     @"device_value": [MD5Helper md5Encrypt:[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString]]
                                     } mutableCopy];
    
    
    
    [urlDic addEntriesFromDictionary:dict];
   // DMLog(@"最终的 dict = %@", urlDic);
    
    NSMutableString *contentString  =[NSMutableString string];
    NSArray *keys = [urlDic allKeys];
    
    //按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    

    //拼接字符串
    for (NSString *categoryId in sortedArray) {

        [contentString appendFormat:@"%@", [urlDic objectForKey:categoryId]];
    }
    
    
    
    NSString *md5 = [contentString stringByAppendingString:MD5LastStr];
    
    DMLog(@"加密前的数据 = %@", md5);
    NSString *signStr = [MD5Helper md5Encrypt:md5];
    
    [urlDic setObject:signStr forKey:@"sign"];
    
    return urlDic;
    
    
    
}



+ (void)openPromise {
    
//    [NetWorkManager  requestWithType:1 withUrlString:@"https://www.baidu.com" withParaments:nil withSuccessBlock:^(NSDictionary *responseObject) {
//       // DMLog(@"是否弹窗 成功 =  %@  %@",  responseObject, responseObject[@"msgstr"]);
//    } withFailureBlock:^(NSError *error) {
//      //   DMLog(@"是否弹窗 失败 ");
//    } progress:^(float progress) {
//
//    }];
    
}

+(void)addClientIDWithUid:(NSString *)uid{
    
    
//    NSString *clientID = [GeTuiSdk clientId];
//  //DMLog(@"cid =233= %@", clientID);
//    NSDictionary *dict = @{
//                          // @"userid":uid,
//                           @"cid":clientID?clientID:@"",
//                           };
//    
//    [NetWorkManager  requestWithType:1 withUrlString:kURLWithAddCid withParaments:dict withSuccessBlock:^(NSDictionary *responseObject) {
//        DMLog(@"绑定个推 cid =  %@  %@   %@",  responseObject, responseObject[@"msgstr"], clientID);
//    } withFailureBlock:^(NSError *error) {
//        DMLog(@"绑定个推失败");
//    } progress:^(float progress) {
//        
//    }];
//    
}


// get请求
+ (void)getDataWithURLString:(NSString *)urlStr dic:(NSDictionary *)dic success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure{
    

    [[NetWorkManager shareManager] GET:urlStr parameters:dic headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         failure(error);
    }];
    


    
    
    
}

+ (void)postDataWithURLString:(NSString *)urlStr dic:(NSDictionary *)dic success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure{
    
    
    [[NetWorkManager shareManager] POST:urlStr parameters:dic headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         failure(error);
    }];
    
    
}



@end
