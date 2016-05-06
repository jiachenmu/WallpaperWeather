//
//  SelectAddressController.m
//  KaiYuanJieKou
//
//  Created by jiachen on 16/4/25.
//  Copyright © 2016年 jiachenmu. All rights reserved.
//

#import "SelectAddressController.h"

#import "CityModel.h"
#import "SelectAddressCell.h"

@interface SelectAddressController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

/// 热门城市列表
@property (nonatomic,strong) NSArray *hotCityList;
/// 查询的城市列表
@property (nonatomic,strong) NSMutableArray *searchCityList;

@end

@implementation SelectAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self setUpHotCityList];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpHotCityList{
    _hotCityList = [[CityManager shareInstance] HotCityList];
    _searchCityList = [NSMutableArray array];
}

// -MARK: UITableViewDelegate  UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return section == 0 ? _hotCityList.count : _searchCityList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CityModel *model = indexPath.section == 0 ? _hotCityList[indexPath.row] : _searchCityList[indexPath.row];
    SelectAddressCell *cell = [SelectAddressCell cellWithUITableView:tableView CityModel:model];
    
    return cell;
}
    //朝阳
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = section == 0 ? @"  热门城市" : @"  搜索结果";
    titleLabel.font = DefaultFont(14);
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor colorWithHex:0x34495e];
    return titleLabel;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CityModel *model = indexPath.section == 0 ? _hotCityList[indexPath.row] : _searchCityList[indexPath.row];
    
    [[CityManager shareInstance] saveCity:model];
}

// -MARK: UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"您搜索的城市/地区为： %@",searchBar.text);
    [MBProgressHUD showHUDAddedTo:self.view animated:true];
    WeakSelf;
    [CMNetworkManager requestDataWithCityName:searchBar.text Complete:^(id obj) {
        CityData *cityData = (CityData *)obj;
        if (cityData.cityList == nil || cityData.cityList.count == 0) {
            [TipView showTitle:@"未找到该城市"];
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.searchCityList = cityData.cityList;
                [weakSelf.tableView reloadData];
            });
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:weakSelf.view animated:true];
        });
        
    }];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}

#pragma mark - 返回
- (IBAction)backToFront:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

@end
