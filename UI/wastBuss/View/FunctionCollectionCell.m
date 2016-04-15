//
//  FourCollectionCell.m
//  DouYU
//
//  Created by admin on 15/11/1.
//  Copyright © 2015年 Alesary. All rights reserved.
//

#import "FunctionCollectionCell.h"
#import "UIImageView+WebCache.h"

@interface FunctionCollectionCell ()

@property (strong, nonatomic) IBOutlet UIImageView *fun_Image;

@property (strong, nonatomic) IBOutlet UILabel  *fun_Title;

@end

@implementation FunctionCollectionCell


-(void)bindData:(NSString *)btnName
{
    self.fun_Title.text = btnName;
}

@end
