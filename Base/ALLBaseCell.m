//
//  ALLBaseCell.m
//  ALiuLian
//
//  Created by 张旭 on 15/5/30.
//  Copyright (c) 2015年 张旭. All rights reserved.
//

#import "ALLBaseCell.h"

@implementation ALLBaseCell


+(void )registForTable:(UITableView *)table identifier:(NSString *)identifier
{
    
    NSString *classStr=NSStringFromClass([self class]);
    UINib *nib2=[UINib nibWithNibName:classStr bundle:nil];
    NSString *nibPath= [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@~iphone",classStr] ofType:@"nib"];
    BOOL have= [[NSFileManager defaultManager] fileExistsAtPath:nibPath];
    if (!have) {
        nibPath= [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",classStr] ofType:@"nib"];
        have= [[NSFileManager defaultManager] fileExistsAtPath:nibPath];
    }
    if (have) {
        [table registerNib:nib2 forCellReuseIdentifier:identifier];
    }else
    {
        [table registerClass:[self class] forCellReuseIdentifier:identifier];
    }
    
}
+(id)createFromNib
{
    NSString *classStr=NSStringFromClass([self class]);
    UINib *nib2=[UINib nibWithNibName:classStr bundle:nil];
    NSString *nibPath= [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@~iphone",classStr] ofType:@"nib"];
    BOOL have= [[NSFileManager defaultManager] fileExistsAtPath:nibPath];
    if (!have) {
        nibPath= [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",classStr] ofType:@"nib"];
        have= [[NSFileManager defaultManager] fileExistsAtPath:nibPath];
    }
    if (have) {
        return  [[nib2 instantiateWithOwner:self options:nil] firstObject];
    }else
    {
        return nil;
    }
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
