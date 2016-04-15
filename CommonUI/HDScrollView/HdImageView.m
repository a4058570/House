//
//  UIImage+ZXTool.m
//  LiuLianServer
//
//  Created by 张旭 on 15/4/18.
//  Copyright (c) 2015年 张旭. All rights reserved.
//

#import "HdImageView.h"

@implementation HdImageView
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:self.backgroundColor forKey:@"backgroundColor"];
    [aCoder encodeObject:self.image forKey:@"image"];
    [aCoder encodeInt:self.contentMode forKey:@"contentMode"];
    [aCoder encodeInt:self.subviews.count forKey:@"subviewscount"];
    for(int i=0;i<self.subviews.count;i++)
    {
        UIView *view=self.subviews[i];
        [aCoder encodeObject:view forKey:[NSString stringWithFormat:@"view%d",i]];
    }
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super init]) {
        self.backgroundColor=[aDecoder decodeObjectForKey:@"backgroundColor"];
        self.image=[aDecoder decodeObjectForKey:@"image"];
        self.contentMode=[aDecoder decodeIntForKey:@"contentMode"];
        int subviewscount=[aDecoder decodeIntForKey:@"subviewscount"];
        for(int i=0;i<subviewscount;i++)
        {
            UIView* view=[aDecoder decodeObjectForKey:[NSString stringWithFormat:@"view%d",i]];
            [self addSubview:view];
        }
    }
    return self;
}
@end