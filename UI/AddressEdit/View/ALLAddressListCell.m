//
//  ALLAddressListCell.m
//  ALiuLian
//
//  Created by 王诗文 on 15/5/30.
//  Copyright (c) 2015年 王诗文. All rights reserved.
//

#import "ALLAddressListCell.h"
#import <UIImageView+WebCache.h>
#import "AppConfig.h"
#import "MacroDefine.h"
#import "ALLAddressLogic.h"
#import "UIGestureRecognizer+YYAdd.h"
#import "ALLAddressEditVC.h"

@interface ALLAddressListCell()

@property (weak, nonatomic) IBOutlet UIImageView *check_icon;
@property (weak, nonatomic) IBOutlet UILabel *address_nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *address_phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *address_contentLabel;

@property (weak, nonatomic) IBOutlet UIButton *mobile_editBtn;//编辑按钮
@property (weak, nonatomic) IBOutlet UIButton *mobile_delBtn;//删除按钮

@property (weak, nonatomic) ALLAddressListVC *addressVC;//父

@end
@implementation ALLAddressListCell


-(void)awakeFromNib
{
    [super awakeFromNib];
    
    //添加一个图片点击事件
    self.check_icon.userInteractionEnabled = NO;
}

-(void)setAddressTableVC:(ALLAddressListVC *)addressVC
{
    _addressVC=addressVC;
}

-(void)bindData:(ALLAddressModel *)model
{
    _addressModel=model;
    
    _address_nameLabel.text=model.userName;
    _address_phoneLabel.text=model.mobile;
    _address_contentLabel.text=model.address;
    
    if (model.defalutLocation == 1 ) {
        _check_icon.image=[UIImage imageNamed:@"checked_icon.png"];
    }else if(model.defalutLocation == 0 ){
        _check_icon.image=[UIImage imageNamed:@"unchecked_icon.png"];
    }
    
    
    _address_contentLabel.preferredMaxLayoutWidth=kWindowWidth-25-14;
    
}

-(IBAction)setDefaultBtnPressed:(id)btn
{
    if (_addressModel.defalutLocation ==1) {
        return;
    }
    
    ALLAddressModel *address=_addressModel;
    address.defalutLocation=1;
    
    [ALLAddressLogic saveAddressMessage:address  Success:^(NSDictionary *info) {
        
        //[self.addressVC.refresh begainRefresh];
        //刷新列表
        [self.addressVC setDefaultLocationByIndex:_addressModel.addressId];
        
    } failed:^(int errorCode,NSString *errDes) {
        
        ALLAlertView(@"提示",errDes);
        
    }];
    
    
    
}

-(IBAction)editBtnPressed:(id)btn
{
    ALLAddressEditVC *collectVC=[[ALLAddressEditVC alloc] initEditModel:_addressModel];

    [self.addressVC.navigationController pushViewController:collectVC animated:YES];
}

-(IBAction)delBtnPressed:(id)btn
{
    //删除地址确定
    [self delAddressDeal];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString* msg = [[NSString alloc] initWithFormat:@"您按下的第%ld个按钮！",(long)buttonIndex];
    NSLog(@"%@",msg);
    
    if ((int)buttonIndex ==0){//取消
        
    }else if ((int)buttonIndex ==1){//确定
        
        WS(weakSelf);
        
        [ALLAddressLogic  deleteAddressMessage:_addressModel.addressId  Success:^(NSDictionary *info) {

            //刷新列表
            [self.addressVC removeAddressByIndex:_addressModel.addressId];
            
        } failed:^(int errorCode,NSString *errDes) {
            
            ALLAlertView(@"提示",errDes);
            
        }];
        
    }
    
}


-(void)delAddressDeal
{
    UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"提示"    //标题
                                                  message:@"您确定删除这条地址吗?"   //显示内容
                                                 delegate:self          //委托，可以点击事件进行处理
                                        cancelButtonTitle:@"取消"
                                        otherButtonTitles:@"确定"
                         ,nil];
    [view show];
}

@end
