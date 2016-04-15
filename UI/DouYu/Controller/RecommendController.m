//
//  RecommendController.m
//  DouYU
//
//  Created by Alesary on 15/10/29.
//  Copyright © 2015年 Alesary. All rights reserved.
//

//http://www.douyutv.com/api/v1/room/299113?aid=ios&auth=e63c643bdb9b88f9d30b867c3982a309&client_sys=ios&time=1447041300
#import "RecommendController.h"
#import "URL.h"
#import "MJExtension.h"
#import "SDCycleScrollView.h"
#import "RecommendTableCell.h"
#import "RecommendHeadView.h"
#import "NewShowViewCell.h"
#import "MoreViewController.h"
#import "NSString+Times.h"
#import "NetworkSingleton.h"
#import "TOPdata.h"
#import "NewShowData.h"
#import "ChanelData.h"
#import "PlayerController.h"
#import "SDRotationLoopProgressView.h"
#import "PlayerController.h"

#define TABBAR_H self.tabBarController.tabBar.frame.size.height


@interface RecommendController () <SDCycleScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,RecommendTableCellDelegate>
{
    UITableView *_tableView;
    
    SDCycleScrollView *_headView;//头部的滚动菜单
    
    SDRotationLoopProgressView *_LoadView;//加载loading页面
    
    RecommendHeadView *_CellHeadView;//栏目标题的页面
    
    MoreViewController *_moreVC;//点击更多按钮的 显示更多页面
    
    NSMutableArray *_topDataArray;//头部 滚动菜单的数据
    NSMutableArray *_imageArray;//图片数据
    NSMutableArray *_titleArray;//标题数据
    
    NSMutableArray *_NewDataArray;
    
    NSMutableArray *_ChanelDataArray;//频道数据数组
    NSMutableArray *_ChanelDatas;//频道数据
    
}

@end

@implementation RecommendController



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsCompact];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    //设置 内容自动移到 navagiationBar下面  20+44=64
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
   
    [self loadChanelData];//加载频道数据
    
    [self loadTopData];
    [self loadNewShowData];
    
    [self initHeadView];
    [self initTableView];
    
    _topDataArray=[NSMutableArray array];
    _imageArray=[NSMutableArray array];
    _titleArray=[NSMutableArray array];
    _NewDataArray=[NSMutableArray array];
    
    _ChanelDataArray=[NSMutableArray array];
    _ChanelDatas=[NSMutableArray array];

    

};

//加载
-(void)loadNewShowData
{
    NSString *url=[NSString stringWithFormat:@"%@%@",NEW_URl,[NSString GetNowTimes]];
    [[NetworkSingleton sharedManager] getResultWithParameter:nil url:url successBlock:^(id responseBody) {
        
    _NewDataArray=[NewShowData objectArrayWithKeyValuesArray:[responseBody objectForKey:@"data"]];
        
    NSIndexPath *index=[NSIndexPath indexPathForRow:0 inSection:0];//刷新
        
    //更新某一行内容
    [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:index,nil] withRowAnimation:UITableViewRowAnimationNone];
        
    } failureBlock:^(NSString *error) {
        
    }];
}

//加载频道数据
-(void)loadChanelData
{
    [self showLoadView];//显示加载框
    
    NSString *url=[NSString stringWithFormat:@"%@%@",CHANEL_URl,[NSString GetNowTimes]];
    
    [[NetworkSingleton sharedManager] getResultWithParameter:nil url:url successBlock:^(id responseBody) {
        
        _ChanelDatas=[responseBody objectForKey:@"data"];
        
        for (NSDictionary *dic in _ChanelDatas) {
            
            NSMutableArray *array=[NSMutableArray array];
            [array addObject:[dic objectForKey:@"title"]];
            [array addObject:[dic objectForKey:@"cate_id"]];
            
            [array addObject:[ChanelData objectArrayWithKeyValuesArray:[dic objectForKey:@"roomlist"]]];
            [_ChanelDataArray addObject:array];
        }
        [self hidenLoadView];
        [self.view addSubview:_tableView];
        
    } failureBlock:^(NSString *error) {
        
    }];

}

