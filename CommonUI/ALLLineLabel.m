//
//  ALLLineLabel.m
//  ALiuLian
//
//  Created by 张旭 on 15/5/23.
//  Copyright (c) 2015年 张旭. All rights reserved.
//

#import "ALLLineLabel.h"

@implementation ALLLineLabel


-(void)setType:(ALLLineLabelType)type
{
    _type=type;
    [self setNeedsDisplay];
}
-(void)setLineColor:(UIColor *)lineColor
{
    _lineColor=lineColor;
    [self setNeedsDisplay];
}

-(void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    if (_lineColor==nil) {
        _lineColor=[UIColor redColor];
    }
    CGFloat width=CGRectGetWidth(self.frame);
    CGFloat height=CGRectGetHeight(self.frame);
    
    [super drawRect:rect];
    if (self.type==ALLLineLabel_None) {
        return;
    }
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGFloat diff=5;
    CGPoint startPos=CGPointMake(0, diff);
    CGPoint endPos=CGPointMake(width, height-diff);
    if (self.type==ALLLineLabel_Horizental) {
        startPos=CGPointMake(0, height/2);
        endPos=CGPointMake(width, height/2);
    }
    CGContextMoveToPoint(context, startPos.x, startPos.y);
    CGContextAddLineToPoint(context, endPos.x, endPos.y);
    
    //设置图形上下文属性
    [_lineColor setStroke];
  //  CGContextSetRGBStrokeColor(context, 0, 1, 0, 1);
    
    CGContextSetLineWidth(context, 1.0);
   
    
    CGContextDrawPath(context, kCGPathStroke);
    CGContextRestoreGState(context);
}


@end
