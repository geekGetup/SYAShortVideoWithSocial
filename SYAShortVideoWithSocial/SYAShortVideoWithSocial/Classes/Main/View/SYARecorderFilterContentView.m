//
//  SYARecorderFilterContentView.m
//  SYAShortVideoWithSocial
//
//  Created by 乐家 on 2017/11/16.
//  Copyright © 2017年 lejiakeji. All rights reserved.
//

#import "SYARecorderFilterContentView.h"
#import "SYARecordFilterCollectionViewCell.h"
@interface SYARecorderFilterContentView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, weak) UICollectionView *filterCollectionView;
@end

@implementation SYARecorderFilterContentView
static NSString *cellID = @"cellID";
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        UIView *topContentView = [[UIView alloc] init];
        [self addSubview:topContentView];
        topContentView.frame = CGRectMake(0, 0, frame.size.width, 60);
        UILabel *titleLabel = [[UILabel alloc] init];
        [topContentView addSubview:titleLabel];
        titleLabel.text = @"滤镜";
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.textColor = [UIColor whiteColor];
        [titleLabel sizeToFit];
        titleLabel.frame = CGRectMake((topContentView.lj_width - titleLabel.lj_width)*0.5, 20, titleLabel.lj_width, 20);
        UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:sureBtn];
        sureBtn.frame = CGRectMake(topContentView.lj_width - 30 - 70, 15, 70, 30);
        sureBtn.backgroundColor = [UIColor redColor];
        sureBtn.layer.cornerRadius = 3;
        sureBtn.layer.masksToBounds = YES;
        [sureBtn setImage:[UIImage imageNamed:@"recorderSure"] forState:UIControlStateNormal];
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(56, 71);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 0;
        UICollectionView *filterCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 60, frame.size.width, frame.size.height-60) collectionViewLayout:flowLayout];
        [self addSubview:filterCollectionView];
        self.filterCollectionView = filterCollectionView;
        filterCollectionView.delegate = self;
        filterCollectionView.dataSource = self;
        [filterCollectionView registerNib:[UINib nibWithNibName:@"SYARecordFilterCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellID];
        filterCollectionView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setFilterModelArray:(NSMutableArray<SYARecordFilterModel *> *)filterModelArray {
    _filterModelArray = filterModelArray;
    [self.filterCollectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.filterModelArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SYARecordFilterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.filterModel = self.filterModelArray[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    SYARecordFilterModel *currentModel = self.filterModelArray[indexPath.item];
    for (SYARecordFilterModel *model in self.filterModelArray) {
        if (model == currentModel) {
            model.isSelected = 1;
        } else {
            model.isSelected = 0;
        }
    }
    [self.filterCollectionView reloadData];
    // 滤镜
    self.filterGroup.filterIndex = indexPath.row;
}

@end
