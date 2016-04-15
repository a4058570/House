//
//  CerterViewController.m
//  QQ空间
//
//  Created by 妖精的尾巴 on 15-9-1.
//  Copyright (c) 2015年 妖精的尾巴. All rights reserved.
//

#import "CerterViewController.h"

@interface CerterViewController ()
/**
 *记录底部图片的属性
 */
@property(nonatomic,strong)UIImageView* bottomImge;
/**
 *定时器
 */
@property(nonatomic,strong)NSTimer* timer;
/**
 *存放按钮的数组
 */
@property(nonatomic,strong)NSMutableArray* btnArray;
/**
 *存放按钮图片的数组
 */
@property(nonatomic,strong)NSArray* imageArray;
/**
 *图片往上滑动的索引
 */
@property(assign,nonatomic)NSInteger upIndex;
/**
 *图片向下滑回的索引
 */
@property(assign,nonatomic)NSInteger downIndex;

@end

@implementation CerterViewController
#pragma mark - 以下是两个懒加载方法
-(NSMutableArray*)btnArray
{
    if (_btnArray==nil) {
        _btnArray=[NSMutableArray array];
    }
    return _btnArray;
}
-(NSArray*)imageArray
{
    if (_imageArray==nil) {
        _imageArray=[NSArray array];
  _imageArray=@[@"tabbar_btn_popup_talk",@"tabbar_btn_popup_transferphotos",@"thirdparty_btn_popup_continuousshooting",@"tabbar_btn_popup_video",@"tabbar_btn_popup_registration",@"thirdparty_btn_popup_journal",@"tabbar_btn_popup_addmore_click"];
    }
    return _imageArray;
}
#pragma mark - 系统方法
-(void)loadView
{
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [view setBackgroundColor:[UIColor whiteColor]];
    UIImageView *imgView = [[UIImageView alloc]initWithImage:self.captureImage];
    UIView *blurView =[[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [blurView setBackgroundColor:[UIColor colorWithWhite:0.8f alpha:0.9f]];
    [imgView addSubview:blurView];
    [view addSubview:imgView];
    self.view = view;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createBtn];
    [self createBottomImage];
    self.view.backgroundColor=[UIColor greenColor];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(popupBtn) userInfo:nil repeats:YES];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchesBegan:)];
    [self.view addGestureRecognizer:tapGesture];
    [self createMessageLabel];
    [self createtimeLabel];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"viewWillAppear");
    [super viewWillAppear:animated];
    [UIView animateWithDuration:0.5f animations:^{
        self.bottomImge.transform = CGAffineTransformRotate(self.bottomImge.transform, M_PI);
    }];
}
#pragma mark - 按钮向上滑动的方法
- (void)popupBtn
{
    
    if (self.upIndex == self.btnArray.count) {
        
        [self.timer invalidate];
        
        self.upIndex = 0;
        
        return;
    }
    qqButton *btn = self.btnArray[self.upIndex];
    [self setUpOneBtnAnim:btn];
    self.upIndex++;
}
#pragma mark - 第一个按钮滑动的方法 
- (void)setUpOneBtnAnim:(UIButton *)btn
{
    
    [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        btn.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished){
        self.downIndex = self.btnArray.count - 1;
    }];
}
#pragma mark - UI界面搭建方法
-(void)createBottomImage
{
    UIImageView* bottomImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tabbar_btn_click"]];
    bottomImage.frame = CGRectMake(self.view.center.x-38, self.view.frame.size.height-60, 76, 60);
    [self.view addSubview:bottomImage];
    self.bottomImge= bottomImage;
}
-(void)createMessageLabel
{
    UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(20, 110, self.view.bounds.size.width-40, 40)];
    label.numberOfLines =0;
    label.adjustsFontSizeToFitWidth=YES;
    label.font=[UIFont systemFontOfSize:17.0f];
    label.text=@"时间知道\n越是平凡的陪伴 就越长久";
    [self.view addSubview:label];
}
-(void)createBtn
{
    NSLog(@"调用了按钮创建方法");
    int cols=4;
    int col=0;
    int row=0;
    CGFloat x=0;
    CGFloat y=0;
    CGFloat wh=67;
    CGFloat Y=280;
    CGFloat margin=([UIScreen mainScreen].bounds.size.width-wh*cols)/(cols+1);
    for (int i=0; i<self.imageArray.count; i++) {
        NSArray* titleArray=@[@"说说",@"照片",@"水印相机",@"短视频",@"签到",@"日志",@"添加应用"];
        /**
         *设置每个按钮的图片与文字
         */
        qqButton* btn=[qqButton buttonWithType:UIButtonTypeCustom];
        UIImage* image=[UIImage imageNamed:self.imageArray[i]];
        NSString* title=titleArray[i];
        [btn setImage:image forState:UIControlStateNormal];
        [btn setTitle:title forState:UIControlStateNormal];
        /**
         *计算每个按钮的坐标与大小
         */
        col=i%cols;
        row=i/cols;
        x=margin+col*(margin+wh);
        y=row*(margin+wh)+Y;
        btn.frame=CGRectMake(x, y, wh, wh);
        btn.transform=CGAffineTransformMakeTranslation(0, self.view.bounds.size.height);
        
        btn.tag=500+i;
        [btn addTarget:self action:@selector(touchDownBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.btnArray addObject:btn];
        [self.view addSubview:btn];
       
    }
     NSLog(@"子视图的个数为:%ld",self.view.subviews.count);
}
-(void)createtimeLabel
{
    NSDate* date=[NSDate date];
    UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(20, 60, self.view.bounds.size.width-60, 40)];
    NSDateFormatter* dateFormater=[[NSDateFormatter alloc]init];
    [dateFormater setDateFormat:@"现在是:yyyy年MM月dd日 HH:mm"];
    NSString* dateStr=[dateFormater stringFromDate:date];
    label.text=dateStr;
    [self.view addSubview:label];
}
#pragma mark - 按钮点击方法
- (void)touchDownBtn:(qqButton *)btn
{
    [UIView animateWithDuration:0.5 animations:^{
        btn.transform = CGAffineTransformMakeScale(2.0, 2.0);
        btn.alpha = 0;
    }];
}
#pragma mark - 按钮落下屏幕的方法
- (void)returnUpVC
{
    
    if (_downIndex == -1) {
        
        [self.timer invalidate];
        
        return;
    }
    qqButton *btn = self.btnArray[_downIndex];
    [self setDownOneBtnAnim:btn];
    _downIndex--;
}
#pragma mark - 从第一个开始按钮落下屏幕
- (void)setDownOneBtnAnim:(UIButton *)btn
{
    
    [UIView animateWithDuration:0.6 animations:^{
        
        btn.transform = CGAffineTransformMakeTranslation(0, self.view.bounds.size.height);
        
    } completion:^(BOOL finished) {
        
        [self dismissViewControllerAnimated:NO completion:nil];
        
    }];
}
#pragma mark - 手势响应事件处理方法
-(void)touchesBegan:(UITapGestureRecognizer *)gesturer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(returnUpVC) userInfo:nil repeats:YES];
    [UIView animateWithDuration:0.3 animations:^{
        self.bottomImge.transform = CGAffineTransformRotate(self.bottomImge.transform, -M_PI_2*1.5);
    }];
}
@end
