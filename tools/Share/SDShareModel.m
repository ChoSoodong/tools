//
// 
//
//
//
//

#import "SDShareModel.h"
//#import <UMShare/UMShare.h>

NSString *const  SDPlatformNameSina = @"SDPlatformNameSina";
NSString *const  SDPlatformNameQQ = @"SDPlatformNameQQ";
NSString *const  SDPlatformNameEmail = @"SDPlatformNameEmail";
NSString *const  SDPlatformNameSms = @"SDPlatformNameSms";
NSString *const  SDPlatformNameWechat = @"SDPlatformNameWechat";
NSString *const  SDPlatformNameAlipay = @"SDPlatformNameAlipay";
NSString *const  SDPlatformNameTwitter = @"SDPlatformNameTwitter";//推特
NSString *const  SDPlatformNameFacebook = @"SDPlatformNameFacebook";//脸书
NSString *const  SDPlatformNameKakaoTalk = @"SDPlatformNameKakaoTalk";//KakaoTalk
NSString *const  SDPlatformNameLine = @"SDPlatformNameLine";//Line
NSString *const  SDPlatformNameKakaoStory = @"SDPlatformNameKakaoStory";//KakaoStory
NSString *const  SDPlatformNameIns = @"SDPlatformNameIns";//ins

NSString *const  SDPlatformHandleSina = @"SDPlatformHandleSina";
NSString *const  SDPlatformHandleQQ = @"SDPlatformHandleQQ";
NSString *const  SDPlatformHandleEmail = @"SDPlatformHandleEmail";
NSString *const  SDPlatformHandleSms = @"SDPlatformHandleSms";
NSString *const  SDPlatformHandleWechat = @"SDPlatformHandleWechat";
NSString *const  SDPlatformHandleAlipay = @"SDPlatformHandleAlipay";
NSString *const  SDPlatformHandleTwitter = @"SDPlatformHandleTwitter";
NSString *const  SDPlatformHandleFacebook = @"SDPlatformHandleFacebook";
NSString *const  SDPlatformHandleKakaoTalk = @"SDPlatformHandleKakaoTalk";
NSString *const  SDPlatformHandleLine = @"SDPlatformHandleLine";
NSString *const  SDPlatformHandleKakaoStory = @"SDPlatformHandleKakaoStory";
NSString *const  SDPlatformHandleIns = @"SDPlatformHandleIns";

@interface SDShareModel()

@end

@implementation SDShareModel

#pragma mark - 初始化方法

