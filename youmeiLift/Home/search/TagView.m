//
//  TagView.m
//  CustomTag
//
//  Created by za4tech on 2017/12/15.
//  Copyright © 2017年 Junior. All rights reserved.
//

#import "TagView.h"
#import "DMTool.h"
#define kScreenWidth      [UIScreen mainScreen].bounds.size.width
@implementation TagView

-(void)setHotArr:(NSArray *)hotArr{
    _hotArr = hotArr;
    CGFloat marginX = 10;
    CGFloat marginY = 10;
    CGFloat height = 32;
    UIButton * markBtn;
    
    DMLog(@"hotarrrrrr == %@", _hotArr);
    for (int i = 0; i < _hotArr.count; i++) {
        
        NSDictionary *dict = (NSDictionary *)_hotArr[i];
        NSString *ttStr = [NSString stringWithFormat:@"%@" ,dict[@"title"]];
        NSString *colorStr = [NSString stringWithFormat:@"0%@" ,dict[@"bgcolor"]];
        
        CGFloat width =  [self calculateString:ttStr Width:13] +30;
        UIButton * tagBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (!markBtn) {
            tagBtn.frame = CGRectMake(marginX, marginY, width, height);
        }else{
            if (markBtn.frame.origin.x + markBtn.frame.size.width + marginX + width + marginX > kScreenWidth) {
                tagBtn.frame = CGRectMake(marginX, markBtn.frame.origin.y + markBtn.frame.size.height + marginY, width, height);
            }else{
                tagBtn.frame = CGRectMake(markBtn.frame.origin.x + markBtn.frame.size.width + marginX, markBtn.frame.origin.y, width, height);
            }
        }
       
        
        [tagBtn setTitle:ttStr forState:UIControlStateNormal];
        tagBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [tagBtn setTitleColor:[self printColor:colorStr] forState:UIControlStateNormal];
      
        tagBtn.backgroundColor = kUIColorFromRGB(0xFFFFFF);
        
        [self makeCornerRadius:16 borderColor:[UIColor blackColor] layer:tagBtn.layer borderWidth:.5];
        markBtn = tagBtn;
        tagBtn.tag = 887+i;
        [tagBtn addTarget:self action:@selector(clickToHot:) forControlEvents:UIControlEventTouchUpInside];

        [self addSubview:markBtn];
    }
    CGRect rect = self.frame;
    rect.size.height = markBtn.frame.origin.y + markBtn.frame.size.height + marginY;
    self.frame = rect;
}

-(void)setHotFQAArr:(NSArray *)hotArr{
    _hotArr = hotArr;
    CGFloat marginX = 10;
    CGFloat marginY = 10;
    CGFloat height = 32;
    UIButton * markBtn;
    

    for (int i = 0; i < _hotArr.count; i++) {
        
        NSDictionary *dict = (NSDictionary *)_hotArr[i];
        NSString *ttStr = [NSString stringWithFormat:@"%@" ,dict[@"title"]];
        NSString *colorStr = [NSString stringWithFormat:@"%@" ,dict[@"bgcolor"]];
        
        CGFloat width =  [self calculateString:ttStr Width:13] +30;
        UIButton * tagBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (!markBtn) {
            tagBtn.frame = CGRectMake(marginX, marginY, width, height);
        }else{
            if (markBtn.frame.origin.x + markBtn.frame.size.width + marginX + width + marginX > kScreenWidth) {
                tagBtn.frame = CGRectMake(marginX, markBtn.frame.origin.y + markBtn.frame.size.height + marginY, width, height);
            }else{
                tagBtn.frame = CGRectMake(markBtn.frame.origin.x + markBtn.frame.size.width + marginX, markBtn.frame.origin.y, width, height);
            }
        }
       
        
        
        [tagBtn setTitle:ttStr forState:UIControlStateNormal];
        tagBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [tagBtn setTitleColor:textMinorColor33 forState:UIControlStateNormal];
       // tagBtn.backgroundColor = kUIColorFromRGB(0xF5F5F5);
        tagBtn.backgroundColor = kUIColorFromRGB(0xFFFFFF);
        
        [self makeCornerRadius:16 borderColor:[UIColor blackColor] layer:tagBtn.layer borderWidth:.5];
        markBtn = tagBtn;
        tagBtn.tag = 887+i;
        [tagBtn addTarget:self action:@selector(clickToHot:) forControlEvents:UIControlEventTouchUpInside];

       
        
        
        [self addSubview:markBtn];
        
        if (colorStr.length != 0) {
            UIImageView *hotImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"college_hot"]];
            hotImgView.frame = CGRectMake(tagBtn.frame.origin.x+tagBtn.frame.size.width - 32, tagBtn.frame.origin.y - 6, 32, 12);
            [self addSubview:hotImgView];
                   
        }
    }
    CGRect rect = self.frame;
    rect.size.height = markBtn.frame.origin.y + markBtn.frame.size.height + marginY;
    self.frame = rect;
}


