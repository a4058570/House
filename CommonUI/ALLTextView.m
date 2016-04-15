//
//  ALLTextView.m
//  ALiuLian
//
//  Created by 张旭 on 15/7/21.
//  Copyright (c) 2015年 张旭. All rights reserved.
//

#import "ALLTextView.h"
@interface ALLTextView()
{
    UILabel *PlaceholderLabel;
    UILabel *limitLabel;
}

-(void)resizeLabel;
@end
@implementation ALLTextView

- (id) initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self awakeFromNib];
    }
    return self;
}


- (void)awakeFromNib {
    
    self.textNumberLimit=0;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DidChange:) name:UITextViewTextDidChangeNotification object:self];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DidChange:) name:UITextViewTextDidEndEditingNotification object:self];
    
    
    float left=5,top=2,hegiht=30;
    
    self.placeholderColor = [UIColor lightGrayColor];
    PlaceholderLabel=[[UILabel alloc] initWithFrame:CGRectMake(left, top
                                                               , CGRectGetWidth(self.frame)-2*left, hegiht)];
    PlaceholderLabel.font=self.placeholderFont?self.placeholderFont:self.font;
    PlaceholderLabel.textColor=self.placeholderColor;
    [self addSubview:PlaceholderLabel];
    PlaceholderLabel.text=self.placeholder;
    PlaceholderLabel.preferredMaxLayoutWidth=self.frame.size.width;
    PlaceholderLabel.numberOfLines=0;
    PlaceholderLabel.lineBreakMode=NSLineBreakByWordWrapping;
    
    
    [self resizeLabel];
    
    limitLabel=[[UILabel alloc] init];
    [self addSubview:limitLabel];
    limitLabel.hidden=YES;
    limitLabel.frame=CGRectMake(0, 0, 150, 30);
    limitLabel.textColor=[UIColor lightGrayColor];
    limitLabel.textAlignment=NSTextAlignmentRight;
//    __weak ALLTextView *weakSelf=self;
//    
//    [limitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(weakSelf.mas_bottom).offset(20);
//        make.right.equalTo(weakSelf.mas_right).offset(20);
//    }];
   
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    limitLabel.center=CGPointMake(self.frame.size.width-limitLabel.frame.size.width/2.0-10, self.frame.size.height-limitLabel.frame.size.height/2.0-5);
}
-(void)resizeLabel
{
    CGSize size = [self.placeholder sizeWithFont:self.placeholderFont
                               constrainedToSize:CGSizeMake(PlaceholderLabel.frame.size.width, MAXFLOAT)
                                   lineBreakMode:NSLineBreakByWordWrapping];
    CGFloat realH=ceilf(size.height);
    if (realH>PlaceholderLabel.frame.size.height) {
        CGRect frame= PlaceholderLabel.frame;
        frame.size.height=realH;
        PlaceholderLabel.frame=frame;
    }
    
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
-(void)setPlaceholder:(NSString *)placeholder{
    if (placeholder.length == 0 || [placeholder isEqualToString:@""]) {
        PlaceholderLabel.hidden=YES;
    }
    else
        PlaceholderLabel.text=placeholder;
    _placeholder=placeholder;
    
    [self resizeLabel];
    
    if (self.text.length>0) {
        [self setPlaceholderHidden:YES];
    }
}
-(void)setText:(NSString *)text
{
    [super setText:text];
    if (self.text.length>0) {
        [self setPlaceholderHidden:YES];
    }else
    {
         [self setPlaceholderHidden:NO];
    }
    
}
-(void)setPlaceholderColor:(UIColor *)placeholderColor
{
    [PlaceholderLabel setTextColor:placeholderColor];
    _placeholderColor=placeholderColor;
}
-(void)setPlaceholderFont:(UIFont *)placeholderFont
{
    _placeholderFont=placeholderFont;
    [PlaceholderLabel setFont:placeholderFont];
    
    [self resizeLabel];
}
-(void)DidChange:(NSNotification*)noti{
    
    if (self.placeholder.length == 0 || [self.placeholder isEqualToString:@""]) {
        PlaceholderLabel.hidden=YES;
    }
    
    if (self.text.length > 0) {
        PlaceholderLabel.hidden=YES;
    }
    else{
        PlaceholderLabel.hidden=NO;
    }
    
    if (self.textNumberLimit>0) {
        //有字数限制
        int kMaxLength=self.textNumberLimit;
        NSString *toBeString = self.text;
        
        NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage];
        
        if([lang isEqualToString:@"zh-Hans"]){ //简体中文输入，包括简体拼音，健体五笔，简体手写
            
            UITextRange *selectedRange = [self markedTextRange];
            
            UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
            
            
            
            if (!position){//非高亮
                
                if (toBeString.length > kMaxLength) {
                    
                    // [self.view makeToast:@"您最多可以输入10个字" duration:1 position:@"top"];
                    
                    self.text = [toBeString substringToIndex:kMaxLength];
                    
                }
                
            }
            
        }else{//中文输入法以外
            
            if (toBeString.length > kMaxLength) {
                
                // [self.view makeToast:@"您最多可以输入10个字" duration:1 position:@"top"];
                
                self.text = [toBeString substringToIndex:kMaxLength];
                
            }
            
        }
        if (!limitLabel.hidden) {
            int curLen=(int)toBeString.length;
            if (curLen>self.textNumberLimit) {
                curLen=self.textNumberLimit;
            }
            limitLabel.text=[NSString stringWithFormat:@"(%d/%d)",curLen,self.textNumberLimit];
            
        }
    }
    
    if (self.vericalCenter&&noti.object==self) {
        UITextView *mTrasView = noti.object;
        
        CGFloat topCorrect = ([mTrasView bounds].size.height - [mTrasView contentSize].height);
        
        topCorrect = (topCorrect <0.0 ?0.0 : topCorrect);
        
        mTrasView.contentOffset = (CGPoint){.x =0, .y = -topCorrect/2};
    }
    
}
-(void)setPlaceholderHidden:(BOOL)hidden
{
    PlaceholderLabel.hidden=hidden;
}

-(void)setVericalCenter:(BOOL)vericalCenter
{
    if (vericalCenter) {
        UITextView *mTrasView = self;
        
        CGFloat topCorrect = ([mTrasView bounds].size.height - [mTrasView contentSize].height);
        
        topCorrect = (topCorrect <0.0 ?0.0 : topCorrect);
        
        mTrasView.contentOffset = (CGPoint){.x =0, .y = -topCorrect/2};
    }
    _vericalCenter=vericalCenter;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [PlaceholderLabel removeFromSuperview];
    
    //  [super dealloc];
    
}



-(void)setShowNumberLimitLabel:(BOOL)showNumberLimitLabel
{
    _showNumberLimitLabel=showNumberLimitLabel;
    limitLabel.hidden=!showNumberLimitLabel;
    [self DidChange:nil];
}


@end