- (instancetype)initWithImage:(UIImage *)image
                        title:(NSString *)title
                       action:(shareHandle)action
{
    NSParameterAssert(title.length || image);
    
    self = [super init];
    if (self) {
        _title = title;
        _image = image;
        _action = action;
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image
                        title:(NSString *)title
                   actionName:(NSString *)actionName
{
    self = [super init];
    if (self) {
        _title = title;
        _image = image;
        _action = [self actionFromString:actionName];
    }
    return self;
}

- (instancetype)initWithPlatformName:(NSString *)platformName{
    
/******************************  添加分享的平台 *******************************/
    NSDictionary *messageDict;
    if ([platformName isEqualToString:SDPlatformNameSina]) {
        messageDict = @{@"image":@"share_sina",@"title":@"新浪微博",@"action":SDPlatformHandleSina};
    }
    if ([platformName isEqualToString:SDPlatformNameQQ]) {
        messageDict = @{@"image":@"share_qq",@"title":@"QQ",@"action":SDPlatformHandleQQ};
    }
    if ([platformName isEqualToString:SDPlatformNameEmail]) {
        messageDict = @{@"image":@"share_email",@"title":@"邮件",@"action":SDPlatformHandleEmail};
    }
    if ([platformName isEqualToString:SDPlatformNameSms]) {
        messageDict = @{@"image":@"share_sms",@"title":@"短信",@"action":SDPlatformHandleSms};
    }
    if ([platformName isEqualToString:SDPlatformNameWechat]) {
        messageDict = @{@"image":@"share_weixin",@"title":@"微信",@"action":SDPlatformHandleWechat};
    }
    if ([platformName isEqualToString:SDPlatformNameAlipay]) {
        messageDict = @{@"image":@"share_alipay",@"title":@"支付宝",@"action":SDPlatformHandleAlipay};
    }
    if ([platformName isEqualToString:SDPlatformNameFacebook]) {
        messageDict = @{@"image":@"share_facebook",@"title":@"脸书",@"action":SDPlatformHandleFacebook};
    }
    if ([platformName isEqualToString:SDPlatformNameTwitter]) {
        messageDict = @{@"image":@"share_twitter",@"title":@"推特",@"action":SDPlatformHandleTwitter};
    }
    if ([platformName isEqualToString:SDPlatformNameKakaoTalk]) {
        messageDict = @{@"image":@"share_talk",@"title":@"talk",@"action":SDPlatformHandleKakaoTalk};
    }
    if ([platformName isEqualToString:SDPlatformNameLine]) {
        messageDict = @{@"image":@"share_line",@"title":@"Line",@"action":SDPlatformHandleLine};
    }
    if ([platformName isEqualToString:SDPlatformNameKakaoStory]) {
        messageDict = @{@"image":@"share_story",@"title":@"story",@"action":SDPlatformHandleKakaoStory};
    }
    if ([platformName isEqualToString:SDPlatformNameIns]) {
        messageDict = @{@"image":@"share_paizhao",@"title":@"ins",@"action":SDPlatformHandleIns};
    }

/*********************************end************************************************/
    
    self = [super init];
    if (self) {
        _title = (messageDict[@"title"] ? messageDict[@"title"] : @"");
        _image = [UIImage imageNamed:[@"SDShareImage.bundle" stringByAppendingPathComponent:messageDict[@"image"]]];
        _action = [self actionFromString:messageDict[@"action"]];
    }
    return self;
}

#pragma mark - 私有方法

//字符串转 Block
- (shareHandle)actionFromString:(NSString *)handleName{
    
    __weak typeof(self) weakSelf = self;
    shareHandle handle = ^(SDShareModel *item){
      
        if ([handleName isEqualToString:SDPlatformHandleEmail]) {
            [weakSelf sendmailTO:@""];
            return ;
        }
        if ([handleName isEqualToString:SDPlatformHandleSms]) {
            [weakSelf sendMessageTO:@""];
            return ;
        }
    
        
/****************** 各种平台 点击分享 ************************/
        if ([handleName isEqualToString:SDPlatformHandleSina]) {
            [weakSelf shareToSina];
        }
        if ([handleName isEqualToString:SDPlatformHandleQQ]) {
            [weakSelf shareToQQ];
        }
        if ([handleName isEqualToString:SDPlatformHandleWechat]) {
            [weakSelf shareToWechat];
        }
        if ([handleName isEqualToString:SDPlatformHandleAlipay]) {
            [weakSelf shareToAliPay];
        }
        if ([handleName isEqualToString:SDPlatformHandleTwitter]) {
            [weakSelf shareToTwitter];
        }
        if ([handleName isEqualToString:SDPlatformHandleFacebook]) {
            [weakSelf shareToFacebook];
        }
        if ([handleName isEqualToString:SDPlatformHandleKakaoTalk]) {
            [weakSelf shareToKakaoTalk];
        }
        if ([handleName isEqualToString:SDPlatformHandleLine]) {
            [weakSelf shareToLine];
        }
        if ([handleName isEqualToString:SDPlatformHandleKakaoStory]) {
            [weakSelf shareToKakaoStory];
        }
        if ([handleName isEqualToString:SDPlatformHandleIns]) {
            [weakSelf shareToIns];
        }

    };
    return handle;
}

#pragma mark - 分享到邮件
- (void)sendmailTO:(NSString *)email{
    
}
#pragma mark - 分享到短信
- (void)sendMessageTO:(NSString *)phoneNum{
    
//    [self shareWebPageToPlatformType:UMSocialPlatformType_Sms];
}

#pragma mark - 分享到新浪
-(void)shareToSina{
    
    NSLog(@"新浪");
    ALERT_MSG(@"提示",@"新浪",_presentVC);
    
}
#pragma mark - 分享到QQ
-(void)shareToQQ{
     NSLog(@"QQ");
    ALERT_MSG(@"提示",@"QQ",_presentVC);
    
//    [self shareWebPageToPlatformType:UMSocialPlatformType_QQ];
}
#pragma mark - 分享到微信
-(void)shareToWechat{
    NSLog(@"微信");
    ALERT_MSG(@"提示",@"微信",_presentVC);
//    [self shareWebPageToPlatformType:UMSocialPlatformType_WechatSession];
}
#pragma mark - 分享到支付宝
-(void)shareToAliPay{
    NSLog(@"支付宝");
    ALERT_MSG(@"提示",@"支付宝",_presentVC);
}
#pragma mark - 分享到推特
-(void)shareToTwitter{
    NSLog(@"推特");
    ALERT_MSG(@"提示",@"推特",_presentVC);
}
#pragma mark - 分享到facebook
-(void)shareToFacebook{
    NSLog(@"facebook");
    ALERT_MSG(@"提示",@"facebook",_presentVC);
//    [self shareWebPageToPlatformType:UMSocialPlatformType_Facebook];
}
#pragma mark - 分享到KakaoTalk
-(void)shareToKakaoTalk{
    NSLog(@"talk");
    ALERT_MSG(@"提示",@"talk",_presentVC);
}
#pragma mark - 分享到line
-(void)shareToLine{
    NSLog(@"line");
    ALERT_MSG(@"提示",@"line",_presentVC);
}
#pragma mark - 分享到kakaoStory
-(void)shareToKakaoStory{
    NSLog(@"kakaoStory");
    ALERT_MSG(@"提示",@"kakaoStory",_presentVC);
//    [self shareWebPageToPlatformType:UMSocialPlatformType_KakaoTalk];

}
#pragma mark - 分享到ins
-(void)shareToIns{
//     [self shareWebPageToPlatformType:UMSocialPlatformType_Instagram];
}



//- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType{
//    
//    //创建分享消息对象
//    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
//    //创建网页内容对象
//    NSString* thumbURL =  self.shareUrl;
//    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"欢迎使用【mignon】" descr:self.shareText thumImage:@"http://pic33.nipic.com/20130912/7428510_011905467000_2.jpg"];
//    //设置网页地址
//    shareObject.webpageUrl = self.shareUrl.absoluteString;
//    //分享消息对象设置分享内容对象
//    messageObject.shareObject = shareObject;
//    //调用分享接口
//    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self.presentVC completion:^(id data, NSError *error) {
//        if (error) {
//            UMSocialLogInfo(@"************Share fail with error %@*********",error);
//        }else{
//            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
//                UMSocialShareResponse *resp = data;
//                //分享结果消息
//                UMSocialLogInfo(@"response message is %@",resp.message);
//                //第三方原始返回的数据
//                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
//            }else{
//                UMSocialLogInfo(@"response data is %@",data);
//            }
//        }
//    }];
//}
//

@end
