//
//  NSData+AES.h
//  TasteFresh
//
//  Created by ZHAO on 2018/1/10.
//  Copyright © 2018年 XiaLanTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSString;

@interface NSData (Encryption)

- (NSData *)AES128EncryptWithKey:(NSString *)key gIv:(NSString *)Iv;   //加密
- (NSData *)AES128DecryptWithKey:(NSString *)key gIv:(NSString *)Iv;   //解密

@end
