//
//  SecurityUtil.h
//  TasteFresh
//
//  Created by ZHAO on 2018/1/10.
//  Copyright © 2018年 XiaLanTech. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SecurityUtil : NSObject 

#pragma mark - base64
+ (NSString*)encodeBase64String:(NSString *)input;
+ (NSString*)decodeBase64String:(NSString *)input;

+ (NSString*)encodeBase64Data:(NSData *)data;
+ (NSString*)decodeBase64Data:(NSData *)data;

#pragma mark - AES加密
//将string转成带密码的data
+ (NSString*)encryptAESData:(NSString*)string key:(NSString *)keyString;
//将带密码的data转成string
+ (NSString*)decryptAESData:(NSString*)string key:(NSString *)keyString;


#pragma mark -  此方法随机产生16位字符串
+(NSString *)ret16bitString;
@end
