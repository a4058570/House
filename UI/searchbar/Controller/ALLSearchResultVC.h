//
//  ALLSearchVC.h
//  House
//
//  Created by wang shiwen on 16/3/3.
//  Copyright © 2016年 AiLiuLian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALLTableRefresh.h"

@protocol ALLSearchResultVCDelegate <NSObject>

- (void)popViewController;

@end

@interface ALLSearchResultVC : UIViewController

@property(nonatomic,assign)id <ALLSearchResultVCDelegate> delegate;

@property(nonatomic,strong)ALLTableRefresh *refresh;

-(id)initWithSearchText:(NSString *) searchtext;

@end
