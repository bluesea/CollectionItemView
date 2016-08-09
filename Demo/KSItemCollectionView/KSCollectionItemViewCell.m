//
//  KSCollectionItemViewCell.m
//  MaintenanceRegulators
//
//  Created by pingyandong on 16/8/8.
//  Copyright © 2016年 Steven. All rights reserved.
//

#import "KSCollectionItemViewCell.h"
#import "UIImageView+WebCache.h"

@implementation KSCollectionItemViewCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //设置CollectionViewCell中的图像框
        _itemImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-15)];
        _itemImageView.backgroundColor = [UIColor clearColor];
        [self addSubview:_itemImageView];
        
        //文本框
        _itemTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame)-15, CGRectGetWidth(self.frame), 15)];
        _itemTitleLabel.font = [UIFont systemFontOfSize:13];
        _itemTitleLabel.textColor = [UIColor grayColor];
        _itemTitleLabel.textAlignment = NSTextAlignmentCenter;
        _itemTitleLabel.text = @"";
        [self addSubview:_itemTitleLabel];
    }
    
    return self;
}

- (void)setupWithDict:(NSDictionary *)dict
{
    _itemTitleLabel.text = dict[@"title"];
    [_itemImageView sd_setImageWithURL:[NSURL URLWithString:dict[@"img"]] placeholderImage:nil];
}

- (void)setupWithModel:(KSCollectionItemModel *)model
{
    _itemTitleLabel.text = model.title;
    [_itemImageView sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:nil];
}
@end
