//
//  DCCycleScrollView.m
//  DCCycleScrollView
//
//  Created by cheyr on 2018/2/27.
//  Copyright © 2018年 cheyr. All rights reserved.
//

#import "DCCycleScrollView.h"
#import "UIImageView+WebCache.h"
#import "DCCycleScrollViewCell.h"
#import "DCCycleScrollViewFlowLayout.h"
#import "DMTool.h"
#import "YXAlertView.h"
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width

@interface DCCycleScrollView()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong) UIImageView *backgroundImageView;
@property (nonatomic,strong) DCCycleScrollViewFlowLayout *flowLayout;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSArray *imgArr;//图片数组
@property (nonatomic,assign) NSInteger totalItems;//item总数
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) NSUInteger currentpage;//当前页
@end

static NSString *const cellID = @"cellID";

@implementation DCCycleScrollView
{
    float _oldPoint;
    NSInteger _dragDirection;
}
#pragma mark  - life cycle
+(instancetype)cycleScrollViewWithFrame:(CGRect)frame shouldInfiniteLoop:(BOOL)infiniteLoop imageGroups:(NSArray *)imageGroups
{
    DCCycleScrollView *cycleScrollView = [[DCCycleScrollView alloc]initWithFrame:frame];
    cycleScrollView.infiniteLoop = infiniteLoop;
    cycleScrollView.autoScroll = infiniteLoop;
    cycleScrollView.imgArr = imageGroups;
    return cycleScrollView;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self initialization];
        [self addSubview:self.collectionView];
       // [self addSubview:self.pageControl];
    }
    return self;
}
-(void)initialization
{
    //初始化
    _infiniteLoop = YES;
    _autoScroll = YES;
    _isZoom = NO;
    _itemWidth = self.bounds.size.width;
    _itemSpace = 0;
    _imgCornerRadius = 0;
    _autoScrollTimeInterval = 2;
    _pageControl.currentPage = 0;
    _bannerImageViewContentMode = UIViewContentModeScaleToFill;
}
-(CGFloat )defaultSpace
{
    return (kScreenWidth - self.itemWidth)/2;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.collectionView.frame = self.bounds;
    self.pageControl.frame = CGRectMake(0, self.bounds.size.height - 30, self.bounds.size.width, 30);
    self.flowLayout.itemSize = CGSizeMake(_itemWidth, self.bounds.size.height);
    self.flowLayout.minimumLineSpacing = self.itemSpace;
    
    if(self.collectionView.contentOffset.x == 0 && _totalItems > 0)
    {
        NSInteger targeIndex = 0;
        if(self.infiniteLoop)
        {//无线循环
            // 如果是无限循环，应该默认把 collection 的 item 滑动到 中间位置。
            // 注意：此处 totalItems 的数值，其实是图片数组数量的 100 倍。
            // 乘以 0.5 ，正好是取得中间位置的 item 。图片也恰好是图片数组里面的第 0 个。
            targeIndex = _totalItems * 0.5;
        }else
        {
            targeIndex = 0;
        }
        //设置图片默认位置
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:targeIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        _oldPoint = self.collectionView.contentOffset.x;
        self.collectionView.userInteractionEnabled = YES;
    }
}
#pragma mark  - event

