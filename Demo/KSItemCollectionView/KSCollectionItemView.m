//
//  KSCollectionItemView.m
//  MaintenanceRegulators
//
//  Created by pingyandong on 16/8/8.
//  Copyright © 2016年 Steven. All rights reserved.
//

#import "KSCollectionItemView.h"
#import "KSCollectionItemViewCell.h"
#import "KSCollectionItemModel.h"
#import "Macro.h"

@interface KSCollectionItemView ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectView;
@property (nonatomic, strong) UIPageControl *pageController;
@end

@implementation KSCollectionItemView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib
{
    [self setupUI];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.backgroundColor = [UIColor whiteColor];
    //1.初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置collectionView滚动方向
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    _collectView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.bounds.size.height) collectionViewLayout:layout];
    _collectView.backgroundColor = [UIColor clearColor];
    //        [_collectView mas_updateConstraints:^(MASConstraintMaker *make) {
    //            make.size.mas_equalTo(CGSizeMake(kScreenWidth, self.bounds.size.height));
    //        }];
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    [_collectView registerClass:[KSCollectionItemViewCell class] forCellWithReuseIdentifier:@"KSCollectionItemViewCell"];
    
    //4.设置代理
    _collectView.delegate = self;
    _collectView.dataSource = self;
    [self addSubview:_collectView];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.numOfSections;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == self.numOfSections - 1) {
        return self.totalItemNums - self.numberOfItems * section;
    }
    return self.numberOfItems;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KSCollectionItemViewCell *cell = (KSCollectionItemViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"KSCollectionItemViewCell" forIndexPath:indexPath];
//    DDLogDebug(@"%ld",indexPath.row + indexPath.section * self.numberOfItems);
//    NSDictionary *dict = [self.dataArray objectAtIndex:indexPath.row + indexPath.section * self.numberOfItems];
//    [cell setupWithDict:dict];
    KSCollectionItemModel *model = [self.dataArray objectAtIndex:indexPath.row + indexPath.section * self.numberOfItems];
    [cell setupWithModel:model];
    return cell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((kScreenWidth-10*(self.numberOfItems + 1))/self.numberOfItems, (self.bounds.size.height-30)/self.defaultSectionInPage);
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10,10,0,10);//（上、左、下、右）
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate collectionItemView:self didSelectItemAtIndexPath:indexPath];
}
@end
