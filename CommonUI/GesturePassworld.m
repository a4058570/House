//
//  GesturePassworld.m
//  ImageTest
//
//  Created by 张旭 on 15/5/9.
//  Copyright (c) 2015年 张旭. All rights reserved.
//

#import "GesturePassworld.h"
@interface GesturePassworld()



@property(nonatomic)CGFloat componentSpace;
@property(nonatomic)CGFloat lineWidth;
@property(nonatomic)CGFloat comW;
@property(nonatomic,strong)UIColor *normalColor;
@property(nonatomic,strong)UIColor *selectColor;
@property(nonatomic,strong)NSMutableArray *components;
@property(nonatomic,strong)NSMutableDictionary *selectIndexDic;
@property(nonatomic,strong)NSMutableArray *selectComponest;
@property(nonatomic)CGPoint currentPos;
@property(nonatomic,copy)void(^finishBlock)(NSString *code ,GestureErrorType error,GesturePassworld *obj);


@property(nonatomic)BOOL inWrongStatue;
@property(nonatomic,strong)UIColor *wrongColor;


@property(nonatomic,strong)UIColor *currentColor;

@property(nonatomic,strong)NSString *currentCode;


@property(nonatomic)BOOL isFinish;

-(void)initComponent;
-(void)initGesture;
-(void)gesturePan:(UIPanGestureRecognizer *)pan;

-(void)selectFinish;

-(void)handlePos:(CGPoint )pos;
-(void)setComponent:(UIView *)com select:(BOOL)select;
@end
@implementation GesturePassworld


#pragma mark -
#pragma mark Init
-(id)initWithSpace:(CGFloat)space
{
    self=[super init];
    if (self) {
        self.inWrongStatue=NO;
        self.componentSpace=space;
        self.lineWidth=3;
        self.comW=70;
        CGFloat viewWidth=self.comW*3+space*2;
        self.frame=CGRectMake(0, 0, viewWidth, viewWidth);
        self.components=[[NSMutableArray alloc]init];
        self.selectIndexDic=[[NSMutableDictionary alloc]init];
        self.backgroundColor=[UIColor whiteColor];
        self.selectComponest=[[NSMutableArray alloc]init];
        self.normalColor=[UIColor lightGrayColor];
        self.selectColor=[UIColor colorWithRed:25/255.0 green:152/255.0 blue:251/255.0 alpha:1.0];
        self.wrongColor=[UIColor redColor];
        self.currentColor=self.selectColor;
        
        [self initComponent ];
        [self initGesture];
        
        
        
//        UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 80,80)];
//        [view1 setBackgroundColor:self.selectColor];
//        [self addSubview:view1];
//        
//        view1=[[UIView alloc]initWithFrame:CGRectMake(40, 0, 80,80)];
//        [view1 setBackgroundColor:self.selectColor];
//        [self addSubview:view1];
    }
    return self;
}
-(void)initComponent
{
    for ( int i=0; i<9; i++) {
        int row=i/3;
        int col=i%3;
        CGFloat originalX=col*self.comW+(col)*self.componentSpace;
        CGFloat originalY=row*self.comW+(row)*self.componentSpace;
        UIView *com=[[UIView alloc]initWithFrame:CGRectMake(originalX, originalY, self.comW, self.comW)];
        [com setBackgroundColor:[UIColor yellowColor]];
        [self addSubview:com];
        com.layer.cornerRadius=self.comW/2;
        [com setBackgroundColor:[UIColor clearColor]];
        com.layer.borderWidth=1;
        com.layer.borderColor=self.normalColor.CGColor;
        com.tag=i+1;
        [self.components addObject:com];
    }
}
-(void)initGesture
{
    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(gesturePan:)];
    [self addGestureRecognizer:pan];
}

-(void)setResultBlock:(void(^)(NSString *code ,GestureErrorType error,GesturePassworld *obj))result
{
    self.finishBlock=result;
}



