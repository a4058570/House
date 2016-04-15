//
//  ALLTextField.m
//  ALiuLian
//
//  Created by 张旭 on 15/7/9.
//  Copyright (c) 2015年 张旭. All rights reserved.
//

#import "ALLTextField.h"
@interface ALLTextField()<UITextFieldDelegate>

@property(nonatomic)BOOL isInit;
@property(nonatomic,strong)UIView *line;
@property(nonatomic)CGFloat upOffset;

@property(nonatomic,strong)UIButton *cleanBtn;


@property(nonatomic,weak)id<UITextFieldDelegate>outerDelegate;


-(void)customInit;
-(void)textDidChangeNotify:(NSNotification *)noty;
-(void)cleanBtnPressed:(UIButton *)btn;
@end
@implementation ALLTextField

-(id)init
{
    self=[super init];
    if (self) {
        [self customInit];
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self customInit];
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    if (self) {
        [self customInit];
    }
    return self;
}
-(void)awakeFromNib
{
    [super awakeFromNib];
   // [self customInit];
    
}
-(void)setType:(ALLTextFieldType)type
{
    _type=type;
    if (_type==ALLTextField_Int) {
        [self setKeyboardType:UIKeyboardTypeNumberPad];
    }else if (_type==ALLTextField_String)
    {
        [self setKeyboardType:UIKeyboardTypeDefault];
    }else if (_type==ALLTextField_Int_Number)
    {
        [self setKeyboardType:UIKeyboardTypeNumberPad];
    }else
    {
         [self setKeyboardType:UIKeyboardTypeDecimalPad];
    }
   
}
-(void)customInit
{
    if (!self.isInit) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChangeNotify:) name:UITextFieldTextDidChangeNotification object:nil];

        //注册事件
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        
        self.stringLength=8;
        self.isInit=YES;
        self.type=ALLTextField_String;
        self.intLength=8;
        self.textFieldKeyboardVerticalSpace=40;
        self.enableSuperViewAdjustForKeyboard=NO;
        self.enableUnderLine=NO;
        self.enableCleanBtn=NO;
        
        [self setDelegate:self];
    }
    
}



-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.enableUnderLine) {
        if (self.line==nil) {
            self.line=[[UIView alloc]init];
            [self.line setBackgroundColor:[UIColor lightGrayColor]];
            [self addSubview:self.line];
        }
        
        [self.line setFrame:CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 0.5)];
    }
    
    self.cleanBtn.hidden=!self.enableCleanBtn;
    self.cleanBtn.center=CGPointMake(self.frame.size.width-self.cleanBtn.frame.size.width/2.0-3, self.frame.size.height/2.0);
    [self bringSubviewToFront:self.cleanBtn];
}

