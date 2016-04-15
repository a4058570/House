//
//  ZXVideoView.m
//  ViewTest
//
//  Created by zhangxu on 15/3/10.
//  Copyright (c) 2015年 zhangxu. All rights reserved.
//

#import "ZXVideoView.h"
#import <AVFoundation/AVFoundation.h>

@interface ZXVideoView ()


@property(nonatomic,strong)NSURL *currentVideoUrl;
@property(nonatomic,strong)AVPlayer *currentPlayer;
@property(nonatomic,assign)id timeObserver;
@property(nonatomic)BOOL isReadyToPlay;

@property(nonatomic)BOOL isPlaying;


-(void)exportVideo;
-(BOOL)isLocalFileExist;
-(NSString *)getLocalFileNameWithUrl:(NSURL *)url;
@end


@implementation ZXVideoView
@synthesize currentVideoUrl;
@synthesize currentPlayer;
@synthesize totalSecond;
@synthesize currentSecond;
@synthesize timeObserver;
@synthesize delegate;
@synthesize isReadyToPlay;
+(Class)layerClass
{
    return [AVPlayerLayer class];
}


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
    }
    return self;
}


-(void)setVideoWithUrl:(NSURL *)url withProgressBlock:(void (^)(CGFloat current,CGFloat total))progress
{
    self.currentVideoUrl=url;
    
    NSURL *targetUrl=url;
    //首先根据 本地视频路径 创建 AVPlayerItem 包含了多媒体信息
//    if ([self isLocalFileExist]) {
//        targetUrl=[NSURL URLWithString:[self getLocalFileNameWithUrl:url]];
//    }
    
    AVURLAsset *urlAssert=[AVURLAsset assetWithURL:targetUrl];
    [self setVideoWithUrlAssert:urlAssert withProgressBlock:progress];
}



-(void)setVideoWithUrlAssert:(AVURLAsset *)assert withProgressBlock:(void (^)(CGFloat current,CGFloat total))progress
{
    self.currentVideoUrl=assert.URL;
    
    
    AVPlayerItem *playerItem=[AVPlayerItem playerItemWithAsset:assert];
    
    //根据 AVPlayerItem 创建 AVPlayer
    
    if (self.currentPlayer==nil) {
        self.currentPlayer=[AVPlayer playerWithPlayerItem:playerItem];
        
        AVPlayerLayer *playerLayer=(AVPlayerLayer *)self.layer;
        playerLayer.player=self.currentPlayer;
        playerLayer.videoGravity=AVLayerVideoGravityResizeAspect;//视频填充模式
        self.currentPlayer.actionAtItemEnd=AVPlayerActionAtItemEndNone;
    }else
    {
        [[self.currentPlayer currentItem] removeObserver:self forKeyPath:@"status"];
        [[self.currentPlayer currentItem] removeObserver:self forKeyPath:@"loadedTimeRanges"];
        [self.currentPlayer removeObserver:self forKeyPath:@"rate"];
        [self.currentPlayer replaceCurrentItemWithPlayerItem:playerItem];
    }
    
    [self.currentPlayer removeTimeObserver:self.timeObserver];
    
    
    
    //    void *LSPlayer=&LSPlayer;
    [self.currentPlayer addObserver:self forKeyPath:@"rate" options:NSKeyValueObservingOptionNew context:nil];
    
    [[self.currentPlayer currentItem] addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
    [[self.currentPlayer currentItem] addObserver:self forKeyPath:@"loadedTimeRanges"options:NSKeyValueObservingOptionNew context:nil];
    
    
    
    
    self.totalSecond=-1;
    self.currentSecond=0;
    
    //这里设置每秒执行一次
    
    __weak ZXVideoView *weakSelf=self;
    self.timeObserver=[self.currentPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        float total=CMTimeGetSeconds([playerItem duration]);
        float current=CMTimeGetSeconds(time);
        
        if ([weakSelf.delegate respondsToSelector:@selector(videoProgress:total:)]) {
            [weakSelf.delegate videoProgress:current total:total ];
        }
        
        if (progress) {
            progress(current,total);
            
        }
        weakSelf.currentSecond=current;
        if (current>=total) {
            //播放完成
            [[weakSelf.currentPlayer currentItem] seekToTime:kCMTimeZero];
        }
    }];
}

