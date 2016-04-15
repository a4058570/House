//
//  ALLBadgeBtn.m
//  ALiuLian
//
//  Created by 张旭 on 15/5/30.
//  Copyright (c) 2015年 张旭. All rights reserved.
//

#import "ALLBadgeBtn.h"
#import "UIView+ZXTool.h"
@interface ALLBadgeBtn()
@property(nonatomic)BOOL isInit;

@property(nonatomic,strong)UILabel *badgeLabel;

@property(nonatomic,strong)UIView *pointView;

-(void)customInit;

-(void)refreshBadge;
@end



@implementation ALLBadgeBtn

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
-(void)awakeFromNib
{
    [super awakeFromNib];
    [self customInit];
}
-(void)customInit
{
    _badgeNumber=0;
    _badgeRadus=10;
    _badgeColor=[UIColor redColor];
}
-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    if (!_isInit) {
        _isInit=YES;
     //   [self customInit];
    }
}

-(void)setBadgeColor:(UIColor *)badgeColor
{
    _badgeColor=badgeColor;
    [self refreshBadge];
}
-(void)setBadgeNumber:(int)badgeNumber
{
    _badgeNumber=badgeNumber;
    [self refreshBadge];
}
-(void)setBadgeRadus:(CGFloat)badgeRadus
{
    _badgeRadus=badgeRadus;
    [self refreshBadge];
    
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.badgeLabel.centerX=self.width-_xOffsetFromRight;
    self.badgeLabel.centerY=0;
    self.pointView.centerX=self.width-_xOffsetFromRight;
    self.pointView.centerY=0;
}
-(void)refreshBadge
{
    if (_badgeNumber>0) {
        self.badgeLabel.hidden=NO;
        self.badgeLabel.text=[NSString stringWithFormat:@"%d",_badgeNumber];
        self.badgeLabel.frame=CGRectMake(0, 0, _badgeRadus*2, _badgeRadus*2);
        self.badgeLabel.backgroundColor=_badgeColor;
        self.badgeLabel.layer.cornerRadius=_badgeRadus;
        
    }else
    {
       self.badgeLabel.hidden=YES;
        
    }
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
-(UILabel *)badgeLabel
{
    if (_badgeLabel==nil) {
        UIFont  *font = [UIFont boldSystemFontOfSize:14.0];
        

        _badgeLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, _badgeRadus*2, _badgeRadus*2)];
        _badgeLabel.font=font;
        _badgeLabel.textColor=[UIColor whiteColor];
        [_badgeLabel setTextAlignment:NSTextAlignmentCenter];
        _badgeLabel.clipsToBounds=YES;
        [self addSubview:_badgeLabel];
    }
    return _badgeLabel;
}
-(void)setPoint:(BOOL)point
{
    _point=point;
    if (_point) {
        self.pointView.hidden=NO;
        self.badgeNumber=0;
    }else
    {
        if (_pointView) {
            self.pointView.hidden=YES;
        }
    }
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
-(UIView *)pointView
{
    if (_pointView==nil) {
        _pointView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _badgeRadus, _badgeRadus)];
        _pointView.backgroundColor=[UIColor redColor];
        _pointView.layer.cornerRadius=_badgeRadus/2.0;
        
        _pointView.center=CGPointMake(self.frame.size.width-self.xOffsetFromRight, 10);
        [self addSubview:_pointView];
        _pointView.hidden=YES;
    }
    return _pointView;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//    [super drawRect:rect];
//    CGPoint pos=CGPointMake(self.frame.size.width-10, 10);
//    CGContextRef context= UIGraphicsGetCurrentContext();
//    if (self.badgeNumber>0) {
//        CGContextSaveGState(context);
//        
//        CGContextAddArc(context, pos.x, pos.y, _badgeRadus, 0, 2*M_PI, 0);
//        [_badgeColor setFill];
//        CGContextDrawPath(context, kCGPathFill);
//        
//        CGContextSetLineWidth(context, 1.0);
//        CGContextSetRGBFillColor (context, 1, 1, 1, 1);
//        UIFont  *font = [UIFont boldSystemFontOfSize:14.0];
//        NSString *number=[NSString stringWithFormat:@"%d",_badgeNumber];
//        CGRect labelRect=CGRectMake(pos.x-_badgeRadus, pos.y-_badgeRadus, _badgeRadus*2, _badgeRadus*2);
//        
//        UILabel *la=[[UILabel alloc]initWithFrame:labelRect];
//        la.font=font;
//        la.textColor=[UIColor whiteColor];
//        la.text=number;
//        [la setTextAlignment:NSTextAlignmentCenter];
//        [la drawTextInRect:labelRect];
//        
//        CGContextSaveGState(context);
//    }
//}


@end
