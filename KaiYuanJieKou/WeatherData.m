//
//  WeatherModel.m
//  KaiYuanJieKou
//
//  Created by jiachen on 16/4/18.
//  Copyright © 2016年 jiachenmu. All rights reserved.
//

#import "WeatherData.h"
#import "WeatherModel.h"

@implementation WeatherData


+ (instancetype)initWithString:(NSString *)jsonString{
    
    [WeatherData mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"cityName" : @"retData.city",
                 @"cityID" : @"retData.cityid",
                 @"today" : @"retData.today",
                 @"forecastArray" : @"retData.forecast",
                 @"historyArray" : @"retData.history",
                 };
    }];
    
    [WeatherData mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"forecastArray" : @"WeatherModel",
                 @"historyArray" : @"WeatherModel",
                 };
    }];
    
    [TodayWeatherModel setup];
    WeatherData *weatherData = [[WeatherData alloc] init];
    weatherData.forecastArray = [NSMutableArray array];
    weatherData.historyArray = [NSMutableArray array];
    weatherData = [WeatherData mj_objectWithKeyValues:jsonString];
  

    return weatherData;
}

@end
