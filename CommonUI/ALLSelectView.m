//
//  ALLSelectView.m
//  DiZhuBang
//
//  Created by 张旭 on 15/12/29.
//  Copyright © 2015年 张旭. All rights reserved.
//

#import "ALLSelectView.h"
#import <UIImageView+WebCache.h>
#import "UIView+ZXTool.h"
#define Row_Height 55


@implementation ALLSelectConfig



@end





@interface ALLSelectRow()
@property(nonatomic,strong)UIImageView *imgView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *rightTitleLabel;
@property(nonatomic,strong)UIButton *checkButton;

@property(nonatomic,strong)ALLSelectConfig *config;

@property(nonatomic,strong)UIView *line;




@end


@implementation ALLSelectRow

-(void)bindConfig:(ALLSelectConfig *)config
{
    if (_config) {
        [_config.leftBtn removeFromSuperview];
    }
    _config=config;
    if (config.localImg) {
        self.imgView.image=config.localImg;
    }else
    {
        [self.imgView sd_setImageWithURL:config.imgUrl placeholderImage:nil];
    }
    if (config.imgBgColor) {
        self.imgView.backgroundColor=config.imgBgColor;
    }
    
    if ([config.title isKindOfClass:[NSAttributedString class]]) {
        self.titleLabel.attributedText=(id)config.title;
    }else
    {
        self.titleLabel.text=config.title;
    }
    if ([config.rightTitle isKindOfClass:[NSAttributedString class]]) {
        self.rightTitleLabel.attributedText=(id)config.rightTitle;
    }else
    {
        self.rightTitleLabel.text=config.rightTitle;
    }
    
    [self.checkButton setImage:config.emptyImg forState:UIControlStateNormal];
    [self.checkButton setImage:config.fullImg forState:UIControlStateSelected];
    
    if (config.leftBtn) {
        [config.leftBtn removeFromSuperview];
        [self.contentView addSubview:config.leftBtn];
    }
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
-(BOOL)isCheck
{
    return _checkButton.isSelected;
}
-(void)setCheck:(BOOL)check
{
    _checkButton.selected=check;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imgView.width=self.height-16;
    self.imgView.height=self.imgView.width;
    self.imgView.left=12;
    self.imgView.centerY=self.height/2.0;
    self.imgView.layer.cornerRadius=self.imgView.width/2.0;
    self.imgView.clipsToBounds=YES;
    
    [self.titleLabel sizeToFit];
    self.titleLabel.left=self.imgView.right+8;
    self.titleLabel.centerY=self.imgView.centerY;
    
    
    [self.rightTitleLabel sizeToFit];
    self.rightTitleLabel.right=self.width-35;
    self.rightTitleLabel.centerY=self.imgView.centerY;
    
    self.checkButton.width=_config.emptyImg.size.width;
    self.checkButton.height=self.checkButton.width;
    self.checkButton.right=self.width-12;
    self.checkButton.centerY=self.height/2.0;
//    self.checkButton.layer.cornerRadius=self.checkButton.width/2.0;
//    self.checkButton.layer.borderWidth=2;
//    self.checkButton.layer.borderColor=[UIColor colorWithRed:79/255.0 green:221/255.0 blue:63/255.0 alpha:1.0].CGColor;
    
    self.line.height=0.5;
    self.line.width=self.width;
    self.line.top=0;
    
    if (self.config.leftBtn) {
        self.config.leftBtn.left=self.titleLabel.right+5;
        self.config.leftBtn.centerY=self.height/2.0;
    }
}

-(UIImageView *)imgView
{
    if (_imgView==nil) {
        _imgView=[[UIImageView alloc]init];
        [self.contentView addSubview:_imgView];
    }
    return _imgView;
}
-(UILabel *)titleLabel
{
    if (_titleLabel==nil) {
        _titleLabel=[[UILabel alloc]init];
        _titleLabel.font=[UIFont systemFontOfSize:13];
        _titleLabel.textColor=[UIColor blackColor];
        self.titleLabel.numberOfLines=2;
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}
-(UILabel *)rightTitleLabel
{
    if (_rightTitleLabel==nil) {
        _rightTitleLabel=[[UILabel alloc]init];
        _rightTitleLabel.font=[UIFont systemFontOfSize:13];
        _rightTitleLabel.textColor=[UIColor blackColor];
        self.rightTitleLabel.numberOfLines=2;
        [self.contentView addSubview:_rightTitleLabel];
    }
    return _rightTitleLabel;
}
-(UIButton *)checkButton
{
    if (_checkButton==nil) {
        _checkButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _checkButton.userInteractionEnabled=NO;
        [self.contentView addSubview:_checkButton];
    }
    return _checkButton;
}
-(UIView *)line
{
    if (!_line) {
        _line=[[UIView alloc]init];
        [_line setBackgroundColor:[UIColor lightGrayColor]];
        [self.contentView addSubview:_line];
    }
    return _line;
}
@end











@interface ALLSelectView()
@property(nonatomic,strong)ALLSelectConfig *selectObject;
@property(nonatomic)int selectIndex;

@property(nonatomic,strong)NSMutableArray *rows;
@property(nonatomic,strong)NSMutableArray *configs;

-(void)rowTap:(UITapGestureRecognizer *)tap;
@end

@implementation ALLSelectView

-(void)bindData:(NSArray *)configs
{
    self.backgroundColor=[UIColor whiteColor];
    self.configs=(id)configs;
    for (NSInteger i=configs.count; i<self.rows.count; i++) {
        [self.rows removeObjectAtIndex:i];
    }
    
    for (int i=0; i<configs.count; i++) {
        ALLSelectRow *row;
        UITapGestureRecognizer *tap;
        if (self.rows.count>i) {
            //已经存在  刷新数据
            row=self.rows[i];
        }else
        {
            //创建
            row=  [[ALLSelectRow  alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
            [self addSubview:row];
            [self.rows addObject:row];
            tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(rowTap:)];
            [row addGestureRecognizer:tap];
        }
        row.tag=i;
        [row setCheck:NO];
        [row bindConfig:configs[i]];
        if (i==self.selectIndex) {
//            [self rowTap:tap];
           [self selectIndex:i row:row];
            
        }
    }
    
    self.height=configs.count*Row_Height;
    
}
-(void)selectIndex:(int )index
{
    if (self.configs.count>index) {
        
        for (int i=0; i<self.rows.count; i++) {
            ALLSelectRow *row=self.rows[i];
            [row setCheck:NO];
            if (index==i) {
                [self selectIndex:i row:row];
                
            }
        }
    }
}

-(void)rowTap:(UITapGestureRecognizer *)tap
{
    ALLSelectRow *tapRow=(id)tap.view;
    if (self.tapBlock) {
        self.tapBlock(tapRow.config);
    }
    if (tapRow.isCheck) {
        //已经选中 再次点击无效
    }else
    {
        NSInteger index= tap.view.tag;
        for (int i=0; i<self.rows.count; i++) {
            ALLSelectRow *row=self.rows[i];
            [row setCheck:NO];
            if (index==i) {
                [self selectIndex:i row:row];
               
            }
        }
    }
    
}
-(void)selectIndex:(int)index row:(ALLSelectRow *)row
{
    [row setCheck:YES];
    
    
    if (self.changeBlock) {
        self.changeBlock(self.configs[index]);
        self.selectObject=self.configs[index];
        self.selectIndex=index;
    }
}
-(ALLSelectRow *)selectRowWithIndex:(int )index
{
    if (self.rows.count>index) {
        return self.rows[index];
    }
    return nil;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    CGFloat rowH=Row_Height;
    for (int i=0; i<self.rows.count; i++) {
        ALLSelectRow *row=self.rows[i];
        row.width=self.width;
        row.height=rowH;
        row.left=0;
        row.top=i*rowH;
    }
}


-(NSMutableArray *)configs
{
    if (_configs==nil) {
        _configs=@[].mutableCopy;
    }
    return _configs;
}

-(NSMutableArray *)rows
{
    if (_rows==nil) {
        _rows=@[].mutableCopy;
    }
    return _rows;
}

@end
