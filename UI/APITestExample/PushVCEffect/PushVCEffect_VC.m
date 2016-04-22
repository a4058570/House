//
//  PushVCEffect_VC.m
//  House
//
//  Created by wang shiwen on 16/4/21.
//  Copyright © 2016年 AiLiuLian. All rights reserved.
//

#import "PushVCEffect_VC.h"
#import "MacroDefine.h"
#import "AppConfig.h"

@interface PushVCEffect_VC ()
@property (nonatomic, copy) NSArray *data;
@property (nonatomic, copy) NSArray *viewControllers;
@property (nonatomic, strong)UITableView *tableView;
@end

@implementation PushVCEffect_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    
    self.tableView.tableFooterView=[[UIView alloc]init];
    
    self.tableView.backgroundColor=kAppBgColor;
    
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    self.tableView.delegate= (id)self;
    self.tableView.dataSource=(id)self;
    
    //[self.tableView reloadData];
    
    [self.view addSubview:self.tableView];
    
    self.title = @"自定义转场动画";
    self.navigationController.view.layer.cornerRadius = 10;
    self.navigationController.view.layer.masksToBounds = YES;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
    
}

#pragma mark - lazyLoding

- (NSArray *)data{
    if (!_data) {
        _data = [@[@"神奇移动",@"弹性pop",@"翻页效果",@"小圆点扩散"] copy];
    }
    return _data;
}

- (NSArray *)viewControllers{
    if (!_viewControllers) {
        _viewControllers = [@[@"XWMagicMoveController", @"XWPresentOneController", @"XWPageCoverController", @"XWCircleSpreadController"] copy];
    }
    return _viewControllers;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = _data[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.navigationController pushViewController:[[NSClassFromString(self.viewControllers[indexPath.row]) alloc] init] animated:YES];
}

@end
