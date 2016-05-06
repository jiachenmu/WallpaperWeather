//
//  SettingTableViewCell.h
//  KaiYuanJieKou
//
//  Created by jiachen on 16/5/5.
//  Copyright © 2016年 jiachenmu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DeleteCityBlock)(NSString *);
@interface SettingTableViewCell : UITableViewCell


+ (instancetype)cellWithTableView:(UITableView *)tableView CityModel:(CityModel *)city;

@property (nonatomic,copy) DeleteCityBlock deleteCityBlock;

@end
