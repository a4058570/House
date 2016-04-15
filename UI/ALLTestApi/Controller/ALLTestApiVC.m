//
//  ALLAddressListVC.m
//  ALiuLian
//
//  Created by wangshiwen on 15/11/10.
//  Copyright (c) 2015年 王诗文. All rights reserved.
//

#import "ALLTestApiVC.h"
#import "MacroDefine.h"
#import <MJRefresh.h>
#import "AppConfig.h"
#import "UIViewController+Empty.h"
#import "ALLEmptyView.h"
#import "ALLBaseCell.h"

@interface ALLTestApiVC ()
@property (nonatomic,strong)NSArray *itemArray;
@end

@implementation ALLTestApiVC


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //设置标题
    self.title=NSLocalizedString(@"addresslist", nil);
    
    self.tableView.tableFooterView=[[UIView alloc]init];

    self.tableView.backgroundColor=kAppBgColor;
    
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    

    
    
    self.refresh=[[ALLTableRefresh alloc]initWithTableView:(id)self.tableView type:Refresh_Page];
    self.refresh.delegate=(id)self;
    
    [self.refresh setRefreshBlock:^{
        
             
         //[weakSelf.refresh finishRefreshWithArr:comments page:nil];
        
    }];
    
    [self.refresh begainRefresh];
    
   
}


#pragma mark - Member Function

-(void)pushVC:(UIViewController *)vc
{
    vc.hidesBottomBarWhenPushed=YES;
    
    [self.navigationController pushViewController:vc animated:YES];

}

#pragma mark --  ALLTableRefreshDelegate

-(UIView *)emptyViewInRefresh:(ALLTableRefresh *)refresh
{
    return [ALLEmptyView defaultEmptyView];
}
-(UIView *)failedViewInRefresh:(ALLTableRefresh *)refresh
{
    
    return [ALLEmptyView defaultFailedView];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    
    return self.refresh.datas.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    ALL_BaseModel *model=[self.refresh.datas objectAtIndex:indexPath.row];
    
    ALLBaseCell *cell =(id)[model.cellConfig dequeueCellWithTable:tableView model:model];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ALL_BaseModel *model=[self.refresh.datas objectAtIndex:indexPath.row];
    CGFloat h= [model.cellConfig calculateHeightWithTable:tableView model:model];
    return h;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

#pragma mark - System Function

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
