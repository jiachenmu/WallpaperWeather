//
//  WeatherDetailCollectionViewCell.h
//  KaiYuanJieKou
//
//  Created by jiachen on 16/5/4.
//  Copyright © 2016年 jiachenmu. All rights reserved.
//

#import <UIKit/UIKit.h>
#define WeatherDetailCollectionViewCellID   @"WeatherDetailCollectionViewCellID"
@class WeatherDetailView;

@interface WeatherDetailCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) UITableView *showTableView;

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView  indexPath:(NSIndexPath *)indexPath tableviewDelegateDataSource:(WeatherDetailView *)detalView WeatherModel:(WeatherModel *)model;
@end
