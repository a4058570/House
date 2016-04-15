//
//  ALLTagView.m
//  House
//
//  Created by wang shiwen on 16/3/3.
//  Copyright © 2016年 AiLiuLian. All rights reserved.
//

#import "ALLTagView.h"

#import "HXTagsView.h"

@interface ALLTagView ()

@end

@implementation ALLTagView

- (id)initWithFrame:(CGRect )rect
{
    self=[super initWithFrame:rect];
    if (self) {
        
        [self initUI];
    }
    return self;
    
}

- (void)initUI
{
    self.backgroundColor= [UIColor colorWithRed:237/255.0 green:234/255.0 blue:231/255.0 alpha:1.0];
    
    //热门搜索
    NSArray *tagAry = @[@"iPhone",@"iPad",@"海购商品",@"黄金",@"coach",@"单反"];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 200, 20)];
    titleLable.text = @"热门搜索";
    [titleLable setFont:[UIFont systemFontOfSize:15]];
    titleLable.textColor = [UIColor colorWithRed:138/255.0 green:138/255.0 blue:138/255.0 alpha:1.0];
    [self addSubview:titleLable];
    
    //添加标签
    NSDictionary *propertyDic = @{@"type":@"1"};
    float height = [HXTagsView getTagsViewHeight:tagAry dic:propertyDic];
    HXTagsView *tagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(0, titleLable.frame.origin.y+titleLable.frame.size.height+5, self.frame.size.width, height)];
    
    tagsView.cornerRadius= 14;
    tagsView.backgroundColor= [UIColor colorWithRed:237/255.0 green:234/255.0 blue:231/255.0 alpha:1.0];
    tagsView.titleNormalColor= [UIColor colorWithRed:138/255.0 green:138/255.0 blue:138/255.0 alpha:1.0];
    tagsView.titleSelectedColor=[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0];
    
    tagsView.propertyDic = propertyDic;
    
    [tagsView setTagAry:tagAry delegate:self];
    [self addSubview:tagsView];

}

#pragma mark HXTagsViewDelegate

/**
 *  tagsView代理方法
 *
 *  @param tagsView tagsView
 *  @param sender   tag:sender.titleLabel.text index:sender.tag
 */
- (void)tagsViewButtonAction:(HXTagsView *)tagsView button:(UIButton *)sender {
    NSLog(@"tag:%@ index:%ld",sender.titleLabel.text,(long)sender.tag);

    if (self.delegate && [self.delegate respondsToSelector:@selector(tagPressCallBack:)]) {
        [self.delegate tagPressCallBack:sender.titleLabel.text];
    }
}




@end
