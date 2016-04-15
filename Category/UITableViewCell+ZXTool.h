//
//  UITableViewCell+ZXTool.h
//  ALiuLian
//
//  Created by 张旭 on 15/5/12.
//  Copyright (c) 2015年 张旭. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    ZXCell_Top=0,
    ZXCell_Bottom=1
}ZXCellDir;

@interface UITableViewCell (ZXTool)


-(void)addlineTo:(ZXCellDir)dir;
-(void)addlineTo:(ZXCellDir)dir color:(UIColor *)color height:(CGFloat)height;

-(void)addVeticalLineTo:(CGFloat)x;
@end
