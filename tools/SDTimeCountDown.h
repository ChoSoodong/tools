//
//  SDTimeCountDown.h
//  AlphaPay
//
//  Created by xialan on 2019/2/16.
//  Copyright © 2019 HARAM. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SDTimeDownCompleteBlock)(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second);

@interface SDTimeCountDown : NSObject



/**
 * 单例创建SDTimeCountDown，适用Cell中的倒计时，
 * 单个倒计时最好使用 alloc init 创建，不要使用单例，避免退出页面时，倒计时没有及时销毁
 
 @return SDTimeCountDown
 */
+(instancetype)ShareManager;

/**
 * 用NSDate日期倒计时
 
 @param startDate 开始时间
 @param endDate 结束时间
 @param completeBlock 倒计时结束的回调
 */
-(void)timeCountDownWithStartDate:(NSDate *)startDate
                             endDate:(NSDate *)endDate
                       completeBlock:(SDTimeDownCompleteBlock)completeBlock;
/**
 * 用时间戳倒计时
 
 @param startTimeStamp 开始时间
 @param endTimeStamp 结束时间
 @param completeBlock 倒计时结束的回调
 */
-(void)timeCountDownWithStartTimeStamp:(long long)startTimeStamp
                             endTimeStamp:(long long)endTimeStamp
                            completeBlock:(SDTimeDownCompleteBlock)completeBlock;


/**
 * 用秒做倒计时
 
 @param secondTime 倒计时秒数
 @param completeBlock 倒计时完成回调
 */
-(void)timeCountDownWithSecondTime:(long long)secondTime
                        completeBlock:(SDTimeDownCompleteBlock)completeBlock;



/**
 * 每秒走一次，回调block
 
 @param PER_SECBlock 回调
 */
-(void)timeCountDownWithPER_SECBlock:(void (^)(void))PER_SECBlock;
-(void)timeCountDownWithTime:(NSInteger)time PER_SECBlock:(void (^)(void))PER_SECBlock;
/**
 * 当前时间与结束时间的对比
 
 @param timeString 时间String
 @return timeString
 */

-(NSString *)zj_timeGetNowTimeWithString:(NSString *)timeString;
/**
 * 当前时间与结束时间的对比,返回天/时/分/秒
 
 @param timeString 时间String
 
 */

-(void)timeGetNowTimeWithEndString:(NSString *)timeString
                        completeBlock:(SDTimeDownCompleteBlock)completeBlock;


/**
 * 将时间戳转换为NSDate
 
 @param longlongValue 时间戳
 @return NSDate
 */
-(NSDate *)timeDateWithLongLong:(long long)longlongValue;

/**
 * 根据传入的年份和月份获得该月份的天数
 *
 * @param year
 *            年份-正整数
 * @param month
 *            月份-正整数
 * @return 返回天数
 */
-(NSInteger)getDayNumberWithYear:(NSInteger )year month:(NSInteger )month;

/**
 * 主动销毁定时器
 */
-(void)timeDestoryTimer;

@end
