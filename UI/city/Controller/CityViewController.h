//
//  CityViewController
//  City
//
//  Created by strj on 15/12/7.
//  Copyright © 2015年 strj. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CityViewController: UIViewController

//返回选择的地址
@property(nonatomic,copy)void (^selectCity)(NSMutableDictionary *obj);

@end

