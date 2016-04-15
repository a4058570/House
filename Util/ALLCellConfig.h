//
//  ALLCellConfig.h
//  ALiuLian
//
//  Created by 张旭 on 15/5/19.
//  Copyright (c) 2015年 张旭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface ALLCellConfig : NSObject

@property(nonatomic)BOOL isSelect;  //是否被选中
@property(nonatomic,strong)NSString *cellClassStr;
@property(nonatomic,strong)Class cellClass;
@property(nonatomic)float cellHeight;

@property(nonatomic,strong)NSString *configTag;

@property(nonatomic,strong)UITableViewCell *cacheCell;

+(ALLCellConfig *)configWithClass:(Class)cls;

-(UITableViewCell *)dequeueCellWithTable:(UITableView *)table model:(id)model;

-(CGFloat)calculateHeightWithTable:(UITableView *)table model:(id)model;

@end
