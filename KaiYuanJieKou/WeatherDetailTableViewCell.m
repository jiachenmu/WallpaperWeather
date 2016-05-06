//
//  WeatherDetailTableViewCell.m
//  KaiYuanJieKou
//
//  Created by jiachen on 16/5/4.
//  Copyright © 2016年 jiachenmu. All rights reserved.
//

#import "WeatherDetailTableViewCell.h"
#import "UIImage+ReturnWeatherImage.h"

#define WeatherDetailTitleArr [NSArray arrayWithObjects:@"天气状况：",@"风向：",@"风力：",@"", nil]
//对应的图片
#define WeatherDetailImageArr [NSArray arrayWithObjects:@"",@"WindDirection",@"WindForce",@"TempChange", nil]


@interface WeatherDetailTableViewCell ()

@property (nonatomic,strong) id model;

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation WeatherDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView WeatherModel:(id)model{

    WeatherDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WeatherDetailTableViewCellID"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([WeatherDetailTableViewCell class]) owner:nil options:nil] lastObject];
    }
    
    cell.model = model;
    
    return cell;
}


//更新数据

- (void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
    UIImage *img;
    NSString *str;

    if (indexPath.section == 0) {
        WeatherModel *model = _model;
        NSString *args;
        switch (indexPath.row) {
            case 0:
                args = model.type;
                img = [UIImage returnImageWithWeatherType:model.type];
                break;
            case 1:
                args = model.fengxiang;
                break;
            case 2:
                args = model.fengli;
                break;
            case 3:
                args = [NSString stringWithFormat:@"最高温：%@ 最低温：%@",model.hightemp,model.lowtemp];
                break;
            default:
                break;
        }
        str = [NSString stringWithFormat:@"%@%@",WeatherDetailTitleArr[indexPath.row],args];
        img = indexPath.row == 0 ? [UIImage returnImageWithWeatherType:model.type] : [UIImage imageNamed:WeatherDetailImageArr[indexPath.row]];
    }else {
        TipModel *tip = _model;
        str = [NSString stringWithFormat:@"%@：%@",tip.name,(!tip.index || tip.index.length == 0 ) ? @"暂无" : tip.index];
        img = [UIImage imageNamed:tip.name];
    }
    
    _iconView.image = img;
    _titleLabel.text = str;
}
@end
