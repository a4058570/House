//
//  YJIntroduceVC.m
//  YingJi
//
//  Created by 张旭 on 15/7/13.
//  Copyright (c) 2015年 张旭. All rights reserved.
//

#import "YJIntroduceVC.h"
//#import "ALLTagController.h"
#import "UIView+ZXTool.h"
#import "MacroDefine.h"
#import <REFrostedViewController.h>
//#import "ALLMyPageTableVC.h"
#import "NSObject+ZXTool.h"

/*地图窗口*/
#import "MainMapVC.h"

/*标签页按钮*/
#import "ALLTagController.h"

/*动画库*/
#import <POP.h>

@interface YJIntroduceVC ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property(nonatomic)int totalPage;
@property(nonatomic,strong)NSMutableArray *totalItems;

-(void)goBtnPressed:(UIButton *)btn;

-(void)animatePage:(int)page;
-(void)resetPage:(int)page;

-(UIView *)creagePage:(int)page;
@end

@implementation YJIntroduceVC
+(BOOL)shouldShowIntro
{
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
    
    // app版本
    
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    
    BOOL showldShow=NO;
    if ([app_Version isEqualToString:@"1.0"]) {
        showldShow=YES;
    }
    
    if (showldShow) {
        NSString *key=[NSString stringWithFormat:@"%@_intro111",app_Version];
        
        BOOL isShow= [[NSUserDefaults standardUserDefaults] boolForKey:key];
       
        
        if (!isShow) {
            return YES;
        }else
        {
            return NO;
        }
    }else
    {
        return NO;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.totalPage=3;
    [self.scrollView setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width*self.totalPage, [UIScreen mainScreen].bounds.size.height)];
    
    self.totalItems=[NSMutableArray array];
    
    
//    UIImageView *imgView=[[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    [imgView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"intro%d.jpg",i+1]]];
//    [imgView setOriX:i*[UIScreen mainScreen].bounds.size.width];
//    [self.scrollView addSubview:imgView];
//    imgView.backgroundColor=[UIColor whiteColor];
//    imgView.userInteractionEnabled=YES;
   
     
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    for(int i=0;i<self.totalPage;i++)
    {
        UIView *container= [self creagePage:i];
        //[container setOriX:i*[UIScreen mainScreen].bounds.size.width ];
        [self.scrollView addSubview:container];
        [self.totalItems addObject:container];
        
        [self resetPage:i];
    }
    
    
    self.pageControl.numberOfPages=self.totalPage;
    //self.pageControl.tintColor=[UIColor blackColor];
    self.pageControl.currentPage=0;
    self.scrollView.delegate=self;
    
    _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    WS(weakSelf);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf animatePage:0];
    });
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//   CGFloat x= scrollView.contentOffset.x;
//    int page=x/[UIScreen mainScreen].bounds.size.width;
//    self.pageControl.currentPage=page;
   // NSLog(@"scroll x %f",x);
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //当前是在哪一页 显示哪一页的动画
    CGFloat x= scrollView.contentOffset.x;
    int page=x/[UIScreen mainScreen].bounds.size.width;
    
    
    int prePage=(int)self.pageControl.currentPage;
    
    if (prePage!=page) {
        self.pageControl.currentPage=page;
        [self resetPage:prePage];
        
        WS(weakSelf);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            /*播放动画*/
            [weakSelf animatePage:page];
        });
    }
   
    
    
}

/**********************************************************
   函数名称：-(void)animatePage:(int)i
   函数描述：引导页的动画
   输入参数：N/A
   输出参数：N/A
   返回值：N/A
 **********************************************************/
