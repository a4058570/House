//
//  ALLSearchBarView.m
//  House
//
//  Created by wang shiwen on 16/3/3.
//  Copyright © 2016年 AiLiuLian. All rights reserved.
//

#import "ALLSearchBarView.h"
#import "ALLGlobalFunction.h"

@interface ALLSearchBarView () <UISearchBarDelegate>

@end

@implementation ALLSearchBarView


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
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width*0.85, self.frame.size.height)];
    self.searchBar.placeholder = @"搜索";
    self.searchBar.showsCancelButton=NO;
    self.searchBar.delegate=self;
    self.searchBar.backgroundImage = [ALLGlobalFunction imageWithColor:[UIColor colorWithRed:245/255.0 green:246/255.0 blue:246/255.0 alpha:1.0] size:self.searchBar.bounds.size];
    [self addSubview:self.searchBar];

    //右上角 新增按钮
    self.linkBtn=[[UIButton alloc]initWithFrame:(CGRect){self.searchBar.frame.size.width+(self.frame.size.width - self.searchBar.frame.size.width )/2-20,0,30,self.frame.size.height}];
    [self.linkBtn.titleLabel setFont:[UIFont systemFontOfSize:15.00]];
    [self.linkBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.linkBtn addTarget:self action:@selector(cancleBtnCallBack) forControlEvents:UIControlEventTouchUpInside];
    self.linkBtn.showsTouchWhenHighlighted = YES;
    [self.linkBtn setTitleColor:[UIColor colorWithRed:138/255.0 green:138/255.0 blue:138/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    [self addSubview:self.linkBtn];
    
    self.backgroundColor= [UIColor colorWithRed:245/255.0 green:246/255.0 blue:246/255.0 alpha:1.0];
    
    UIView *lineview= [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-0.5f,self.frame.size.width , 0.5f)];
    lineview.backgroundColor= [UIColor lightGrayColor];
    [self addSubview:lineview];
}

- (void)cancleBtnCallBack
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancleBtnCallBacl)]) {
        [self.delegate cancleBtnCallBacl];
    }
    
    [self.searchBar resignFirstResponder];
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
    [self.linkBtn setTitleColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0] forState:UIControlStateNormal];
}

//搜索框结束编辑时调用
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [self.linkBtn setTitleColor:[UIColor colorWithRed:138/255.0 green:138/255.0 blue:138/255.0 alpha:1.0] forState:UIControlStateNormal];
}

@end
