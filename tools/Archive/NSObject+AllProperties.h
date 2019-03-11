//
//  NSObject+AllProperties.h
//  TryToHARAM
//
//  Created by xialan on 2018/10/19.
//  Copyright © 2018 HARAM. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NSObject (AllProperties)

/**
 *  获取一个类的所有属性的名称和类型
 *
 *  @return @[@{@"name":@"XXX",@"type":@"XXX"},,,,]
 */
- (NSArray*)sd_allProperty;

@end


