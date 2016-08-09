//
//  KSCollectionItemView.h
//  MaintenanceRegulators
//
//  Created by pingyandong on 16/8/8.
//  Copyright © 2016年 Steven. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KSCollectionItemView;

@protocol UICollectionItemViewDelegate <NSObject>
- (void)collectionItemView:(KSCollectionItemView *)collectionItemView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface KSCollectionItemView : UIView
@property (nonatomic, weak) id <UICollectionItemViewDelegate> delegate;
@property (nonatomic, assign) NSInteger numberOfItems;//每行多少个
@property (nonatomic, assign) NSInteger numOfSections;//每页真实显示多少行
@property (nonatomic, assign) NSInteger totalItemNums;//每页多少个
@property (nonatomic, assign) NSInteger defaultSectionInPage;//每页默认多少行

@property (nonatomic, copy) NSArray *dataArray;
- (instancetype)initWithFrame:(CGRect)frame;

@end
