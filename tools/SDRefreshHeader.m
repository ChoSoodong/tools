//
//  SDRefreshHeader.m
//  KoreanPetApp
//
//  Created by xialan on 2018/11/16.
//  Copyright © 2018 HARAM. All rights reserved.
//

#import "SDRefreshHeader.h"

@interface SDRefreshHeader()
//@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIImageView *arrowImgView;
@property (nonatomic,strong) UIActivityIndicatorView *loadingView;
@end

@implementation SDRefreshHeader

#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare{
    
    [super prepare];
    // 设置控件的高度
    self.mj_h = 50;
    
//    // 添加label
//    _titleLabel = [[UILabel alloc] init];
//    _titleLabel.textColor = RGB(102, 102, 102);
//    _titleLabel.font = [UIFont boldSystemFontOfSize:13];
//    _titleLabel.textAlignment = NSTextAlignmentCenter;
//    [self addSubview:_titleLabel];

    
    // logo
    _arrowImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"refresh_arrow"]];
    _arrowImgView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_arrowImgView];
    
    // loading
    _loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self addSubview:_loadingView];

}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews{
    
    [super placeSubviews];

    CGFloat lab_x = (SCREEN_WIDTH - 30)*0.5;
    
//    _titleLabel.frame = CGRectMake(lab_x, 0, 60, 20);
//    [_titleLabel sizeToFit];
    
    _arrowImgView.frame = CGRectMake(lab_x, (self.height - 20)*0.5, 30, 20);
    
    _loadingView.center = _arrowImgView.center;
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state{
    
    MJRefreshCheckState;
    
    WeakSelf;
    switch (state) {
        case MJRefreshStateIdle:
        {
//            self.titleLabel.text = @"下拉刷新";
            //箭头恢复向下
            [UIView animateWithDuration:0.25 animations:^{
                weakSelf.arrowImgView.transform = CGAffineTransformIdentity;
            }];
            
            //延迟1秒后
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                //菊花结束转动
                [weakSelf.loadingView stopAnimating];
                //箭头不隐藏
                 weakSelf.arrowImgView.hidden = NO;
            });
        }
            
            
            break;
        case MJRefreshStatePulling:
        {
            //菊花结束转动
            [self.loadingView stopAnimating];
//            self.titleLabel.text = @"释放更新";
            
            //箭头旋转180度
            [UIView animateWithDuration:0.25 animations:^{
                weakSelf.arrowImgView.transform = CGAffineTransformMakeRotation(M_PI);
            }];
        }
            
  
            break;
        case MJRefreshStateRefreshing:
        {
//            self.titleLabel.text = @"加载中...";
            
            //隐藏箭头
            weakSelf.arrowImgView.hidden = YES;
            [UIView animateWithDuration:0.25 animations:^{
                weakSelf.arrowImgView.transform = CGAffineTransformIdentity;
                
            }];
            //菊花开始转动
            [self.loadingView startAnimating];
        }
            
            break;
        default:
        {
            
        }
            break;
    }
}

@end
