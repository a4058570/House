//
//  ZXPhotoView.m
//  PhotoBroswer
//
//  Created by zhangxu on 15/3/6.
//  Copyright (c) 2015年 zhangxu. All rights reserved.
//

#import "ZXPhotoView.h"
#import "LLARingSpinnerView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImageManager.h>
#import <SDImageCache.h>
@interface ZXPhotoView ()



@property(nonatomic,strong)LLARingSpinnerView *progressView;
@property(nonatomic)BOOL isFinishDownload;

-(void)handleSingleTap:(UITapGestureRecognizer *)tap;
-(void)handleDoubleTap:(UITapGestureRecognizer *)tap;
-(void)handleLongTag:(UILongPressGestureRecognizer *)tag;

-(void)showImageAndAdjustFrame:(UIImage *)image;



@end


@implementation ZXPhotoView



@synthesize index;
@synthesize isFinishDownload;
@synthesize photoDelegate;
-(id)init
{
    
    if ((self = [super initWithFrame:[UIScreen mainScreen].bounds])) {
        
        
        // 图片
        self.imageView=[[UIImageView alloc]init];
        [self addSubview:_imageView];
        self.imageView.center=CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
        
        // 属性
        self.backgroundColor = [UIColor clearColor];
        self.delegate = self;
        self.clipsToBounds = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.userInteractionEnabled=YES;
        self.multipleTouchEnabled=YES;
        self.maximumZoomScale=3;
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        
        
        
        // 监听点击
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        singleTap.delaysTouchesBegan = YES;
        singleTap.numberOfTapsRequired = 1;
        [self addGestureRecognizer:singleTap];
        
        //双击
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        doubleTap.numberOfTapsRequired = 2;
        [self.imageView addGestureRecognizer:doubleTap];
        
        
        //长按
        UILongPressGestureRecognizer *longTag=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleLongTag:)];
        [self.imageView addGestureRecognizer:longTag];
        [self.imageView setUserInteractionEnabled:YES];
       
    }
    return self;
}


-(void)setModel:(ZXPhotoModel *)model
{
    _model=model;
    if (model==nil) {
        [self.imageView sd_cancelCurrentImageLoad];
        self.isFinishDownload=NO;
        self.progressView.hidden=YES;
        [self.progressView stopAnimating];
        return;
    }
    
    NSString *key= [[SDWebImageManager sharedManager] cacheKeyForURL:self.model.detalUrl];
    UIImage *image= [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:key];
    if (image) {
         [self showImageAndAdjustFrame:image];
    }else
    {
        
        [self.progressView setProgress:0];
        [self.progressView startAnimating];
        self.progressView.hidden=NO;
        self.scrollEnabled = NO;
     
        __weak ZXPhotoView *photoView = self;
        __weak LLARingSpinnerView *loading = self.progressView;
        
        UIImage *thunbImage=self.model.thumbnailImage?self.model.thumbnailImage:self.model.fromImageView.image;
        if (thunbImage) {
            [self showImageAndAdjustFrame:thunbImage];
        }
        
        [self.imageView sd_setImageWithURL:self.model.detalUrl placeholderImage:thunbImage options:SDWebImageRetryFailed|SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            if (receivedSize > 0.00001) {
                [loading setProgress:((float)receivedSize/expectedSize)*100];
            }
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType,NSURL *url) {
            if (image) {
                [loading stopAnimating];
                loading.hidden=YES;
                [photoView showImageAndAdjustFrame:image];
                photoView.scrollEnabled = YES;
                photoView.isFinishDownload=true;
            }else
            {
                
                NSLog(@"download failed  %@",error);
            }
            
        }];
    }
    
}
-(void)showImageAndAdjustFrame: (UIImage *)image;
{
    CGSize imageSize=image.size;
    CGSize scrollSize=self.bounds.size;
    
    CGFloat imageViewH=scrollSize.width*(imageSize.height/imageSize.width);
    self.imageView.frame=CGRectMake(0, (scrollSize.height-imageViewH)/2, scrollSize.width, imageViewH);
    [self.imageView setImage:image];
    
    
    //重新设置scrollView contentSize
    [self setContentSize:self.imageView.bounds.size];
}


#pragma mark --
#pragma mark --  Gesture
-(void)handleSingleTap:(UITapGestureRecognizer *)tap
{
    //单机  关闭
    if (self.photoDelegate) {
        if ([self.photoDelegate respondsToSelector:@selector(didTouchClose:)]) {
            [self.photoDelegate didTouchClose:self];
        }
    }
}
-(void)handleDoubleTap:(UITapGestureRecognizer *)tap
{
    //双击 放大
    
    CGPoint touchPoint = [tap locationInView:self];
    if (self.zoomScale == self.maximumZoomScale) {
        [self setZoomScale:self.minimumZoomScale animated:YES];
    } else {
        [self zoomToRect:CGRectMake(touchPoint.x, touchPoint.y, 1, 1) animated:YES];
    }
}
-(void)handleLongTag:(UILongPressGestureRecognizer *)tag
{
    if (!isFinishDownload) {
        return;
    }
    
    if (tag.state == UIGestureRecognizerStateBegan) {
        NSLog(@"Long press Ended");
        //弹出 actionSheet
        UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                 delegate:(id)self
                                                        cancelButtonTitle:@"取消"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"保存到相册", nil];
        
        
        [choiceSheet showInView:self];
    }
    
}

-(ZXPhotoModel *)getModel
{
    return self.model;
}
-(UIImageView *)getImageView
{
    return self.imageView;
}


-(LLARingSpinnerView *)progressView
{
    if (_progressView==nil) {
        // 进度条
        _progressView = [[LLARingSpinnerView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        
        // self.progressView.tintColor = [UIColor whiteColor];
        _progressView.lineWidth=3;
        
        _progressView.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
        [_progressView setProgress:0];
        [self addSubview:_progressView];
    }
    return _progressView;
}

#pragma mark --
#pragma mark --  ScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView

{
   // UIView *vi=[scrollView viewWithTag:101];
    
    return self.imageView;
    
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView

{
    
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    
    
    
    self.imageView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                            
                            scrollView.contentSize.height * 0.5 + offsetY);
    
}





#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        UIImageWriteToSavedPhotosAlbum(self.imageView.image, nil, nil, nil);
    }

}
@end
