//
//  ALLStoreShopListVC.m
//  ALiuLian
//
//  Created by wangshiwen on 15/7/3.
//  Copyright (c) 2015年 王诗文. All rights reserved.
//

#import "WastBussVC.h"
#import "MacroDefine.h"
#import <MJRefresh.h>
#import "AppConfig.h"
#import "UIViewController+Empty.h"
#import "ALLGlobalFunction.h"
#import "KYCuteView.h"


//table刷新
#import "ALLTableRefresh.h"

//模型
#import "ALLWastBussModel.h"

#import "ALLScrollAdCell.h"
#import "ALLBtnCell.h"
#import "ALLExpandCell.h"
#import "ALLTitleCell.h"
#import "ALLNewsCell.h"
#import "ALLMoreCell.h"
#import "ALLPersonCell.h"
#import "ALLMenuCell.h"
#import "ALLCompanyCell.h"

#import "JHCustomMenu.h"

@interface WastBussVC () <JHCustomMenuDelegate>

@property(nonatomic)BOOL staticData;
@property(nonatomic,strong)ALLTableRefresh *refresh;

@property(nonatomic,strong)NSMutableArray *resultArr;

@property(nonatomic,strong)UITableView *tableView;

@property (nonatomic, strong) JHCustomMenu *menu;

@end

@implementation WastBussVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置 内容自动移到 navagiationBar下面  20+44=64
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self addNavagationBar];

    self.tableView.backgroundColor=[UIColor whiteColor];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,kWindowWidth,kWindowHeight-64-50) style:UITableViewStylePlain];
    
    self.tableView.delegate =self;
    
    self.tableView.dataSource=self;
    
    //去掉下划线
    self.tableView.separatorStyle = NO;
    
    [self.view addSubview:_tableView];
    
    WS(weakSelf);
    
    self.refresh=[[ALLTableRefresh alloc]initWithTableView:(id)self.tableView type:Refresh_Page];
    self.refresh.delegate=(id)self;
    
    //添加主页的行
    [self addTableCell];
    
    self.refresh.datas=_resultArr;
    
    [self.refresh setRefreshBlock:^{
        [weakSelf.tableView reloadData];
        /*
         [ALLBrandLogic getOrderDinnerListWithId:weakSelf.currentModel.entityId page:nil result:^(BOOL success,NSMutableArray *comments,ALLPageModel *page) {
         
         if (comments.count>0) {
         
         
         [weakSelf.refresh finishRefreshWithArr:comments page:page];
         
         for (ALL_BaseModel *model in weakSelf.refresh.datas) {
         ALLCellConfig *config=[ALLCellConfig new];
         config.cellClass=[ALLOrderHistoryCellTableViewCell class];
         model.cellConfig=config;
         }
         
         }else
         {
         [weakSelf.refresh finishRefreshWithArr:comments page:page];
         }
         
         } failed:^(int errorCode, NSString *errDes) {
         [weakSelf.refresh finishRefreshWithArr:nil page:nil];
         }];*/
        [weakSelf.refresh finishRefreshWithArr:nil page:nil];
    }];
    
    [self.refresh setLoadMoreBlock:^(ALLPageModel *page, id lastModel) {
        [weakSelf.tableView reloadData];
        /*
         [ALLBrandLogic getOrderDinnerListWithId:weakSelf.currentModel.entityId page:page result:^(BOOL success,NSMutableArray *comments,ALLPageModel *page) {
         
         
         [weakSelf.refresh finishLoadMoreWithArr:comments page:page];
         
         for (ALL_BaseModel *model in weakSelf.refresh.datas) {
         ALLCellConfig *config=[ALLCellConfig new];
         config.cellClass=[ALLOrderHistoryCellTableViewCell class];
         model.cellConfig=config;
         }
         
         } failed:^(int errorCode, NSString *errDes) {
         [weakSelf.refresh finishLoadMoreWithArr:nil page:nil];
         }];*/
        [weakSelf.refresh finishLoadMoreWithArr:nil page:nil];
    }];
    
    [self.refresh begainRefresh];
    
    // self.tableView.separatorStyle=NO;
    
    //添加更新角标
    [self addKYCuteView];
    
    //注册通知服务
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(jumpToPage:)
                                                 name:@"jumpToPage"
                                               object:nil];
}

#pragma mark - Member Function

