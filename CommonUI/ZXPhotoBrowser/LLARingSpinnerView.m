//
//  LLARingSpinnerView.m
//  LLARingSpinnerView
//
//  Created by Lukas Lipka on 05/04/14.
//  Copyright (c) 2014 Lukas Lipka. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "LLARingSpinnerView.h"

static NSString *kLLARingSpinnerAnimationKey = @"llaringspinnerview.rotation";

@interface LLARingSpinnerView ()

@property (nonatomic, readonly) CAShapeLayer *progressLayer;
@property (nonatomic, readwrite) BOOL isAnimating;
@property (nonatomic,strong)UILabel *label;
@property(nonatomic)int currentProgress;
@property(nonatomic)CGRect myFrame;
@end

@implementation LLARingSpinnerView

@synthesize progressLayer = _progressLayer;
@synthesize isAnimating = _isAnimating;
@synthesize label;
@synthesize currentProgress;
@synthesize myFrame;
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.myFrame=frame;
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    
    CALayer *layer=[[CALayer alloc]init];
    CGRect rect=CGRectMake(0, 0, self.bounds.size.width*1.2, self.bounds.size.height*1.2);
    
    [layer setFrame:rect];
    layer.position=CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    [layer setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6].CGColor];
    [self.layer addSublayer:layer];
    
    [self.layer addSublayer:self.progressLayer];
    
    
    self.label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, myFrame.size.width, myFrame.size.height)];
    [self.label setBackgroundColor:[UIColor clearColor]];
    [self.label setText:@"0"];
    [self.label setHidden:YES];
    [self.label setFont:[UIFont systemFontOfSize:14]];
    [self.label setTextColor:[UIColor whiteColor]];
    [self.label setTextAlignment:NSTextAlignmentCenter];
    
    [self  addSubview:label];
    
    self.currentProgress=0;
}
-(void)setProgress:(int )progress
{
    self.currentProgress=progress;
    [self.label setHidden:NO];
    [self.label setText:[NSString stringWithFormat:@"%d",progress]];
}
- (void)layoutSubviews {
    [super layoutSubviews];

    self.progressLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
    [self updatePath];
}

- (void)tintColorDidChange {
    [super tintColorDidChange];

    self.progressLayer.strokeColor = self.tintColor.CGColor;
}

- (void)startAnimating {
    if (self.isAnimating)
        return;

    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation";
    animation.duration = 1.0f;
    animation.fromValue = @(0.0f);
    animation.toValue = @(2 * M_PI);
    animation.repeatCount = INFINITY;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

    [self.progressLayer addAnimation:animation forKey:kLLARingSpinnerAnimationKey];
    self.isAnimating = true;
}

- (void)stopAnimating {
    if (!self.isAnimating)
        return;

    [self.progressLayer removeAnimationForKey:kLLARingSpinnerAnimationKey];
    self.isAnimating = false;
}

#pragma mark - Private

- (void)updatePath {
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    CGFloat radius = MIN(CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds) / 2) - self.progressLayer.lineWidth / 2;
    CGFloat startAngle = (CGFloat)(-M_PI_4);
    CGFloat endAngle = (CGFloat)(3 * M_PI_2);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    self.progressLayer.path = path.CGPath;
}

#pragma mark - Properties

- (CAShapeLayer *)progressLayer {
    if (!_progressLayer) {
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.strokeColor = [UIColor whiteColor].CGColor;
        _progressLayer.fillColor = nil;
        _progressLayer.lineWidth = 1.5f;
        
    }
    return _progressLayer;
}

- (BOOL)isAnimating {
    return _isAnimating;
}

- (CGFloat)lineWidth {
    return self.progressLayer.lineWidth;
}

- (void)setLineWidth:(CGFloat)lineWidth {
    self.progressLayer.lineWidth = lineWidth;
    [self updatePath];
}

@end
