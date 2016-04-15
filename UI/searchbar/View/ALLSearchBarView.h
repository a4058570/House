//
//  ALLSearchBarView.h
//  House
//
//  Created by wang shiwen on 16/3/3.
//  Copyright © 2016年 AiLiuLian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ALLSearchBarViewDelegate<NSObject>

- (void)searchTextCallBack:(NSString *) searchtext;
- (void)cancleBtnCallBacl;

@end

@interface ALLSearchBarView : UIView

@property (nonatomic,assign)id <ALLSearchBarViewDelegate> delegate;

@property (nonatomic,strong)UISearchBar *searchBar;

@property (nonatomic,strong)UIButton *linkBtn;

-(id)initWithFrame:(CGRect )rect;

@end
