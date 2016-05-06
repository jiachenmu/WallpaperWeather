//
//  NullDataView.h
//  KaiYuanJieKou
//
//  Created by jiachen on 16/4/25.
//  Copyright © 2016年 jiachenmu. All rights reserved.
//  首页没有数据的页面

#import <UIKit/UIKit.h>

typedef void(^SelectAddressBlock)(void);

@interface NullDataView : UIView



+ (instancetype)show;


@property (nonatomic,copy) SelectAddressBlock selectAddressBlock;
@end
