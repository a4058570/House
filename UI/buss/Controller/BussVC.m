//
//  BussVC.m
//  House
//
//  Created by wang shiwen on 15/9/1.
//  Copyright (c) 2015年 AiLiuLian. All rights reserved.
//

#import "BussVC.h"
#import "MacroDefine.h"
#import "AppConfig.h"
#import "TextModel.h"
#import "ALLPageModel.h"
#import "WJItemsControlView.h"


typedef NS_ENUM(NSInteger, Test) {
    
    TestA = 1, //1 1 1
    
    TestB = 1 << 1, //2 2 10 转换成 10进制 2
    
    TestC = 1 << 2, //4 3 100 转换成 10进制 4
    
    TestD = 1 << 3, //8 4 1000 转换成 10进制 8
    
    TestE = 1 << 4 //16 5 10000 转换成 10进制 16
    
};

typedef NS_OPTIONS (NSInteger, YYTextLineStyle) {
    // basic style (bitmask:0xFF)
    YYTextLineStyleNone       = 0x00, ///< (        ) Do not draw a line (Default).
    YYTextLineStyleSingle     = 0x01, ///< (──────) Draw a single line.
    YYTextLineStyleThick      = 0x02, ///< (━━━━━━━) Draw a thick line.
    YYTextLineStyleDouble     = 0x09, ///< (══════) Draw a double line.
    
    // style pattern (bitmask:0xF00)
    YYTextLineStylePatternSolid      = 0x000, ///< (────────) Draw a solid line (Default).
    YYTextLineStylePatternDot        = 0x100, ///< (‑ ‑ ‑ ‑ ‑ ‑) Draw a line of dots.
    YYTextLineStylePatternDash       = 0x200, ///< (— — — —) Draw a line of dashes.
    YYTextLineStylePatternDashDot    = 0x300, ///< (— ‑ — ‑ — ‑) Draw a line of alternating dashes and dots.
    YYTextLineStylePatternDashDotDot = 0x400, ///< (— ‑ ‑ — ‑ ‑) Draw a line of alternating dashes and two dots.
    YYTextLineStylePatternCircleDot  = 0x900, ///< (••••••••••••) Draw a line of small circle dots.
};

@interface BussVC () <UIScrollViewDelegate>

@property (nonatomic,strong)WJItemsControlView *itemControlView;


@end

@implementation BussVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    //添加选项菜单
    //[self addWJSegment];
    
    NSArray *myImages = [NSArray arrayWithObjects:
                         
                         [UIImage imageNamed:@"h1.jpg"],
                         
                         [UIImage imageNamed:@"h2.jpg"],
                         
                         nil];
    
    UIImageView *myAnimatedView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWindowWidth, 100)];
    
    myAnimatedView.animationImages = myImages;
    
    myAnimatedView.animationDuration = 0.5;
    
    myAnimatedView.animationRepeatCount = 0;
    
    [myAnimatedView startAnimating];
    
    [self.view addSubview:myAnimatedView];
    
    //NSCoding 保存自定义对象
    [self save];
    
    //NSCoding 读取自定义对象
    [self read];
    
    
    //copy 和 mutableCopy
    ALLPageModel *stu = [[ALLPageModel alloc] init];
    
    stu.currentPage= 20;
    
    
    ALLPageModel *stu_copy = [stu copy];
    stu_copy.currentPage = 30;
    
    ALLPageModel *stu_mutableCopy = [stu mutableCopy];
    
    stu.currentPage= 10;
    
    NSLog(@"原:%d,Copy:%d,MutableCopy:%d",stu.currentPage,stu_copy.currentPage,stu_mutableCopy.currentPage);
    
    
    
    //枚举
    //Test tes = (TestA|TestB);
    
    //判断枚举变量是否包含某个固定的枚举值,使用前需要确保枚举值以及各个组合的唯一性:
    
    NSLog(@"%ld %ld %ld %ld %ld",(long)TestA,(long)TestB,(long)TestC,(long)TestD,(long)TestE);
    
    Test tes = (TestA|TestB); NSLog(@"%ld",tes);
    
    NSLog(@"%ld",(tes & TestA));
    
    if ((tes & TestA)) {
        NSLog(@"有");
    }else {
        NSLog(@"没有");
    }
    
    NSLog(@"%ld",(tes & TestB));
    
    if ((tes & TestB)) {
        NSLog(@"有");
    }else {
        NSLog(@"没有");
    }
    
    NSLog(@"%ld",(tes & TestC));
    
    if ((tes & TestC)) {
        NSLog(@"有");
    }else {
        NSLog(@"没有");
    }
    
    YYTextLineStyle yy= (YYTextLineStyleSingle|YYTextLineStylePatternDot|YYTextLineStylePatternDashDotDot);
    if (yy & YYTextLineStyleSingle) {
        NSLog(@"含属性%ld",YYTextLineStyleSingle);
    }
    if (yy & YYTextLineStylePatternDot) {
        NSLog(@"含属性%ld",YYTextLineStylePatternDot);
    }
    
    if (yy & YYTextLineStylePatternDashDotDot) {
        NSLog(@"含属性%ld",YYTextLineStylePatternDashDotDot);
    }
    
   
    [self jsPatchText];
}

