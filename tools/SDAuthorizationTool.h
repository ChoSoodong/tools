//
//  SDAuthorizationTool.h
//  AlphaPay
//
//  Created by xialan on 2019/2/16.
//  Copyright © 2019 HARAM. All rights reserved.
//

/**
 
 Tips：在iOS10下记得在plist文件下添加对应的参数。
 ```
 <key>NSBluetoothPeripheralUsageDescription</key>
 <string>需要获取蓝牙权限</string>
 <key>NSCalendarsUsageDescription</key>
 <string>日历</string>
 <key>NSCameraUsageDescription</key>
 <string>需要获取您的摄像头信息</string>
 <key>NSContactsUsageDescription</key>
 <string>需要获取您的通讯录权限</string>
 <key>NSHealthShareUsageDescription</key>
 <string>健康分享权限</string>
 <key>NSHealthUpdateUsageDescription</key>
 <string>健康数据更新权限</string>
 <key>NSHomeKitUsageDescription</key>
 <string>HomeKit权限</string>
 <key>NSLocationAlwaysUsageDescription</key>
 <string>一直定位权限</string>
 <key>NSLocationUsageDescription</key>
 <string>定位权限</string>
 <key>NSLocationWhenInUseUsageDescription</key>
 <string>使用app期间定位权限</string>
 <key>NSMicrophoneUsageDescription</key>
 <string>需要获取您的麦克风权限</string>
 <key>NSPhotoLibraryUsageDescription</key>
 <string>需要获取您的相册信息</string>
 <key>NSRemindersUsageDescription</key>
 <string>提醒事项</string>
 <key>NSSiriUsageDescription</key>
 <string>需要获取您的Siri权限</string>
 <key>NSSpeechRecognitionUsageDescription</key>
 <string>语音识别权限</string>
 <key>NSVideoSubscriberAccountUsageDescription</key>
 <string>AppleTV权限</string>
 <key>NSAppleMusicUsageDescription</key>
 <string>Add tracks to your music library.</string>
 <key>NSMotionUsageDescription</key>
 <string>运动与健身权限</string>
 <key>NSPhotoLibraryAddUsageDescription</key>
 <string>需要获取您的相册信息</string>
 
 ```

 */





@import Foundation;
@import UIKit;
@import AssetsLibrary;
@import Photos;
@import AddressBook;
@import Contacts;
@import AVFoundation;
@import CoreBluetooth;
@import CoreLocation;
@import EventKit;
@import Speech;
@import HealthKit;
@import HomeKit;
@import StoreKit;
@import CoreMotion;



#define _isiOS7_          (([UIDevice currentDevice].systemVersion.floatValue >= 7.0f && [UIDevice currentDevice].systemVersion.floatValue < 8.0) ? YES : NO)
#define _isiOS7_Or_Later_ (([UIDevice currentDevice].systemVersion.floatValue >= 7.0f) ? YES : NO)
#define _isiOS8_          (([UIDevice currentDevice].systemVersion.floatValue >= 8.0f && [UIDevice currentDevice].systemVersion.floatValue < 9.0f) ? YES : NO)
#define _isiOS8_Or_Later_ (([UIDevice currentDevice].systemVersion.floatValue >= 8.0f) ? YES : NO)
#define _isiOS9_          (([UIDevice currentDevice].systemVersion.floatValue >= 9.0f && [UIDevice currentDevice].systemVersion.floatValue < 10.0f) ? YES : NO)
#define _isiOS9_Or_Later_ (([UIDevice currentDevice].systemVersion.floatValue >= 9.0f) ? YES : NO)
#define _isiOS10_          (([UIDevice currentDevice].systemVersion.floatValue >= 10.0f && [UIDevice currentDevice].systemVersion.floatValue < 11.0f) ? YES : NO)
#define _isiOS10_Or_Later_ (([UIDevice currentDevice].systemVersion.floatValue >= 10.0f) ? YES : NO)



/*
 Enumerate
 */
// Privacy classify 分类
typedef NS_ENUM(NSUInteger, SDPrivacyType){
    SDPrivacyType_None                  = 0,
    SDPrivacyType_LocationServices      = 1,    // 定位服务
    SDPrivacyType_Contacts              = 2,    // 通讯录
    SDPrivacyType_Calendars             = 3,    // 日历
    SDPrivacyType_Reminders             = 4,    // 提醒事项
    SDPrivacyType_Photos                = 5,    // 照片
    SDPrivacyType_BluetoothSharing      = 6,    // 蓝牙共享
    SDPrivacyType_Microphone            = 7,    // 麦克风
    SDPrivacyType_SpeechRecognition     = 8,    // 语音识别 >= iOS10
    SDPrivacyType_Camera                = 9,    // 相机
    SDPrivacyType_Health                = 10,   // 健康 >= iOS8.0
    SDPrivacyType_HomeKit               = 11,   // 家庭 >= iOS8.0
    SDPrivacyType_MediaAndAppleMusic    = 12,   // 媒体与Apple Music >= iOS9.3
    SDPrivacyType_MotionAndFitness      = 13,   // 运动与健身
};

// SDAuthorizationStatus 权限状态，参考PHAuthorizationStatus等
typedef NS_ENUM(NSUInteger, SDAuthorizationStatus){
    SDAuthorizationStatus_NotDetermined  = 0, // 用户从未进行过授权等处理，首次访问相应内容会提示用户进行授权
    SDAuthorizationStatus_Authorized     = 1, // 已授权
    SDAuthorizationStatus_Denied         = 2, // 拒绝
    SDAuthorizationStatus_Restricted     = 3, // 应用没有相关权限，且当前用户无法改变这个权限，比如:家长控制
    SDAuthorizationStatus_NotSupport     = 4, // 硬件等不支持
};

