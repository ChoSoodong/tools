//
//  SDNavToast.h
//  AlphaPay
//
//  Created by xialan on 2019/2/23.
//  Copyright © 2019 HARAM. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,SDNavToastType){
    
    //普通提示类
    SDNavToastTypeInfo=0,
    
    //错误
    SDNavToastTypeError,
    
    //成功
    SDNavToastTypeSuccess
};



@interface SDNavToast : NSObject

/**
 *  提示工具
 *
 *  @param msgType         类型
 *  @param msg             标题
 *  @param subMsg          子标题
 *  @param timeInterval    时间
 *  @param trigger         触发控件
 *  @param apperanceBlock  开始回调
 *  @param completionBlock 结束回调
 */
+(void)showMsgType:(SDNavToastType)msgType msg:(NSString *)msg subMsg:(NSString *)subMsg timeInterval:(NSTimeInterval)timeInterval trigger:(UIView *)trigger apperanceBlock:(void(^)(void))apperanceBlock completionBlock:(void(^)(void))completionBlock;


@end


