//
//  ALLCountView.m
//  ALiuLian
//
//  Created by 张旭 on 16/3/3.
//  Copyright © 2016年 张旭. All rights reserved.
//

#import "ALLCountView.h"
#import "ALLTextField.h"
#import "UIView+ZXTool.h"


@interface ALLCountView()

@property (strong, nonatomic)  UIButton *minusBtn;
@property (strong, nonatomic)  UIButton *addBtn;
@property (strong, nonatomic)  ALLTextField *numberTextField;



@property(nonatomic)CGFloat btnWidth;

@end




@implementation ALLCountView


-(id)init
{
    self=[super init];
    if (self) {
        [self customInit];
    }
    return self;
}
-(void)customInit
{
    self.btnWidth=30;
    
    self.minusBtn.layer.cornerRadius=self.minusBtn.frame.size.width/2.0;
    self.addBtn.layer.cornerRadius=self.addBtn.frame.size.width/2.0;
    self.minusBtn.layer.borderWidth=0.5;
    self.addBtn.layer.borderWidth=0.5;
    // self.numberLabel.layer.borderWidth=0.5;
    
    self.numberTextField.type=ALLTextField_Int_Number;
    self.numberTextField.enableSuperViewAdjustForKeyboard=NO;
    self.numberTextField.userInteractionEnabled=NO;
    self.numberTextField.delegate=(id)self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
    
    self.maxNumber=5;
    self.minNumber=1;
    self.step=1;
    
    self.numberTextField.text=[NSString stringWithFormat:@"%d",self.step];
    [self refreshUI];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat btnTextFieldHorizentalMargin=5;
    CGFloat maxTextFieldWith=100;
    CGFloat textFieldHeight=30;
    
    CGFloat remaindTextFieldWidth= self.width-self.btnWidth*2-btnTextFieldHorizentalMargin*2;
    if (remaindTextFieldWidth>maxTextFieldWith) {
        remaindTextFieldWidth=maxTextFieldWith;
    }
    
    self.numberTextField.width=remaindTextFieldWidth;
    self.numberTextField.height=textFieldHeight;
    self.numberTextField.centerX=self.width/2.0;
    self.numberTextField.centerY=self.height/2.0;
    
    self.minusBtn.right=self.numberTextField.left-btnTextFieldHorizentalMargin;
    self.minusBtn.centerY=self.height/2.0;
    
    self.addBtn.left=self.numberTextField.right+btnTextFieldHorizentalMargin;
    self.addBtn.centerY=self.numberTextField.centerY;
    
}

-(void)setCurrentNumber:(int)number
{
    self.numberTextField.text=[NSString stringWithFormat:@"%d",number];
    [self validValue];
    [self refreshUI];
}


-(void)enabelEdit:(BOOL)enable adjustKeyboardView:(UIView *)view
{
    self.numberTextField.enableSuperViewAdjustForKeyboard=YES;
    self.numberTextField.userInteractionEnabled=YES;
    self.numberTextField.adjustView=view;
    
    
}
-(void)refreshUI
{
    int number=[self.numberTextField.text intValue];
    
    
    if (number<=self.minNumber) {
        self.minusBtn.enabled=NO;
        self.addBtn.enabled=YES;
        self.minusBtn.layer.borderColor=[UIColor lightGrayColor].CGColor;
        self.addBtn.layer.borderColor=[UIColor redColor].CGColor;
    }else if(number>=self.maxNumber)
    {
        self.minusBtn.enabled=YES;
        self.addBtn.enabled=NO;
        self.minusBtn.layer.borderColor=[UIColor redColor].CGColor;
        self.addBtn.layer.borderColor=[UIColor lightGrayColor].CGColor;
    }
    else
    {
        self.minusBtn.enabled=YES;
        self.addBtn.enabled=YES;
        
        self.minusBtn.layer.borderColor=[UIColor redColor].CGColor;
        self.addBtn.layer.borderColor=[UIColor redColor].CGColor;
    }
    if (self.maxNumber<=self.minNumber) {
        self.minusBtn.enabled=NO;
        self.minusBtn.layer.borderColor=[UIColor lightGrayColor].CGColor;
        
        self.addBtn.enabled=NO;
        self.addBtn.layer.borderColor=[UIColor lightGrayColor].CGColor;
        
        if (self.maxNumber==0) {
            self.numberTextField.text=@"0";
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(didNumberChange:)]) {
        [self.delegate didNumberChange:[self.numberTextField.text intValue]];
    }
}
-(void)setMaxNumber:(int)maxNumber
{
    _maxNumber=maxNumber;
 
    [self refreshUI];
}
-(void)setMinNumber:(int)minNumber
{
    _minNumber=minNumber;
 
    [self refreshUI];
}
- (IBAction)addBtnPressed:(id)sender {
    int number=[self.numberTextField.text intValue];
    self.numberTextField.text=[NSString stringWithFormat:@"%d",number+self.step];
    [self validValue];
    [self refreshUI];
    
}
-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    [self validValue];
}

- (IBAction)minusBtnPressed:(id)sender {
    int number=[self.numberTextField.text intValue];
    self.numberTextField.text=[NSString stringWithFormat:@"%d",number-self.step];
    [self validValue];
    [self refreshUI];
}

-(void)setStep:(int)step
{
    int oldStep=_step;
    if (oldStep==0) {
        oldStep=1;
    }
    int number= [self.numberTextField.text intValue]/oldStep;
    _step=step;
    self.numberTextField.text=[NSString stringWithFormat:@"%d",_step*number];
    [self refreshUI];
}

-(int)currentNumber
{
    return [self.numberTextField.text intValue];
}

-(void)textFieldDidChange:(NSNotification *)noti
{
    UITextField *field=noti.object;
//    if (field==self.numberTextField) {
//        [self validValue];
//        [self refreshUI];
//    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField==self.numberTextField) {
        [self validValue];
        [self refreshUI];
    }
}
-(void)validValue
{
    int value=[self.numberTextField.text intValue];
    
    if (value>self.maxNumber) {
        value=self.maxNumber;
    }
    if (value<self.minNumber) {
        value=self.minNumber;
        
    }
    if (value%self.step!=0) {
        value+=(self.step-value%self.step);
    }
    self.numberTextField.text=[NSString stringWithFormat:@"%d",value];
}




-(UIButton *)addBtn
{
    if (_addBtn==nil) {
        _addBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _addBtn.size=CGSizeMake(self.btnWidth, self.btnWidth);
        [self addSubview:_addBtn];
        [_addBtn setTitle:@"+" forState:UIControlStateNormal];
        [_addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(addBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}
-(UIButton *)minusBtn
{
    if (_minusBtn==nil) {
        _minusBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _minusBtn.size=CGSizeMake(self.btnWidth, self.btnWidth);
        [self addSubview:_minusBtn];
        [_minusBtn setTitle:@"－" forState:UIControlStateNormal];
        [_minusBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_minusBtn addTarget:self action:@selector(minusBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _minusBtn;
}
-(ALLTextField *)numberTextField
{
    if (_numberTextField==nil) {
        _numberTextField=[[ALLTextField alloc]init];
        _numberTextField.font=[UIFont systemFontOfSize:14];
        _numberTextField.textAlignment=NSTextAlignmentCenter;
        [_numberTextField setBorderStyle:UITextBorderStyleRoundedRect];
        [self addSubview:_numberTextField];
    }
    return _numberTextField;
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
