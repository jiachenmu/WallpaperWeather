//
//  CityManager.m
//  KaiYuanJieKou
//
//  Created by jiachen on 16/4/25.
//  Copyright © 2016年 jiachenmu. All rights reserved.
//

#import "CityManager.h"


@interface CityManager()

@property (nonatomic,strong) NSMutableArray *hotCityList;

@end

@implementation CityManager


static CityManager *manager;

+ (instancetype)shareInstance{
    @synchronized(self) {
        if (!manager) {
            manager = [[CityManager alloc] init];
            manager.hotCityList = [NSMutableArray arrayWithCapacity:8];
        }
        return manager;
    }
}

/// 用户是否有选择的城市
- (BOOL)isExistHasSelectedCity{
    NSArray *cityList = (NSArray *)[[NSUserDefaults standardUserDefaults] objectForKey:UserSelectedCityListKey];
    if (cityList != nil && cityList.count > 0) {
        return true;
    }
    
    return false;
}

// - MARK: 用户第一次启动的时候 会执行这个方法 配置热门城市列表
- (void)setUpHotCityList{
    
    NSMutableArray *dataArr = [NSMutableArray arrayWithCapacity:8];
    NSArray *cityNameArr = [NSArray arrayWithObjects:@"北京",@"上海",@"西安",@"广州",@"深圳",@"南京",@"太原",@"杭州", nil];
    NSArray *cityIDArr = [NSArray arrayWithObjects:@"101010100",@"101020100",@"101110101",@"101280101",@"101280601",@"101190101",@"101100101" ,@"101210101",nil];
    
    if (_hotCityList == nil || _hotCityList.count == 0) {
        for (int i = 0; i < cityNameArr.count; i++) {
            CityModel *model = [[CityModel alloc] init];
            model.province_cn = @"";
            model.name_cn = @"";
            model.name_en = @"";
            model.district_cn = cityNameArr[i];
            model.area_id = cityIDArr[i];
            
            //这里 无法直接将自定义对象 用userDefaults存储，所以先转为NSData
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
            
            [dataArr addObject:data];
        }
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:dataArr forKey:HotCityListKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// - MARK:返回热门城市列表
- (NSArray *)HotCityList{
    if (_hotCityList == nil || _hotCityList.count == 0) {
        NSArray *dataArr = [[NSUserDefaults standardUserDefaults] objectForKey:HotCityListKey];
        WeakSelf;
        [dataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CityModel *model = [[CityModel alloc] init];
            model = [NSKeyedUnarchiver unarchiveObjectWithData:obj];
            [weakSelf.hotCityList  addObject:model];
        }];
    }

    return _hotCityList;
}

// - MARK:存储选定的城市
- (void)saveCity:(CityModel *)model{
    NSLog(@"城市ID：%@",model.area_id);
    //1.先查看是否已经保存过该城市
//    NSMutableArray *dataArr = [[NSMutableArray alloc] initWithCapacity:10];
    NSMutableArray *dataArr = [[NSUserDefaults standardUserDefaults] objectForKey:UserSelectedCityListKey];
    
    __block BOOL isHasSaved = false;
    if (dataArr && dataArr.count > 0) {
        [dataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CityModel *city = [NSKeyedUnarchiver unarchiveObjectWithData:obj];
            if ([city.area_id isEqualToString:model.area_id]) {
                [TipView showTitle:@"大神，您已经保存过该城市😅"];
                isHasSaved = true;
                *stop = true;
            }
        }];
    }
    //朝阳
    //如果没有保存过该城市
    if (!isHasSaved) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
        if (dataArr.count == 0) {
            NSMutableArray *arr = [NSMutableArray arrayWithCapacity:1];
             [[NSUserDefaults standardUserDefaults] setObject:arr forKey:UserSelectedCityListKey];
        }
        NSMutableArray *arr = [NSMutableArray array];
        [arr addObjectsFromArray:dataArr];
        [arr addObject:data];
        [[NSUserDefaults standardUserDefaults] setObject:arr forKey:UserSelectedCityListKey];
        [TipView showTitle:@"保存成功😄"];
    }
}

// -MARK: 返回已经选定的城市
- (NSArray *)savedCityList{
    NSArray *arr = [[NSUserDefaults standardUserDefaults] objectForKey:UserSelectedCityListKey];
    if (arr && arr.count > 0 ) {
        NSMutableArray *cityList = [NSMutableArray array];
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           //解析城市数据
            CityModel *city= (CityModel *)[NSKeyedUnarchiver unarchiveObjectWithData:obj];
            [cityList addObject:city];
        }];
        return cityList;
    }
    return nil;
}
@end
