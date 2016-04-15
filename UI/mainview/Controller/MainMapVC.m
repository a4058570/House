//
//  MainMapVC.m
//  House
//
//  Created by wang shiwen on 15/8/28.
//  Copyright (c) 2015年 AiLiuLian. All rights reserved.
//

#import "MainMapVC.h"
#import "NSObject+ZXTool.h"
#import "CityViewController.h"
#import "HongBaoView.h"

@interface MainMapVC ()<UIGestureRecognizerDelegate,HongBaoViewDelegate> {

}
@end

@implementation MainMapVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置 内容自动移到 navagiationBar下面  20+44=64
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self addNavagationBar];//创建导航条
    //适配ios7
    //if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    //{
        //self.edgesForExtendedLayout=UIRectEdgeNone;
      //  self.navigationController.navigationBar.translucent = NO;
    //}
    //初始化定位
    _locService = [[BMKLocationService alloc]init];
    
    [self addCustomGestures];//添加自定义的手势
    
    //添加定位按钮
    [self addPosLocation];

    //添加红包显示
    [self addHongBao];
}

- (void)addNavagationBar
{
    
    UIButton *leftbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftbutton setTitle:@"搜索" forState:UIControlStateNormal];
    leftbutton.frame=CGRectMake(0, 0, 50, 35);
    [leftbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftbutton addTarget:self action:@selector(menuBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftbutton];
    
    UIButton *rightbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    [rightbutton setTitle:@"切换" forState:UIControlStateNormal];
    [rightbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    rightbutton.frame=CGRectMake(0, 0, 50, 35);
    [rightbutton addTarget:self action:@selector(searchBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightbutton];
    
    self.navigationItem.title=@"北京";
    
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];//设置导航条背景颜色
    
    self.navigationController.navigationBar.tintColor=[UIColor blackColor];//设置导航栏标题颜色为 黑色
    
    //设置字体为白色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];

    self.navigationController.navigationBar.translucent=true;
}

- (void)addPosLocation
{
    //创建 进入按钮
    UIButton *btn1=[[UIButton alloc]initWithFrame:CGRectMake(_mapView.frame.origin.x+10, _mapView.frame.origin.y+_mapView.frame.size.height-60-40, 60, 60)];
    //[btn1 setBackgroundColor:[UIColor redColor]];
    [btn1 setBackgroundImage:[UIImage imageNamed:@"locationIcon.png"] forState:UIControlStateNormal];
    btn1.tagString=@"button";
    [btn1 addTarget:self action:@selector(startLocation:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
}

- (void)addHongBao
{
    UIImage *defaultImg = [UIImage imageNamed:@"tz_2"];
    HongBaoView *view = [[HongBaoView alloc] initWithFrame:CGRectMake(20, 50,defaultImg.size.width,defaultImg.size.height)];
    view.tag = 101;
    view.defaultImage = defaultImg;
    view.delegate = self;
    [view showInView:self.view];
}

- (void)menuBtn:(UIBarButtonItem *)item
{
    
}

- (void)searchBtn:(UIBarButtonItem *)item
{
    CityViewController *cityVC = [[CityViewController alloc] init];
    
    [cityVC setSelectCity:^(NSMutableDictionary *obj) {
        
        NSString *city_name= [obj objectForKey:@"name"];
        self.navigationItem.title= city_name;
        
        NSLog(@"选择的地址为:%@",city_name);
        
    }];
    [self presentViewController: cityVC animated:YES completion:nil];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;

    [self loadLocation];//定位
    
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
}
- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
}
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


#pragma mark - BMKMapViewDelegate

- (void)mapViewDidFinishLoading:(BMKMapView *)mapView {
    /*
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"BMKMapView控件初始化完成" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
    [alert show];
    alert = nil;
     */
}

- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate {
    NSLog(@"map view: click blank");
}

- (void)mapview:(BMKMapView *)mapView onDoubleClick:(CLLocationCoordinate2D)coordinate {
    NSLog(@"map view: double click");
}

/**********************************************************
   函数名称：-(void)startLocation
   函数描述：开始定位操作按钮
   输入参数：N/A
   输出参数：N/A
   返回值：无
 **********************************************************/
-(IBAction)startLocation:(id)sender
{
    NSLog(@"进入定位态");
    [self loadLocation];
}


- (void)loadLocation{
    [_locService startUserLocationService];
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
    _mapView.zoomLevel=15;//定义比例尺级别
    
    _mapView.center = CGPointMake( 0, 0 );
    
}

# pragma mark----HongBaoDelegate
- (void)hongBaoViewDidTap:(HongBaoView *)view{
    
    NSLog(@"--->>点击");
}

#pragma mark - 添加自定义的手势（若不自定义手势，不需要下面的代码）

- (void)addCustomGestures {
    /*
     *注意：
     *添加自定义手势时，必须设置UIGestureRecognizer的属性cancelsTouchesInView 和 delaysTouchesEnded 为NO,
     *否则影响地图内部的手势处理
     */
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    doubleTap.delegate = self;
    doubleTap.numberOfTapsRequired = 2;
    doubleTap.cancelsTouchesInView = NO;
    doubleTap.delaysTouchesEnded = NO;
    
    [self.view addGestureRecognizer:doubleTap];
    
    /*
     *注意：
     *添加自定义手势时，必须设置UIGestureRecognizer的属性cancelsTouchesInView 和 delaysTouchesEnded 为NO,
     *否则影响地图内部的手势处理
     */
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    singleTap.delegate = self;
    singleTap.cancelsTouchesInView = NO;
    singleTap.delaysTouchesEnded = NO;
    [singleTap requireGestureRecognizerToFail:doubleTap];
    [self.view addGestureRecognizer:singleTap];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)theSingleTap {
    /*
     *do something
     */
    NSLog(@"my handleSingleTap");
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)theDoubleTap {
    /*
     *do something
     */
    NSLog(@"my handleDoubleTap");
}

#pragma mark - 定位消息
/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)willStartLocatingUser
{
    NSLog(@"start locate");
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    NSLog(@"heading is %@",userLocation.heading);
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [_mapView updateLocationData:userLocation];
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}



@end