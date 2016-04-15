//
//  ALLSelectView.h
//  DiZhuBang
//
//  Created by 张旭 on 15/12/29.
//  Copyright © 2015年 张旭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALLSelectConfig : NSObject

@property(nonatomic,strong)UIImage *localImg;
@property(nonatomic,strong)UIColor *imgBgColor;
@property(nonatomic,strong)NSURL *imgUrl;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *rightTitle;
@property(nonatomic,strong)UIImage *emptyImg;
@property(nonatomic,strong)UIImage *fullImg;
@property(nonatomic,strong)UIButton *leftBtn;

//自行携带的数据
@property(nonatomic,strong)NSObject *data;
@end




@interface ALLSelectRow : UITableViewCell

@property(nonatomic)BOOL isCheck;

-(void)bindConfig:(ALLSelectConfig *)config;

-(void)setCheck:(BOOL)check;
@end






@interface ALLSelectView : UIView
@property(nonatomic,copy)void (^changeBlock)(ALLSelectConfig *obj);
@property(nonatomic,copy)void (^tapBlock)(ALLSelectConfig *obj);


@property(nonatomic,readonly)ALLSelectConfig *selectObject;


-(void)bindData:(NSArray *)configs;
//手动设置
-(void)selectIndex:(int )index;
-(ALLSelectRow *)selectRowWithIndex:(int )index;
@end
