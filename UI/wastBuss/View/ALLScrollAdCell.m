//
//  ALLScrollAdCell.m
//  ALiuLian
//
//  Created by 王诗文 on 15/11/6.
//  Copyright (c) 2015年 王诗文. All rights reserved.
//

#import "ALLScrollAdCell.h"
#import <UIImageView+WebCache.h>
#import "AppConfig.h"
#import "MacroDefine.h"
#import "SDCycleScrollView.h"

@interface ALLScrollAdCell() <SDCycleScrollViewDelegate>

@end
@implementation ALLScrollAdCell

+(CGFloat)staticHeight
{
    return  90;
}
-(void)awakeFromNib
{
    [super awakeFromNib];
    
}

-(void)bindData:(ALLWastBussModel *)model
{
    // 情景一：采用本地图片实现
    NSArray *images = @[[UIImage imageNamed:@"h1.jpg"],
                        [UIImage imageNamed:@"h2.jpg"],
                        [UIImage imageNamed:@"h3.jpg"],
                        [UIImage imageNamed:@"h4.jpg"]
                        ];
    
    // 本地加载 --- 创建不带标题的图片轮播器
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kWindowWidth, 90) imagesGroup:images];
    
    cycleScrollView.infiniteLoop = YES;
    cycleScrollView.delegate = self;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    [self addSubview:cycleScrollView];
    //  --- 轮播时间间隔，默认1.0秒，可自定义
    cycleScrollView.autoScrollTimeInterval = 3.0;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
}

@end
