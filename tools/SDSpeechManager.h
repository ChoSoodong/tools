//
//  SDSpeechManager.h
//  AlphaPay
//
//  Created by xialan on 2019/3/11.
//  Copyright © 2019 HARAM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SDSpeechManager : NSObject

//播放模型单例
+ (instancetype)sharedInstance;
/**
 要读出来的内容
 */
@property (nonatomic,copy) NSString *speechStr;

- (void)start;



@end

NS_ASSUME_NONNULL_END