//响应通知中心NSNotificationCenter
- (void)jumpToPage:(NSNotification *)notification{
    if([notification object] != nil)
    {
        NSLog(@"调用了 跳转页面的通知");
        
        NSMutableDictionary *div= [notification object];
        
        if([[div objectForKey:@"order"] isEqualToString:@"jump"]){
            if([[div objectForKey:@"jumpto"] isEqualToString:@"foodsearch"]){
                //FoodSearchVC *foodsearch= [[FoodSearchVC alloc] init];
                //LookHouseVC *look= [[LookHouseVC alloc] init];
                //UINavigationController *navigation= [[UINavigationController alloc] initWithRootViewController:look];
                
                //[self.navigationController pushViewController:navigation animated:YES];
            }
        }
    }
}

- (void)addNavagationBar
{
    
    UIButton *leftbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftbutton setImage: [UIImage imageNamed:@"Image_scan"] forState:UIControlStateNormal];
    leftbutton.frame=CGRectMake(0, 0, 25, 25);
    [leftbutton addTarget:self action:@selector(menuBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftbutton];
    
    UIButton *rightbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    [rightbutton setImage: [UIImage imageNamed:@"btn_search"] forState:UIControlStateNormal];
    rightbutton.frame=CGRectMake(0, 0, 25, 25);
    [rightbutton addTarget:self action:@selector(searchBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightbutton];

    //UIImageView *titleView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 104, 28)];
    //titleView.image=[UIImage imageNamed:@"logo"];
    //self.navigationItem.titleView=titleView;
    self.navigationItem.title=@"详细介绍";

    self.navigationController.navigationBar.barTintColor=[UIColor redColor];//设置导航条背景颜色
    
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];//设置导航栏标题颜色为 白色
    
    //[[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
}

- (void)addKYCuteView
{
    
    KYCuteView *cuteView = [[KYCuteView alloc]initWithPoint:CGPointMake(10, 100) superView:self.view];
    cuteView.viscosity  = 20;
    cuteView.bubbleWidth = 35;
    cuteView.bubbleColor = [UIColor colorWithRed:0 green:0.722 blue:1 alpha:1];
    [cuteView setUp];
    [cuteView addGesture];
    
    //注意：设置 'bubbleLabel.text' 一定要放在 '-setUp' 方法之后
    //Tips:When you set the 'bubbleLabel.text',you must set it after '-setUp'
    cuteView.bubbleLabel.text = @"13";

}

- (void)menuBtn:(UIBarButtonItem *)item
{
    NSLog(@"点击了扫一扫按钮");
    
    WS(weakSelf);
    
    if (!self.menu) {
        self.menu = [[JHCustomMenu alloc] initWithDataArr:@[@"附近学校", @"联赛流程", @"其他联赛", @"校内群聊", @"邀请好友"] origin:CGPointMake(0,0) width:125 rowHeight:44 direction:Direct_Right];
        _menu.delegate = self;
        _menu.dismiss = ^() {
            weakSelf.menu = nil;
        };
        _menu.arrImgName = @[@"item_school.png", @"item_battle.png", @"item_list.png", @"item_chat.png", @"item_share.png"];
        [self.view addSubview:_menu];
    } else {
        [_menu dismissWithCompletion:^(JHCustomMenu *object) {
            weakSelf.menu = nil;
        }];
    }
    
}

- (void)searchBtn:(UIBarButtonItem *)item
{
    WS(weakSelf);
    
    if (!self.menu) {
        self.menu = [[JHCustomMenu alloc] initWithDataArr:@[@"附近学校", @"联赛流程", @"其他联赛", @"校内群聊", @"邀请好友"] origin:CGPointMake(kWindowWidth,0) width:125 rowHeight:44 direction:Direct_Left];
        _menu.delegate = self;
        _menu.dismiss = ^() {
            weakSelf.menu = nil;
        };
        _menu.arrImgName = @[@"item_school.png", @"item_battle.png", @"item_list.png", @"item_chat.png", @"item_share.png"];
        [self.view addSubview:_menu];
    } else {
        [_menu dismissWithCompletion:^(JHCustomMenu *object) {
            weakSelf.menu = nil;
        }];
    }
}

- (void)jhCustomMenu:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"select: %ld", indexPath.row);
}

