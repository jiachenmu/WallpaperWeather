//
//  CityModel.h
//  KaiYuanJieKou
//
//  Created by jiachen on 16/4/22.
//  Copyright © 2016年 jiachenmu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityModel : NSObject<NSCoding>

/// 省
@property (nonatomic,strong) NSString  *province_cn;
/// 市
@property (nonatomic,strong) NSString *district_cn;
/// 区、县
@property (nonatomic,strong) NSString *name_cn;
/// 城市拼音
@property (nonatomic,strong) NSString *name_en;
/// 城市编码
@property (nonatomic,strong) NSString *area_id;
@end


@interface CityData : NSObject

@property (nonatomic,strong) NSMutableArray *cityList;

+ (CityData *)initWithString:(NSString *)jsonString;

@end