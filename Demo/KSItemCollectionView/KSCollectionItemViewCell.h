//
//  KSCollectionItemViewCelll.h
//  MaintenanceRegulators
//
//  Created by pingyandong on 16/8/8.
//  Copyright © 2016年 Steven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSCollectionItemModel.h"

@interface KSCollectionItemViewCell : UICollectionViewCell
@property (strong, nonatomic) UIImageView *itemImageView;

@property (strong, nonatomic) UILabel *itemTitleLabel;

- (void)setupWithDict:(NSDictionary *)dict;

- (void)setupWithModel:(KSCollectionItemModel *)model;
@end
