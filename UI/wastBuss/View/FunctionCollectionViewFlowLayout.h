//
//  ToolBarView.h
//  BeautifulChina--test1
//
//  Created by scsys on 15/11/23.
//  Copyright (c) 2015年 王诗文. All rights reserved.
//
#import <UIKit/UIKit.h>
@class FunctionCollectionViewFlowLayout;
@protocol ZWwaterFlowDelegate <NSObject>

-(CGFloat)ZWwaterFlow:(FunctionCollectionViewFlowLayout*)waterFlow heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath*)indexPach;

@end

@interface FunctionCollectionViewFlowLayout : UICollectionViewLayout
@property(nonatomic,assign)UIEdgeInsets sectionInset;
@property(nonatomic,assign)CGFloat rowMagrin;
@property(nonatomic,assign)CGFloat colMagrin;
@property(nonatomic,assign)CGFloat colCount;
@property(nonatomic,weak)id<ZWwaterFlowDelegate>degelate;
@end
