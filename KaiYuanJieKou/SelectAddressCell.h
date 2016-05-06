//
//  SelectAddressCell.h
//  KaiYuanJieKou
//
//  Created by jiachen on 16/4/25.
//  Copyright © 2016年 jiachenmu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityModel.h"

@interface SelectAddressCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

+ (instancetype)cellWithUITableView:(UITableView *)tableView CityModel:(CityModel *)model;

@end
