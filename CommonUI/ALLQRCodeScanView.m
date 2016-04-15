//
//  ALLQRCodeScanView.m
//  ALiuLian
//
//  Created by 张旭 on 15/5/12.
//  Copyright (c) 2015年 张旭. All rights reserved.
//

#import "ALLQRCodeScanView.h"
#import <ZXingObjC.h>
#import "MacroDefine.h"
@interface ALLQRCodeScanView()<ZXCaptureDelegate>
{
    BOOL isFnishScan;
}
@property(nonatomic,copy)void(^finishBlock)(NSString *resultStr);

@property(nonatomic,strong) ZXCapture *capture;

@property(nonatomic,strong)CALayer *greyLayer;
@property(nonatomic,strong)CALayer *scanRectLayer;
@property(nonatomic,strong)CAGradientLayer *grandLayer;

@property(nonatomic)CGRect scanRect;
-(void)customInit;
-(void)initGreyLayer;
//-(void)initUI;
-(void)scanAnim;
@end


@implementation ALLQRCodeScanView
@synthesize grandLayer;
-(id)init
{
    self=[super init];
    if (self) {
        [self setFrame:[UIScreen mainScreen].bounds];
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

-(void)customInit
{
    
    
    isFnishScan=YES;
    [self initGreyLayer];

    //   NSString *mediaType = AVMediaTypeVideo;
//    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
//    
//    if(authStatus == AVAuthorizationStatusAuthorized){
        self.capture = [[ZXCapture alloc] init];
        self.capture.camera = self.capture.back;
        self.capture.focusMode = AVCaptureFocusModeContinuousAutoFocus;
        self.capture.rotation = 90.0f;
        
        self.capture.layer.frame = self.bounds;
        [self.layer insertSublayer:self.capture.layer below:self.greyLayer];
        self.capture.delegate=(id)self;
        [self.capture start];
   // }
    
    
    self.capture.scanRect = self.scanRectLayer.frame;
    self.scanRect=self.scanRectLayer.frame;
    
    
    
    
    
    
    UIGraphicsBeginImageContextWithOptions(self.scanRect.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context=UIGraphicsGetCurrentContext();
        
    
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, 0, self.scanRect.size.width);
    CGContextAddLineToPoint(context, self.scanRect.size.width, self.scanRect.size.width);
    CGContextAddLineToPoint(context, self.scanRect.size.width, 0);
    CGContextClosePath(context);
    
    
    //设置图形上下文属性
    CGContextSetRGBFillColor(context, 1, 0, 1, 1);
    CGContextSetRGBStrokeColor(context, 0, 1, 0, 1);
    CGContextSetLineCap(context, kCGLineCapButt);
    CGContextSetLineJoin(context, kCGLineJoinMiter);
    CGContextSetLineWidth(context, 3.0);
    CGFloat lengths[2] = { 40, CGRectGetWidth(self.scanRect)-40 };
    CGContextSetLineDash(context, 20, lengths, 2);
    
    CGContextDrawPath(context, kCGPathStroke);
    UIImage *resultImg= UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.scanRect.size.width, self.scanRect.size.height)];
    imgView.image=resultImg;
    imgView.backgroundColor=[UIColor clearColor];
    //[self addSubview:imgView];
    [self.scanRectLayer addSublayer:imgView.layer];
    
}

