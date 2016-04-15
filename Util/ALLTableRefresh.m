//
//  ALLTableRefresh.m
//  ALiuLian
//
//  Created by 张旭 on 15/7/2.
//  Copyright (c) 2015年 张旭. All rights reserved.
//

#import "ALLTableRefresh.h"
#import <UIKit/UIKit.h>
#import "ALLPageModel.h"
#import <MJRefresh.h>
#import "MacroDefine.h"
#import "ALLEmptyView.h"
#import <objc/runtime.h>
#import "UIView+Empty.h"

@interface ALLTableRefresh()
@property(nonatomic)RefreshType currentType;
@property(nonatomic)BOOL enabelRefresh;
@property(nonatomic,strong)ALLPageModel *currentPage;


-(void)addMoreView;



-(void)removeInfoView;
@end


@implementation ALLTableRefresh

-(id)initWithTableView:(UITableView *)tableView
                  type:(RefreshType)type
{
    self=[super init];
    if (self) {
        self.table=tableView;
        self.currentType=type;
    }
    return self;
}

-(void)setRefreshBlock:(void (^)())refreshBlock
{
    _refreshBlock=refreshBlock;
    self.enabelRefresh=YES;
    WS(weakSelf);
    
    
    //if (self.table.mj_header==nil) {
    self.table.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (weakSelf.refreshBlock) {
            weakSelf.refreshBlock();
            
        }
    }];
    self.table.mj_header.ignoredScrollViewContentInsetTop=self.ignoreScrollInsertTop;
    [self.table bringSubviewToFront:self.table.mj_header];
    //}
}
-(void)setIgnoreScrollInsertTop:(CGFloat)ignoreScrollInsertTop
{
    _ignoreScrollInsertTop=ignoreScrollInsertTop;
    if (self.table.mj_header) {
        self.table.mj_header.ignoredScrollViewContentInsetTop=_ignoreScrollInsertTop;
        [self.table.mj_header placeSubviews];
    }
}
-(void)setLoadMoreBlock:(void (^)(ALLPageModel *, id))loadMoreBlock
{
    _loadMoreBlock=loadMoreBlock;
    self.enabelLoadMore=YES;
    
}
-(void)finishRefreshWithArr:(NSMutableArray *)arr
                       page:(ALLPageModel *)page
{
    if (page) {
        if (page.totalPage>1&&self.enabelLoadMore) {
            [self addMoreView];
        }else
        {
            self.table.mj_footer=nil;
        }
        self.currentPage=page;
    }
    if (arr==nil) {
        //网络失败
        if (self.datas==nil||self.datas.count==0) {
            //网络失败
            [self showFailed];
            
        }
    }else
    {
        [self removeInfoView];
        if (arr.count==0) {
            [self showEmpty];
        }
        self.datas=arr;
    }
    if (arr) {
         [self.table reloadData];
    }
   
    [self.table.mj_header endRefreshing];
}

-(void)finishLoadMoreWithArr:(NSMutableArray *)arr
                        page:(ALLPageModel *)page
{
    if (arr) {
        
        if (self.groupEnable) {
            [[self.datas lastObject] addObjectsFromArray:arr];
        }else
        {
            [self.datas addObjectsFromArray:arr];
        }
    }
    if (page) {
        self.currentPage=page;
        if (page.currentPage==page.totalPage) {
            //已经是最后一页了
            WS(weakSelf);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                weakSelf.table.mj_footer=nil;
            });
           // [self.table removeFooter];
        }
    }
    [self.table reloadData];
    [self.table.mj_footer endRefreshing];
}
-(void)begainRefresh
{
    [self.table.mj_header beginRefreshing];
}
-(void)endRefresh
{
    [self.table.mj_header endRefreshing];
}
-(void)setEnabelRefresh:(BOOL)enabelRefresh
{
    _enabelRefresh=enabelRefresh;
    
    if (enabelRefresh) {
      
    }else
    {
        self.table.mj_header=nil;
    }
}
-(void)setEnabelLoadMore:(BOOL)enabelLoadMore
{
    _enabelLoadMore=enabelLoadMore;
    
    if (enabelLoadMore) {
    }else
    {
        self.table.mj_header=nil;
    }
}
-(void)addMoreView
{
    WS(weakSelf);
    
    if (self.dragLoadMore) {
        self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            if (weakSelf.loadMoreBlock) {
                ALLPageModel *page=[ALLPageModel new];
                page.currentPage=weakSelf.currentPage.currentPage+1;
                weakSelf.loadMoreBlock(page,[weakSelf.datas lastObject]);
                
            }
        }];
    }else
    {
        self.table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            if (weakSelf.loadMoreBlock) {
                ALLPageModel *page=[ALLPageModel new];
                page.currentPage=weakSelf.currentPage.currentPage+1;
                weakSelf.loadMoreBlock(page,[weakSelf.datas lastObject]);
                
            }
        }];
    }
    
}



-(void)showFailed
{
    [self removeInfoView];
    
    if ([self.delegate respondsToSelector:@selector(failedViewInRefresh:)]) {
        UIView *failedView=[self.delegate failedViewInRefresh:self];
        CGPoint pos;
        if ([self.delegate respondsToSelector:@selector(positionForInfoViewInRefresh:)]) {
            pos=[self.delegate positionForInfoViewInRefresh:self];
        }else
        {
            pos=CGPointMake([UIScreen mainScreen].bounds.size.width/2.0, [UIScreen mainScreen].bounds.size.height/2.0);
        }
        failedView.center=pos;
        [self.table addSubview:failedView];
        self.infoView=failedView;
    }else
    {
        [self.table showFailed:@"网络加载失败"];
    }
}
-(void)showEmpty
{
    [self removeInfoView];
    
    
    if ([self.delegate respondsToSelector:@selector(emptyViewInRefresh:)]) {
        UIView *emptyView=[self.delegate emptyViewInRefresh:self];
        CGPoint pos;
        if ([self.delegate respondsToSelector:@selector(positionForInfoViewInRefresh:)]) {
            pos=[self.delegate positionForInfoViewInRefresh:self];
        }else
        {
            pos=CGPointMake([UIScreen mainScreen].bounds.size.width/2.0, [UIScreen mainScreen].bounds.size.height/2.0);
        }
        emptyView.center=pos;
        [self.table addSubview:emptyView];
        self.infoView=emptyView;
        
    }else
    {
          [self.table showEmpty:@"暂时没有数据"];
    }
}

-(void)removeInfoView
{
    
    if (self.infoView) {
        [self.infoView removeFromSuperview];
        self.infoView=nil;
    }
    [self.table removeEmpty];
}
//static char empty;
//
//-(void)showEmpty:(NSString *)content
//{
//    
//    ALLEmptyView * emptyView= objc_getAssociatedObject(self, &empty) ;
//    if (!emptyView) {
//        NSString *str=@"暂时没有数据哦!";
//        if (content) {
//            str=content;
//        }
//        ALLEmptyView *em= [[ALLEmptyView alloc]initWithContent:str img:nil];
//        [self.table addSubview:em];
//        em.center=CGPointMake([UIScreen mainScreen].bounds.size.width/2, 250);
//        
//        
//        objc_setAssociatedObject(self, &empty, em, OBJC_ASSOCIATION_RETAIN);
//    }
//}
//
//-(void)removeEmpty
//{
//    ALLEmptyView * emptyView= objc_getAssociatedObject(self, &empty) ;
//    if (emptyView) {
//        [emptyView removeFromSuperview];
//        objc_setAssociatedObject(self, &empty, nil, OBJC_ASSOCIATION_RETAIN);
//    }
//}

@end
