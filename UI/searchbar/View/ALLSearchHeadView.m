//
//  ALLSearchHeadView.m
//  House
//
//  Created by wang shiwen on 16/3/3.
//  Copyright © 2016年 AiLiuLian. All rights reserved.
//

#import "ALLSearchHeadView.h"
#import "ALLSearchBarView.h"
#import "ALLGlobalFunction.h"
@interface ALLSearchHeadView()<UISearchBarDelegate>

@property (nonatomic,strong)UIButton *popBtn;
@property (nonatomic,strong)UIButton *shoppingCarBtn;

@property (nonatomic,strong)UISearchBar *searchBar;

@end

@implementation ALLSearchHeadView

#pragma mark Member Function

- (id)initWithFrame:(CGRect )rect
{
    self=[super initWithFrame:rect];
    if (self) {
        
        [self initUI];
    }
    return self;
    
}

- (void)initUI
{
    //添加搜索栏
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(self.frame.size.width*0.2 , 0 , self.frame.size.width*0.7, self.frame.size.height)];
    self.searchBar.placeholder = @"搜索";
    self.searchBar.showsCancelButton=NO;
    self.searchBar.delegate=self;
    self.searchBar.backgroundImage = [ALLGlobalFunction imageWithColor:[UIColor colorWithRed:245/255.0 green:246/255.0 blue:246/255.0 alpha:1.0] size:self.searchBar.bounds.size];
    [self addSubview:self.searchBar];
    
    //返回按钮
    self.popBtn=[[UIButton alloc]initWithFrame:(CGRect){self.frame.size.width*0.075-15,0,30,self.frame.size.height}];
    [self.popBtn.titleLabel setFont:[UIFont systemFontOfSize:20.00]];
    [self.popBtn setTitle:@"《" forState:UIControlStateNormal];
    [self.popBtn addTarget:self action:@selector(popBtnCallBack) forControlEvents:UIControlEventTouchUpInside];
    self.popBtn.showsTouchWhenHighlighted = YES;
    [self.popBtn setTitleColor: [UIColor darkTextColor] forState:UIControlStateNormal];
    [self addSubview:self.popBtn];
    
    //购物车
    self.shoppingCarBtn=[[UIButton alloc]initWithFrame:(CGRect){self.frame.size.width*0.85-15,0,30,self.frame.size.height}];
    [self.shoppingCarBtn.titleLabel setFont:[UIFont systemFontOfSize:20.00]];
    [self.shoppingCarBtn setTitle:@"购" forState:UIControlStateNormal];
    [self.shoppingCarBtn addTarget:self action:@selector(shoppingCarBtnCallBack) forControlEvents:UIControlEventTouchUpInside];
    self.shoppingCarBtn.showsTouchWhenHighlighted = YES;
    [self.shoppingCarBtn setTitleColor: [UIColor darkTextColor] forState:UIControlStateNormal];
    [self addSubview:self.shoppingCarBtn];
    
}

- (void)popBtnCallBack
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(posViewController)]) {
        [self.delegate posViewController];
    }
}

- (void)shoppingCarBtnCallBack
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(shoppingCarBtnCack)]) {
        [self.delegate shoppingCarBtnCack];
    }
}


#pragma mark -ALLSearchViewDelegate

//点击键盘上的search按钮时调用

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString *searchTerm = searchBar.text;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchTextCallBack:)]) {
        [self.delegate searchTextCallBack:searchTerm];
    }
    
}

//输入文本实时更新时调用

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
}

//点击搜索框时调用

- (void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{

}

//搜索框结束编辑时调用
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
 
}


@end
