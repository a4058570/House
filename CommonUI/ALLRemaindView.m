//
//  ALLRemaindView.m
//  ALiuLian
//
//  Created by 张旭 on 15/12/30.
//  Copyright © 2015年 张旭. All rights reserved.
//

#import "ALLRemaindView.h"
#import "UIView+ZXTool.h"
#import "UIGestureRecognizer+YYAdd.h"
@interface ALLRemaindView()

@property(nonatomic,strong)UIImageView *imgView;
@property(nonatomic,strong)UILabel *label;

-(void)myInit;
@end

@implementation ALLRemaindView
//-(id)init
//{
//    self=[super init];
//    if (self) {
//        self.verticalSpace=20;
//    }
//    return self;
//}
-(void)myInit
{
    self.verticalSpace=20;
    __weak ALLRemaindView *weakSelf=self;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer  alloc]initWithActionBlock:^(id sender) {
        if (weakSelf.tapBlock) {
            weakSelf.tapBlock(weakSelf);
        }
    }];
    [self addGestureRecognizer:tap];
}
-(CGSize)imgSize
{
    CGFloat scale=1;
    if (_image.scale==1) {
        scale=0.5;
    }
    CGSize imgSize=CGSizeMake(_image.size.width*scale, _image.size.height*scale);
    return imgSize;
}
-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self myInit];
    }
    return self;
}

-(void)setImage:(UIImage *)image
{
    _image=image;
    self.imgView.image=image;

    CGSize imgSize=[self imgSize];
    
    self.height=imgSize.height+self.label.height+self.verticalSpace;
    self.width=self.label.width>imgSize.width?self.label.width:imgSize.width;
}
-(void)setContent:(NSString *)content
{
    _content=content;
    self.label.text=content;
    self.label.preferredMaxLayoutWidth=200;
    [self.label sizeToFit];
    
    CGSize imgSize=[self imgSize];
    
    self.height=imgSize.height+self.label.height+self.verticalSpace;
    self.width=self.label.width>imgSize.width?self.label.width:imgSize.width;
}
-(void)setVerticalSpace:(CGFloat)verticalSpace
{
    _verticalSpace=verticalSpace;
    CGSize imgSize=[self imgSize];
    
    self.height=imgSize.height+self.label.height+self.verticalSpace;
    self.width=self.label.width>imgSize.width?self.label.width:imgSize.width;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGSize imgSize=[self imgSize];
    
    self.imgView.width=imgSize.width;
    self.imgView.height=imgSize.height;
    self.imgView.top=0;
    self.imgView.centerX=self.width/2.0;
    
    self.label.top=self.imgView.bottom+self.verticalSpace;
    self.label.centerX=self.width/2.0;
}

-(UIImageView *)imgView
{
    if (_imgView==nil) {
        _imgView=[[UIImageView alloc]init];
        [self addSubview:_imgView];
    }
    return _imgView;
}
-(UILabel *)label
{
    if (_label==nil) {
        _label=[[UILabel alloc]init];
        _label.textColor=[UIColor grayColor];
        _label.numberOfLines=2;
        self.label.width=200;
        _label.textAlignment=NSTextAlignmentCenter;
        _label.font=[UIFont systemFontOfSize:15];
        [self addSubview:_label];
    }
    return _label;
}
@end
