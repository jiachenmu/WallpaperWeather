//
//  TodayWeatherModel.h
//  KaiYuanJieKou
//
//  Created by jiachen on 16/4/18.
//  Copyright © 2016年 jiachenmu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TipModel.h"

@protocol WeatherModel
@end

@interface WeatherModel : NSObject

/// 日期
@property (nonatomic,strong) NSString *date;
/// 星期
@property (nonatomic,strong) NSString *week;

/// 风向
@property (nonatomic,strong) NSString *fengxiang;
/// 风力
@property (nonatomic,strong) NSString *fengli;
/// 最高温
@property (nonatomic,strong) NSString *hightemp;
/// 最低温
@property (nonatomic,strong) NSString *lowtemp;
/// 天气类型
@property (nonatomic,strong) NSString *type;

+ (instancetype)toWeatherModelWithData:(id)obj;

@end


//今日天气模型
@interface TodayWeatherModel : WeatherModel

/// 当前温度
@property (nonatomic,strong) NSString *curTemp;

//其实天气提示  感冒指数 等等
@property (nonatomic,strong) NSArray  *index;

+ (void)setup;

@end