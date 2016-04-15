//
//  ZXVideoView.h
//  ViewTest
//
//  Created by zhangxu on 15/3/10.
//  Copyright (c) 2015年 zhangxu. All rights reserved.
//



#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@class ZXVideoView;

@protocol ZXVideoDelegate <NSObject>

@optional
-(void)videoDidPlay:(ZXVideoView *)videVide;
-(void)videoProgress:(CGFloat )cur total:(CGFloat)total;
-(void)videoLoadTime:(CGFloat )time total:(CGFloat)total;

@end



@interface ZXVideoView : UIView



-(void)setVideoWithUrl:(NSURL *)url withProgressBlock:(void (^)(CGFloat current,CGFloat total))progress;


-(void)setVideoWithUrlAssert:(AVURLAsset *)assert withProgressBlock:(void (^)(CGFloat current,CGFloat total))progress;
-(UIImage *)thumbnailImage:(CGFloat )timeBySecond;

-(void)play;
-(void)pause;
-(void)stop;
-(void)playAt:(CGFloat)time;


-(void)setVolumn:(CGFloat)val;
-(void)changeVoid:(NSURL *)url;

@property(nonatomic)CGFloat totalSecond;
@property(nonatomic)CGFloat currentSecond;
@property(nonatomic)BOOL autoPlay;

@property(nonatomic,assign)id <ZXVideoDelegate>   delegate;

@end
