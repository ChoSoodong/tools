//
//  NSObject+Archiver.h
//  TryToHARAM
//
//  Created by xialan on 2018/10/19.
//  Copyright © 2018 HARAM. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NSObject (Archiver)

/**
 *  通过自定的名字归档
 *
 *  @param name 名字
 *
 *  @return 是否成功
 */
- (BOOL)sd_archiveToName:(NSString *)name;

/**
 *  通过之前归档的名字解归档
 *
 *  @param name 名字
 *
 *  @return 解归档的对象
 */
+ (id)sd_unArchive:(NSString *)name;


@end

