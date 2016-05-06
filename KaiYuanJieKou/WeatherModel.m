//
//  TodayWeatherModel.m
//  KaiYuanJieKou
//
//  Created by jiachen on 16/4/18.
//  Copyright © 2016年 jiachenmu. All rights reserved.
//

#import "WeatherModel.h"

@implementation WeatherModel

+ (instancetype)toWeatherModelWithData:(id)obj{
    WeatherModel *model = [[WeatherModel alloc] init];
    
    NSDictionary *dict = [obj mj_keyValues];
    
    model = [WeatherModel mj_objectWithKeyValues:dict];
    
    return model;
    
}

@end


@implementation TodayWeatherModel

+ (void)setup{
    [TodayWeatherModel mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"index" : @"TipModel",
                 };
    }];
}

@end
