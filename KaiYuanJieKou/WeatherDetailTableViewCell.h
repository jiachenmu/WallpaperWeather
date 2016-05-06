//
//  WeatherDetailTableViewCell.h
//  KaiYuanJieKou
//
//  Created by jiachen on 16/5/4.
//  Copyright © 2016年 jiachenmu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherDetailTableViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView WeatherModel:(id)model;

@property (nonatomic,assign) BOOL isToday;
@property (nonatomic,strong) NSIndexPath *indexPath;
@end
