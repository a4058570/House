//
//  ALLTableRefresh.h
//  ALiuLian
//
//  Created by 张旭 on 15/7/2.
//  Copyright (c) 2015年 张旭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ALLPageModel.h"
typedef enum
{
    Refresh_Page=0,
    Refresh_LastId,
}RefreshType;



@class ALLTableRefresh;

@protocol ALLTableRefreshDelegate <NSObject>

-(CGPoint)positionForInfoViewInRefresh:(ALLTableRefresh *)refresh;
-(UIView *)emptyViewInRefresh:(ALLTableRefresh *)refresh;
-(UIView *)failedViewInRefresh:(ALLTableRefresh *)refresh;

@end


@interface ALLTableRefresh : NSObject


@property(nonatomic,copy)void (^refreshBlock)();
@property(nonatomic,copy)void (^loadMoreBlock)(ALLPageModel *page,id lastModel);
@property(nonatomic)BOOL dragLoadMore;
@property(nonatomic,weak)id<ALLTableRefreshDelegate>delegate;
@property(nonatomic)BOOL groupEnable;
@property(nonatomic)BOOL enabelLoadMore;
@property(nonatomic)CGFloat ignoreScrollInsertTop;
@property(nonatomic,strong)NSMutableArray *datas;
@property(nonatomic,weak)UITableView *table;

//无网络 或者无数据的view
@property(nonatomic,strong)UIView *infoView;


-(id)initWithTableView:(UITableView *)tableView
                  type:(RefreshType)type;

-(void)showFailed;
-(void)showEmpty;
-(void)begainRefresh;
-(void)endRefresh;
-(void)finishRefreshWithArr:(NSMutableArray *)arr
                       page:(ALLPageModel *)page;

-(void)finishLoadMoreWithArr:(NSMutableArray *)arr
                        page:(ALLPageModel *)page;
@end
