//
//  ALLADImageView.m
//  ALiuLian
//
//  Created by 张旭 on 15/7/15.
//  Copyright (c) 2015年 张旭. All rights reserved.
//

#import "ALLADImageView.h"
#import <UIImageView+WebCache.h>
#import "MacroDefine.h"
@interface ALLADImageView()

@property(nonatomic,strong)NSURL *currentUrl;
@property(nonatomic,strong)UIButton *clostBtn;

-(void)closeBtnPressed:(UIButton *)btn;
@end
@implementation ALLADImageView


-(id)initWithUrl:(NSURL *)url
{
    self=[super init];
    if (self) {
        [self setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        self.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        self.contentMode=UIViewContentModeScaleAspectFit;
        self.userInteractionEnabled=YES;
        _currentUrl=url;
        
        _clostBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_clostBtn setTitle:@"关闭" forState:UIControlStateNormal];
        [_clostBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _clostBtn.titleLabel.font=[UIFont systemFontOfSize:14];
        [_clostBtn setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];
        [self addSubview:_clostBtn];
        [_clostBtn addTarget:self action:@selector(closeBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        _clostBtn.layer.cornerRadius=9;
        _clostBtn.clipsToBounds=YES;
        _clostBtn.frame=CGRectMake(0, 0, 50, 30);
        _clostBtn.center=CGPointMake(30, 40);
    }
    return self;
}
-(void)loadAndShowInView:(UIView *)view
{
    WS(weakSelf);
    WEAK(view);
    [self sd_setImageWithURL:self.currentUrl completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [weakview addSubview:weakSelf];
    }];
}

-(void)closeBtnPressed:(UIButton *)btn
{
    [self removeFromSuperview];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
