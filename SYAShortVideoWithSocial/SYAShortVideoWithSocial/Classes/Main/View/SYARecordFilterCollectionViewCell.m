//
//  SYARecordFilterCollectionViewCell.m
//  SYAShortVideoWithSocial
//
//  Created by 乐家 on 2017/11/16.
//  Copyright © 2017年 lejiakeji. All rights reserved.
//

#import "SYARecordFilterCollectionViewCell.h"
@interface SYARecordFilterCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIView *backSelectedView;
@property (weak, nonatomic) IBOutlet UIImageView *filterImageView;
@property (weak, nonatomic) IBOutlet UILabel *filterLabel;

@end

@implementation SYARecordFilterCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setFilterModel:(SYARecordFilterModel *)filterModel {
    _filterModel = filterModel;
    self.filterLabel.text = filterModel.filterName;
    self.filterImageView.image = [UIImage imageWithContentsOfFile:filterModel.imageName];
    if (filterModel.isSelected) {
        self.backSelectedView.backgroundColor = [UIColor redColor];
    } else {
        self.backSelectedView.backgroundColor = [UIColor whiteColor];
    }
}

@end