#pragma mark  - delegate
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.collectionView.userInteractionEnabled = NO;
    if (!self.imgArr.count) return; // 解决清除timer时偶尔会出现的问题
    NSInteger currentPage = [self currentIndex] % self.imgArr.count;
    self.pageControl.currentPage = currentPage;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self currentIndex] inSection:0];
      
     //  [self.collectionView layoutIfNeeded];
      
     
          DCCycleScrollViewCell *cell = (DCCycleScrollViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
          
          if ([self.delegate respondsToSelector:@selector(cycleScrollView:scrollItemAtIndex:image:)]) {
              [self.delegate cycleScrollView:self scrollItemAtIndex:[self currentIndex] % self.imgArr.count image:cell.imageView.image];
          }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _oldPoint = scrollView.contentOffset.x;
    if (self.autoScroll) {
        [self invalidateTimer];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.autoScroll) {
        [self setupTimer];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:self.collectionView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    self.collectionView.userInteractionEnabled = YES;
    if (!self.imgArr.count) return; // 解决清除timer时偶尔会出现的问题
}

//手离开屏幕的时候
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    if(!self.infiniteLoop) return;//如果不是无限轮播，则返回
    
    //如果是向右滑或者滑动距离大于item的一半，则像右移动一个item+space的距离，反之向左
    float currentPoint = scrollView.contentOffset.x;
    float moveWidth = currentPoint-_oldPoint;
    int shouldPage = moveWidth/(self.itemWidth/2);
    if (velocity.x>0 || shouldPage > 0) {
        _dragDirection = 1;
    }else if (velocity.x<0 || shouldPage < 0){
        _dragDirection = -1;
    }else{
        _dragDirection = 0;
    }
    self.collectionView.userInteractionEnabled = NO;
    NSInteger currentIndex = (_oldPoint + (self.itemWidth + self.itemSpace) * 0.5) / (self.itemSpace + self.itemWidth);

    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:currentIndex + _dragDirection inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];

}

//开始减速的时候
- (void)scrollViewWillBeginDecelerating: (UIScrollView *)scrollView{
    if(!self.infiniteLoop) return;//如果不是无限轮播，则返回
    //松开手指滑动开始减速的时候，设置滑动动画
    NSInteger currentIndex = (_oldPoint + (self.itemWidth + self.itemSpace) * 0.5) / (self.itemSpace + self.itemWidth);

    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:currentIndex + _dragDirection inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

#pragma mark  - 数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _totalItems;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DCCycleScrollViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    long itemIndex = (int) indexPath.item % self.imgArr.count;
     NSString *imagePath = self.imgArr[itemIndex];
    
         if ([imagePath hasPrefix:@"http"]) {
           //  [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imagePath] placeholderImage:self.cellPlaceholderImage];
             
             [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imagePath] placeholderImage:[[YXAlertView shareInstance] CSPlaceholderImageWithWidth:_flowLayout.itemSize.width height:_flowLayout.itemSize.height] options:SDWebImageRetryFailed completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                 if (image) {
                     DMLog(@"indexPath == %ld --- %ld--%ld", (long)indexPath.row, (long)indexPath.section , itemIndex);
                     
                     UIImage *newImg = [self CSImage:image AddText:@"" index:0];
                     cell.imageView.image = newImg;
                     cell.contentView.backgroundColor = [UIColor clearColor];
                     if (itemIndex == 0) {
                         
                         if ([self.delegate respondsToSelector:@selector(cycleScrollView:scrollItemAtIndex:image:)]) {
                             [self.delegate cycleScrollView:self scrollItemAtIndex:[self currentIndex] % self.imgArr.count image:cell.imageView.image];
                         }
                        
                     }
                     
                 }else{
                    
                 }
             }];
             
             
             
         }
         else {
             UIImage *image = [UIImage imageNamed:imagePath];
             if (!image) {
                 [UIImage imageWithContentsOfFile:imagePath];
              }
         cell.imageView.image = image;
        }

    cell.imageView.contentMode = self.bannerImageViewContentMode;
    cell.imgCornerRadius = self.imgCornerRadius;
    return cell;
}
#pragma mark  - 代理方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(cycleScrollView:didSelectItemAtIndex:)]) {
        [self.delegate cycleScrollView:self didSelectItemAtIndex:indexPath.row % self.imgArr.count];
    }
}
#pragma mark  - notification

