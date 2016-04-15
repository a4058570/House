//
//  ALLEmptyView.m
//  ALiuLian
//
//  Created by 张旭 on 15/6/2.
//  Copyright (c) 2015年 张旭. All rights reserved.
//

#import "ALLEmptyView.h"

@implementation ALLEmptyView




-(id)initWithContent:(NSString *)content img:(UIImage *)img
{
    self=[super init];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        
        CGSize labelSize=CGSizeMake(150, 50);
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, labelSize.width, labelSize.height)];
        label.preferredMaxLayoutWidth=labelSize.width;
        label.textColor=[UIColor lightGrayColor];
        label.font=[UIFont systemFontOfSize:16];
        label.numberOfLines=2;
        label.textAlignment=NSTextAlignmentCenter;
        label.text=content;
    
        UIImage *targetImg=img;
        if (targetImg==nil) {
            targetImg=[UIImage imageNamed:@"icon_empty"];
        }
        
        CGSize size= CGSizeMake(targetImg.size.width*targetImg.scale/2.0, targetImg.size.height*targetImg.scale/2.0);
        if (size.width>70) {
            size.width=70;
        }
        if (size.height>70) {
            size.height=70;
        }
        UIImageView *imgView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_empty"]];
        if (img) {
            imgView.image=img;
        }
        [imgView setFrame:CGRectMake(0, 0,size.width,size.height)];
        
        
        [self setFrame:CGRectMake(0, 0, labelSize.width, labelSize.height+imgView.frame.size.height)];
        
        
        imgView.center=CGPointMake(labelSize.width/2, imgView.frame.size.height/2);
        [self addSubview:imgView];
        label.frame=CGRectMake(0, imgView.frame.size.height+20, labelSize.width, labelSize.height);
        [self addSubview:label];
        
        
        self.layer.anchorPoint=CGPointMake(0.5, 0.5);
    }
    return self;
}

+(UIView *)defaultEmptyView
{
    NSString *str=@"暂时没有数据哦!";
    
    ALLEmptyView *em= [[ALLEmptyView alloc]initWithContent:str img:nil];
    return em;
}
+(UIView *)defaultFailedView
{
    NSString *str=@"亲 您的网络不太顺畅哦!";
    
    ALLEmptyView *em= [[ALLEmptyView alloc]initWithContent:str img:[UIImage imageNamed:@"logoHolder"]];
    return em;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
