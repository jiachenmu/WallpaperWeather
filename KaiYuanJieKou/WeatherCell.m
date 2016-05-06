//
//  WeatherCell.m
//  KaiYuanJieKou
//
//  Created by jiachen on 16/4/26.
//  Copyright © 2016年 jiachenmu. All rights reserved.
//  襄汾

#import "WeatherCell.h"
#import "UIImage+ReturnWeatherImage.h"

#define kAutoChangeModeInterval 3.0

@interface WeatherCell()

@property (weak, nonatomic) IBOutlet UIImageView *weatherTypeImgView;

@property (weak, nonatomic) IBOutlet UILabel *curTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *districtNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *weatherTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *HighOrLowTempLabel;

@end

@implementation WeatherCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setupWeatherTypeImage:(NSString *)weatherType{
    self.contentView.backgroundColor = [UIColor colorWithHex:0x707070 alpha:0.0];
    //Tips:因为返回的天气状况字段  只有中文 没有code，所以只能这样做了
    _weatherTypeImgView.image = [UIImage returnImageWithWeatherType:weatherType];
}

+ (instancetype)cellWithTableview:(UITableView *)tableView WeatherData:(WeatherData *)data{
    static NSString *cellID = @"WeatherCellIdentifier";
    WeatherCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WeatherCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    //1.根据天气类型更改 imgView图片
    [cell setupWeatherTypeImage:data.today.type];
    //2.更新天气显示数据
    cell.curTempLabel.text = data.today.curTemp;
    cell.districtNameLabel.text = data.cityName;
    cell.weatherTypeLabel.text = data.today.type;
    cell.HighOrLowTempLabel.text = [NSString stringWithFormat:@"Max.%@ - Min.%@",data.today.hightemp,data.today.lowtemp];

    return cell;
}
@end
