//
//  SDRedDotManager.h
//  KoreanPetApp
//
//  Created by xialan on 2018/12/13.
//  Copyright © 2018 HARAM. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface SDRedDotManager : NSObject



/**
 显示小红点

 @param view 小红点的父控件
 */
+(void)showRedDotOnView:(UIView *)view;

/**
 显示小红点 允许调整小红点的偏移量
 
 @param view 小红点的父控件
 @param offsetx x方向偏移量 向左偏移传入正数 向右偏移传入负数
 @param offsetY y方向偏移量 向下偏移传入正数 向上偏移传入负数
 */
+(void)showRedDotOnView:(UIView *)view offsetX:(CGFloat)offsetx offsetY:(CGFloat)offsetY;


/**
 将小红点从父控件移除

 @param view 父控件
 */
+(void)removeRedDotOnView:(UIView *)view;




@end


