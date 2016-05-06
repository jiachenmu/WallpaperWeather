//
//  TipView.m
//  KaiYuanJieKou
//
//  Created by jiachen on 16/4/26.
//  Copyright © 2016年 jiachenmu. All rights reserved.
//

#import "TipView.h"

#define TitleLabelTopMargin  8
#define TitleLabelLeftMargin 20

#define TextSpace 4    //行间距

@interface TipView()

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,assign) CGRect resultFrame;
@property (nonatomic,assign) CGRect startFrame;

@end

@implementation TipView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)buildUIWithTitle:(NSString *)title{
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = DefaultFont(14);
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.attributedText = [self attributeWithString:title];
    _titleLabel.text = title;
    _titleLabel.numberOfLines = 0;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [_titleLabel sizeToFit];
    _titleLabel.frame = CGRectMake(TitleLabelLeftMargin, TitleLabelTopMargin, SCREEN_WIDTH - 2 * TitleLabelLeftMargin, _titleLabel.frame.size.height);
    [self addSubview:_titleLabel];
    
    self.startFrame = CGRectMake(0, 70, SCREEN_WIDTH, 0);
    self.frame = self.startFrame;
    self.clipsToBounds = true;
    self.layer.cornerRadius = 8.0;
    self.resultFrame = CGRectMake(0, 70, SCREEN_WIDTH, CGRectGetMaxY(_titleLabel.frame) + TitleLabelTopMargin);
    self.backgroundColor = [UIColor colorWithHex:0x64af00];
    
    
}

//设置行间距
- (NSAttributedString *)attributeWithString:(NSString *)str{
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:str];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineBreakMode = NSLineBreakByTruncatingTail;
    style.lineSpacing = TextSpace;
    [attributeStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, str.length)];
    return attributeStr;
}

+ (void)showTitle:(NSString *)title{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        TipView *view = [[TipView alloc] init];
        [view buildUIWithTitle:title];
       
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        [keyWindow addSubview:view];
        
        [UIView animateWithDuration:0.3 animations:^{
            view.frame = view.resultFrame;
        } completion:^(BOOL finished) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:0.3 animations:^{
                    view.frame = view.startFrame;
                } completion:^(BOOL finished) {
                    [view removeFromSuperview];
                }];
            });
        }];
    });
}


@end