-(void)animatePage:(int)i
{
    
    UIView *container= [self.totalItems objectAtIndex:i];
    if (i==0) {//第一页的动画
        for(UIView *sub in container.subviews)
        {
            if ([sub.tagString isEqualToString:@"title"]) { //标题
                //创建动画,修改透明度
                POPSpringAnimation *scaleAnim=[POPSpringAnimation animationWithPropertyNamed:kPOPLayerOpacity];
                //修改透明度为1.0
                scaleAnim.toValue=@(1.0);
                //scaleAnim.springBounciness=12;
                
                [sub.layer pop_addAnimation:scaleAnim forKey:@"opacity"];
                
                //播放动画
                [UIView animateWithDuration:0.4 delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:12 options:UIViewAnimationOptionCurveLinear animations:^{
                    [sub setCenter:CGPointMake([UIScreen mainScreen].bounds.size.width/2.0, sub.center.y)];
                } completion:^(BOOL finished) {
                    
                }];
            
                
            }else if ([sub.tagString isEqualToString:@"pay"]) //支付内容
            {
                [UIView animateWithDuration:0.5 delay:0.3 usingSpringWithDamping:0.7 initialSpringVelocity:12 options:UIViewAnimationOptionCurveLinear animations:^{
                    
                   // [sub setCenter:CGPointMake([sub getOriX]+90, sub.center.y)];
                    sub.transform=CGAffineTransformMakeScale(0.5, 0.5);
                } completion:^(BOOL finished) {
                    
                }];
                
            }else if ([sub.tagString isEqualToString:@"hand"]) //手指
            {
                
                [UIView animateWithDuration:0.5 delay:0.4 usingSpringWithDamping:0.7 initialSpringVelocity:12 options:UIViewAnimationOptionCurveLinear animations:^{
                    
                    [sub setCenter:CGPointMake([UIScreen mainScreen].bounds.size.width/2.0+50, sub.center.y)];
                    sub.alpha=1.0;
                } completion:^(BOOL finished) {
                    
                }];
            }
        }
    }else if (i==1)
    {
        for(UIView *sub in container.subviews)
        {
            if ([sub.tagString isEqualToString:@"title"]) {
                POPSpringAnimation *scaleAnim=[POPSpringAnimation animationWithPropertyNamed:kPOPLayerOpacity];
                scaleAnim.toValue=@(1.0);
                //  scaleAnim.springBounciness=12;
                
                [sub.layer pop_addAnimation:scaleAnim forKey:@"opacity"];
                
                
                [UIView animateWithDuration:0.4 delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:12 options:UIViewAnimationOptionCurveLinear animations:^{
                    [sub setCenter:CGPointMake([UIScreen mainScreen].bounds.size.width/2.0, sub.center.y)];
                } completion:^(BOOL finished) {
                    
                }];
                
                
            }else if ([sub.tagString isEqualToString:@"dialog1"])
            {
                [UIView animateWithDuration:1.0 delay:0.2 options:UIViewAnimationOptionCurveLinear animations:^{
                    sub.alpha=1.0;
                    sub.center=CGPointMake(sub.center.x, sub.center.y-20);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:1.8 delay:0.0 options:UIViewAnimationOptionRepeat|UIViewAnimationOptionAutoreverse animations:^{
                        
                        sub.center=CGPointMake(sub.center.x, sub.center.y+20);
                    } completion:nil];
                    
                }];
                
                
                
                
            }else if ([sub.tagString isEqualToString:@"dialog2"])
            {
                [UIView animateWithDuration:1.0 delay:0.5 options:UIViewAnimationOptionCurveLinear animations:^{
                    sub.alpha=1.0;
                    sub.center=CGPointMake(sub.center.x, sub.center.y-20);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:1.8 delay:0.0 options:UIViewAnimationOptionRepeat|UIViewAnimationOptionAutoreverse animations:^{
                        
                        sub.center=CGPointMake(sub.center.x, sub.center.y+20);
                    } completion:nil];
                    
                }];
                
            }
        }
    }else
    {
        for(UIView *sub in container.subviews)
        {
            if ([sub.tagString isEqualToString:@"logo"]) {
                POPSpringAnimation *scaleAnim=[POPSpringAnimation animationWithPropertyNamed:kPOPLayerOpacity];
                scaleAnim.toValue=@(1.0);
                //  scaleAnim.springBounciness=12;
                
                [sub.layer pop_addAnimation:scaleAnim forKey:@"opacity"];
                
                
                [UIView animateWithDuration:0.4 delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:12 options:UIViewAnimationOptionCurveLinear animations:^{
                    [sub setCenter:CGPointMake([UIScreen mainScreen].bounds.size.width/2.0, sub.center.y)];
                } completion:^(BOOL finished) {
                    
                }];
                
                
            }else if ([sub.tagString isEqualToString:@"111"])
            {
                
        
                [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveLinear animations:^{
                    sub.alpha=1.0;
                } completion:^(BOOL finished) {
                    
                }];
               
                
            }else if ([sub.tagString isEqualToString:@"slogan"])
            {
                [UIView animateWithDuration:0.3 delay:0.5 options:UIViewAnimationOptionCurveLinear animations:^{
                    sub.alpha=1.0;
                } completion:^(BOOL finished) {
                    
                }];
                
            }else if ([sub.tagString isEqualToString:@"button"])
            {
                [UIView animateWithDuration:0.3 delay:0.8 options:UIViewAnimationOptionCurveLinear animations:^{
                    sub.alpha=1.0;
                } completion:^(BOOL finished) {
                    
                }];
            }
        }
    }
}

