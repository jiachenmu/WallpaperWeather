//
//  UIImage+ReturnWeatherImage.m
//  KaiYuanJieKou
//
//  Created by jiachen on 16/5/3.
//  Copyright © 2016年 jiachenmu. All rights reserved.
//

#import "UIImage+ReturnWeatherImage.h"

@implementation UIImage (ReturnWeatherImage)


+ (instancetype)returnImageWithWeatherType:(NSString *)type{

    NSString *weatherImagNamed = @"";

    if ([type containsString:@"雨"]) {
        weatherImagNamed = @"Rain";
 
        if ([type containsString:@"雪"]) {
            //😄『雨夹雪』。。。
            weatherImagNamed = @"RainAndSnow";
        }else if ([type containsString:@"雷"]){
            //😄『雷阵雨』。。。
            weatherImagNamed = @"Thundershower";
        }
    }else if ([type containsString:@"晴"]){
        weatherImagNamed = @"Fine";
    }else if ([type containsString:@"阴"]){
        weatherImagNamed = @"Overcast";
    }else if ([type containsString:@"多云"]){
        weatherImagNamed = @"Cloudy";
    }else if ([type containsString:@"雪"]){
        weatherImagNamed = @"Snow";
    }else if ([type containsString:@"霾"]){
        weatherImagNamed = @"Haze";
    }else if ([type containsString:@"尘"] || [type containsString:@"沙"]){
        weatherImagNamed = @"Dusts";
    }

    return [UIImage imageNamed:weatherImagNamed];
}

@end