#pragma mark  - private
- (void)setupTimer
{
    [self invalidateTimer]; // 创建定时器前先停止定时器，不然会出现僵尸定时器，导致轮播频率错误
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollTimeInterval target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    _timer = timer;
    
}
//销毁定时器
- (void)invalidateTimer
{
    [_timer invalidate];
    _timer = nil;
}
-(void)automaticScroll
{
    if(_totalItems == 0) return;
    
    NSInteger currentIndex = [self currentIndex];
    
    NSInteger targetIndex = currentIndex + 1;
    
    [self scrollToIndex:targetIndex];
}
-(NSInteger)currentIndex
{
    if(self.collectionView.frame.size.width == 0 || self.collectionView.frame.size.height == 0)
        return 0;
    NSInteger index = 0;
    
    if (_flowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {//水平滑动
        index = (self.collectionView.contentOffset.x + (self.itemWidth + self.itemSpace) * 0.5) / (self.itemSpace + self.itemWidth);
    }else{
        index = (self.collectionView.contentOffset.y + _flowLayout.itemSize.height * 0.5)/ _flowLayout.itemSize.height;
    }
    return MAX(0,index);
}
-(void)scrollToIndex:(NSInteger)index
{
    if(index >= _totalItems) //滑到最后则调到中间
    {
        if(self.infiniteLoop)
        {
            index = _totalItems * 0.5;
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        }
        return;
    }
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];

}
#pragma mark  - public
/**设置分页滑动属性（如果infiniteLoop属性为yes，则设置无效）*/
-(void)setCollectionViewPagingEnabled:(BOOL)pagingEnabled
{
    if(self.infiniteLoop == NO)
    {
        self.collectionView.pagingEnabled = pagingEnabled;
    }
}
#pragma mark  - setter or getter
- (void)setPlaceholderImage:(UIImage *)placeholderImage
{
    _placeholderImage = placeholderImage;
    
    if (!self.backgroundImageView) {
        UIImageView *bgImageView = [UIImageView new];
        bgImageView.frame = self.collectionView.frame;
        bgImageView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:bgImageView];
        [self insertSubview:bgImageView belowSubview:self.collectionView];
        self.backgroundImageView = bgImageView;
    }
    self.backgroundImageView.image = placeholderImage;
}
-(void)setItemWidth:(CGFloat)itemWidth
{
    _itemWidth = itemWidth;
    self.flowLayout.itemSize = CGSizeMake(itemWidth, self.bounds.size.height);
}
-(void)setItemSpace:(CGFloat)itemSpace
{
    _itemSpace = itemSpace;
    self.flowLayout.minimumLineSpacing = itemSpace;
}
-(void)setIsZoom:(BOOL)isZoom
{
    _isZoom = isZoom;
    self.flowLayout.isZoom = isZoom;
}
-(void)setImgArr:(NSArray *)imgArr
{
    _imgArr = imgArr;
    self.pageControl.numberOfPages = imgArr.count;
    //如果循环则100倍，
    _totalItems = self.infiniteLoop?imgArr.count * 100:imgArr.count;
    if(_imgArr.count > 0)
    {
        self.collectionView.scrollEnabled = YES;
        [self setAutoScroll:self.autoScroll];
    }else
    {
        //不循环
        self.collectionView.scrollEnabled = NO;
        [self invalidateTimer];
    }
    
    [self.collectionView reloadData];
        
}
-(void)setAutoScroll:(BOOL)autoScroll
{
    if(self.infiniteLoop)
    {
        _autoScroll = autoScroll;
        //创建之前，停止定时器
        [self invalidateTimer];
        
        if (_autoScroll) {
            [self setupTimer];
        }
    }else
    {
        _autoScroll = NO;
    }

}
-(UICollectionView *)collectionView
{
    if(_collectionView == nil)
    {
        _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:self.flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollsToTop = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        
        //注册cell
        [_collectionView registerClass:[DCCycleScrollViewCell class] forCellWithReuseIdentifier:cellID];

    }
    return _collectionView;
}
-(UIPageControl *)pageControl
{
    if(_pageControl == nil)
    {
        _pageControl = [[UIPageControl alloc]init];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    }
    return _pageControl;
}
-(DCCycleScrollViewFlowLayout *)flowLayout
{
    if(_flowLayout == nil)
    {
        _flowLayout = [[DCCycleScrollViewFlowLayout alloc]init];
        _flowLayout.isZoom = self.isZoom;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout.minimumLineSpacing = 0;

    }
    return _flowLayout;
}