/**********************************************************
   函数名称：-(void)resetPage:(int)i
  函数描述：重置引导页面和页面的控件
  输入参数：N/A
   输出参数：N/A
  返回值：N/A
 **********************************************************/
-(void)resetPage:(int)i
{
    CGFloat titleOffset=[UIScreen mainScreen].bounds.size.height/2.0-190;
    if ([UIScreen mainScreen].bounds.size.height!=480) {
        titleOffset=[UIScreen mainScreen].bounds.size.height/2.0-210;
    }
   UIView *container= [self.totalItems objectAtIndex:i];
    if (i==0) {
        for(UIView *sub in container.subviews)
        {
            if ([sub.tagString isEqualToString:@"title"]) {
                sub.alpha=0;
                sub.center=CGPointMake(-sub.frame.size.width/2.0, titleOffset);
            }else if ([sub.tagString isEqualToString:@"pay"])
            {
                //sub.center=CGPointMake([self.view getWidth]/2.0, [self.view getHeight]/2.0);
               // sub.transform=CGAffineTransformMakeScale(0.01, 0.01);
            }else if ([sub.tagString isEqualToString:@"hand"])
            {
                sub.center=CGPointMake([UIScreen mainScreen].bounds.size.width+sub.frame.size.width/2.0, [UIScreen mainScreen].bounds.size.height/2.0+45);
                sub.alpha=0;
            }
        }
    }else if (i==1)
    {
        for(UIView *sub in container.subviews)
        {
            if ([sub.tagString isEqualToString:@"title"]) {
                sub.alpha=0;
                sub.center=CGPointMake(-sub.frame.size.width/2.0, titleOffset);
            }else if ([sub.tagString isEqualToString:@"dialog1"])
            {
               // sub.center=CGPointMake([self.view getWidth]/2.0-85, [self.view getHeight]/2.0-108);
               // sub.alpha=0;
                
            }else if ([sub.tagString isEqualToString:@"dialog2"])
            {
                //sub.center=CGPointMake([self.view getWidth]/2.0+85, [self.view getHeight]/2.0-114);
               // sub.alpha=0;
            }
        }
    }else
    {
        for(UIView *sub in container.subviews)
        {
            if ([sub.tagString isEqualToString:@"logo"]) {
                sub.alpha=0;
                sub.center=CGPointMake(-sub.frame.size.width/2.0, titleOffset+20);
            }else if ([sub.tagString isEqualToString:@"111"])
            {
                //sub.center=CGPointMake([self.view getWidth]/2.0, [self.view getHeight]-210);
               // sub.alpha=0;
                
            }else if ([sub.tagString isEqualToString:@"slogan"])
            {
               // sub.center=CGPointMake([self.view getWidth]/2.0, [self.view getHeight]-145);
               // sub.alpha=0;
            }else if ([sub.tagString isEqualToString:@"button"])
            {
                sub.center=CGPointMake([UIScreen mainScreen].bounds.size.width/2.0, [UIScreen mainScreen].bounds.size.height-76);
                sub.alpha=0;
            }
        }
    }
}

