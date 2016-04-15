//
//  ALLADImageView.h
//  ALiuLian
//
//  Created by 张旭 on 15/7/15.
//  Copyright (c) 2015年 张旭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALLADImageView : UIImageView


-(id)initWithUrl:(NSURL *)url;
-(void)loadAndShowInView:(UIView *)view;
@end
