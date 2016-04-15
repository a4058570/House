//
//  ZXPhotoBrowser.m
//  PhotoBroswer
//
//  Created by zhangxu on 15/3/6.
//  Copyright (c) 2015年 zhangxu. All rights reserved.
//

#import "ZXPhotoBrowser.h"
#import "ZXPhotoView.h"


#define BG_COLOR  [UIColor colorWithRed:0 green:0 blue:0 alpha:0.9]
#define ScrollPage_Edge  15


@implementation ZXPhotoModel

@end





@interface ZXPhotoBrowser ()<ZXPhotoViewDelegate>

@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UILabel *controlLabel;


@property(nonatomic,strong)NSMutableArray *photoModels;

@property(nonatomic,strong)NSMutableArray *usePhotoViews;

@property(nonatomic,weak)UIView *container;

@property(nonatomic)BOOL preStatusBarHidden;


-(void)initUI;


-(void)showPhotoView:(int)index;
-(CGPoint )getPageOffset:(int)index   isCenter:(BOOL)isCenter;
-(int)offsetInPage:(CGPoint)offset isCenter:(BOOL )isCenter;
-(void)changeLabel:(int)curIndex  :(int)total;




/*photoView ReUse*/
-(ZXPhotoView *)dequenePhotoView;
-(void)freeUnUsePhotoView;

-(ZXPhotoView *)photoViewForPage:(int)page;
-(void)didTouchClose:(ZXPhotoView *)photoView;
@end



@implementation ZXPhotoBrowser
@synthesize photoModels;
@synthesize usePhotoViews;

@synthesize scrollView;
@synthesize controlLabel;

@synthesize currentIndex;


@synthesize animType;
-(id)init
{
    if (self==[super init]) {
        usePhotoViews=[[NSMutableArray alloc]init];
        photoModels=[[NSMutableArray alloc]init];
    }
    return self;
   
}


-(id)initWithPhotoModels:(NSArray *)models
{
    self=[super init];
    if (self) {
        usePhotoViews=[[NSMutableArray alloc]init];
        photoModels=(id)models;
        
        [self initUI];
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
   
}
-(void)initUI
{
    CGSize screenSize=[UIScreen mainScreen].bounds.size;
  //  [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    NSUInteger totalPage=[photoModels count];
    
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    
    
    
    
    self.scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, screenSize.width+ScrollPage_Edge*2, screenSize.height)];
    self.scrollView.center=CGPointMake(screenSize.width/2,screenSize.height/2);
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.delegate = self;
    self.scrollView.clipsToBounds = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.userInteractionEnabled=YES;
    self.scrollView.pagingEnabled=YES;
    self.scrollView.decelerationRate = UIScrollViewDecelerationRateFast;
    self.scrollView.contentSize=CGSizeMake(self.scrollView.bounds.size.width*totalPage, screenSize.height);
    self.scrollView.contentOffset=CGPointMake(self.scrollView.bounds.size.width*self.currentIndex, 0);
    [self.view addSubview: self.scrollView];
    
    
    
    
    //状态条  -10/20-
    self.controlLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.controlLabel.backgroundColor=[UIColor clearColor] ;
   // [self.controlLabel setFont:[UIFont systemFontOfSize:14]];
    [self.controlLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
    [self.controlLabel setTextColor:[UIColor whiteColor]];
    [self.controlLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:self.controlLabel];
    self.controlLabel.center=CGPointMake(screenSize.width/2, screenSize.height-20);
    [self changeLabel:self.currentIndex : (int)totalPage];
    
}
-(void)changeLabel:(int)curIndex  :(int)total
{
    NSString *content=[NSString stringWithFormat:@"%d/%d",curIndex+1,total];
    [self.controlLabel setText:content];
}
-(ZXPhotoView *)photoViewForPage:(int)page
{
    for(ZXPhotoView *view in self.usePhotoViews)
    {
        if (view.index==page) {
            return view;
        }
    }
    return nil;
}
-(void)showPhotoView:(int)index
{
    if (index<0||index>=[self.photoModels count]) {
        return ;
    }
    
    
    ZXPhotoModel *model=[self.photoModels objectAtIndex:index];
    ZXPhotoView *photoView=[self photoViewForPage:index];
    if (photoView==nil) {
        photoView=[self dequenePhotoView];
    }
    
    if (photoView.model==nil) {
        photoView.model=model;
        photoView.center=[self getPageOffset:index isCenter:YES];
        [self.scrollView addSubview:photoView];
        [photoView setTag:model.index];
        [photoView setIndex:index];

    }
}


-(ZXPhotoView *)dequenePhotoView
{
    ZXPhotoView *photo=nil;
    for(ZXPhotoView *view in self.usePhotoViews)
    {
        if (view.superview==nil) {
            return view;
        }
    }
    
    photo=[[ZXPhotoView alloc]init];
    photo.photoDelegate=(id)self;
    [self.usePhotoViews addObject:photo];
    return photo;
}

-(void)showBrowswerWithIndex:(int)index inContainner:(UIView *)container
{
    
    if (index>=self.photoModels.count||index<0) {
        NSLog(@"invalid show index");
        return;
    }
    
    _container=container;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.view];
    [window.rootViewController addChildViewController:self];
    
    
