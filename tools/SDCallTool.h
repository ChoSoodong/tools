//
//  SDCallTool.h
//  AlphaPay
//
//  Created by xialan on 2019/2/16.
//  Copyright © 2019 HARAM. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface SDCallTool : NSObject


/**
 打电话

 @param phoneNumber 电话号码
 */
+(void)callNumber:(NSString* )phoneNumber;

@end


