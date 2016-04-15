//
//  DZAddPicView.h
//
//  Created by 张旭 on 15/12/30.
//  Copyright © 2015年 张旭. All rights reserved.
//

#import <UIKit/UIKit.h>

//图片数据 model
@interface DZAddPicConfig : NSObject

@property(nonatomic,strong)UIImage *img;
@property(nonatomic,strong)NSString *uploadUrl;

@end








//图片单元组件
@class DZAddPicComponent;

@protocol DZAddPicComponentDelegate <NSObject>


-(void)didComponentDeletePressed:(DZAddPicComponent *)component;
-(void)didComponentImagePressed:(DZAddPicComponent *)component;
@end



@interface DZAddPicComponent : UIView

@property(nonatomic)BOOL autoUpload; //是否自动上传
@property(nonatomic,readonly)NSString *uploadUrl; //上传成功的url
@property(nonatomic,weak)id<DZAddPicComponentDelegate>delegate;
-(void)bindConfig:(DZAddPicConfig *)config;
@end







//整个添加图片 组件 管理 图片组件单元数组
@interface DZAddPicView : UIView
@property(nonatomic)int imageLimit;

-(id)initWithShowVC:(UIViewController *)vc;
-(void)addImages:(NSArray *)images;


-(int)currentPicNumber;
//获取自动上传 成功之后的所有url  如果有上传不成功 返回nil
-(NSArray *)uploadUrls;

@end