//
//  CMNetworkManager.h
//  KaiYuanJieKou
//
//  Created by jiachen on 16/4/18.
//  Copyright © 2016年 jiachenmu. All rights reserved.
//  网络管理

#import <Foundation/Foundation.h>
#import "WeatherData.h"

typedef void(^CompleteBlock)(id obj);

@interface CMNetworkManager : NSObject

/**
 *  根据城市编码获取天气信息
 *
 *  @param cityID 城市编码id
 */
+ (void)requestDataWithCityID:(NSString *)cityID Complete:(CompleteBlock)completeBlock;


+ (void)requestDataWithCityName:(NSString *)cityName Complete:(CompleteBlock)completeBlock;
@end
