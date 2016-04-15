
/*－－－－－－－－－－－－－－－－－－－－app的相关配置－－－－－－－－－－－－－－－－－－*/
/*---------------------------------相关值根据需要自行更改------------------------*/
#import "ALLGlobalData.h"

//开启统计

#define ALIULIAN_URL   @"http://w"


#ifdef EnterPrice
#define Channel   @"EnterPrise"

#else
#define Channel   @"AppStore"
#endif


/*---------------------------------第三方sdk id key--------------------------------*/
#define TALKING_DATA_APPID  @"d8c041be9b8140729b27eabb83e02526"
#define JS_PATCH_KEY  @"f1ee7e4016cde5e9"
#define UM_ID  @"559607c867e58e580400052f"
#define WX_ID  @"wxf6db68184525b5a3"
#define WX_Secret   @"bc079d010f983b03e23822dcceef9b40"
//#define WX_ID   @"wx6a8cae352eb83416"
//#define WX_Secret   @"711bd8cfc04ceece5b211fa179e569d8"

#ifdef EnterPrice
//企业推送
#ifdef DEBUG
#define kPushAppId           @"1rkg4CaNZJAHTvMD01BCs6"
#define kPushAppKey          @"IvAZh6w6uQ8LgpVLHbSZn3"
#define kPushAppSecret       @"1rkg4CaNZJAHTvMD01BCs6"
#else
#define kPushAppId           @"nuftZ9AU0jAcZwIy44Y8g5"
#define kPushAppKey          @"nuftZ9AU0jAcZwIy44Y8g5"
#define kPushAppSecret       @"Hl56JQi29U9wQLVsU1b2P7"
#endif

#else

//appstore 推送
#ifdef DEBUG
#define kPushAppId           @"1rkg4CaNZJAHTvMD01BCs6"
#define kPushAppKey          @"IvAZh6w6uQ8LgpVLHbSZn3"
#define kPushAppSecret       @"1rkg4CaNZJAHTvMD01BCs6"
#else
#define kPushAppId           @"r7vwzCf9XK7u7Sj1EwgesA"
#define kPushAppKey          @"CuHRTf3Suh7MfnJAbE4wp"
#define kPushAppSecret       @"CuHRTf3Suh7MfnJAbE4wp"
#endif


#endif


/*---------------------------------用户相关信息-------------------------------------*/

#define kClient_token   @"client_token"
#define kAccess_token   @"access_token"
#define kRefresh_token  @"refresh_token"
#define kUser_account   @"userId"


#define kCacheCurrentMallKey  @"kCurrentMallCacheKey"
#define kCacheCurrentUserKey  @"kCacheCurrentUserKey"
#define kCacheMallListKey     @"kCacheMallListKey"
#define kCacheBrandListKey    @"kCacheBrandListKey"
#define kCacheSearchMemoryKey @"kCacheSearchMemoryKey"

/*---------------------------------程序相关常数-------------------------------------*/
//App Id、下载地址、评价地址
#define kAppId      @"1022725080"
#define kAppUrl     [NSString stringWithFormat:@"https://itunes.apple.com/us/app/ling-hao-xian/id%@?ls=1&mt=8",kAppId]
#define kRateUrl    [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",kAppId]


/*---------------------------------程序全局通知-------------------------------------*/
//重新登录通知
#define kNotificationReLogin    @"ReLoginNotification"
#define kNotificationNetReconnect  @"kNotificationNetReconnect"
#define kNotificationPaySuccessfull @"kNotificationPaySuccessfull"

/*---------------------------------程序界面配置信息-------------------------------------*/

//设置app界面字体及颜色
#define kTitleFont1              [UIFont boldSystemFontOfSize:20]//一级标题字号
#define kTitleFont2              [UIFont boldSystemFontOfSize:17]//二级标题字号
#define kContentFont             [UIFont systemFontOfSize:14.5]  //内容部分字号
#define kContentFontWithSize(size)       [UIFont systemFontOfSize:size]  //内容尺寸
//内容部分正常显示颜色和突出显示颜色
#define kContentNormalColor      [UIColor colorWithRed:57/255.0 green:32/255.0 blue:0/255.0 alpha:1]
#define kContentHighlightColor   [UIColor colorWithRed:57/255.0 green:32/255.0 blue:0/255.0 alpha:1]

//按钮上字体颜色
#define kBtnTitleNormalColor     [UIColor colorWithRed:57/255.0 green:32/255.0 blue:0/255.0 alpha:1]
#define kBtnTitleHighlightColor  [UIColor colorWithRed:255/255.0 green:96/255.0 blue:0/255.0 alpha:1]

//设置应用的页面背景色
#define kAppBgColor  [UIColor colorWithRed:242/255.0 green:243/255.0 blue:249/255.0 alpha:1]
#define kAppBgColor2  [UIColor colorWithRed:242/255.0 green:243/255.0 blue:249/255.0 alpha:1]
//[UIColor colorWithRed:26/255.0 green:29/255.0 blue:41/255.0 alpha:1]

#define kBtnOringeColor  [UIColor colorWithRed:229/255.0 green:175/255.0 blue:52/255.0 alpha:1]

#define kLineColor  [UIColor colorWithRed:221/255.0 green:223/255.0 blue:225/255.0 alpha:1.0]

//TableView相关设置
//设置TableView分割线颜色
#define kSeparatorColor   [UIColor colorWithRed:221/255.0 green:223/255.0 blue:225/255.0 alpha:1.0]
//设置TableView背景色
#define kTableViewBgColor [UIColor colorWithRed:154/255.0 green:154/255.0 blue:154/255.0 alpha:1]

//默认第一个显示的商场的id 
#define kDefaultMallId    @"1001"

#define ALLMallId @"1017"

//imageView 默认图
#define kSmallLogoPlaceholer   [ALLGlobalData shareInstance].logoImageHolder
#define kHeaderPlaceholder     [UIImage imageNamed:@"headerHolder.png"]
#define kMallBgPlaceHolder     [ALLGlobalData shareInstance].bgImageHolder


/*----------------------------全局枚举定义-------------------------*/
typedef enum
{
    ALLNotitication_OpenApp=6,
    ALLNotitication_Mall,
    ALLNotitication_Brand,
    ALLNotitication_AD,
    ALLNotitication_ProductList,
    ALLNotitication_Product,
    ALLNotitication_Exchange,
    ALLNotitication_ExchangeList,
    ALLNotitication_MyExchangeList,
    ALLNotitication_VIP,
    ALLNotitication_VipActivityList,
    ALLNotification_MyOrderList,
    ALLNotification_ScoreDraw,
    ALLNotification_CarStopDetail,
    ALLNotification_WEBVIEW_COMMON_OPERATE,
    ALLNotification_Recharge_Score,
    ALLNotification_Indiana_Detail, 
    ALLNotification_Indiana_List,
    ALLNotification_My_Indiana_Record_List,
    ALLNotification_Indiana_Share_Order_List,
    ALLNotification_My_Qrcode,
    ALLNotitication_My_Adress_List,
    ALLNotitication_My_ShoppingCar,
    ALLNotitication_My_Car_List,
    ALLNotitication_Category_List,
    ALLNotitication_Comment_Wall,
    ALLNotitication_Brand_Wifi_List,
    ALLNotitication_Brand_Shop_List,
    ALLNotitication_Brand_Dinner,
    ALLNotitication_Msg_Center,
    ALLNotitication_Indiana_NewAnnounce,
    ALLNotitication_Indiana_Detail_Latest,
    ALLNotitication_Share,    //分享
    ALLNotitication_Swip_QrCode, //扫描二维码
}ALLNotiticationType;



