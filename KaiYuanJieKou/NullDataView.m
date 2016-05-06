//
//  NullDataView.m
//  KaiYuanJieKou
//
//  Created by jiachen on 16/4/25.
//  Copyright © 2016年 jiachenmu. All rights reserved.
//

#import "NullDataView.h"

@implementation NullDataView

+ (instancetype)show{
    NSArray *nibArr = [[NSBundle mainBundle] loadNibNamed:@"NullDataView" owner:nil options:nil];
    NullDataView *nullView = [nibArr lastObject];
    nullView.frame = [UIScreen mainScreen].bounds;
    
    return nullView;
}


//点击 选择城市

- (IBAction)goToSelectAddress:(id)sender {
    if (_selectAddressBlock != nil) {
        _selectAddressBlock();
    }
}


@end
