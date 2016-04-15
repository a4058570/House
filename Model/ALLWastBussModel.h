//
//  ALLUserModel.h
//  ALiuLian
//
//  Created by 王诗文 on 15/9/6.
//  Copyright (c) 2015年 王诗文. All rights reserved.
//

#import "ALL_BaseModel.h"

@interface ALLWastBussModel : ALL_BaseModel

@property(nonatomic)int deskId; //桌子id
@property(nonatomic,strong)NSString *name; //桌子名称
@property(nonatomic)int type; //桌子类型
@property(nonatomic)int minPeople; //最少人数
@property(nonatomic)int maxPeople; //最大人数
@property(nonatomic)int code; //桌号

-(id)initWithDic:(NSMutableDictionary *)dic;

@end

@interface ALLOrderDinnerModel : ALL_BaseModel
@property(nonatomic)NSString *entityId; //商家id
@property(nonatomic)NSString *shopId; //店铺id
@property(nonatomic)NSString *userId; //用户id

/*订单基本信息*/
@property(nonatomic,strong)NSString *orderId; //订单id
@property(nonatomic,strong)NSString *shopName; //分店名称
@property(nonatomic)int peopleNum;//客人数量
@property(nonatomic,strong)NSString *username;//客人名称
@property(nonatomic,strong)NSString *orderData;//日期
@property(nonatomic,)int status;//订餐状态
@property(nonatomic,strong)NSString *tableType;//桌型:小桌,大桌
@property(nonatomic,strong)NSString *tablename;//桌子名称
@property(nonatomic)int tablenum;//桌号
@property(nonatomic)int sexType;//称呼:先生,女士
@property(nonatomic,strong)NSString *des;//备注
@property(nonatomic)int orderState;//订单状态:1已预订 2已取消

-(id)initWithDinnerInfo:(NSMutableDictionary *)dic;


-(void)update;
@end