/**********************************************************
  函数名称：-(UIView *)creagePage:(int)i
  函数描述：创建引导页面和页面的控件
  输入参数：N/A
  输出参数：N/A
  返回值：UIView :视图。
**********************************************************/
-(UIView *)creagePage:(int)i
{
    UIView *container=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    container.backgroundColor=[UIColor whiteColor];
   
    
    if (i==0) {/*第一页的控件创建*/
        
        //创建标题控件
        UIImage *titleImg=[UIImage imageNamed:@"intro1_title.png"];
        UIImageView *titleImgView=[[UIImageView alloc]initWithImage:titleImg];
        [titleImgView setSize:CGSizeMake(titleImg.size.width/2.0, titleImg.size.height/2.0)];
        [container addSubview:titleImgView];
        titleImgView.tagString=@"title";
        
        //创建圆形背景
        UIImage *bgImage= [UIImage imageNamed:@"intro1_bg.png"];
        UIImageView *bgImgView=[[UIImageView alloc]initWithImage:bgImage];
        [bgImgView setSize:CGSizeMake(bgImage.size.width/2.0, bgImage.size.height/2.0)];
        [container addSubview:bgImgView];
        bgImgView.center=CGPointMake([UIScreen mainScreen].bounds.size.width/2.0, [UIScreen mainScreen].bounds.size.height/2.0);
        
        //创建圆形背景
        UIImageView *payImgView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"intro1_pay.png"]];
        [container addSubview:payImgView];
        payImgView.tagString=@"pay";
        
        //创建手指
        UIImage *handImage=[UIImage imageNamed:@"intro1_hand"];
        UIImageView *handImgView=[[UIImageView alloc]initWithImage:handImage];
        [handImgView setSize:CGSizeMake(handImage.size.width/2.0, handImage.size.height/2.0)];
        [container addSubview:handImgView];
        handImgView.tagString=@"hand";
        
        
    }
    else if (i==1)/*第二页的控件创建*/
    {
        //创建标题
        UIImage *titleImg=[UIImage imageNamed:@"intro2_title.png"];
        UIImageView *titleImgView=[[UIImageView alloc]initWithImage:titleImg];
        [titleImgView setSize:CGSizeMake(titleImg.size.width/2.0, titleImg.size.height/2.0)];
        [container addSubview:titleImgView];
        titleImgView.tagString=@"title";
        
        //创建圆形背景
        UIImage *bgImage= [UIImage imageNamed:@"intro2_bg.png"];
        UIImageView *bgImgView=[[UIImageView alloc]initWithImage:bgImage];
        [bgImgView setSize:CGSizeMake(bgImage.size.width/2.0, bgImage.size.height/2.0)];
        [container addSubview:bgImgView];
        bgImgView.center=CGPointMake([UIScreen mainScreen].bounds.size.width/2.0, [UIScreen mainScreen].bounds.size.height/2.0);
        
        //创建 图标1
        UIImage *dialog1Image=[UIImage imageNamed:@"intro2_dialog1.png"];
        UIImageView *dialog1ImgView=[[UIImageView alloc]initWithImage:dialog1Image];
        [dialog1ImgView setSize:CGSizeMake(dialog1Image.size.width/2.0,dialog1Image.size.height/2.0 )];
        [container addSubview:dialog1ImgView];
        dialog1ImgView.tagString=@"dialog1";
        
        //创建 图标2
        UIImage *dialog2Image=[UIImage imageNamed:@"intro2_dialog2.png"];
        UIImageView *dialog2ImgView=[[UIImageView alloc]initWithImage:dialog2Image];
        [dialog2ImgView setSize:CGSizeMake(dialog2Image.size.width/2.0,dialog2Image.size.height/2.0 )];
        [container addSubview:dialog2ImgView];
        dialog2ImgView.tagString=@"dialog2";
        

    }else/*第三页的控件创建*/
    {
        //创建logo标题
        UIImage *titleImg=[UIImage imageNamed:@"intro3_logo.png"];
        UIImageView *titleImgView=[[UIImageView alloc]initWithImage:titleImg];
        [titleImgView setSize:CGSizeMake(titleImg.size.width/2.0, titleImg.size.height/2.0)];
        [container addSubview:titleImgView];
        titleImgView.tagString=@"logo";
        
        //创建城市背景
        UIImage *cityImage= [UIImage imageNamed:@"intro3_city.jpg"];
        UIImageView *cityImgView=[[UIImageView alloc]initWithImage:cityImage];
        [cityImgView setSize:CGSizeMake(cityImage.size.width/2.0, cityImage.size.height/2.0)];
        [container addSubview:cityImgView];
        
        cityImgView.tagString=@"111";
        
        //创建标语
        UIImage *dialog1Image=[UIImage imageNamed:@"intro3_slogan.png"];
        UIImageView *dialog1ImgView=[[UIImageView alloc]initWithImage:dialog1Image];
        [dialog1ImgView setSize:CGSizeMake(dialog1Image.size.width/2.0,dialog1Image.size.height/2.0 )];
        [container addSubview:dialog1ImgView];
        dialog1ImgView.tagString=@"slogan";
        
        //创建 进入按钮
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-100, 40)];
        [btn setBackgroundColor:[UIColor redColor]];
        [btn setTitle:@"立即体验" forState:UIControlStateNormal];
        btn.tagString=@"button";
        [btn addTarget:self action:@selector(goBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [container addSubview:btn];
        
    }
    
    
    return container;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**********************************************************
   函数名称：-(void)goBtnPressed:(UIButton *)btn
   函数描述：按进入按钮回调
   输入参数：N/A
   输出参数：N/A
   返回值：UIView :视图。
 **********************************************************/
-(void)goBtnPressed:(UIButton *)btn
{
  //  WS(weakSelf);
    
//    [UIView animateWithDuration:0.3 animations:^{
//        weakSelf.view.alpha=0;
//        YJTabbarController *tab=[[YJTabbarController alloc]init];
//       // [UIApplication sharedApplication].keyWindow.rootViewController=tab;
//    }];
    
    /*
    ALLMyPageTableVC *myPage=[ALLMyPageTableVC loadFromNib];
    ALLTagController *tab=[[ALLTagController alloc]init];
    
    REFrostedViewController *frostedViewController = [[REFrostedViewController alloc] initWithContentViewController:tab menuViewController:myPage];
    frostedViewController.direction = REFrostedViewControllerDirectionLeft;
    // frostedViewController.liveBlurBackgroundStyle = REFrostedViewControllerLiveBackgroundStyleLight;
    frostedViewController.liveBlur = NO;
    frostedViewController.blurTintColor=[UIColor colorWithRed:26/255.0 green:29/255.0 blue:41/255.0 alpha:1.0];

    [UIApplication sharedApplication].keyWindow.rootViewController=frostedViewController;
    frostedViewController.delegate=(id)[UIApplication sharedApplication].delegate;
    
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:transition forKey:nil];
    */
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:transition forKey:nil];
    
    // app版本设置-判断是否进行过安装引导
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    NSString *key=[NSString stringWithFormat:@"%@_intro111",app_Version];
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];//保存数据,调用synchronize函数将立即更新这些默认值。
    
    //跳转页面
    ALLTagController *tab=[[ALLTagController alloc]init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tab;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
