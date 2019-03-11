//
//  SDArchiverTool.h
//  TryToHARAM
//
//  Created by xialan on 2018/10/19.
//  Copyright © 2018 HARAM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+Archiver.h"

@interface SDArchiverTool : NSObject

/**
 *  清楚所有归档
 */
+ (void)clearAll;

/**
 *  清楚一个类的归档
 *
 *  @param className 类的名字
 */
+ (void)clear:(NSString *)className;

/**
 *  清除一个类归档名为name的归档
 *
 *  @param name      归档名
 */
+ (void)clearWithName:(NSString *)name;

@end

