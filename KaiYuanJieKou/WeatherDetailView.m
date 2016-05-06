//
//  WeatherDeatailView.m
//  KaiYuanJieKou
//
//  Created by jiachen on 16/4/28.
//  Copyright © 2016年 jiachenmu. All rights reserved.
//  点击首页中的城市 即可显示出 天气的详细数据  包括 预测天气 和 历史天气等  ，其中 '今日天气' 包括 '感冒指数' 、 '提示文字'等

#import "WeatherDetailView.h"
#import "WeatherDetailCollectionViewCell.h"
#import "WeatherDetailTableViewCell.h"

@interface WeatherDetailView()<UICollectionViewDataSource,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,
UITableViewDataSource,UITableViewDelegate>

/// 城市姓名
@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;

/// 当前温度
@property (weak, nonatomic) IBOutlet UILabel *curTempLabel;

/// 天气对应的时间
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

/// 底下天气状况展示
// - 容器
@property (weak, nonatomic) IBOutlet UICollectionView *showCollectionView;


/// 天气列表包括 历史天气、今日天气、预测天气
@property (nonatomic,strong) NSMutableArray *weatherList;
@property (nonatomic,strong) TodayWeatherModel *todayModel;

@property (nonatomic,assign) NSInteger currentIndex;
@property (nonatomic,assign) NSInteger todayIndex;

@end

@implementation WeatherDetailView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (void)showWithWeatherData:(WeatherData *)data{
    WeatherDetailView *detailView = [[[NSBundle mainBundle] loadNibNamed:@"WeatherDetailView" owner:nil options:nil] lastObject];
    detailView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    detailView.weatherList = [NSMutableArray array];
    [detailView.weatherList addObjectsFromArray:data.historyArray];
    detailView.todayIndex = data.historyArray.count;
 
    [detailView.weatherList addObject:data.today];
    detailView.todayModel = data.today;
    [detailView.weatherList addObjectsFromArray:data.forecastArray];
    
    [detailView buildUIWithWeatherData:data];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:detailView];
    
    [UIView animateWithDuration:0.4 animations:^{
        detailView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }];
}

- (void)buildUIWithWeatherData:(WeatherData *)data{
    _cityNameLabel.text = data.cityName;
    _curTempLabel.text = [NSString stringWithFormat:@"当前温度：%@",data.today.curTemp];
    _currentIndex = 0 ;
    
    _showCollectionView.delegate = self;
    _showCollectionView.dataSource = self;
    _showCollectionView.contentSize = CGSizeMake(_showCollectionView.bounds.size.width * _weatherList.count, 0);
    [_showCollectionView registerClass:[WeatherDetailCollectionViewCell class] forCellWithReuseIdentifier:WeatherDetailCollectionViewCellID];

    WeatherModel *model = [_weatherList objectAtIndex:0];
    _timeLabel.text = [NSString stringWithFormat:@"%@  %@",model.date,model.week];
}

#pragma mark - UITableViewDelegate DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _currentIndex == _todayIndex ? 2 : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //天气模型中包括 天气类型、风向、风力、最高温+最低温
    //今日天气 模型中含有 诸如 感冒指数、提示文字等 所以特殊处理
    
    return section == 1 ?  _todayModel.index.count : 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    id model;
    if (indexPath.section == 0) {
        model = [_weatherList objectAtIndex:_currentIndex];
    }else{
        model = [_todayModel.index objectAtIndex:indexPath.row];
    }
    
    WeatherDetailTableViewCell *cell = [WeatherDetailTableViewCell cellWithTableView:tableView WeatherModel:model];
    cell.indexPath = indexPath;
    return cell;
}

//
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

#pragma mark - UICollectionViewDelegate DataSource FlowLayout
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _weatherList.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WeatherModel *model = [_weatherList objectAtIndex:indexPath.section];
    WeatherDetailCollectionViewCell *cell = [WeatherDetailCollectionViewCell cellWithCollectionView:collectionView indexPath:indexPath tableviewDelegateDataSource:self WeatherModel:model];

    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return _showCollectionView.bounds.size;
}

//结束滚动的时候 更改天气对应的时间
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _currentIndex = (NSInteger)(_showCollectionView.contentOffset.x / _showCollectionView.bounds.size.width);
    if (scrollView == _showCollectionView) {
        WeatherModel *model = [_weatherList objectAtIndex:_currentIndex];
        _timeLabel.text = [NSString stringWithFormat:@"%@  %@",model.date,model.week];
        _timeLabel.textColor = _currentIndex == _todayIndex ? [UIColor colorWithHex:0x56ABE4] : [UIColor whiteColor];
        [_showCollectionView reloadData];
    }
}
// - MARK: 事件处理
- (IBAction)return:(id)sender {
    [self removeFromSuperview];
}



@end
