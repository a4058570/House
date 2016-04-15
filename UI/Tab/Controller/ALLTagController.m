//
//  ALLTagController.m
//  ALiuLian
//
//  Created by 张旭 on 15/6/29.
//  Copyright (c) 2015年 张旭. All rights reserved.
//

#import "ALLTagController.h"
#import "ALLGlobalData.h"
#import "LHTabBar.h"
#import "CerterViewController.h"
#import "UIImage+Extesion.h"

//地图视图
#import "MainMapVC.h"

//金融视图
#import "BussVC.h"

//测试api
#import "ALLTestApiVC.h"

//东方财付通视图
#import "WastBussVC.h"

//斗鱼视图
#import "BaseNaviController.h"

//搜索页面视图
#import "ALLSearchVC.h"

@interface ALLTagController () <LHTabBarDelegate>

@end

@implementation ALLTagController


#pragma mark --
#pragma mark -Life cycle

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    
    //百度地图
    MainMapVC *mappage=[[MainMapVC alloc]init];
    BaseNaviController *mapPageNavC = [[BaseNaviController alloc] initWithRootViewController:mappage];
    
    //东方财付通主页
    WastBussVC *wastbuss=[[WastBussVC alloc]init];
    BaseNaviController *wastbuss_nav = [[BaseNaviController alloc] initWithRootViewController:wastbuss];
    
    
    BussVC *buss=[[BussVC alloc]init];
    
    
    ALLTestApiVC *testApiVC= [[ALLTestApiVC alloc] init];
    
    //搜索页面
    ALLSearchVC *search= [[ALLSearchVC alloc] init];
    
    //斗鱼主页
   
    //BaseNaviController *RecommendNavC = [[BaseNaviController alloc] initWithRootViewController:account];
    
    // 1.初始化子控制器
    
    [self addChildVc:mapPageNavC title:@"地图" image:@"tabbar_icon_auth" selectedImage:@"tabbar_icon_auth_click"];
    
    [self addChildVc:wastbuss_nav title:@"东方" image:@"tabbar_icon_at" selectedImage:@"tabbar_icon_at_click"];
    
    //[self addChildVc:RecommendNavC title:@"斗鱼" image:@"tabbar_icon_space" selectedImage:@"tabbar_icon_space_click"];
    
    [self addChildVc:buss title:@"玩吧" image:@"tabbar_icon_more" selectedImage:@"tabbar_icon_more_click@2x"];
    
    [self addChildVc:testApiVC title:@"测试" image:@"tabbar_icon_more" selectedImage:@"tabbar_icon_more_click@2x"];
    
    LHTabBar *tabBar = [[LHTabBar alloc] init];
    tabBar.delegate = self;
    [self setValue:tabBar forKeyPath:@"tabBar"];
}


- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置子控制器的文字
    childVc.title = title; // 同时设置tabbar和navigationBar的文字
    //    childVc.tabBarItem.title = title; // 设置tabbar的文字
    //    childVc.navigationItem.title = title; // 设置navigationBar的文字
    
    // 设置子控制器的图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //    // 设置文字的样式
    //    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    //    textAttrs[NSForegroundColorAttributeName] = HWColor(123, 123, 123);
    //    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    //    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    //    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    //    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    //    childVc.view.backgroundColor = HWRandomColor;
    
    // 先给外面传进来的小控制器 包装 一个导航控制器
    //UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVc];
    // 添加为子控制器
    [self addChildViewController:childVc];
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if (self.selectedIndex==0) {
        //[ALLAnalysisUtil logEvent:@"Btn_MallList" withDic:nil];
    }else if (self.selectedIndex==2)
    {
        //[ALLAnalysisUtil logEvent:@"Btn_BrandList" withDic:nil];
    }
//    if (self.selectedIndex==0) {
//            ALLMallListTableVC *mallListVC=[[ALLMallListTableVC alloc]init];
//            UINavigationController *listNav=[[UINavigationController alloc]initWithRootViewController:mallListVC];
//        [viewController presentViewController:listNav animated:YES completion:nil];
//
//    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark --
#pragma mark -Setter Getter


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - HWTabBarDelegate代理方法
- (void)tabBarDidClickPlusButton:(LHTabBar *)tabBar
{
    CerterViewController *vc = [[CerterViewController alloc] init];
    vc.captureImage=[UIImage imageWithCaputureView:self.view];
    [self presentViewController:vc animated:NO completion:nil];
}
@end