-(void)loadTopData
{

    NSDictionary *parameteiDic=@{@"aid":@"ios",@"auth":@"97d9e4d3e9dfab80321d11df5777a107",@"client_sys":@"ios",@"time":[NSString GetNowTimes]};
    
    [[NetworkSingleton sharedManager] getResultWithParameter:parameteiDic url:TOP_URl successBlock:^(id responseBody) {
        
        _topDataArray=[TOPdata objectArrayWithKeyValuesArray:[responseBody objectForKey:@"data"]];
        
        
        for (TOPdata *topdata in _topDataArray) {
            
            [_imageArray addObject:topdata.pic_url];
            
            [_titleArray addObject:topdata.title];
        }
        
        _headView.imageURLStringsGroup=_imageArray;
        _headView.titlesGroup=_titleArray;
        
    } failureBlock:^(NSString *error) {
        
    }];

}
-(void)initTableView
{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height-64-TABBAR_H) style:UITableViewStyleGrouped];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.tableHeaderView=_headView;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;

    
}
-(void)initHeadView
{
    
    _headView=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, screen_width, 200*KWidth_Scale) imagesGroup:_imageArray];
    _headView.titlesGroup=_titleArray;
    _headView.placeholderImage=[UIImage imageNamed:@"Img_default"];
    _headView.delegate=self;
    _headView.pageControlStyle=SDCycleScrollViewPageContolStyleClassic;
    _headView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    _headView.titleLabelTextFont=[UIFont systemFontOfSize:17];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_ChanelDataArray.count) {//获取频道的数量
        
        return _ChanelDataArray.count;
    }else{
    
        return 1;
    }
    return 0;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        
        return 145;//头部的 滚动图片的高度
    }else{
    
        return 280*KWidth_Scale;
    }
    
    return 0;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld,%ld",indexPath.section,indexPath.row);
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (indexPath.section==0) {//获取第一个section
        
        static NSString *identfire=@"NewShowViewCell";
        
        NewShowViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identfire];
        
        if (!cell) {
            
            cell=[[NewShowViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identfire];
        }
        
        [cell setContentView:_NewDataArray];
        
        return cell;
    }else{
        
        static NSString *identfire=@"RecommendTableCell";
        
        RecommendTableCell *cell=[tableView dequeueReusableCellWithIdentifier:identfire];
        
        if (!cell) {
            
            cell=[[RecommendTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identfire];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        NSArray *array=_ChanelDataArray[indexPath.section-1];
        
        cell.modelArray=array[2];
        cell.delegate=self;
        cell.tags=(int)indexPath.section-1;

        return cell;
    }
    
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //创建每一个section的头名称
    _CellHeadView=[[RecommendHeadView alloc]init];
    _CellHeadView.tag=section;
    
    if (section==0) {
        //_CellHeadView.Title.text=@"推荐视频";
        _CellHeadView.more.hidden=YES;
        _CellHeadView.moreimage.hidden=YES;
    }else{
        //设置标题内容
        NSArray *array=_ChanelDataArray[section-1];
        _CellHeadView.Title.text=[array firstObject];
        
        //添加标题触摸事件
        UITapGestureRecognizer *tapHeadView=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHeadView:)];
        tapHeadView.delegate=self;
        [_CellHeadView addGestureRecognizer:tapHeadView];
    }
    
    return _CellHeadView;
}

//点击更多按钮后的触发
-(void)tapHeadView:(UIGestureRecognizer*)sender
{
    
    NSArray *array=_ChanelDataArray[sender.view.tag-1];


    _moreVC=[[MoreViewController alloc]init];
    _moreVC.title=array[0];
    _moreVC.Cate_id=array[1];
    
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:_moreVC animated:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isMemberOfClass:[UIButton class]]) {
        
        return YES;
    }
    
    return YES;
}

//点击了头部滚动视图后 push到视频播放页面
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
    TOPdata *topdata=_topDataArray[index];
    
    PlayerController *playVC=[[PlayerController alloc]init];
    
    NSLog(@"%@",[topdata.room objectForKey:@"hls_url"]);
    
    playVC.Hls_url=[topdata.room objectForKey:@"hls_url"];
    
    [self setHidesBottomBarWhenPushed:YES];
    [self presentViewController:playVC animated:YES completion:nil];

    
}

#pragma mark loadView
-(void)hidenLoadView
{
    [UIView animateWithDuration:0.3 animations:^{
        
        [_LoadView removeFromSuperview];

    }];
}

-(void)showLoadView
{
    _LoadView=[SDRotationLoopProgressView progressView];
    
    _LoadView.frame=CGRectMake(0, 0, 100*KWidth_Scale, 100*KWidth_Scale);
    
    _LoadView.center=self.view.center;
    
    [self.view addSubview: _LoadView ];
    
}

//点击栏目视频后触发
-(void)TapRecommendTableCellDelegate:(ChanelData *)chaneldata
{
    PlayerController *playVC=[[PlayerController alloc]init];
    
    NSLog(@"%@",chaneldata.room_name);
    
    [self setHidesBottomBarWhenPushed:YES];
    
    [self presentViewController:playVC animated:YES completion:nil];
    

}
@end
