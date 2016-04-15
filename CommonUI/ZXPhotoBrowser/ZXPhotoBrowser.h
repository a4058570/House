//
//  ZXPhotoBrowser.h
//  PhotoBroswer
//
//  Created by zhangxu on 15/3/6.
//  Copyright (c) 2015年 zhangxu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZXPhotoShowAnimation) {
    ZXPhotoShowNormal       = 1,    //
    ZXPhotoShowScale   =  2,    // 必须设置fromImageViews
    ZXPhotoShowFlip   =  3     //  必须设置fromImageViews
} NS_ENUM_AVAILABLE_IOS(6_0);





@interface ZXPhotoModel : NSObject


@property(nonatomic,strong)NSURL *detalUrl;
@property(nonatomic,strong)UIImage *thumbnailImage;
@property(nonatomic,strong)UIImage *detailImage;
@property(nonatomic,strong)UIImageView *fromImageView;

@property(nonatomic)int index;
@property(nonatomic)BOOL isFirst;  //是否是显示的第一张图片
@end




@interface ZXPhotoBrowser : UIViewController<UIScrollViewDelegate>


@property(nonatomic)int currentIndex;
@property(nonatomic)ZXPhotoShowAnimation animType;


-(id)initWithPhotoModels:(NSArray *)models;
-(void)showBrowswerWithIndex:(int)index inContainner:(UIView *)container;
@end
