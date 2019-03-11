//
//  SDRedDotManager.m
//  KoreanPetApp
//
//  Created by xialan on 2018/12/13.
//  Copyright © 2018 HARAM. All rights reserved.
//

#import "SDRedDotManager.h"

@interface SDRedDotDotView : UIView

@end

@implementation SDRedDotDotView


@end



@interface SDRedDotManager()


@end

@implementation SDRedDotManager



+(void)showRedDotOnView:(UIView *)view{
    
    SDRedDotManager *mgr = [[SDRedDotManager alloc] init];
    [mgr redDotViewWithOnView:view offsetX:0 offsetY:0];
    
    
}

+(void)removeRedDotOnView:(UIView *)view{
    
   
    for (UIView *v in view.subviews) {
        if ([v isKindOfClass:[SDRedDotDotView class]]) {
            [v removeFromSuperview];
        }
    }
    
    
}


-(void)redDotViewWithOnView:(UIView *)parentView offsetX:(CGFloat)offsetx offsetY:(CGFloat)offsetY{
    
    //小红点
    CGFloat dotX = parentView.size.width - 4.5-offsetx;
    CGFloat dotY = offsetY;
    CGFloat dotW = 4.5;
    CGFloat dotH = dotW;
    SDRedDotDotView *redView = [[SDRedDotDotView alloc] initWithFrame:CGRectMake(dotX, dotY, dotW, dotH)];
    redView.backgroundColor = KThemePink;
    redView.alpha = 1.0f;
    redView.layer.cornerRadius = dotW*0.5;
    redView.layer.masksToBounds = YES;
    [parentView addSubview:redView];
    
}

+(void)showRedDotOnView:(UIView *)view offsetX:(CGFloat)offsetx offsetY:(CGFloat)offsetY{
    
    SDRedDotManager *mgr = [[SDRedDotManager alloc] init];
    [mgr redDotViewWithOnView:view offsetX:offsetx offsetY:offsetY];
    
}

@end
