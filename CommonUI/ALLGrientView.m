//
//  ALLGrientView.m
//  ALiuLian
//
//  Created by 张旭 on 15/5/25.
//  Copyright (c) 2015年 张旭. All rights reserved.
//

#import "ALLGrientView.h"

@implementation ALLGrientView


-(id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    if (self) {
       // NSLog(@"asdad");
    }
    return self;
}

+(Class)layerClass
{
    return [CAGradientLayer class];
    
    

}

-(void)setColors:(NSArray *)colors
{
    CAGradientLayer *grenLayer=(id)self.layer;
    grenLayer.colors=colors;
    _colors=colors;
    
}
-(void)setLocations:(NSArray *)locations
{
    CAGradientLayer *grenLayer=(id)self.layer;
    grenLayer.locations=locations;
    _locations=locations;
}
-(void)setStartPoint:(CGPoint)startPoint
{
    _startPoint=startPoint;
    CAGradientLayer *grenLayer=(id)self.layer;
    grenLayer.startPoint=startPoint;
}
-(void)setEndPoint:(CGPoint)endPoint
{
    _endPoint=endPoint;
    CAGradientLayer *grenLayer=(id)self.layer;
    grenLayer.endPoint=endPoint;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
