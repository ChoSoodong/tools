//
//  NetAlertView.h
//  TryToHARAM
//
//  Created by xialan on 2018/10/22.
//  Copyright © 2018 HARAM. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NetAlertView : UIView

//提示框背景颜色，默认颜色3691D1  232，78，64
@property (nonatomic,weak) UIColor *alertBgColor;

//提示框显示时间，默认2.5s
@property (nonatomic,assign) CGFloat alertShowTime;

- (void)showAlertMessage:(NSString *)msg;

- (void)alertShow;

-(void)alertDismiss;

@end