-(void)initGreyLayer
{
    CGSize screenSize=[UIScreen mainScreen].bounds.size;
    self.greyLayer=[CALayer layer];
    [self.greyLayer setFrame:self.bounds];
    [self.greyLayer  setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7].CGColor];
    [self.layer addSublayer:self.greyLayer];
    
    self.scanRectLayer=[CALayer layer];
    CGFloat w=[UIScreen mainScreen].bounds.size.width-90;
    
    [self.scanRectLayer setFrame:CGRectMake(0, 0, w, w)];
    [self.scanRectLayer setBackgroundColor:[UIColor clearColor].CGColor];
    [self.layer addSublayer:self.scanRectLayer];
    [self.scanRectLayer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.scanRectLayer setBorderWidth:0.5];
    self.scanRectLayer.position=CGPointMake(screenSize.width/2, screenSize.height/2);
    
    //四个红色角
    
    
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    CGMutablePathRef path = CGPathCreateMutable();
    // 左边矩形
    CGPathAddRect(path, nil, CGRectMake(0, 0,
                                        self.scanRectLayer.frame.origin.x,
                                        screenSize.height));
    // 右边矩形
    CGPathAddRect(path, nil, CGRectMake(
                                        self.scanRectLayer.frame.origin.x + self.scanRectLayer.frame.size.width,
                                        0,
                                        screenSize.width - self.scanRectLayer.frame.origin.x - self.scanRectLayer.frame.size.width,
                                        screenSize.height));
    // 上边矩形
    CGPathAddRect(path, nil, CGRectMake(0, 0,
                                        screenSize.width,
                                        self.scanRectLayer.frame.origin.y));
    // 下边举行
    CGPathAddRect(path, nil, CGRectMake(0,
                                        self.scanRectLayer.frame.origin.y + self.scanRectLayer.frame.size.height,
                                        screenSize.width,
                                        screenSize.height - self.scanRectLayer.frame.origin.y + self.scanRectLayer.frame.size.height));
    maskLayer.path = path;
    self.greyLayer.mask = maskLayer;
    
    
    
    
    UILabel *remaindLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.scanRectLayer.frame.size.width, 30)];
    [remaindLabel setTextColor:[UIColor whiteColor]];
    [remaindLabel setFont:[UIFont systemFontOfSize:13]];
    remaindLabel.center=CGPointMake(self.scanRectLayer.position.x,self.scanRectLayer.position.y+self.scanRectLayer.frame.size.width/2+20  );
    [remaindLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:remaindLabel];
    remaindLabel.text=@"将二维码放入矩形框内,即可自动扫描";
    
    
    
    
    grandLayer=[CAGradientLayer layer];
    [grandLayer setFrame:CGRectMake(0, 0, self.scanRectLayer.frame.size.width, 1)];
    grandLayer.colors=[NSArray arrayWithObjects:(id)[UIColor clearColor].CGColor,[UIColor whiteColor].CGColor,[UIColor clearColor].CGColor ,nil];
    grandLayer.locations=[NSArray arrayWithObjects:  [NSNumber numberWithFloat:0.0],  [NSNumber numberWithFloat:0.5],  [NSNumber numberWithFloat:1.0], nil];
    
    grandLayer.startPoint=CGPointMake(0, 0.5);
    grandLayer.endPoint=CGPointMake(1, 0.5);
    grandLayer.position=CGPointMake(self.scanRectLayer.position.x, self.scanRectLayer.frame.origin.y);
    [self.layer addSublayer:grandLayer];
    
    
    [self scanAnim];
}
-(void)finishBlock:(void(^)(NSString *resultStr))finish
{
    self.finishBlock=finish;
}

-(void)startScan
{
    self.capture.running=YES;
    isFnishScan=NO;
}
-(void)stopScan
{
    self.capture.running=NO;
    isFnishScan = YES;
}

-(void)scanAnim
{
    CABasicAnimation *animation= [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setFromValue:[NSValue valueWithCGPoint:CGPointMake(self.scanRectLayer.position.x, self.scanRectLayer.frame.origin.y)]];
    
    [animation setToValue:[NSValue valueWithCGPoint:CGPointMake(self.scanRectLayer.position.x, self.scanRectLayer.frame.origin.y+self.scanRectLayer.frame.size.height)]];
    [animation setDuration:2.5];
    animation.repeatCount=10000;
    [self.grandLayer addAnimation:animation forKey:nil];
}





#pragma mark -
#pragma mark ZXCaptureDelegate

- (void)captureResult:(ZXCapture *)capture result:(NSString *)result
{
    if (isFnishScan) {
        return ;
    }
        //得到用户id 去服务端取用户信息 然后跳转界面
        if (self.finishBlock) {
            _finishBlock(result);
        }
        
        
        // [self.capture stop];
  //  }
    [self stopScan];
}
- (void)captureSize:(ZXCapture *)capture
              width:(NSNumber *)width
             height:(NSNumber *)height
{
    NSLog(@"aaaaaaaaa");
}

- (void)captureCameraIsReady:(ZXCapture *)capture
{
    NSLog(@"bbbbbbbb");
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//    [super drawRect:rect];
//    CGContextRef context=UIGraphicsGetCurrentContext();
//    CGContextSaveGState(context);
//    
//    
//    CGFloat minX=CGRectGetMinX(self.scanRect);
//    CGFloat minY=CGRectGetMinY(self.scanRect);
//    CGFloat maxX=CGRectGetMaxX(self.scanRect);
//    CGFloat maxY=CGRectGetMaxY(self.scanRect);
//    
//    
//    CGContextMoveToPoint(context, minX, minY);
//    CGContextAddLineToPoint(context, minX, maxY);
//    CGContextAddLineToPoint(context, maxX, maxY);
//    CGContextAddLineToPoint(context, maxX, minY);
//    CGContextClosePath(context);
//    
//    
//    //设置图形上下文属性
//    CGContextSetRGBFillColor(context, 1, 0, 1, 1);
//    CGContextSetRGBStrokeColor(context, 0, 1, 0, 1);
//    CGContextSetLineCap(context, kCGLineCapButt);
//    CGContextSetLineJoin(context, kCGLineJoinMiter);
//    CGContextSetLineWidth(context, 3.0);
//    CGFloat lengths[2] = { 40, CGRectGetWidth(self.scanRect)-40 };
//    CGContextSetLineDash(context, 20, lengths, 2);
//    
//    CGContextDrawPath(context, kCGPathFillStroke);
//    CGContextRestoreGState(context);
//}


@end
