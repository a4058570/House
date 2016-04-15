//
//  ALLSearchVC.m
//  House
//
//  Created by wang shiwen on 16/3/3.
//  Copyright © 2016年 AiLiuLian. All rights reserved.
//

#import "ALLSearchResultVC.h"
#import "AppConfig.h"
#import "ALLEmptyView.h"
#import "ALLSearchHeadView.h"

@interface ALLSearchResultVC ()

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)ALLSearchHeadView *searchBar;

@property (nonatomic,strong)NSString *searchText;

@end

@implementation ALLSearchResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor= [UIColor colorWithRed:245/255.0 green:246/255.0 blue:246/255.0 alpha:1.0];
    
    self.tableView= [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kWindowWidth, kWindowHeight-64)];
    self.tableView.tableFooterView= [[UIView alloc]init];
    self.tableView.backgroundColor=kAppBgColor;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
  
    [self.view addSubview:self.tableView];
    
    //添加搜索栏
    [self addSearchHeadView];
    
    
    self.refresh=[[ALLTableRefresh alloc]initWithTableView:(id)self.tableView type:Refresh_Page];
    self.refresh.delegate=(id)self;
    
    [self.refresh setRefreshBlock:^{
        
    }];
    [self.refresh begainRefresh];
    
}

#pragma mark Member Function

-(id)initWithSearchText:(NSString *) searchtext
{
    self = [super init];
    if (self) {
        self.searchText=searchtext;
    }
    return self;
}

- (void)addSearchHeadView
{
    self.searchBar = [[ALLSearchHeadView alloc] initWithFrame:CGRectMake(0,20, self.view.frame.size.width, 44)];
    self.searchBar.delegate=self;
    [self.view addSubview:self.searchBar];
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
