//
//  UITextField+RYNumberKeyboard.m
//  RYNumberKeyboardDemo
//
//  Created by Resory on 16/2/21.
//  Copyright © 2016年 Resory. All rights reserved.
//

#import "UITextField+SDNumberKeyboard.h"
#import <objc/runtime.h>

@implementation UITextField (SDNumberKeyboard)

#pragma mark -
#pragma mark -  Setter

- (void)setSd_inputType:(SDKeyBoardInputType)sd_inputType
{
    SDNumberKeyboard *inputView = [[SDNumberKeyboard alloc] initWithInputType:sd_inputType];
    inputView.textInput = self;
    self.inputView = inputView;
    objc_setAssociatedObject(self, _cmd, @(sd_inputType), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setSd_interval:(NSInteger)sd_interval
{
    if([self.inputView isKindOfClass:[SDNumberKeyboard class]])
        [self.inputView performSelector:@selector(setInterval:) withObject:@(sd_interval)];
    objc_setAssociatedObject(self, _cmd, @(sd_interval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setSd_inputAccessoryText:(NSString *)sd_inputAccessoryText
{
    // inputAccessoryView
    UIView *tView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SYS_DEVICE_WIDTH, 35)];
    // 顶部分割线
    UIView *tLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SYS_DEVICE_WIDTH, 0.5)];
    tLine.backgroundColor = [UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:1.0];
    // 字体label
    UILabel *tLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SYS_DEVICE_WIDTH, 35)];
    tLabel.text = sd_inputAccessoryText;
    tLabel.textAlignment = NSTextAlignmentCenter;
    tLabel.font = [UIFont systemFontOfSize:14.0];
    tLabel.backgroundColor = [UIColor whiteColor];
    
    [tView addSubview:tLabel];
    [tView addSubview:tLine];
    self.inputAccessoryView = tView;
    objc_setAssociatedObject(self, _cmd, sd_inputAccessoryText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark -
#pragma mark -  Getter

- (SDKeyBoardInputType)sd_inputType
{
    return [objc_getAssociatedObject(self, @selector(setSd_inputType:)) integerValue];
}

- (NSInteger)sd_interval
{
    return [objc_getAssociatedObject(self, @selector(setSd_interval:)) integerValue];
}

- (NSString *)sd_inputAccessoryText
{
    return objc_getAssociatedObject(self, @selector(sd_inputAccessoryText));
}



@end