#pragma mark -
#pragma mark Event
CGFloat distanceBetweenPoints (CGPoint first, CGPoint second) {
    CGFloat deltaX = second.x - first.x;
    CGFloat deltaY = second.y - first.y;
    return sqrt(deltaX*deltaX + deltaY*deltaY );
};
-(void)gesturePan:(UIPanGestureRecognizer *)pan
{
    CGPoint pos= [pan locationInView:self];
    [self handlePos:pos];
    
    //遍历当前所有component 看触摸哪一个
    
    
    if (pan.state==UIGestureRecognizerStateBegan) {
       
    }
    else if (pan.state==UIGestureRecognizerStateChanged) {
       
        
    }else if (pan.state==UIGestureRecognizerStateEnded)
    {
        [self selectFinish];
    }
   
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self handlePos:[[touches anyObject] locationInView:self]];
}
#pragma mark -
#pragma mark  Private Method
-(void)reset
{
    _isFinish=NO;
    for(UIView *com in self.selectComponest)
    {
        [self setComponent:com select:NO];
    };
    [self.selectComponest removeAllObjects];
    [self.selectIndexDic removeAllObjects];
    self.inWrongStatue=NO;
    self.currentColor=self.selectColor;
    [self setNeedsDisplay];
}
-(void)showWrongState
{
    self.inWrongStatue=YES;
    self.currentColor=self.wrongColor;
    
}
-(void)selectFinish
{
    _isFinish=YES;
    GestureErrorType error=Gesture_None;
     NSMutableString *code=nil;
    
    
    if (self.selectComponest.count<3) {
        error=Gesture_Less;

    }else
    {
        code=[[NSMutableString alloc]init];
        for(UIView *com in self.selectComponest)
        {
            [code appendString:[NSString stringWithFormat:@"%d",(int )com.tag]];
        };
        self.currentCode=code;
    }
    
    
    if (self.finishBlock) {
        self.finishBlock(code,error,self);
    }
}


-(void)handlePos:(CGPoint )pos
{
    self.currentPos=pos;
    for(UIView *com in self.components)
    {
        
        if (distanceBetweenPoints(pos, com.center)<self.comW/2) {
            NSString *key=[NSString stringWithFormat:@"%ld",com.tag];
            if (![self.selectIndexDic objectForKey:key]) {
                [self setComponent:com select:YES];
                [self.selectComponest addObject:com];
                [self.selectIndexDic setObject:com forKey:key];
            }
            break;
        }
    }
    [self setNeedsDisplay];
}
-(void)setComponent:(UIView *)com select:(BOOL)select
{
    
    if (select) {
        com.layer.borderColor=self.currentColor.CGColor;
        CGFloat subW=self.comW/2;
        UIView *subView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, subW, subW)];
        subView.layer.cornerRadius=subW/2;
        subView.backgroundColor=self.currentColor;
        subView.center=CGPointMake(self.comW/2,self.comW/2);
        [com addSubview:subView];
        
        
    }else
    {
        com.layer.borderColor=self.normalColor.CGColor;
        for ( UIView *sub in com.subviews) {
            [sub removeFromSuperview];
        }
    }
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
   int i=0;
    for(UIView *com in self.selectComponest)
    {

        CGPoint pos=com.center;
        if (i==0) {

            CGContextMoveToPoint(context, pos.x, pos.y);
        }else
        {
            CGContextAddLineToPoint(context, pos.x, pos.y);
        }
        
        i++;
    }
    if (self.selectComponest.count>0&&self.selectComponest.count<=8&&!_isFinish) {
        CGContextAddLineToPoint(context, _currentPos.x, _currentPos.y);
    }
    CGFloat r,g,b,a;
    [self.currentColor getRed:&r green:&g  blue:&b  alpha:&a];
   
    CGContextSetRGBStrokeColor(context, r ,g ,b ,a);
    
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetLineWidth(context, self.lineWidth);
   
    
    
    CGContextDrawPath(context, kCGPathStroke);
    CGContextRestoreGState(context);
}


@end