//    [UIView setAnimationsEnabled:YES];
//    _preStatusBarHidden=[UIApplication sharedApplication].statusBarHidden;
//    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
//     [self setNeedsStatusBarAppearanceUpdate];
    
    
    ZXPhotoModel *showModel=self.photoModels[index];
    if (showModel.fromImageView.image) {
        //动画进入
        CGSize screenSize=[UIScreen mainScreen].bounds.size;
        CGRect originRect=[showModel.fromImageView.superview convertRect:showModel.fromImageView.frame toView:container];
        CGRect finalRect;
        
        finalRect.size.width=[UIScreen mainScreen].bounds.size.width;
        finalRect.size.height=showModel.fromImageView.image.size.height*[UIScreen mainScreen].bounds.size.width/showModel.fromImageView.image.size.width;
        
        if (finalRect.size.height>screenSize.height) {
            finalRect.origin=CGPointMake(0, 0);
        }else
        {
            finalRect.origin=CGPointMake(0, screenSize.height/2.0-finalRect.size.height/2.0);
        }
        
        UIImageView *tmpImgView=[[UIImageView alloc]initWithFrame:originRect];
        tmpImgView.image=showModel.fromImageView.image;
        [self.view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0]];
        [self.view addSubview:tmpImgView];
        [UIView animateWithDuration:0.3 animations:^{
            [tmpImgView setFrame:finalRect];
            [self.view setBackgroundColor:BG_COLOR];
        } completion:^(BOOL finished) {
            [tmpImgView removeFromSuperview];
            self.scrollView.contentOffset=CGPointMake((self.scrollView.frame.size.width)*index, 0);
            [self scrollViewDidScroll:self.scrollView];
        }];
    }else
    {
        //背景渐变
        self.scrollView.contentOffset=CGPointMake((self.scrollView.frame.size.width)*index, 0);
        [self.view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0]];
        [UIView animateWithDuration:0.3 animations:^{
            [self.view setBackgroundColor:BG_COLOR];
        } completion:^(BOOL finished) {
            [self scrollViewDidScroll:self.scrollView];
        }];
    }
    
    

}




-(int)offsetInPage:(CGPoint)offset isCenter:(BOOL )isCenter
{
   //  CGSize screenSize=[UIScreen mainScreen].bounds.size;
    if (isCenter) {
        return 0;
    }else
    {
        return offset.x/self.scrollView.bounds.size.width;
    }
    return 0;
}
-(CGPoint )getPageOffset:(int)index   isCenter:(BOOL)isCenter
{
    CGSize screenSize=[UIScreen mainScreen].bounds.size;
    if (isCenter) {
        return CGPointMake(screenSize.width*index+(2*index+1)*ScrollPage_Edge+screenSize.width/2.0, screenSize.height/2);
    }else
    {
        return CGPointMake(screenSize.width*index+(2*index+1)*ScrollPage_Edge, 0);
    }
}
-(void)freeUnUsePhotoView
{
    for(ZXPhotoView *view in self.usePhotoViews)
    {
        CGFloat viewLeft=view.frame.origin.x;
        CGFloat viewRight=view.frame.origin.x+view.frame.size.width;
        if (viewLeft>self.scrollView.contentOffset.x+self.scrollView.frame.size.width*2||
            viewRight<self.scrollView.contentOffset.x-self.scrollView.frame.size.width) {
            view.model=nil;
            view.tag=-1;
            [view setIndex:-1];
            [view removeFromSuperview];
        }
        
    }
}

#pragma mark --
#pragma mark -- ScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  //  NSLog(@"didScrol");
    [self freeUnUsePhotoView];
    
    
    self.currentIndex=[self offsetInPage:self.scrollView.contentOffset isCenter:NO];
    
    [self showPhotoView:currentIndex-1];
    [self showPhotoView:currentIndex];
    [self showPhotoView:currentIndex+1];
    
    
    [self changeLabel:self.currentIndex :(int)self.photoModels.count];
   
    
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
   //NSLog(@"finish");
}




//- (BOOL)prefersStatusBarHidden
//{
//    // iOS7后,[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
//    // 已经不起作用了
//    return YES;
//}


#pragma mark --
#pragma mark -- photoView Delegate
-(void)didTouchClose:(ZXPhotoView *)photoView
{
    
    ZXPhotoModel *model=photoView.model;
    UIImageView *imageView=nil;
    
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    [self setNeedsStatusBarAppearanceUpdate];
    
    
    ZXPhotoShowAnimation animationType=ZXPhotoShowNormal;
    
    if (photoView.model.fromImageView) {
        imageView=[[UIImageView alloc]initWithFrame:photoView.imageView.frame];
        [[UIApplication sharedApplication].keyWindow addSubview:imageView];
        imageView.image=photoView.imageView.image;
        imageView.contentMode=UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds=YES;
        photoView.imageView.hidden=YES;
        animationType=ZXPhotoShowScale;
    }

    [UIView animateWithDuration:0.3 animations:^(){
       
        
        if (animationType==ZXPhotoShowNormal) {
            [self.view setAlpha:0.0];
        }else if (animationType==ZXPhotoShowScale)
        {
            CGRect newRect=[model.fromImageView.superview convertRect:model.fromImageView.frame toView:self.view];
            [self.view setBackgroundColor:[UIColor clearColor]];
            [imageView setFrame:newRect];
        }else if (animationType==ZXPhotoShowFlip)
        {
//            CGRect newRect=[model.fromImageView.superview convertRect:model.fromImageView.frame toView:self.view];
//            [self.view setBackgroundColor:[UIColor clearColor]];
//            [imageView setFrame:newRect];
//            imageView.layer.transform=CATransform3DMakeRotation(-M_PI, 0, 1, 0);
            
        }
        
        
    } completion:^(BOOL finish){
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
        [imageView removeFromSuperview];
    }];
}

@end
