//
//  ALLEmptyView.h
//  ALiuLian
//
//  Created by 张旭 on 15/6/2.
//  Copyright (c) 2015年 张旭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALLEmptyView : UIView

+(UIView *)defaultEmptyView;
+(UIView *)defaultFailedView;

-(id)initWithContent:(NSString *)content img:(UIImage *)img;
@end
