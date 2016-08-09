//
//  ViewController.m
//  Demo
//
//  Created by pingyandong on 16/8/9.
//  Copyright © 2016年 Kingsum. All rights reserved.
//

#import "ViewController.h"
#import "KSCollectionItemModel.h"
#import "KSCollectionScrollView.h"

@interface ViewController ()<KSCollectionScrollViewDataSource,KSCollectionScrollViewDelegate>
@property (weak, nonatomic) IBOutlet KSCollectionScrollView *itemCollectionScrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - KSCollectionScrollViewDataSource
- (NSArray *)collectionScrollViewData
{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 18; i ++) {
        KSCollectionItemModel *model = [[KSCollectionItemModel alloc] init];
        model.imgUrl = @"http://img05.tooopen.com/images/20150830/tooopen_sy_140703593676.jpg";
        model.title = [NSString stringWithFormat:@"标签%d",i];
        [array addObject:model];
    }
    return array;
}

#pragma mark - KSCollectionScrollViewDelegate
- (void)collectionScrollItemView:(KSCollectionScrollView *)collectionItemView didSelectItemAtIndexPath:(NSIndexPath *)indexPath selectPage:(NSInteger)page
{
    NSLog(@"%@,page:%ld\n,第%ld个",indexPath,(long)page,(long)(page*_itemCollectionScrollView.sectionItemNum * _itemCollectionScrollView.numOfSection + (indexPath.row+(indexPath.section * _itemCollectionScrollView.sectionItemNum))));
}
@end