#pragma mark --
#pragma mark Getter/Setter
-(void)setDelegate:(id<UITextFieldDelegate>)delegate
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
        if (delegate!=(id)self) {
            self.outerDelegate=delegate;
        }else
        {
            
            [super setDelegate:self];
        }
    }else
    {
        [super setDelegate:delegate];
    }
    
}
-(void)setText:(NSString *)text
{
    [super setText:text];
    //[[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidChangeNotification object:self];
}
-(UIButton *)cleanBtn
{
    if (_cleanBtn==nil) {
        _cleanBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_cleanBtn setTitle:@"×" forState:UIControlStateNormal];
        [_cleanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _cleanBtn.backgroundColor=[UIColor lightGrayColor];
        _cleanBtn.frame=CGRectMake(0, 0, 18, 18);
        [self addSubview:_cleanBtn];
        
        _cleanBtn.alpha=0;
        _cleanBtn.userInteractionEnabled=YES;
        [_cleanBtn addTarget:self action:@selector(cleanBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        _cleanBtn.layer.cornerRadius=_cleanBtn.frame.size.width/2.0;
        
        UIEdgeInsets insert=_cleanBtn.titleEdgeInsets;
        insert.right=1;
        insert.bottom=1;
        _cleanBtn.titleEdgeInsets=insert;
    }
    return _cleanBtn;
}



#pragma mark --
#pragma mark Event Response
-(void)cleanBtnPressed:(UIButton *)btn
{
    self.text=@"";
    [UIView animateWithDuration:0.3 animations:^{
        self.cleanBtn.alpha=0;
    }];
}
-(void)keyboardWillShow:(NSNotification *)noty
{
    if (self.enableSuperViewAdjustForKeyboard&&self.isEditing) {
        NSDictionary *userInfo = [noty userInfo];
        
        NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
        CGRect keyboardRect = [aValue CGRectValue];
        
        //获取textField当前在window 中的坐标
        CGPoint posInWindow= [[UIApplication sharedApplication].keyWindow convertPoint:self.frame.origin fromView:self.superview];
        CGFloat textFieldH=[UIScreen mainScreen].bounds.size.height-posInWindow.y;
        if (textFieldH-keyboardRect.size.height<self.textFieldKeyboardVerticalSpace) {
            CGFloat offset=keyboardRect.size.height-textFieldH+self.frame.size.height+self.textFieldKeyboardVerticalSpace;
            //动画上移
            __weak UIView *weakView=self.adjustView?self.adjustView: self.superview;
            [UIView animateWithDuration:0.3 animations:^{
                CGRect oldFrame=weakView.frame;
                oldFrame.origin.y-=offset;
                weakView.frame=oldFrame;
            }];
            self.upOffset+=offset;
        }
    }
}
-(void)keyboardWillHide:(NSNotification *)noty
{
    if (self.enableSuperViewAdjustForKeyboard&&self.upOffset) {
        __weak UIView *weakView=self.adjustView?self.adjustView: self.superview;
        [UIView animateWithDuration:0.3 animations:^{
            CGRect oldFrame=weakView.frame;
            oldFrame.origin.y+=self.upOffset;
            weakView.frame=oldFrame;
        }];
        self.upOffset=0;
    }
}
-(void)textDidChangeNotify:(NSNotification *)noty
{
    UITextField *textField=noty.object;
    if (textField==self) {
        
        
        if (self.type==ALLTextField_String) {
            int kMaxLength=self.stringLength;
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
        }else if (self.type==ALLTextField_Int)
        {
            int number=self.intLength;
            if (textField.text.length>=number) {
                textField.text=[textField.text substringWithRange:NSMakeRange(0, number)];
                
            }
            
        }else if (self.type==ALLTextField_Int_Number)
        {
            NSInteger  maxIntegerLength=self.intLength;//最大整数位
            NSString *x=textField.text;
            if (x.length) {
                //第一个字符处理
                //第一个字符为0,且长度>1时
                if ([[x substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"0"]) {
                    self.text=@"";
                    if (x.length>1) {
                        if ([[x substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"0"]) {
                            //如果第二个字符还是0,即"00",则无效,改为"0"
                            textField.text=@"0";
                        }else if (![[x substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"."]){
                            //如果第二个字符不是".",比如"03",清除首位的"0"
                            textField.text=[x substringFromIndex:1];
                        }
                    }
                }
                //第一个字符为"."时,改为"0."
                else if ([[x substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"."]){
                    textField.text=@"";
                }
                //2个以上字符的处理
                NSRange pointRange = [x rangeOfString:@"."];
                
                if (pointRange.length>0){
                    textField.text=[x substringToIndex:x.length-1];
                    
                }
                else{
                    if (x.length>maxIntegerLength) {
                        textField.text=[x substringToIndex:maxIntegerLength];
                    }
                }
                
            }
            
            
        }else if (self.type==ALLTextField_Int_Float_Number)
        {
            NSInteger  maxIntegerLength=self.intLength;//最大整数位
            NSInteger  maxFloatLength=self.floatLength;//最大精确到小数位
            
            NSString *x=textField.text;
            if (x.length) {
                //第一个字符处理
                //第一个字符为0,且长度>1时
                if ([[x substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"0"]) {
                    if (x.length>1) {
                        if ([[x substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"0"]) {
                            //如果第二个字符还是0,即"00",则无效,改为"0"
                            textField.text=@"0";
                        }else if (![[x substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"."]){
                            //如果第二个字符不是".",比如"03",清除首位的"0"
                            textField.text=[x substringFromIndex:1];
                        }
                    }
                }
                //第一个字符为"."时,改为"0."
                else if ([[x substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"."]){
                    textField.text=@"0.";
                }
                
                //2个以上字符的处理
                NSRange pointRange = [x rangeOfString:@"."];
                NSRange pointsRange = [x rangeOfString:@".."];
                if (pointsRange.length>0) {
                    //含有2个小数点
                    textField.text=[x substringToIndex:x.length-1];
                }
                else if (pointRange.length>0){
                    //含有1个小数点时,并且已经输入了数字,则不能再次输入小数点
                    if ((pointRange.location!=x.length-1) && ([[x substringFromIndex:x.length-1]isEqualToString:@"."])) {
                        textField.text=[x substringToIndex:x.length-1];
                    }
                    if (pointRange.location+maxFloatLength<x.length) {
                        //输入位数超出精确度限制,进行截取
                        textField.text=[x substringToIndex:pointRange.location+maxFloatLength+1];
                    }
                }
                else{
                    if (x.length>maxIntegerLength) {
                        textField.text=[x substringToIndex:maxIntegerLength];
                    }
                }
                
            }
        }
        
    }
    
    
    
    //是否显示 清除按钮
    if (self.text.length>0&&self.enableCleanBtn) {
        [UIView animateWithDuration:0.3 animations:^{
            self.cleanBtn.alpha=1.0;
            self.cleanBtn.userInteractionEnabled=YES;
        }];
    }else
    {
        [UIView animateWithDuration:0.3 animations:^{
            self.cleanBtn.alpha=0.0;
        }];
    }
    
}


#pragma mark --
#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    BOOL outer=YES;
    
    if ([self.outerDelegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        outer=[self.outerDelegate textFieldShouldBeginEditing:textField];
    }
    return outer;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([self.outerDelegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [self.outerDelegate textFieldDidBeginEditing:textField];
    }
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    BOOL outer=YES;
    
    if ([self.outerDelegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        outer=[self.outerDelegate textFieldShouldEndEditing:textField];
    }
    return outer;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([self.outerDelegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [self.outerDelegate textFieldDidEndEditing:textField];
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    BOOL outer=YES;
    if ([self.outerDelegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        outer=[self.outerDelegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    
    if (outer==YES) {
        //处理自己的逻辑
        
    }
    return outer;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    BOOL outer=YES;
    
    if ([self.outerDelegate respondsToSelector:@selector(textFieldShouldClear:)]) {
        outer=[self.outerDelegate textFieldShouldClear:textField];
    }
    return outer;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    BOOL outer=YES;
    if ([self.outerDelegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        outer=[self.outerDelegate textFieldShouldReturn:textField];
    }
    return outer;
}



-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