-(UIImage *)thumbnailImage:(CGFloat )timeBySecond
{
    if (self.currentVideoUrl==nil) {
        NSLog(@"[ZXVideoView]:没有设置url  ");
        return nil;
    }
    
    
    //根据url创建AVURLAsset
    AVURLAsset *urlAsset=[AVURLAsset assetWithURL:self.currentVideoUrl];
    //根据AVURLAsset创建AVAssetImageGenerator
    AVAssetImageGenerator *imageGenerator=[AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
    /*截图
     * requestTime:缩略图创建时间
     * actualTime:缩略图实际生成的时间
     */
    NSError *error=nil;
    CMTime time=CMTimeMakeWithSeconds(timeBySecond, 10);//CMTime是表示电影时间信息的结构体，第一个参数表示是视频第几秒，第二个参数表示每秒帧数.(如果要活的某一秒的第几帧可以使用CMTimeMake方法)
    CMTime actualTime;
    CGImageRef cgImage= [imageGenerator copyCGImageAtTime:time actualTime:&actualTime error:&error];
    if(error){
        NSLog(@"截取视频缩略图时发生错误，错误信息：%@",error.localizedDescription);
        return nil;
    }
    CMTimeShow(actualTime);
    UIImage *image=[UIImage imageWithCGImage:cgImage];//转化为UIImage
    CGImageRelease(cgImage);
    
    return image;
}
-(void)play
{
    if (self.currentPlayer) {
        self.isPlaying=YES;
        [self.currentPlayer play];
        
    }
}
-(void)pause
{

    if (self.currentPlayer) {
        self.isPlaying=NO;
        [self.currentPlayer pause];
    }
}
-(void)stop
{
    if (self.currentPlayer) {
        [self.currentPlayer pause];
        self.isPlaying=NO;
         [[self.currentPlayer currentItem] seekToTime:kCMTimeZero];
    }
}
-(void)playAt:(CGFloat)time
{
    if (self.currentPlayer) {
        [self.currentPlayer pause];
        
//        CMTimeMake(<#int64_t value#>, <#int32_t timescale#>)
//         [[self.currentPlayer currentItem] seekToTime:kCMTimeZero];
    }
}

-(void)setVolumn:(CGFloat)val
{
    
    NSArray *audioTracks = [self.currentPlayer.currentItem.asset tracksWithMediaType:AVMediaTypeAudio];
    
    NSMutableArray *allAudioParams = [NSMutableArray array];
    for (AVAssetTrack *track in audioTracks) {
        AVMutableAudioMixInputParameters *audioInputParams =
        [AVMutableAudioMixInputParameters audioMixInputParameters];
        [audioInputParams setVolume:val atTime:kCMTimeZero];
        [audioInputParams setTrackID:[track trackID]];
        [allAudioParams addObject:audioInputParams];
    }
    
    AVMutableAudioMix *audioMix = [AVMutableAudioMix audioMix];
    [audioMix setInputParameters:allAudioParams];
    
    [self.currentPlayer.currentItem setAudioMix:audioMix];
}

-(void)changeVoid:(NSURL *)url
{
    AVURLAsset *audioAsset=[AVURLAsset assetWithURL:url];
    NSArray *audioTracks = [audioAsset tracksWithMediaType:AVMediaTypeAudio];
    
    
    NSMutableArray *allAudioParams = [NSMutableArray array];
    for (AVAssetTrack *track in audioTracks) {
        AVMutableAudioMixInputParameters *audioInputParams =
        [AVMutableAudioMixInputParameters audioMixInputParameters];
        
        [audioInputParams setTrackID:[track trackID]];
        [allAudioParams addObject:audioInputParams];
    }
    
    AVMutableAudioMix *audioMix = [AVMutableAudioMix audioMix];
    [audioMix setInputParameters:allAudioParams];
    
    [self.currentPlayer.currentItem setAudioMix:audioMix];
}
-(void)exportVideo
{
    if (![self isLocalFileExist]) {
        
        
        
        AVAsset *asset = self.currentPlayer.currentItem.asset;
        AVAssetExportSession * exporter =
        [AVAssetExportSession exportSessionWithAsset:asset presetName:AVAssetExportPresetPassthrough];
        NSLog (@"created exporter. supportedFileTypes: %@", exporter.supportedFileTypes);
        //        AVFileTypeQuickTimeMovie
        exporter.outputFileType = AVFileTypeMPEG4;
        exporter.timeRange = [self.currentPlayer.currentItem.loadedTimeRanges.firstObject CMTimeRangeValue];
        
        
        NSURL *url2 = [NSURL fileURLWithPath:[self getLocalFileNameWithUrl:self.currentVideoUrl]];
        [exporter setOutputURL:url2];
        
        NSLog(@"temp file %@",url2);
        [exporter exportAsynchronouslyWithCompletionHandler:^{
            NSLog(@".....complete./..:%@\n\n\n  localizedDescription:%@\n\n  es.status:%ld", exporter.error,[[exporter error] localizedDescription],(long)exporter.status);
        }];

    }
}

-(BOOL)isLocalFileExist
{
    NSString *localPath=[self getLocalFileNameWithUrl:self.currentVideoUrl];
    
    return  [[NSFileManager defaultManager] fileExistsAtPath:localPath];
    
}
-(NSString *)getLocalFileNameWithUrl:(NSURL *)url
{
    //Document/video/
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",[[url absoluteString] lastPathComponent]]];
    
    return path;
    
    
}


- (NSTimeInterval)availableDuration
{
    NSArray *loadedTimeRanges = [[self.currentPlayer currentItem] loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result = startSeconds + durationSeconds;
    return result;
}




- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    AVPlayerItem *playerItem = (AVPlayerItem *)object;
    if ([keyPath isEqualToString:@"rate"])
    {
        NSLog(@"rate change  %f",self.currentPlayer.rate);
        if (self.currentPlayer.rate==1) {
            if ([self.delegate respondsToSelector:@selector(videoDidPlay:)]&&[self isReadyToPlay]) {
                [self.delegate videoDidPlay:self];
            }
        }
    }
    
    if ([keyPath isEqualToString:@"status"])
    {
        
        if ([playerItem status] == AVPlayerStatusReadyToPlay)
        {
            
            //numberOfDroppedVideoFrames
            CMTime duration = self.currentPlayer.currentItem.duration;
            
            float _totalTime=CMTimeGetSeconds(duration);
          
            self.totalSecond=_totalTime;
            NSLog(@"isReadytoPlay  %f   ",_totalTime );
            self.isReadyToPlay=YES;
            if (self.autoPlay) {
                [self play];
            }
            
            
            
            
        } else if ([playerItem status] == AVPlayerStatusFailed)
        {
            NSLog(@"is play failed");
        }
        
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"])
    {
        
        NSTimeInterval timeInterval = [self availableDuration];
        if ([self.delegate respondsToSelector:@selector(videoLoadTime:total:)]&&self.totalSecond!=-1) {
            
            [self.delegate videoLoadTime :timeInterval total:self.totalSecond];
        }
        
        int rate =[[NSString stringWithFormat:@"%f",self.currentPlayer.rate] intValue];
        
        if (rate==0)
        {
            
            float ti =[[NSString stringWithFormat:@"%f",timeInterval] floatValue];
            if (ti >CMTimeGetSeconds(self.currentPlayer.currentTime)+2) {
                if (self.isPlaying) {
                    [self  play];
                }
            }
        }
    }
}





-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    if (self.currentPlayer) {
       [self.currentPlayer removeTimeObserver:self.timeObserver];
        [self.currentPlayer removeObserver:self forKeyPath:@"rate"];
        [[self.currentPlayer currentItem] removeObserver:self forKeyPath:@"status"];
        [[self.currentPlayer currentItem] removeObserver:self forKeyPath:@"loadedTimeRanges"];
        
        [self.currentPlayer replaceCurrentItemWithPlayerItem:nil];
        self.currentPlayer=nil;
    }
}
@end
