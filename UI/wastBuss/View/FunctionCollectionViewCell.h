//
//  FunctionCollectionViewCell.h
//  House
//
//  Created by wang shiwen on 15/11/27.
//  Copyright © 2015年 AiLiuLian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FunctionCollectionModel.h"

@interface FunctionCollectionViewCell : UICollectionViewCell

-(void)bindData:(FunctionCollectionModel *) funModel;

@end
