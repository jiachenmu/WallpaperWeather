//
//  ViewController.m
//  KaiYuanJieKou
//
//  Created by jiachen on 16/4/18.
//  Copyright © 2016年 jiachenmu. All rights reserved.
//

#import "ViewController.h"
#import "CMNetworkManager.h"
#import "CityModel.h"
#import "WaveButton.h"


@interface ViewController ()

@property (nonatomic,strong) UIButton *testButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor redColor];
    
    [self setupAnimationOperationBtn];
    
    
    NSString *cityName = @"北京";
    __weak typeof(self) weakSelf = self;
    [CMNetworkManager requestDataWithCityName:cityName Complete:^(id obj) {
        CityData *data = (CityData *)obj;
        NSLog(@"有%ld个城市叫做 %@",data.cityList.count,cityName);
        [data.cityList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CityModel *city = (CityModel *)obj;
            NSLog(@"城市ID： %@",city.area_id);
            if (idx == 0) {
                [weakSelf requestWeatherDataWithCityID:city.area_id];
            }
            
        }];
    }];
    
//    NSLog(@"%@",[self operationString:@"12345678910" insertIndex:4]);
}

- (void)setupAnimationOperationBtn{
    _testButton = [[WaveButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2,64 ,64)];
    _testButton.backgroundColor = [UIColor blackColor];
    [_testButton setImage:[UIImage imageNamed:@"Circle"] forState:UIControlStateNormal];
    [self.view addSubview:_testButton];

}
- (void)setUpNullDataView{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestWeatherDataWithCityID:(NSString *)cityID{
    
    [CMNetworkManager requestDataWithCityID:cityID Complete:^(WeatherData *data){
        NSLog(@"请求数据成功");
        if (data != nil) {
            NSLog(@"城市ID：%@",data.cityID);
            NSLog(@"城市名称： %@",data.cityName);
            
            NSLog(@"当前温度:  %@",data.today.curTemp);
            NSLog(@"今天天气提醒： %@",( (TipModel *) ( data.today.index[0]) ).details );
            
            NSLog(@"预测天气日期： %@", ( (WeatherModel *)(data.forecastArray[0]) ).date);
            NSLog(@"预测天气类型： %@", ( (WeatherModel *)(data.forecastArray[0]) ).type);
            
            NSLog(@"历史天气日期： %@", ( (WeatherModel *)(data.historyArray[0]) ).date);
        }
    }];
}

- (NSString *)operationString:(NSString *)str insertIndex:(NSInteger) index{
    NSMutableString *result = [[NSMutableString alloc] initWithString:str];
   
    while (index < str.length) {
        [result insertString:@" " atIndex:index];
        index += index + 1;
    }
    return result;
}
@end
