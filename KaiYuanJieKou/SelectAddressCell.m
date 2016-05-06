//
//  SelectAddressCell.m
//  KaiYuanJieKou
//
//  Created by jiachen on 16/4/25.
//  Copyright © 2016年 jiachenmu. All rights reserved.
//

#import "SelectAddressCell.h"

@implementation SelectAddressCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//朝阳

+ (instancetype)cellWithUITableView:(UITableView *)tableView CityModel:(CityModel *)model{
    NSString *cellID = @"SelectAddressCellID";
    SelectAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        NSArray *nibArr = [[NSBundle mainBundle] loadNibNamed:@"SelectAddressCell" owner:nil options:nil];
        cell = [nibArr lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSMutableString *str = [NSMutableString string];
    if (model.province_cn && model.province_cn.length > 0) {
        [str appendString:model.province_cn];
    }
    if (model.district_cn && model.district_cn.length > 0) {
        [str appendFormat:@" %@",model.district_cn];
    }
    
    if (model.name_cn && model.name_cn.length > 0 ) {
        [str appendFormat:@" %@",model.name_cn];
    }
    
    cell.titleLabel.text = str;
    
    return cell;
}

@end
