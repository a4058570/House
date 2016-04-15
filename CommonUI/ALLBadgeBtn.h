//
//  ALLBadgeBtn.h
//  ALiuLian
//
//  Created by 张旭 on 15/5/30.
//  Copyright (c) 2015年 张旭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALLBadgeBtn : UIButton

@property(nonatomic)int badgeNumber;
@property(nonatomic)CGFloat badgeRadus;
@property(nonatomic,strong)UIColor *badgeColor;
@property(nonatomic)CGFloat xOffsetFromRight;


@property(nonatomic)BOOL point;
@end
