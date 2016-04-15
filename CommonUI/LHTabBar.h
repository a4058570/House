//
//  LHTabBar.h
//  QQ空间
//
//  Created by 妖精的尾巴 on 15-9-4.
//  Copyright (c) 2015年 妖精的尾巴. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LHTabBar;

@protocol LHTabBarDelegate <UITabBarDelegate>

@optional

- (void)tabBarDidClickPlusButton:(LHTabBar *)tabBar;

@end

@interface LHTabBar : UITabBar

@property (nonatomic, weak) id<LHTabBarDelegate> delegate;

@end
