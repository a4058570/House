//
//  ALLCompanyCell.m
//  House
//
//  Created by wang shiwen on 15/12/2.
//  Copyright © 2015年 AiLiuLian. All rights reserved.
//

#import "ALLCompanyCell.h"

@implementation ALLCompanyCell

+(CGFloat)staticHeight
{
    return  70;
}

- (void)awakeFromNib {
    // Initialization code
    
    self.separatorInset = UIEdgeInsetsMake(0,0,0,0);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
