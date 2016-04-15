//
//  ALLScrollAdCell.m
//  ALiuLian
//
//  Created by 王诗文 on 15/11/6.
//  Copyright (c) 2015年 王诗文. All rights reserved.
//

#import "ALLBtnCell.h"
#import <UIImageView+WebCache.h>
#import "AppConfig.h"
#import "MacroDefine.h"

#import "FunctionCollectionView.h"

@interface ALLBtnCell()

@property(nonatomic,strong)HDScrollview *scrollview;//餐桌控件

@property(nonatomic,strong)NSMutableArray *tablePageArray;//餐桌列表空间

@property (strong, nonatomic) IBOutlet UICollectionView *myConllection;// collectionView

@property(nonatomic)float collectionWidth;

@end

@implementation ALLBtnCell

+(CGFloat)staticHeight
{
    return  200;
}
-(void)awakeFromNib
{
    [super awakeFromNib];
    
    _tablePageArray=[[NSMutableArray alloc] init];
    
    _collectionWidth=0;
}

-(void)bindData:(ALLWastBussModel *)model
{
   
    //添加菜单
    [self addScrollView];
}

#pragma mark Memmber Function

-(void)addScrollView
{
    
    //移除餐桌元素
    [_tablePageArray removeAllObjects];
    
    //获取桌子高度
    float tableheight=[ALLBtnCell staticHeight];
    
    //设置桌子大小
    CGRect bound=CGRectMake(0, 0, kWindowWidth, tableheight-2);
    
    //计算页数
    int page=1;
    
    //每页容量
    int pagecount=8;
    
    int tableCount=50;
    if (tableCount<=0){
        page=1;
    }if (tableCount%pagecount==0){
        page=tableCount/pagecount;
    }else{
        page=tableCount/pagecount+1;
    }
    
    //创建每页的内容
    for (int i=1; i<=page; i++) {
        FunctionCollectionView *collectView = [[FunctionCollectionView alloc] initWithFrame:CGRectMake(0, 0, kWindowWidth, 180)];
        
        [collectView addCollectionView];
        
        collectView.backgroundColor=[UIColor whiteColor];
        
        [_tablePageArray addObject:collectView];
    }

    //创建滑动面板
    _scrollview=[[HDScrollview alloc]initWithFrame:bound withImageView:_tablePageArray];
    //_scrollview.backgroundColor=[UIColor whiteColor];
    _scrollview.delegate=self;
    _scrollview.HDdelegate=self;
    [self addSubview:_scrollview];
    _scrollview.pagecontrol.frame=CGRectMake((kWindowWidth-_scrollview.pagecontrol.frame.size.width)/2, _scrollview.pagecontrol.frame.origin.y+_scrollview.frame.size.height-10, _scrollview.pagecontrol.frame.size.width, _scrollview.pagecontrol.frame.size.height);
    _scrollview.pagecontrol.currentcolor=[UIColor blackColor];
    _scrollview.pagecontrol.othercolor=[UIColor lightGrayColor];
    _scrollview.pagecontrol.currentPage=0;
    
    [self addSubview:_scrollview.pagecontrol];
    
}

#pragma mark ==========UIScrollViewDelegate============

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    [_scrollview HDscrollViewDidScroll];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView
{
    [_scrollview HDscrollViewDidEndDecelerating];
}
-(void)TapView:(int)index
{
    NSLog(@"点击了第%d个页面",index);
    //下面可以根据自己的需求操作
    //Example
    //    if (_tablePageArray.count>1) {
    //        //删除一个
    //        [_tablePageArray removeObjectAtIndex:index];
    //        //_scrollview=[_scrollview initWithFrame:_scrollview.frame withImageView:imageArray];
    //
    //        _scrollview=[_scrollview initLoopScrollWithFrame:_scrollview.frame withImageView:_tablePageArray];
    //        _scrollview.pagecontrol.currentPage=index;
    //        
    //    }
    
}


@end