-( void)addTableCell
{
    //模拟数据
    _resultArr=[NSMutableArray array];
    
    //头部行
    NSMutableArray *titleCell=[NSMutableArray array];
    for (int i=0;i<2;i++) {
        if(i==0){//广告页面
            ALLWastBussModel *orderlist=[[ALLWastBussModel alloc]init];
            ALLCellConfig *config=[ALLCellConfig new];
            config.cellClass=[ALLScrollAdCell class];
            orderlist.cellConfig=config;
            [titleCell addObject:orderlist];
        }else if(i==1){//功能按钮页面
            ALLWastBussModel *orderlist=[[ALLWastBussModel alloc]init];
            ALLCellConfig *config=[ALLCellConfig new];
            config.cellClass=[ALLBtnCell class];
            orderlist.cellConfig=config;
            [titleCell addObject:orderlist];
        }
    }
    [_resultArr addObject:titleCell];
    
    //推广行
    NSMutableArray *expandCell=[NSMutableArray array];
    for (int i=0;i<5;i++) {
    
            ALLWastBussModel *orderlist=[[ALLWastBussModel alloc]init];
            ALLCellConfig *config=[ALLCellConfig new];
            config.cellClass=[ALLExpandCell class];
            orderlist.cellConfig=config;
            [expandCell addObject:orderlist];
        
    }
    [_resultArr addObject:expandCell];
    
    //新闻行
    NSMutableArray *newsCell=[NSMutableArray array];
    
    ALLWastBussModel *orderlist=[[ALLWastBussModel alloc]init];
    ALLCellConfig *config=[ALLCellConfig new];
    config.cellClass=[ALLTitleCell class];
    orderlist.cellConfig=config;
    [newsCell addObject:orderlist];
    
    for (int i=0;i<4;i++) {
        ALLWastBussModel *orderlist=[[ALLWastBussModel alloc]init];
        ALLCellConfig *config=[ALLCellConfig new];
        config.cellClass=[ALLNewsCell class];
        orderlist.cellConfig=config;
        [newsCell addObject:orderlist];
    }
    
    ALLWastBussModel *model1=[[ALLWastBussModel alloc]init];
    ALLCellConfig *config1=[ALLCellConfig new];
    config1.cellClass=[ALLMoreCell class];
    model1.cellConfig=config1;
    [newsCell addObject:model1];
    
    [_resultArr addObject:newsCell];
    
    //发现高手
    NSMutableArray *playerCell=[NSMutableArray array];
    
    ALLWastBussModel *titleModel=[[ALLWastBussModel alloc]init];
    ALLCellConfig *titleconfig=[ALLCellConfig new];
    titleconfig.cellClass=[ALLTitleCell class];
    titleModel.cellConfig=titleconfig;
    [playerCell addObject:titleModel];
    
    for (int i=0;i<4;i++) {
        ALLWastBussModel *orderlist=[[ALLWastBussModel alloc]init];
        ALLCellConfig *config=[ALLCellConfig new];
        config.cellClass=[ALLPersonCell class];
        orderlist.cellConfig=config;
        [playerCell addObject:orderlist];
    }
    
    ALLWastBussModel *expandModel=[[ALLWastBussModel alloc]init];
    ALLCellConfig *expandConfig=[ALLCellConfig new];
    expandConfig.cellClass=[ALLExpandCell class];
    expandModel.cellConfig=expandConfig;
    [playerCell addObject:expandModel];
    
    for (int i=0;i<4;i++) {
        ALLWastBussModel *orderlist=[[ALLWastBussModel alloc]init];
        ALLCellConfig *config=[ALLCellConfig new];
        config.cellClass=[ALLMenuCell class];
        orderlist.cellConfig=config;
        [playerCell addObject:orderlist];
    }
    
    ALLWastBussModel *companyModel=[[ALLWastBussModel alloc]init];
    ALLCellConfig *companyConfig=[ALLCellConfig new];
    companyConfig.cellClass=[ALLCompanyCell class];
    companyModel.cellConfig=companyConfig;
    [playerCell addObject:companyModel];
    
    
    [_resultArr addObject:playerCell];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
     return self.refresh.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    NSArray *setion=[self.refresh.datas objectAtIndex:section];

    return setion.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSInteger section=indexPath.section;
    NSInteger row=indexPath.row;
    ALL_BaseModel *model= [[self.refresh.datas objectAtIndex:section]objectAtIndex:row];
    UITableViewCell *cell= [model.cellConfig dequeueCellWithTable:tableView model:model];
    
    if ([ALLScrollAdCell class] ==model.cellConfig.cellClass) {
        ALLScrollAdCell *scrollCell=(id)cell;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section=indexPath.section;
    NSInteger row=indexPath.row;
    ALL_BaseModel *model= [[self.refresh.datas objectAtIndex:section] objectAtIndex:row];

    return  [model.cellConfig calculateHeightWithTable:tableView model:model];

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section

{
    if (section==0){
        return 0;
    }else{
        return 10;
    }
    
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - System Function

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