-(UIImage *)CSImage:(UIImage *)img AddText:(NSString *)text index:(NSUInteger )index
{
    
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 375, 667)];
    imageView.image = img;
    
    
    UIView *erView = [[UIView alloc]initWithFrame:CGRectMake(125, 451, 129, 129)];
    erView.backgroundColor = [UIColor whiteColor];
    erView.layer.masksToBounds = YES;
    erView.layer.cornerRadius = 8.0f;
    [imageView addSubview:erView];
    
    
    
    
    //分享带二维码
    UIImage *erImg =  [DCCycleScrollView qrImageForString:[NSString stringWithFormat:@"%@", self.erStr] imageSize:77 logoImageSize:0];
    UIImageView *erImgView = [[UIImageView alloc]initWithFrame:CGRectMake(12, 12 , 104, 104)];
    erImgView.image = erImg;
    [erView addSubview:erImgView];
    
    UILabel *ttLab = [[UILabel alloc]initWithFrame:CGRectMake(125, 451+129+6, 129, 20)];
    ttLab.text = @"—— 邀请码 ——";
    ttLab.textColor = [UIColor whiteColor];
    ttLab.font = [UIFont systemFontOfSize:17];
    ttLab.textAlignment = NSTextAlignmentCenter;
    ttLab.adjustsFontSizeToFitWidth = YES;
    [imageView addSubview:ttLab];
    
    UILabel *inviteNumLab = [[UILabel alloc]initWithFrame:CGRectMake(141, 451+129+6+20+6, 99, 24)];
    inviteNumLab.text = [NSString stringWithFormat:@"%@",self.inviteNum];
    inviteNumLab.backgroundColor = [UIColor whiteColor];
    inviteNumLab.textColor = textMinorColor33;
    inviteNumLab.font = [UIFont systemFontOfSize:17];
    inviteNumLab.textAlignment = NSTextAlignmentCenter;
    inviteNumLab.adjustsFontSizeToFitWidth = YES;
    inviteNumLab.layer.masksToBounds = YES;
    inviteNumLab.layer.cornerRadius = 12;
    [imageView addSubview:inviteNumLab];
    
    
    
    return [self convertViewToImage:imageView];
    
    
}

+ (UIImage *)qrImageForString:(NSString *)string imageSize:(CGFloat)Imagesize logoImageSize:(CGFloat)waterImagesize{
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];//通过kvo方式给一个字符串，生成二维码
    [filter setValue:@"M" forKey:@"inputCorrectionLevel"];//设置二维码的纠错水平，越高纠错水平越高，可以污损的范围越大
    CIImage *outPutImage = [filter outputImage];//拿到二维码图片
    return [[self alloc] createNonInterpolatedUIImageFormCIImage:outPutImage withSize:Imagesize waterImageSize:waterImagesize];
}

- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size waterImageSize:(CGFloat)waterImagesize{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    //创建一个DeviceGray颜色空间
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    //CGBitmapContextCreate(void * _Nullable data, size_t width, size_t height, size_t bitsPerComponent, size_t bytesPerRow, CGColorSpaceRef  _Nullable space, uint32_t bitmapInfo)
    //width：图片宽度像素
    //height：图片高度像素
    //bitsPerComponent：每个颜色的比特值，例如在rgba-32模式下为8
    //bitmapInfo：指定的位图应该包含一个alpha通道。
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    //创建CoreGraphics image
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef); CGImageRelease(bitmapImage);
    
    //原图
    UIImage *outputImage = [UIImage imageWithCGImage:scaledImage];
    //给二维码加 logo 图
    UIGraphicsBeginImageContextWithOptions(outputImage.size, NO, [[UIScreen mainScreen] scale]);
    [outputImage drawInRect:CGRectMake(0,0 , size, size)];
    //    //logo图
    //    UIImage *waterimage = [UIImage imageNamed:@"icon_imgApp"];
    //    //把logo图画到生成的二维码图片上，注意尺寸不要太大（最大不超过二维码图片的%30），太大会造成扫不出来
    //    [waterimage drawInRect:CGRectMake((size-waterImagesize)/2.0, (size-waterImagesize)/2.0, waterImagesize, waterImagesize)];
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newPic;
}



-(UIImage*)convertViewToImage:(UIView*)v
{
    CGSize s = v.bounds.size;
    
    
    
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [v.layer renderInContext:context];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    v.layer.contents = nil;
    return image;
    
}

@end
