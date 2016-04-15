//
//  ALLRecomondCell.h
//  ALiuLian
//
//  Created by 王诗文 on 15/10/19.
//  Copyright (c) 2015年 王诗文. All rights reserved.
//

#import "ALLBaseCell.h"
#import "ALLWastBussModel.h"
@interface ALLScrollAdCell : ALLBaseCell

+(CGFloat)staticHeight;
-(void)bindData:(ALLWastBussModel *)model;

@end
