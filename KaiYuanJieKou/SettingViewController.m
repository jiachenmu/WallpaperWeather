//
//  SettingViewController.m
//  KaiYuanJieKou
//
//  Created by jiachen on 16/5/5.
//  Copyright © 2016年 jiachenmu. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingTableViewCell.h"
#import "SelectAddressController.h"

@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray *cityList;

@property (weak, nonatomic) IBOutlet UITableView *showTableView;

@property (weak, nonatomic) IBOutlet UIButton *addCityBtn;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _cityList = [[NSMutableArray alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _cityList = (NSMutableArray *)[[CityManager shareInstance] savedCityList];
    [_showTableView reloadData];
    if ([[CityManager shareInstance] isExistHasSelectedCity]) {
        _showTableView.hidden = false;
        _addCityBtn.hidden = true;
    }else {
        _showTableView.hidden = true;
        _addCityBtn.hidden = false;
    }
}



// - MARK:UITableViewDelegate DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_cityList && _cityList.count > 0) {
        return _cityList.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CityModel *model = [_cityList objectAtIndex:indexPath.row];
    
    SettingTableViewCell *cell = [SettingTableViewCell cellWithTableView:tableView CityModel:model];
    
    WeakSelf;
    //避免循环引用
    __weak SettingTableViewCell *weakCell = cell;
    cell.deleteCityBlock = ^(NSString *cityID){
        NSLog(@"要移除的地区ID： %@",cityID);
        [weakSelf.cityList removeObjectAtIndex:indexPath.row];
        [weakSelf syncLocalUserDefaults];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.6 delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                weakCell.transform = CGAffineTransformMakeScale(0.3, 0.3);
            } completion:^(BOOL finished) {
                if (finished) {
                    
                    [weakSelf.showTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        if (![[CityManager shareInstance] isExistHasSelectedCity]) {
                            weakSelf.showTableView.hidden = true;
                            weakSelf.addCityBtn.hidden = false;
                        }else{
                            [weakSelf.showTableView reloadData];
                        }
                    });

                }
            }];
    
        });
    };
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 88;
}

- (void)syncLocalUserDefaults {
    NSMutableArray *arr = [NSMutableArray array];
    [_cityList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:(CityModel *)obj];
        [arr addObject:data];
    }];
    [[NSUserDefaults standardUserDefaults] setObject:arr forKey:UserSelectedCityListKey];
}

// - MARK: 事件处理
- (IBAction)addCity:(id)sender {
    SelectAddressController *selectAddressVC = [[SelectAddressController alloc] init];
    [self.navigationController pushViewController:selectAddressVC animated:true];
}
- (IBAction)returnToFront:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}


@end
