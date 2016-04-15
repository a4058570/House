//
//  AppDelegate.h
//  House
//
//  Created by wang shiwen on 15/8/24.
//  Copyright (c) 2015年 AiLiuLian. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BMapKit.h"

@interface AppDelegate :NSObject <UIApplicationDelegate, BMKGeneralDelegate> {

UIWindow *window;

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

