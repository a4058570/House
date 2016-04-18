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


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef ref = UIGraphicsGetCurrentContext();
    //flip the coordinate system
    
    CGContextSetTextMatrix(ref, CGAffineTransformIdentity);
    CGContextTranslateCTM(ref, 0, self.bounds.size.height);
    CGContextScaleCTM(ref, 1.0, -1.0);  CGMutablePathRef
    path = CGPathCreateMutable();
    //1
    CGPathAddRect(path, NULL, self.bounds);
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
}


@end
