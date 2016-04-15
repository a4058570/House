//
//  ALLAddressListCell.m
//  ALiuLian
//
//  Created by 王诗文 on 15/5/30.
//  Copyright (c) 2015年 王诗文. All rights reserved.
//

#import "ALLStringCell.h"
#import <UIImageView+WebCache.h>
#import "AppConfig.h"
#import "MacroDefine.h"
#import "ALLStringModel.h"

@interface ALLStringCell()

@property(nonatomic,strong)IBOutlet UILabel* titleLabel;

@end
@implementation ALLStringCell


-(void)awakeFromNib
{
    [super awakeFromNib];
    
}

-(void)bindData:(ALLStringModel *)model
{
    self.titleLabel.text = model.content;
}


@end