- (IBAction)save {
    // 1.新的模型对象
    TextModel *stu = [[TextModel alloc] init];
    stu.no = @"42343254";
    stu.age = 20;
    stu.height = 1.55;
    
    // 2.归档模型对象
    // 2.1.获得Documents的全路径
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 2.2.获得文件的全路径
    NSString *path = [doc stringByAppendingPathComponent:@"stu.data"];
    // 2.3.将对象归档
    [NSKeyedArchiver archiveRootObject:stu toFile:path];
}

- (IBAction)read {
    // 1.获得Documents的全路径
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 2.获得文件的全路径
    NSString *path = [doc stringByAppendingPathComponent:@"stu.data"];
    
    // 3.从文件中读取MJStudent对象
    TextModel *stu = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    NSLog(@"%@ %d %f", stu.no, stu.age, stu.height);
    
}


- (void)jsPatchText
{
    NSLog(@"调用JSPatch失败");
}

- (void)addWJSegment
{
    //选项
    NSArray *array = @[@"人气",@"最新",@"进度",@"总需人数^"];
    
    //4页内容的scrollView
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 100, kWindowWidth, kWindowHeight-100)];
    scroll.delegate = self;
    scroll.pagingEnabled = YES;
    scroll.contentSize = CGSizeMake(kWindowWidth*array.count, 0);
    
    for (int i=0; i<array.count; i++) {
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kWindowWidth*i, 0, kWindowWidth, kWindowHeight-100)];
        label.text = array[i];
        label.textAlignment = NSTextAlignmentCenter;
        //[scroll addSubview:label];
    }
    [self.view addSubview:scroll];
    
    int leftSpace=kWindowWidth*0.02;
    
    //头部控制的segMent
    WJItemsConfig *config = [[WJItemsConfig alloc]init];
    config.itemWidth = (kWindowWidth-leftSpace)/4.0;
    
    _itemControlView = [[WJItemsControlView alloc]initWithFrame:CGRectMake(leftSpace, 100-44, kWindowWidth-leftSpace, 44)];
    _itemControlView.tapAnimation = YES;
    _itemControlView.config = config;
    _itemControlView.titleArray = array;
    
    __weak typeof (scroll)weakScrollView = scroll;
    
    [_itemControlView setTapItemWithIndex:^(NSInteger index,BOOL animation){
        
        NSLog(@"选择第%ld项搜索",(long)index);
        [weakScrollView scrollRectToVisible:CGRectMake(index*weakScrollView.frame.size.width, 0.0, weakScrollView.frame.size.width,weakScrollView.frame.size.height) animated:animation];
           }];
    [self.view addSubview:_itemControlView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float offset = scrollView.contentOffset.x;
    offset = offset/CGRectGetWidth(scrollView.frame);
    [_itemControlView moveToIndex:offset];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    float offset = scrollView.contentOffset.x;
    offset = offset/CGRectGetWidth(scrollView.frame);
    [_itemControlView endMoveToIndex:offset];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
