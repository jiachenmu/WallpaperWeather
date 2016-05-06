//
//  TipModel.h
//  KaiYuanJieKou
//
//  Created by jiachen on 16/4/18.
//  Copyright © 2016年 jiachenmu. All rights reserved.
//  天气提示文字 比如 感冒指数 、防晒指数 、 穿衣指数 、 运动指数等等

#import <Foundation/Foundation.h>

@protocol TipModel
@end

@interface TipModel : NSObject

@property (nonatomic,strong) NSString *name;
/// 指数等级名称
@property (nonatomic,strong) NSString *index;
/// 详情
@property (nonatomic,strong) NSString *details;

@end
