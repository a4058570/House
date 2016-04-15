//
//  ALLLineLabel.h
//  ALiuLian
//
//  Created by 张旭 on 15/5/23.
//  Copyright (c) 2015年 张旭. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    ALLLineLabel_Horizental=0,
    ALLLineLabel_Slant,
    ALLLineLabel_None
}ALLLineLabelType;


@interface ALLLineLabel : UILabel

@property(nonatomic,strong)UIColor *lineColor;
@property(nonatomic)ALLLineLabelType type;
@end
