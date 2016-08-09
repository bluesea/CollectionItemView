//
//  KSCollectionScrollView.m
//  MaintenanceRegulators
//
//  Created by pingyandong on 16/8/8.
//  Copyright © 2016年 Steven. All rights reserved.
//

#import "KSCollectionScrollView.h"
#import "KSCollectionItemView.h"
#import "Macro.h"
@interface KSCollectionScrollView ()<UICollectionItemViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *bgScrollView;
@property (nonatomic, strong) UIPageControl *pageController;
@end

@implementation KSCollectionScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib
{
    if (self.sectionItemNum == 0) {
        self.sectionItemNum = 4;
    }
    if (self.numOfSection == 0) {
        self.numOfSection = 2;
    }
    
    [self setUpUI];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        if (self.sectionItemNum == 0) {
            self.sectionItemNum = 4;
        }
        if (self.numOfSection == 0) {
            self.numOfSection = 2;
        }
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    _bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.bounds.size.height)];
    _bgScrollView.pagingEnabled = YES;
    _bgScrollView.scrollEnabled = YES;
    _bgScrollView.delegate = self;
    _bgScrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_bgScrollView];
    
    _pageController = [[UIPageControl alloc] initWithFrame:CGRectMake((kScreenWidth-30)/2, self.bounds.size.height - 30, 100, 30)];
    _pageController.currentPageIndicatorTintColor = [UIColor orangeColor];
    _pageController.pageIndicatorTintColor = [UIColor grayColor];
    [self addSubview:_pageController];
//    [_bgScrollView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(kScreenWidth, self.bounds.size.height));
//    }];
//    [_pageController mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.centerXWithinMargins.equalTo(self);
//        make.bottom.equalTo(self).with.offset(0);
//    }];
    
    
    NSArray *totalDataSource = [self.dataSource collectionScrollViewData];
    NSInteger page = ceil((totalDataSource.count*1.000) / self.sectionItemNum / self.numOfSection );
    [self.bgScrollView setContentSize:CGSizeMake(page * kScreenWidth, self.bounds.size.height)];
    if (1 == page) {
        self.pageController.hidden = YES;
    }else{
        self.pageController.numberOfPages = page;
        self.pageController.currentPage = 0;
    }
    
    for (int i = 0; i < page; i ++) {
        KSCollectionItemView *itemView = [[KSCollectionItemView alloc] initWithFrame:CGRectMake(0 + kScreenWidth * i, 0 , kScreenWidth, self.bounds.size.height - 30)];
        itemView.numberOfItems = self.sectionItemNum;
        itemView.numOfSections = self.numOfSection;
        itemView.totalItemNums = self.numOfSection * self.sectionItemNum;
        itemView.defaultSectionInPage = self.numOfSection;
        if (i == page - 1) {
            itemView.numOfSections = ceil((totalDataSource.count - (i * self.sectionItemNum * self.numOfSection)*1.000) / self.sectionItemNum);
            itemView.totalItemNums = totalDataSource.count - (i * self.sectionItemNum * self.numOfSection);
            NSIndexSet *rangeSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(i * self.numOfSection * self.sectionItemNum, totalDataSource.count-i * self.numOfSection * self.sectionItemNum)];
            itemView.dataArray = [totalDataSource objectsAtIndexes:rangeSet];
        }else{
            NSIndexSet *rangeSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(i * self.numOfSection * self.sectionItemNum, self.numOfSection * self.sectionItemNum)];
            itemView.dataArray = [totalDataSource objectsAtIndexes:rangeSet];
        }
        itemView.delegate = self;
        [self.bgScrollView addSubview:itemView];
    }
}

- (void)setUpItems
{
    [self setUpUI];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
    _pageController.currentPage = index;
}

#pragma mark - UICollectionItemViewDelegate
- (void)collectionItemView:(KSCollectionItemView *)collectionItemView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate collectionScrollItemView:self didSelectItemAtIndexPath:indexPath selectPage:_pageController.currentPage];
}
@end
