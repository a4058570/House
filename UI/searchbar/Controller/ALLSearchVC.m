//
//  ALLSearchVC.m
//  House
//
//  Created by wang shiwen on 16/3/3.
//  Copyright © 2016年 AiLiuLian. All rights reserved.
//

#import "ALLSearchVC.h"
#import "AppConfig.h"
#import "ALLEmptyView.h"
#import "ALLSearchBarView.h"
#import "ALLTagView.h"
#import "ALLSearchResultVC.h"

@interface ALLSearchVC ()

@property (nonatomic,strong)UISearchBar *searchBar;

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)ALLTagView *tagView;

@end

@implementation ALLSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor= [UIColor colorWithRed:245/255.0 green:246/255.0 blue:246/255.0 alpha:1.0];
    
    self.tableView= [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kWindowWidth, kWindowHeight-64)];
    self.tableView.tableFooterView= [[UIView alloc]init];
    self.tableView.backgroundColor=kAppBgColor;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
  
    [self.view addSubview:self.tableView];
    //添加搜索栏
    [self addSearchBar];
    
    //添加标签页
    [self addTagView];


    //self.refresh=[[ALLTableRefresh alloc]initWithTableView:(id)self.tableView type:Refresh_Page];
    //self.refresh.delegate=(id)self;
    
    //[self.refresh setRefreshBlock:^{
        
    //}];
    //[self.refresh begainRefresh];
    
    if (1) {
        self.tableView.tableHeaderView=self.tagView;
        [self.tableView reloadData];
    }else{
        
    }
}

#pragma mark Member Function

- (void)addSearchBar
{
    ALLSearchBarView *searchBar = [[ALLSearchBarView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    searchBar.delegate=self;
    [self.view addSubview:searchBar];
}

- (void)addTagView
{
    self.tagView= [[ALLTagView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kWindowHeight-64)];
    self.tagView.delegate= self;
}

#pragma mark - ALLSearchBarViewDelegate

- (void)searchTextCallBack:(NSString *) searchtext
{
    ALLSearchResultVC *resultVC=[[ALLSearchResultVC alloc] initWithSearchText:searchtext];
    resultVC.delegate=self;
    [self.view addSubview:resultVC.view];
}

- (void)cancleBtnCallBacl
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - ALLTagViewDelegate

- (void)tagPressCallBack:(NSString *) text
{
    ALLSearchResultVC *resultVC=[[ALLSearchResultVC alloc] initWithSearchText:text];
    resultVC.delegate=self;
    
    [self.view addSubview:resultVC.view];
}
#pragma  mark - ALLSearchResultVCDelegate

- (void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - ALLTableRefreshDelegate

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
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ALL_BaseModel *model=[self.refresh.datas objectAtIndex:indexPath.row];
    
    UITableViewCell *cell =(id)[model.cellConfig dequeueCellWithTable:tableView model:model];
    
    //[cell setAddressTableVC:self];
    
    //[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
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
    if (section==0){
        return 40;
    }else{
        return 0;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark System Function

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
