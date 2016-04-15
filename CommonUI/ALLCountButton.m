//
//  ALLCountButton.m
//  DiZhuBang
//
//  Created by 张旭 on 15/12/16.
//  Copyright © 2015年 张旭. All rights reserved.
//

#import "ALLCountButton.h"
@interface ALLCountButton()
{
    int currentCountNumber;
}
@property(nonatomic)NSTimer *countTimer;
@property(nonatomic,copy) void (^finishBlock)(void);


-(void)count:(NSTimer *)timer;



@end

@implementation ALLCountButton

-(void)startCount
{
    [self stopCount];
    
    
    
    self.countTimer=[NSTimer scheduledTimerWithTimeInterval:self.countInterval target:self selector:@selector(count:) userInfo:nil repeats:YES];
    [self.countTimer fire];
    
    self.enabled=NO;
    
}
-(void)stopCount
{
    if (self.countTimer) {
        [self.countTimer invalidate];
        self.countTimer=nil;
    }
    self.enabled=YES;
}
-(void)count:(NSTimer *)timer
{
    currentCountNumber--;
    
    if (self.contentPattern&&self.countInterval>0) {
        NSString *str;
        if (self.timeCount) {
            str=[NSString stringWithFormat:@"%.2d:%.2d",currentCountNumber/60,currentCountNumber%60];
        }else
        {
            str=[NSString stringWithFormat:self.contentPattern,currentCountNumber];
        }
        [self setTitle:str forState:UIControlStateDisabled];
    }else
    {
        NSLog(@"count argument invalid");
    }
    if (currentCountNumber<=0) {
        [self stopCount];
        if (self.finishBlock) {
            self.finishBlock();
        }
        currentCountNumber=self.countNumber;
    }
}
-(void)finishBlock:(void(^)(void))finish
{
    self.finishBlock=finish;
}
-(void)setCountNumber:(int)countNumber
{
    _countNumber=countNumber;
    currentCountNumber=countNumber;
}


@end
