//
//  CoreTextView.m
//  House
//
//  Created by wang shiwen on 16/4/18.
//  Copyright © 2016年 AiLiuLian. All rights reserved.
//

#import "CoreTextView.h"
#import <CoreText/CoreText.h>

@implementation CoreTextView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor= [UIColor whiteColor];
    }
    
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    /*Core Text
    // Drawing code
    CGContextRef ref = UIGraphicsGetCurrentContext();
    //flip the coordinate system
    
    CGContextSetTextMatrix(ref, CGAffineTransformIdentity);
    CGContextTranslateCTM(ref, 0, 100);
    CGContextScaleCTM(ref, 1.0, -1.0);  CGMutablePathRef
    path = CGPathCreateMutable();
    //1
    CGPathAddRect(path, NULL, CGRectMake(0, 0, 100, 150));
    NSAttributedString* attString = [[NSAttributedString alloc] initWithString:@"测试代码"];
    //2
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
    //3
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, attString.length), path, NULL);
    CTFrameDraw(frame, ref);
    //4
    CFRelease(framesetter);
    //5
    CFRelease(path);
    CFRelease(frame);
     */
    
    /****直线****/
    
    //获得处理的上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //指定直线样式
    CGContextSetLineCap(context,kCGLineCapSquare);
    
    //直线宽度
    CGContextSetLineWidth(context,2.0);
    
    //设置颜色
    CGContextSetRGBStrokeColor(context,0.314, 0.486, 0.859, 1.0);
    
    //开始绘制
    CGContextBeginPath(context);
    
    //画笔移动到点(31,170)
    CGContextMoveToPoint(context,31, 70);
    
    //下一点
    CGContextAddLineToPoint(context,129, 148);
    
    //下一点
    CGContextAddLineToPoint(context,159, 148);
    
    //绘制完成
    CGContextStrokePath(context);
    
    /****矩形****/
    
    //创建路径并获取句柄
    CGMutablePathRef path = CGPathCreateMutable();
    
    //指定矩形
    CGRect rectangle = CGRectMake(10.0f, 150.0f,100.0f,50.0f);
    
    //将矩形添加到路径中
    CGPathAddRect(path,NULL,rectangle);
    
    //获取上下文
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    //将路径添加到上下文
    CGContextAddPath(currentContext, path);
    
    //设置矩形填充色
    [[UIColor colorWithRed:0.20f green:0.60f blue:0.80f alpha:1.0f]
     setFill];
    
    //矩形边框颜色
    [[UIColor brownColor] setStroke];
    
    //边框宽度
    CGContextSetLineWidth(currentContext,5.0f);
    
    //绘制
    CGContextDrawPath(currentContext, kCGPathFillStroke);
    
    CGPathRelease(path);
    
    
    
    /****三角形****/
    
    //设置背景颜色
    //[[UIColor clearColor]set];
    
    //UIRectFill([self bounds]);
    
    //拿到当前视图准备好的画板
    
    //CGContextRef context = UIGraphicsGetCurrentContext();
    
    //利用path进行绘制三角形
    
    //指定直线样式
    CGContextSetLineCap(context,kCGLineCapSquare);
    
    //直线宽度
    CGContextSetLineWidth(context,2.0);
    
    //设置颜色
    CGContextSetRGBStrokeColor(context,0.314, 0.486, 0.859, 1.0);
    
    CGContextBeginPath(context);//标记
    
    CGContextMoveToPoint(context,10, 230);//设置起点
    
    CGContextAddLineToPoint(context,10, 230+105);
    
    CGContextAddLineToPoint(context,100, 230);
    
    CGContextAddLineToPoint(context,10, 230);
    
    //绘制完成
    CGContextStrokePath(context);
    
    //CGContextClosePath(context);//路径结束标志，不写默认封闭
    
    //[[UIColor yellowColor] setFill];
    
    //设置填充色
    
    //设置边框颜色
    //CGContextDrawPath(context,kCGPathFillStroke);//绘制路径path
    
    
}


@end
