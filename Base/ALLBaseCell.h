//
//  ALLBaseCell.h
//  ALiuLian
//
//  Created by 张旭 on 15/5/30.
//  Copyright (c) 2015年 张旭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALLBaseCell : UITableViewCell


@property(nonatomic,weak)UITableView *tableView;

+(void )registForTable:(UITableView *)table identifier:(NSString *)identifier;
+(id)createFromNib;
@end