// SDLocationAuthorizationStatus 定位权限状态，参考CLAuthorizationStatus
typedef NS_ENUM(NSUInteger, SDLocationAuthorizationStatus){
    SDLocationAuthorizationStatus_NotDetermined         = 0, // 用户从未进行过授权等处理，首次访问相应内容会提示用户进行授权
    SDLocationAuthorizationStatus_Authorized            = 1, // 一直允许获取定位 ps：< iOS8用
    SDLocationAuthorizationStatus_Denied                = 2, // 拒绝
    SDLocationAuthorizationStatus_Restricted            = 3, // 应用没有相关权限，且当前用户无法改变这个权限，比如:家长控制
    SDLocationAuthorizationStatus_NotSupport            = 4, // 硬件等不支持
    SDLocationAuthorizationStatus_AuthorizedAlways      = 5, // 一直允许获取定位
    SDLocationAuthorizationStatus_AuthorizedWhenInUse   = 6, // 在使用时允许获取定位
};

// SDCBManagerState 蓝牙状态，参考 CBManagerState
typedef NS_ENUM(NSUInteger, SDCBManagerStatus){
    SDCBManagerStatusUnknown         = 0,        // 未知状态
    SDCBManagerStatusResetting       = 1,        // 正在重置，与系统服务暂时丢失
    SDCBManagerStatusUnsupported     = 2,        // 不支持蓝牙
    SDCBManagerStatusUnauthorized    = 3,        // 未授权
    SDCBManagerStatusPoweredOff      = 4,        // 关闭
    SDCBManagerStatusPoweredOn       = 5,        // 开启并可用
};


/*
 定义权限状态回调block
 */
typedef void(^AccessForTypeResultBlock)(SDAuthorizationStatus status, SDPrivacyType type);
typedef void(^AccessForLocationResultBlock)(SDLocationAuthorizationStatus status);
typedef void(^AccessForBluetoothResultBlock)(SDCBManagerStatus status);
typedef void(^AccessForHomeResultBlock)(BOOL isHaveHomeAccess);
typedef void(^AccessForMotionResultBlock)(BOOL isHaveMotionAccess);




@interface SDAuthorizationTool : NSObject

@property (nonatomic, strong) CLLocationManager         *locationManager;       // 定位
@property (nonatomic, strong) CBCentralManager          *cMgr;                  // 蓝牙
@property (nonatomic, strong) HKHealthStore             *healthStore;           // 健康
@property (nonatomic, strong) HMHomeManager             *homeManager;           // home
@property (nonatomic, strong) CMMotionActivityManager   *cmManager;             // 运动
@property (nonatomic, strong) NSOperationQueue          *motionActivityQueue;   // 运动




#pragma mark -------------------- Public Methods --------------------
/*
 NS_ENUM -> NSString
 */
+ (NSString *)stringForPrivacyType:(SDPrivacyType)privacyType;
+ (NSString *)stringForAuthorizationStatus:(SDAuthorizationStatus)authorizationStatus;
+ (NSString *)stringForLocationAuthorizationStatus:(SDLocationAuthorizationStatus)locationAuthorizationStatus;
+ (NSString *)stringForCBManagerStatus:(SDCBManagerStatus)CBManagerStatus;


#pragma mark -------------------- Main Enter Method --------------------
/**
 Check and request access for * type
 检查和请求对应类型的权限
 
 @param type SDPrivacyType
 @param accessStatusCallBack AccessForTypeResultBlock
 */
+ (void)checkAndRequestAccessForType:(SDPrivacyType)type accessStatus:(AccessForTypeResultBlock)accessStatusCallBack;

/**
 Check and request access for LocationServices
 检查和请求定位服务的权限
 
 @param accessStatusCallBack accessStatus
 */
- (void)checkAndRequestAccessForLocationServicesWithAccessStatus:(AccessForLocationResultBlock)accessStatusCallBack;

/**
 Check and request access for BluetoothSharing
 检查和请求蓝牙共享服务的权限
 
 @param accessStatusCallBack accessStatus
 */
- (void)checkAndRequestAccessForBluetoothSharingWithAccessStatus:(AccessForBluetoothResultBlock)accessStatusCallBack;

/**
 Check and request access for Health
 检查和请求健康的权限
 
 @param accessStatusCallBack accessStatus
 */
- (void)checkAndRequestAccessForHealthWtihAccessStatus:(AccessForTypeResultBlock)accessStatusCallBack;

/**
 Check And Request Access For Home
 Tip：访问家庭权限是需要回调指定的的HMHomeManagerDelegate协议，并且回调之后的后续逻辑处理比较麻烦，建议使用者可以直接调用系统的获取权限方法。在回调协议中做处理。这里做出简单Demo以方便参考。注意：HMError.h类
 
 @param accessForHomeCallBack AccessForHomeResultBlock
 */
- (void)checkAndRequestAccessForHome:(AccessForHomeResultBlock)accessForHomeCallBack;

/**
 Check And Request Access For Motion And Fitness
 同访问Home一样，运动与健身这里也只给出简单demo方便参考，可以直接copy代码到自己的项目中直接用
 
 */
- (void)checkAndRequestAccessForMotionAndFitness;

@end














