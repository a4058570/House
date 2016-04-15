//
//  ALLCellConfig.m
//  ALiuLian
//
//  Created by 张旭 on 15/5/19.
//  Copyright (c) 2015年 张旭. All rights reserved.
//

#import "ALLCellConfig.h"
#import <objc/message.h>
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

@implementation ALLCellConfig
+(ALLCellConfig *)configWithClass:(Class)cls
{
    ALLCellConfig *config= [[self class] new];
    config.cellClass=cls;
    return config;
}


+(void )registForTable:(UITableView *)table identifier:(NSString *)identifier
{
    
}
+(CGFloat)staticHeight
{
    return 0;
}
-(void)bindData:(id *)model
{
    
}


-(UITableViewCell *)dequeueCellWithTable:(UITableView *)table model:(id)model
{
    if (self.cacheCell) {
        UITableViewCell *cell=(id)self.cacheCell;
        self.cacheCell=nil;
        return cell;
    }
    
    UITableViewCell *cell=[table dequeueReusableCellWithIdentifier:self.cellClassStr];
    
    if (cell==nil) {
        
        void (*action)(id, SEL, UITableView *,NSString *) = (void (*)(id, SEL, UITableView *,NSString *)) objc_msgSend;
        action(self.cellClass, @selector(registForTable:identifier:),table,self.cellClassStr);
        cell=[table dequeueReusableCellWithIdentifier:self.cellClassStr];
        
    }
    SEL bindSel=@selector(bindData:);
    
    if ([cell respondsToSelector:bindSel]) {
        
        void (*action)(id, SEL, id) = (void (*)(id, SEL, id)) objc_msgSend;
        action(cell, @selector(bindData:),model);
        
        
//        SuppressPerformSelectorLeakWarning(
//           [cell performSelector:bindSel withObject:model];
//           );
    }
  //  ALLCODE_USE_END(@"cell config");
    return cell;
}

-(CGFloat)calculateHeightWithTable:(UITableView *)table model:(id)model
{
    if (self.cellHeight>0) {
        return self.cellHeight;
    }
    SEL bindSel=@selector(bindData:);
    SEL staticSelHeight=@selector(staticHeight);
    
    Method me= class_getClassMethod(self.cellClass, staticSelHeight);
    if (me==NULL) {
        //动态高度
        if (self.cacheCell==nil) {
            self.cacheCell=[self dequeueCellWithTable:table model:model];
        }else{
            if ([self.cacheCell respondsToSelector:bindSel]) {
                SuppressPerformSelectorLeakWarning(
                   [self.cacheCell performSelector:bindSel withObject:model];
                   );
            }
        }
        //没用autolayout
        if (self.cellHeight>0) {
            return self.cellHeight;
        }
        CGSize size = [self.cacheCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        
        self.cellHeight= size.height+2;
        
    }else
    {
        CGFloat (*action)(id, SEL) = (CGFloat (*)(id, SEL)) objc_msgSend;
        CGFloat height= action(self.cellClass, staticSelHeight);
        self.cellHeight=height;
    }
    
    return self.cellHeight;
}



-(void)setCellClass:(Class)cellClass
{
    _cellClass=cellClass;
    self.cellClassStr=NSStringFromClass(cellClass);
}

@end
