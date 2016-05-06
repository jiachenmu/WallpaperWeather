//
//  CMNetworkManager.m
//  KaiYuanJieKou

//  Created by jiachen on 16/4/18.
//  Copyright © 2016年 jiachenmu. All rights reserved.
//

#import "CMNetworkManager.h"
#import "WeatherData.h"
#import "CityModel.h"
#import "TipModel.h"



#define BaiduApiKey      @"f53935739bddf08263e13b7c85d45869"
#define BaiduWeatherHttp @"http://apis.baidu.com/apistore/weatherservice/recentweathers"
#define BaiduWeatherCityListHttp @"http://apis.baidu.com/apistore/weatherservice/citylist"


@implementation CMNetworkManager


+ (void)requestDataWithCityID:(NSString *)cityID Complete:(CompleteBlock)completeBlock{
    NSString *httpArg = [NSString stringWithFormat:@"cityname=?&cityid=%@",cityID];
    NSString *urlStr = [NSString stringWithFormat:@"%@?%@",BaiduWeatherHttp,httpArg];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"GET"];
    [request addValue:BaiduApiKey forHTTPHeaderField:@"apikey"];
    
    // - MARK: NSURLSession方法
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
        } else {
            NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

            //解析json
            WeatherData *data = [WeatherData initWithString:responseString];
            
            if (completeBlock != nil) {
                completeBlock(data);
            }
            
        }
    }];
    [task resume];
}

//根据城市名称 查询 cityID
+ (void)requestDataWithCityName:(NSString *)cityName Complete:(CompleteBlock)completeBlock{
    NSString *httpArg = [NSString stringWithFormat:@"cityname=%@",cityName];
    NSString *urlStr = [NSString stringWithFormat:@"%@?%@",BaiduWeatherCityListHttp,httpArg];
    //此处 城市名称为中文 需要先将中文转换成utf-8编码
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"GET"];
    [request addValue:BaiduApiKey forHTTPHeaderField:@"apikey"];
    
    // - MARK: NSURLSession方法
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Httperror: %@    %ld", error.localizedDescription, error.code);
        } else {
            NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            //解析json
            CityData *data = [CityData initWithString:responseString];
            
            if (completeBlock != nil) {
                completeBlock(data);
            }
            
        }
    }];
    [task resume];
}

#pragma mark - 类方法 请求数据
//+ (void)requestWeatherDataWithCityID:(NSString)cityID Complete:(CompleteBlock)completeBlock{
////    [CMNetworkManager requestDataWithCityID:cityID Complete:completeBlock];
//}



@end
