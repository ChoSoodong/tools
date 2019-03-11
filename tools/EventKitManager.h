//
//  EventKitManager.h
//  AlphaPay
//
//  Created by xialan on 2019/2/16.
//  Copyright © 2019 HARAM. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface EventKitManager : NSObject

+ (instancetype)shared;

#pragma mark - 系统日历提醒

//增加系统日历提醒事件
- (void)addEventToCalendarWithTitle:(NSString *)title
                              notes:(NSString *)notes
                                url:(NSString *)urlString
                          startDate:(NSDate *)startDate
                            dueDate:(NSDate *)dueDate
                      alarmInterval:(NSTimeInterval)alarmInterval
                         completion:(void (^)(BOOL success, NSError *error))completion;

//移除系统日历提醒事件
- (void)removeEventWithStartDate:(NSDate *)startDate
                         dueDate:(NSDate *)dueDate
                           title:(NSString *)title
                      completion:(void (^)(BOOL success, NSError *error))completion;




@end

