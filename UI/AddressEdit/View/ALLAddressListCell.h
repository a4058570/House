//
//  ALLAddressListCell.h
//  ALiuLian
//
//  Created by 王诗文 on 15/10/19.
//  Copyright (c) 2015年 王诗文. All rights reserved.
//

#import "ALLBaseCell.h"
#import "ALLAddressModel.h"
#import "ALLAddressListVC.h"
@interface ALLAddressListCell : ALLBaseCell<UIAlertViewDelegate>

@property (strong, nonatomic) ALLAddressModel *addressModel;//属性model
-(void)bindData:(ALLAddressModel *)model;

-(void)setAddressTableVC:(ALLAddressListVC *)addressVC;

@end
