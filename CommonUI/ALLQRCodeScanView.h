//
//  ALLQRCodeScanView.h
//  ALiuLian
//
//  Created by 张旭 on 15/5/12.
//  Copyright (c) 2015年 张旭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALLQRCodeScanView : UIView
@property(nonatomic,readonly)CGRect scanRect;

-(void)finishBlock:(void(^)(NSString *resultStr))finish;

-(void)startScan;
-(void)stopScan;
@end
