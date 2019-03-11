//
//  
//
//
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define  ALERT_MSG(TITLE,MESSAGE,CONTROLLER) UIAlertController *alertController = [UIAlertController alertControllerWithTitle:TITLE message:MESSAGE preferredStyle:UIAlertControllerStyleAlert];\
[alertController addAction:[UIAlertAction actionWithTitle:@"确定"style:UIAlertActionStyleDefault handler:nil]];\
[CONTROLLER presentViewController:alertController animated:YES completion:nil];

#define  SDColor(r, g, b, a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]

@class SDShareModel;
typedef void (^__nullable shareHandle)(SDShareModel *item);

//预制的分享平台
extern NSString *const  SDPlatformNameSina;// 新浪微博
extern NSString *const  SDPlatformNameQQ;//QQ
extern NSString *const  SDPlatformNameEmail;//邮箱
extern NSString *const  SDPlatformNameSms;//短信
extern NSString *const  SDPlatformNameWechat;//微信
extern NSString *const  SDPlatformNameAlipay;//支付宝
extern NSString *const  SDPlatformNameTwitter;//推特
extern NSString *const  SDPlatformNameFacebook;//脸书
extern NSString *const  SDPlatformNameKakaoTalk;//KakaoTalk
extern NSString *const  SDPlatformNameLine;//Line
extern NSString *const  SDPlatformNameKakaoStory;//KakaoStory
extern NSString *const  SDPlatformNameIns;//ins



//预制的分享事件
extern NSString *const  SDPlatformHandleSina;// 新浪微博
extern NSString *const  SDPlatformHandleQQ;//QQ
extern NSString *const  SDPlatformHandleEmail;//邮箱
extern NSString *const  SDPlatformHandleSms;//短信
extern NSString *const  SDPlatformHandleWechat;//微信
extern NSString *const  SDPlatformHandleAlipay;//支付宝
extern NSString *const  SDPlatformHandleTwitter;//推特
extern NSString *const  SDPlatformHandleFacebook;//脸书
extern NSString *const  SDPlatformHandleKakaoTalk;//talk
extern NSString *const  SDPlatformHandleLine;//line
extern NSString *const  SDPlatformHandleKakaoStory;//story
extern NSString *const  SDPlatformHandleIns;//ins


@interface SDShareModel : NSObject
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, weak)UIViewController *presentVC;
@property (nonatomic, copy) shareHandle action;

@property (nullable, nonatomic, strong) NSString *shareText;
@property (nullable, nonatomic, strong) UIImage *shareImage;
@property (nullable, nonatomic, strong) NSURL *shareUrl;

/*
 * 调用以下代码获取手机中装的App的所有Share Extension的ServiceType
 
 SLComposeViewController *composeVc = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
 
 * 我获得的部分数据
 
 com.taobao.taobao4iphone.ShareExtension  淘宝
 com.apple.share.Twitter.post  推特
 com.apple.share.Facebook.post 脸书
 com.apple.share.SinaWeibo.post 新浪微博
 com.apple.share.Flickr.post 雅虎
 com.burbn.instagram.shareextension   instagram
 com.amazon.AmazonCN.AWListShareExtension 亚马逊
 com.apple.share.TencentWeibo.post 腾讯微博
 com.smartisan.notes.SMShare 锤子便签
 com.zhihu.ios.Share 知乎
 com.tencent.mqq.ShareExtension QQ
 com.tencent.xin.sharetimeline 微信
 com.alipay.iphoneclient.ExtensionSchemeShare 支付宝
 com.apple.mobilenotes.SharingExtension  备忘录
 com.apple.reminders.RemindersEditorExtension 提醒事项
 com.apple.Health.HealthShareExtension      健康
 com.apple.mobileslideshow.StreamShareService  iCloud
 
 */


- (instancetype)initWithImage:(UIImage *)image
                        title:(NSString *)title
                       action:(shareHandle)action;

- (instancetype)initWithImage:(UIImage *)image
                        title:(NSString *)title
                   actionName:(NSString *)actionName;

- (instancetype)initWithPlatformName:(NSString *)platformName;


@end

NS_ASSUME_NONNULL_END
