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
#import "ALLStringModel.h"
#import "ALLStringCell.h"
#import "CoreText_VC.h"

@interface ALLTestApiVC ()

@property (nonatomic,strong)NSArray *itemArray;
@property (nonatomic,strong)NSMutableArray<ALLStringModel*> *datas;

@end

@implementation ALLTestApiVC


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //设置 内容自动移到 navagiationBar下面  20+44=64
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //设置标题
    self.title=@"测试api";
    
    self.tableView.tableFooterView=[[UIView alloc]init];

    self.tableView.backgroundColor=kAppBgColor;
    
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    self.refresh=[[ALLTableRefresh alloc]initWithTableView:(id)self.tableView type:Refresh_Page];
    self.refresh.delegate=(id)self;
    
    //添加行
    [self addTableCell];
    
    WS(weakSelf);
    [self.refresh setRefreshBlock:^{
        
        
        [weakSelf.refresh finishRefreshWithArr:weakSelf.datas page:nil];
    }];
    
    [self.refresh begainRefresh];
    
   
}


#pragma mark - Member Function

- (void)addTableCell
{
    self.itemArray = @[@"GCD_VC",
                       @"CoreText_VC",
                       @"CoreImage_VC"];
    
    self.datas = [NSMutableArray array];
    for (int i=0; i<self.itemArray.count; i++) {
        ALLStringModel *model= [[ALLStringModel alloc]init];
        model.content=[self.itemArray objectAtIndex:i];
        model.cellConfig = [ALLCellConfig configWithClass:[ALLStringCell class]];
        [self.datas addObject:model];
    }
    
}

-(void)pushVC:(UIViewController *)vc
{
    vc.hidesBottomBarWhenPushed=YES;
    
    [self.navigationController pushViewController:vc animated:YES];

}

#pragma mark Test Function

- (NSString *)getTestString:(NSString *)normalStr
{
    return [NSString stringWithFormat:@"[%@]",normalStr];
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
    
    //根据类名跳转到 viewcontroller
    ALLStringModel *model=[self.refresh.datas objectAtIndex:indexPath.row];
    
    Class c = NSClassFromString(model.content);
    
    UIViewController *controller = [[c alloc] initWithNibName:model.content bundle:nil];

    [self pushVC:controller];
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
