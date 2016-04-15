//
//  ALLCountButton.h
//  DiZhuBang
//
//  Created by 张旭 on 15/12/16.
//  Copyright © 2015年 张旭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALLCountButton : UIButton




@property(nonatomic,strong)NSString *contentPattern;
@property(nonatomic)CGFloat countInterval;
@property(nonatomic)int countNumber;

@property(nonatomic)BOOL timeCount;

-(void)startCount;
-(void)stopCount;

-(void)finishBlock:(void(^)(void))finish;



@end
