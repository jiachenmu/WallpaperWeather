//
//  WeatherModel.h
//  KaiYuanJieKou
//
//  Created by jiachen on 16/4/18.
//  Copyright © 2016年 jiachenmu. All rights reserved.
//
#import <Foundation/Foundation.h>

#import "WeatherModel.h"


@interface WeatherData : NSObject

/// 城市名称
@property (nonatomic,strong) NSString          *cityName;
/// 城市ID
@property (nonatomic,strong) NSString          *cityID;

/// 今日天气
@property (nonatomic,strong) TodayWeatherModel *today;

/////// 预测天气
@property (nonatomic,strong) NSMutableArray    *forecastArray;
////
/////// 历史数据
@property (nonatomic,strong) NSMutableArray           *historyArray;


+ (instancetype)initWithString:(NSString *)jsonString;
@end
