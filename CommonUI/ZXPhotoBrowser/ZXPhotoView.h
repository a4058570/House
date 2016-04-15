//
//  ZXPhotoView.h
//  PhotoBroswer
//
//  Created by zhangxu on 15/3/6.
//  Copyright (c) 2015年 zhangxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXPhotoBrowser.h"


@class ZXPhotoView;

@protocol ZXPhotoViewDelegate<NSObject>

-(void)didTouchClose:(ZXPhotoView *)photoView;

@end


@interface ZXPhotoView : UIScrollView<UIScrollViewDelegate>

@property(nonatomic,strong)UIImageView  *imageView;
@property(nonatomic)int index;
@property(nonatomic,assign) id<ZXPhotoViewDelegate>  photoDelegate;
@property(nonatomic)BOOL isAnimIn;
@property(nonatomic,strong)ZXPhotoModel *model;




@end
