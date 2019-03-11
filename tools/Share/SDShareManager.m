//
//  SDShareManager.m
//  KoreanPetApp
//
//  Created by xialan on 2018/12/11.
//  Copyright © 2018 HARAM. All rights reserved.
//

#import "SDShareManager.h"

@interface SDShareManager()

@property(nonatomic, strong) NSMutableArray *shareArray;
@property(nonatomic, strong) NSMutableArray *functionArray;

@end

@implementation SDShareManager

+ (instancetype)shared{
    // 保存在静态存储区
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

-(void)showShareViewFromController:(UIViewController *)vc shareText:(NSString *)text shareUrl:(NSString *)url image:(NSString *)image{
    

    NSMutableArray *totalArry = [NSMutableArray array];
    [totalArry addObjectsFromArray:self.shareArray];
    [totalArry addObjectsFromArray:self.functionArray];
    SDShareView *shareView = [[SDShareView alloc] initWithItems:totalArry itemSize:CGSizeMake(100, 120) DisplayLine:NO];
    [shareView addText:text];
    [shareView addURL:[NSURL URLWithString:url]];
    [shareView addImage:[UIImage imageNamed:image]];
    shareView.itemSpace = 10;
    [shareView showFromControlle:vc];
    
    
}

- (NSMutableArray *)shareArray{
    if (!_shareArray) {
        _shareArray = [NSMutableArray array];
        
        [_shareArray addObject:SDPlatformNameFacebook];
        [_shareArray addObject:SDPlatformNameIns];
        [_shareArray addObject:SDPlatformNameSms];
        [_shareArray addObject:SDPlatformNameKakaoStory];
        [_shareArray addObject:SDPlatformNameWechat];
        
    }
    return _shareArray;
}

- (NSMutableArray *)functionArray{
    if (!_functionArray) {
        _functionArray = [NSMutableArray array];

        [_functionArray addObject:[[SDShareModel alloc] initWithImage:[UIImage imageNamed:[@"SDShareImage.bundle" stringByAppendingPathComponent:@"share_link"]] title:@"复制链接" action:^(SDShareModel *item) {
            
        }]];
       
    }
    return _functionArray;
}


@end
