//
//  WeatherDetailCollectionViewCell.m
//  KaiYuanJieKou
//
//  Created by jiachen on 16/5/4.
//  Copyright © 2016年 jiachenmu. All rights reserved.
//

/*这里有个小问题 tableviewCell复用时  很好解决 只需要判断 是否从重用队列中取到的cell是否为空 即可判断是不是需要创建子控件
 -但是collectionViewCell 在colelctionView注册过cell以后 从重用队列中取到的cell不可能为空，所以还需要手动判断

*/
#import "WeatherDetailCollectionViewCell.h"

@interface WeatherDetailCollectionViewCell()



@end

@implementation WeatherDetailCollectionViewCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView  indexPath:(NSIndexPath *)indexPath tableviewDelegateDataSource:(WeatherDetailView *)detalView WeatherModel:(WeatherModel *)model {
    WeatherDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:WeatherDetailCollectionViewCellID forIndexPath:indexPath];
    
    
    //这里collectionView 复用的问题,不能每次都添加一个tableView吧 那样就没有复用😂
    BOOL isExistTableView = false;
    for (UIView *view in cell.contentView.subviews) {
        if ([view isKindOfClass:[UITableView class]]) {
            isExistTableView = true;
        }
    }
    if (!isExistTableView) {
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.showTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, cell.bounds.size.width, cell.bounds.size.height) style:UITableViewStylePlain];
        cell.showTableView.backgroundColor = [UIColor clearColor];
        cell.showTableView.delegate = (id<UITableViewDelegate>)detalView;
        cell.showTableView.dataSource = (id<UITableViewDataSource>)detalView;
        cell.showTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [cell.contentView addSubview:cell.showTableView];
    }
    
    [cell.showTableView reloadData];
    return cell;
}
@end
