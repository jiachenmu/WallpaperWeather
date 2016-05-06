//
//  CityManager.h
//  KaiYuanJieKou
//
//  Created by jiachen on 16/4/25.
//  Copyright © 2016年 jiachenmu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CityModel;
@interface CityManager : NSObject

+ (instancetype)shareInstance;

- (BOOL)isExistHasSelectedCity;

- (void)setUpHotCityList;
- (NSArray *)HotCityList;

// - MARK:存储选定的城市
- (void)saveCity:(CityModel *)model;

// - MARK: 返回已经选定的城市
- (NSArray *)savedCityList;
@end
