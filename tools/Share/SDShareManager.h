//
//  SDShareManager.h
//  KoreanPetApp
//
//  Created by xialan on 2018/12/11.
//  Copyright © 2018 HARAM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SDShareManager : NSObject

+ (instancetype)shared;

-(void)showShareViewFromController:(UIViewController *)vc shareText:(NSString *)text shareUrl:(NSString *)url image:(NSString *)image;

@end

NS_ASSUME_NONNULL_END
