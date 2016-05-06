//
//  SettingTableViewCell.m
//  KaiYuanJieKou
//
//  Created by jiachen on 16/5/5.
//  Copyright © 2016年 jiachenmu. All rights reserved.
//

#define SettingTableViewCellID @"SettingTableViewCellID"
#import "SettingTableViewCell.h"
#import <QuartzCore/QuartzCore.h>

@interface SettingTableViewCell()

@property (nonatomic,strong) CityModel *city;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;


// - MARK: Animation
@property (nonatomic,strong) CABasicAnimation *anim1;
@property (nonatomic,strong) CABasicAnimation *anim2;
@property (nonatomic,strong) CABasicAnimation *anim3;

@end

@implementation SettingTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// - Animation 懒加载
- (CABasicAnimation *)anim1 {
    if (!_anim1) {
        _anim1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        [_anim1 setDelegate:self];
        [_anim1 setFromValue:@0];
        [_anim1 setToValue:@ (2 * M_PI)];
        [_anim1 setDuration:1.0];
        [_anim1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    }
    return _anim1;
}

- (CABasicAnimation *)anim2 {
    if (!_anim2) {
        _anim2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        [_anim2 setDelegate:self];
        [_anim2 setFromValue:@0];
        [_anim2 setToValue:@ (2 * M_PI)];
        [_anim2 setDuration:1.0];
        
        [_anim2 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    }
    return _anim2;
}

- (CABasicAnimation *)anim3 {
    if (!_anim3) {
        _anim3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        [_anim3 setDelegate:self];
        [_anim3 setFromValue:@0];
        [_anim3 setToValue:@ (2 * M_PI)];
        [_anim3 setDuration:1.0];
        [_anim3 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    }
    return _anim3;
}

- (IBAction)deleteThisCity:(id)sender {

    if (_deleteCityBlock != nil) {
        
        //让按钮疯狂的转吧
        [_deleteBtn.layer addAnimation:self.anim1 forKey:nil];
    
        
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (anim == _anim1) {
        [_deleteBtn.layer addAnimation:self.anim2 forKey:nil];
    }else if (anim == _anim2) {
        [_deleteBtn.layer addAnimation:self.anim3 forKey:nil];
    }else{
        NSLog(@"动画执行完毕");
        [_deleteBtn.layer removeAllAnimations];
        _deleteCityBlock(_city.area_id);
    }
}

// - MARK: 更新UI
- (void)setCity:(CityModel *)city {
    _city = city;
    
    NSMutableString *str = [NSMutableString string];
    if (_city.province_cn && _city.province_cn.length > 0) {
        [str appendString:_city.province_cn];
    }
    if (_city.district_cn && _city.district_cn.length > 0) {
        [str appendFormat:@" %@",_city.district_cn];
    }
    
    if (_city.name_cn && _city.name_cn.length > 0 ) {
        [str appendFormat:@" %@",_city.name_cn];
    }
    _titleLabel.text = str;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView CityModel:(CityModel *)city {
    SettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SettingTableViewCellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SettingTableViewCell" owner:nil options:nil] lastObject];
    }
    cell.city = city;
    
    return cell;
}
@end
