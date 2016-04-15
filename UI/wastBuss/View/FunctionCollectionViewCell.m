//
//  FunctionCollectionViewCell.m
//  House
//
//  Created by wang shiwen on 15/11/27.
//  Copyright © 2015年 AiLiuLian. All rights reserved.
//

#import "FunctionCollectionViewCell.h"


@interface  FunctionCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *function_imgView;//按钮图标

@property (weak, nonatomic) IBOutlet UILabel *function_titleLabel;//按钮文字

@property (weak, nonatomic) FunctionCollectionModel *curModel;
@end

@implementation FunctionCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.layer.borderWidth=0.3;
    
}

-(void)bindData:(FunctionCollectionModel *) funModel
{
    self.curModel=funModel;
    
    //添加按钮事件
    self.function_imgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(infoBtnPressed:)];
    [self.function_imgView addGestureRecognizer:singleTap1];
    
    //添加标题事件
    self.function_titleLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleBtnPressed:)];
    [self.function_titleLabel addGestureRecognizer:singleTap2];
    
}

-(void)infoBtnPressed:(id)btn
{
    NSLog(@"点击了图标");
 
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
    [dic setObject:@"jump" forKey:@"order"];
    [dic setObject:@"foodsearch" forKey:@"jumpto"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"jumpToPage" object:dic];
}

-(void)titleBtnPressed:(id)btn
{
    NSLog(@"点击了标题");
    
   
    NSURL *url= [NSURL URLWithString:@"prefs:root=Photos"];
    if ( [[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
    
}

@end