- (UIColor*)printColor:(NSString *)str{
    
    int red = (int)strtoul([[str substringWithRange:NSMakeRange(2, 2)] UTF8String], 0, 16);
    
    int green = (int)strtoul([[str substringWithRange:NSMakeRange(4, 2)] UTF8String], 0, 16);
    
    int blue = (int)strtoul([[str substringWithRange:NSMakeRange(6, 2)] UTF8String], 0, 16);
    
    UIColor *hexColor = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
    return hexColor;
    
}



-(void)setArr:(NSArray *)arr{
    _arr = arr;
    CGFloat marginX = 10;
    CGFloat marginY = 10;
    CGFloat height = 32;
    UIButton * markBtn;
    
    DMLog(@"arrrrrr == %@", arr);
    for (int i = 0; i < _arr.count; i++) {
        
       
        
        CGFloat width =  [self calculateString:_arr[i] Width:13] +30;
        if (width > kScreenWidth - 30) {
            width = kScreenWidth - 30;
        }
        UIButton * tagBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (!markBtn) {
            tagBtn.frame = CGRectMake(marginX, marginY, width, height);
        }else{
            if (markBtn.frame.origin.x + markBtn.frame.size.width + marginX + width + marginX > kScreenWidth) {
                tagBtn.frame = CGRectMake(marginX, markBtn.frame.origin.y + markBtn.frame.size.height + marginY, width, height);
            }else{
                tagBtn.frame = CGRectMake(markBtn.frame.origin.x + markBtn.frame.size.width + marginX, markBtn.frame.origin.y, width, height);
            }
        }
       
        
        [tagBtn setTitle:_arr[i] forState:UIControlStateNormal];
        tagBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [tagBtn setTitleColor:kUIColorFromRGB(0x777777) forState:UIControlStateNormal];
    
        tagBtn.backgroundColor = kUIColorFromRGB(0xFFFFFF);
        
        [self makeCornerRadius:16 borderColor:[UIColor blackColor] layer:tagBtn.layer borderWidth:.5];
        markBtn = tagBtn;
        
        [tagBtn addTarget:self action:@selector(clickTo:) forControlEvents:UIControlEventTouchUpInside];

        [self addSubview:markBtn];
    }
    CGRect rect = self.frame;
    rect.size.height = markBtn.frame.origin.y + markBtn.frame.size.height + marginY;

    self.frame = rect;
}


-(void)clickTo:(UIButton *)sender
{
    
    
    if ([self.delegate respondsToSelector:@selector(handleSelectTag:)]) {
        [self.delegate handleSelectTag:sender.titleLabel.text];
    }
}

- (void)clickToHot:(UIButton *)sender{
    DMLog(@"%ld", (long)sender.tag);
    
    NSDictionary *dict = self.hotArr[sender.tag-887];
    if ([self.delegate respondsToSelector:@selector(handleSelectTagDict:)]) {
        [self.delegate handleSelectTagDict:dict];
    }
    
}

-(void)makeCornerRadius:(CGFloat)radius borderColor:(UIColor *)borderColor layer:(CALayer *)layer borderWidth:(CGFloat)borderWidth
{
    layer.cornerRadius = radius;
    layer.masksToBounds = YES;

}

-(CGFloat)calculateString:(NSString *)str Width:(NSInteger)font
{
    CGSize size = [str boundingRectWithSize:CGSizeMake(kScreenWidth, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:font]} context:nil].size;
    return size.width;
}

@end
