//
//  ALLAddressListVC.h
//  ALiuLian
//
//  Created by 王诗文 on 15/11/10.
//  Copyright (c) 2015年 王诗文. All rights reserved.
//

#import <UIKit/UIKit.h>
//table刷新
#import "ALLTableRefresh.h"

@interface ALLTestApiVC : UITableViewController

@property(nonatomic,strong)ALLTableRefresh *refresh;

- (NSString *)getTestString:(NSString *)normalStr;

@end
