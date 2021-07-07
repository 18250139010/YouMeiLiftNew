//
//  ShowImageVC.m
//  KuaiJieCaiFu
//
//  Created by KuaiJie on 15/11/16.
//  Copyright © 2015年 KuaiJie. All rights reserved.
//

#import "ShowImageVC.h"
#import "DMTool.h"
#import "UIImageView+WebCache.h"
#import "YXAlertView.h"

#define kScrollViewImageViewOfTag 200

@interface ShowImageVC ()<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *bigScrollView;

@property (strong, nonatomic) UIScrollView *imageScrollView;

@property (strong, nonatomic) UIPageControl *pageControl;

@end

@implementation ShowImageVC



- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    self.bigScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    
    
    self.bigScrollView.contentSize = CGSizeMake(self.receivedImageArr.count * self.view.bounds.size.width, self.view.bounds.size.height-64);
    self.bigScrollView.contentOffset = CGPointMake(kScreenWidth * self.receivedIndex, kScreenHeight - 64);
    self.bigScrollView.pagingEnabled = YES;
    self.bigScrollView.delegate = self;
    self.bigScrollView.backgroundColor = [UIColor blackColor];
    _bigScrollView.showsVerticalScrollIndicator = NO;
    _bigScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.bigScrollView];
   
    
    
    if (@available(iOS 11.0, *)) {
        self.bigScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.bigScrollView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
        self.bigScrollView.scrollIndicatorInsets = self.bigScrollView.contentInset;
        
    } else {
        self.bigScrollView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-49- (iPhoneX?44:0));
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
    }
    
    
    
    for (int i = 0; i < self.receivedImageArr.count; i++) {
        
        self.imageScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(i * self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height )];
        
       // _imageScrollView.contentSize = self.view.bounds.size;
        _imageScrollView.scrollEnabled = YES;
        _imageScrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height-64);
        _imageScrollView.zoomScale = 1.0;
        _imageScrollView.maximumZoomScale = 3.0;
        _imageScrollView.minimumZoomScale = 1.0;
        _imageScrollView.bouncesZoom = YES;
        
      
        _imageScrollView.delegate = self;
        _imageScrollView.showsHorizontalScrollIndicator = NO;
        _imageScrollView.showsVerticalScrollIndicator = NO;
        
        _imageScrollView.backgroundColor = [UIColor blackColor];

        
        UIImageView *imageView = [[UIImageView alloc]init];
       
        
        if ([self.imageType isEqualToString:@"url"]) {
            
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.receivedImageArr[i]]] placeholderImage:[UIImage imageNamed:@"onecell.png"] options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            if (image) {
                //  imageView.image = image;
                [UIView transitionWithView:imageView duration:0.2 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                    
                    imageView.image = image;
                    
                } completion:nil];
                
                
            }
            else{
                  imageView.image = [UIImage imageNamed:@"onecell.png"];
            }
          
            //异步操作  frame写外面会崩溃
            CGFloat hight = self.imageScrollView.frame.size.width * imageView.image.size.height / imageView.image.size.width;
            
            
            if (hight >  self.view.bounds.size.height ) {
                
                imageView.frame = CGRectMake(0, 0, self.imageScrollView.frame.size.width, self.imageScrollView.frame.size.width * imageView.image.size.height / imageView.image.size.width);
                
                
                _imageScrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.imageScrollView.frame.size.width * imageView.image.size.height / imageView.image.size.width);
                
            }
            
            else{
                
                imageView.frame = CGRectMake(0, -20, self.imageScrollView.frame.size.width, self.imageScrollView.frame.size.width * imageView.image.size.height / imageView.image.size.width+20);
                imageView.center = self.bigScrollView.center;
                
            }
           
            
            
            
            }];

        }
        
        
        
        else if ([self.imageType isEqualToString:@"image"]) {
            
             imageView.image = _receivedImageArr[i];
            
        
            
            CGFloat hight = self.imageScrollView.frame.size.width * imageView.image.size.height / imageView.image.size.width;
            
            if (hight >  self.view.bounds.size.height ) {
               
            imageView.frame = CGRectMake(0, -20, self.imageScrollView.frame.size.width, self.imageScrollView.frame.size.width * imageView.image.size.height / imageView.image.size.width +20);
                
                
                 _imageScrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.imageScrollView.frame.size.width * imageView.image.size.height / imageView.image.size.width);
                
            }
            
            else{
                
                imageView.frame = CGRectMake(0, 0, self.imageScrollView.frame.size.width, self.imageScrollView.frame.size.width * imageView.image.size.height / imageView.image.size.width);
                imageView.center = self.bigScrollView.center;
                
            }
            
          
        }
        

        
        
        //设置双击操作
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleDoubleClickAction:)];
        tapGesture.numberOfTapsRequired = 2;
        [self.imageScrollView addGestureRecognizer:tapGesture];

        UITapGestureRecognizer *tapGestureOne = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleOneClickAction:)];
        tapGestureOne.numberOfTapsRequired = 1;
        [self.imageScrollView addGestureRecognizer:tapGestureOne];

         [tapGestureOne requireGestureRecognizerToFail:tapGesture];
        
        
        UILongPressGestureRecognizer *longPgr = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressSave:)];
        longPgr.minimumPressDuration = 1.0;
        [_imageScrollView addGestureRecognizer:longPgr];
        
        self.imageScrollView.tag = kScrollViewImageViewOfTag + i;
        [_imageScrollView addSubview:imageView];
        
        [self.bigScrollView addSubview:self.imageScrollView];
        
      
        
    }
    
    self.view.backgroundColor = [UIColor whiteColor];

    
    
    
    
    self.pageControl = [[UIPageControl alloc] init];
 
    _pageControl.numberOfPages = self.receivedImageArr.count;
    //默认是0
    _pageControl.currentPage = self.receivedIndex;
    //自动计算大小尺寸
    CGSize pageSize = [_pageControl sizeForNumberOfPages:self.receivedImageArr.count];
    
    
    
    _pageControl.bounds = CGRectMake(0, 0, self.view.frame.size.width, pageSize.height);
    _pageControl.center = CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height-_pageControl.frame.size.height/2.0-0 - (iPhoneX ?20:0));
    
   
    
     _pageControl.currentPageIndicatorTintColor = DMColor;
    

    [self.view addSubview:_pageControl];
    
    
    // Do any additional setup after loading the view.
}



