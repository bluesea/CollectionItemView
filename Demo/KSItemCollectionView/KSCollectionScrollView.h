//
//  KSCollectionScrollView.h
//  MaintenanceRegulators
//
//  Created by pingyandong on 16/8/8.
//  Copyright © 2016年 Steven. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KSCollectionScrollView;
@protocol KSCollectionScrollViewDataSource <NSObject>
/**
 *  总数据源
 *
 *  @return 总数据源
 */
- (NSArray *)collectionScrollViewData;

@end

@protocol KSCollectionScrollViewDelegate <NSObject>
/**
 *  点击item的事件
 *
 *  @param collectionItemView 点击的view
 *  @param indexPath          点击的indexPath
 *  @param page               当前所在页面
 */
- (void)collectionScrollItemView:(KSCollectionScrollView *)collectionItemView didSelectItemAtIndexPath:(NSIndexPath *)indexPath selectPage:(NSInteger)page;

@end

@interface KSCollectionScrollView : UIView

/**
 *  每一行多少个
 */
@property (nonatomic, assign) IBInspectable NSInteger sectionItemNum;



/**
 *  多少行
 */
@property (nonatomic, assign) IBInspectable NSInteger numOfSection;

@property (nonatomic, weak)IBOutlet id <KSCollectionScrollViewDataSource> dataSource;
@property (nonatomic, weak)IBOutlet id <KSCollectionScrollViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame;
- (void)setUpItems;
@end
