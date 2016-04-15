//
//  FunctionCollectionView.m
//  House
//
//  Created by wang shiwen on 15/11/27.
//  Copyright © 2015年 AiLiuLian. All rights reserved.
//

#import "FunctionCollectionView.h"

#import "FunctionCollectionViewCell.h"

#import "ZWCollectionViewFlowLayout.h"


static NSString *cellIdentifier = @"FunctionCollectionViewCell";

@interface FunctionCollectionView() <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property(nonatomic)float collectionWidth;

@property(nonatomic,strong) UICollectionView *myConllection;

@end

@implementation FunctionCollectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)addCollectionView
{
    //初始化
    _collectionWidth=kWindowWidth*1.0;
    
    //初始化自定义layout
    ZWCollectionViewFlowLayout *flowLayout = [[ZWCollectionViewFlowLayout alloc] init];
    flowLayout.colMagrin = 0;
    flowLayout.rowMagrin = 0;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.colCount = 4;
    flowLayout.degelate = self;
    
    
    _myConllection = [[UICollectionView alloc]initWithFrame:CGRectMake(self.frame.size.width*0.0, 0, _collectionWidth,self.frame.size.height) collectionViewLayout:flowLayout];
    
    //注册
    UINib *cellNib=[UINib nibWithNibName:@"FunctionCollectionViewCell" bundle:nil];
    [_myConllection registerNib:cellNib forCellWithReuseIdentifier:cellIdentifier];
    
    //设置代理
    _myConllection.delegate = self;
    
    _myConllection.dataSource = self;
    
    [self addSubview:_myConllection];
    
    NSLog(@"加载列表");
}

#pragma mark -- UICollectionViewDataSource

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 8;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"FunctionCollectionViewCell";
    FunctionCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    FunctionCollectionModel *model= [[FunctionCollectionModel alloc] init];
    
    model.type=@"";
    model.iconName=@"";
    model.funName=@"";

    [cell bindData:model];
    
    cell.backgroundColor = [UIColor colorWithRed:(255 / 255.0) green:(255 /255.0) blue:(255 /255.0) alpha:1.0f];
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float width=_collectionWidth/4-8;
    
    return CGSizeMake(width, _collectionWidth/4*120/100);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0,0,0,0);
}

#pragma mark --UICollectionViewDelegate

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    NSLog(@"点击了项目");
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark ZWwaterFlowDelegate
- (CGFloat)ZWwaterFlow:(ZWCollectionViewFlowLayout *)waterFlow heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPach
{
    return 90;
}

@end