//双击手势的响应方法
-(void)handleDoubleClickAction:(UIGestureRecognizer *)sender{
    //取到手势上的view视图对象,也就是小的scrollview
    UIScrollView *scrollView = (UIScrollView *)sender.view;
    //如果当前图片的大小是最小的缩放比例  则让它放到最大比例     反之，则放到最小比例
    if (scrollView.zoomScale == scrollView.minimumZoomScale) {
        [scrollView setZoomScale:scrollView.maximumZoomScale animated:YES];
    }else{
        [scrollView setZoomScale:1.0 animated:YES];
    }
}


//单击返回
- (void)handleOneClickAction:(UIGestureRecognizer *)sender{
    
 
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}



- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    if (scrollView != self.bigScrollView) {
        return scrollView.subviews.firstObject;//图片视图
    }
    return nil;

}


- (void)longPressSave:(UILongPressGestureRecognizer *)longPgr{
    
  //  NSInteger index  = longPgr.view.tag;
    
   
    
    if (longPgr.state == UIGestureRecognizerStateBegan) {
        DMLog(@"长按");
//
        [[YXAlertView shareInstance] showAlert:@"保存图片到手机相册" message:@"" cancelTitle:@"取消" titleArray:nil viewController:self confirm:^(NSInteger buttonTag) {
            
            DMLog(@"buttonTag == %ld", (long)buttonTag);
            
            switch (buttonTag) {
                case 0:
                    for (UIView *view in longPgr.view.subviews) {
                        if ([view isKindOfClass:[UIImageView class]]) {
                            UIImageView *imgView = (UIImageView *)view;
                            UIImageWriteToSavedPhotosAlbum(imgView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
                        }
                    }
                    break;
                case 1:
                    
                  
                    
                    break;
                default:
                    break;
            }
            
        }];
       
        
       
        

        
        
    }else {
        
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    
    DMLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
    
    if (error) {
            //DMLog(@"%@", error.localizedDescription);
//            [YJProgressHUD hide];
//           [YJProgressHUD showMsgWithMsgStr:@"保存图片失败，请检查相册访问权限" imageName:@"show_tipError.png" inview:self.navigationController.view afterDelayTime:1.3];
//                        return;
        }
        else {
            
//            [YJProgressHUD hide];
//            [YJProgressHUD showMsgWithMsgStr:@"保存图片完成" imageName:@"copy_success.png" inview:self.navigationController.view afterDelayTime:1.5];
            
        }
    
    
}





- (void)scrollViewDidZoom:(UIScrollView *)scrollView{

    //因为已经只允许小的scrollView可以缩放，所以，不用判断此时的参数scrollView，肯定是小的scrollView
    UIImageView *_imageView = [scrollView.subviews firstObject];//得到图片
    CGSize boundsSize = scrollView.bounds.size;
    CGRect frameToCenter = _imageView.frame;
    //如果图片的宽度比高度大
    if (frameToCenter.size.width < boundsSize.width){
        frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2;
    }else{
        frameToCenter.origin.x = 0;
    }
    


    //如果图片的高度比宽度大
    if (frameToCenter.size.height < boundsSize.height){
        frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2;
    }else{
        frameToCenter.origin.y = 0;
    }
    _imageView.frame = frameToCenter;
}



//完成拖拽的方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //如果scrollView为大的scrollView时，则响应拖拽完成的方法，
    if (scrollView == self.bigScrollView) {
        //得到整屏偏移量的个数
        NSInteger index =( self.bigScrollView.contentOffset.x )/ self.bigScrollView.bounds.size.width;
        //添加
        //便历scrollView上的子视图，得到小的uiscrollview类型的视图
        for (id tempScrollImageView in scrollView.subviews) {
            if ([tempScrollImageView isKindOfClass:[UIScrollView class]]) {
                //如果此时的视图不等于拖拽之后的视图，则把之前的视图缩放成原来的大小
                if (tempScrollImageView != (UIScrollView *)[self.bigScrollView viewWithTag:kScrollViewImageViewOfTag + index]) {
                    [tempScrollImageView setZoomScale:1.0 animated:YES];
                    
                }
            }
        }
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
     int pageCount = scrollView.contentOffset.x / self.view.frame.size.width;
     self.pageControl.currentPage = pageCount;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
