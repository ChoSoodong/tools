//
//  SDAuthorizationTool.m
//  AlphaPay
//
//  Created by xialan on 2019/2/16.
//  Copyright © 2019 HARAM. All rights reserved.
//

#import "SDAuthorizationTool.h"

@interface SDAuthorizationTool ()<CLLocationManagerDelegate,CBCentralManagerDelegate,HMHomeManagerDelegate,UINavigationControllerDelegate>

@property (nonatomic,copy) void (^kCLCallBackBlock)(CLAuthorizationStatus state);
@property (nonatomic,copy) void (^CBManagerStateCallBackBlock)(CBManagerState state);
@property (nonatomic,copy) void (^HomeAccessCallBackBlock)(BOOL isHaveAccess);

@end


@implementation SDAuthorizationTool

#pragma mark -------------------- Main Enter Method --------------------
#pragma mark -
#pragma mark - checkAndRequestAccessForType
+ (void)checkAndRequestAccessForType:(SDPrivacyType)type accessStatus:(AccessForTypeResultBlock)accessStatusCallBack;
{
    if (type == SDPrivacyType_LocationServices) {           // 定位服务
        
        //        [self checkAndRequestAccessForLocationServicesWithAccessStatus:accessStatusCallBack];
        
    }else if (type == SDPrivacyType_Contacts) {             // 联系人
        
        [self checkAndRequestAccessForContactsWithAccessStatus:accessStatusCallBack];
        
    }else if (type == SDPrivacyType_Calendars) {            // 日历
        
        [self checkAndRequestAccessForCalendarsWithAccessStatus:accessStatusCallBack];
        
    }else if (type == SDPrivacyType_Reminders) {            // 提醒事项
        
        [self checkAndRequestAccessForRemindersWithAccessStatus:accessStatusCallBack];
        
    }else if (type ==  SDPrivacyType_Photos) {              // 照片
        
        [self checkAndRequestAccessForPhotosWithAccessStatus:accessStatusCallBack];
        
    }else if (type == SDPrivacyType_BluetoothSharing) {     // 蓝牙
        
        //        [self checkAndRequestAccessForBluetoothSharingWithAccessStatus:accessStatusCallBack];
        
    }else if (type == SDPrivacyType_Microphone) {           // 麦克风
        
        [self checkAndRequestAccessForMicrophoneWithAccessStatus:accessStatusCallBack];
        
    }else if (type == SDPrivacyType_SpeechRecognition) {    // 语音识别
        
        [self checkAndRequestAccessForSpeechRecognitionWithAccessStatus:accessStatusCallBack];
        
    }else if (type == SDPrivacyType_Camera) {               // 相机
        
        [self checkAndRequestAccessForCameraWithAccessStatus:accessStatusCallBack];
        
    }else if (type == SDPrivacyType_Health) {               // 健康
        
        //        [self checkAndRequestAccessForHealthWithAccessStatus:accessStatusCallBack];
        
    }else if (type == SDPrivacyType_HomeKit) {              // home
        
        //        [self checkAndRequestAccessForHomeWithAccessStatus:accessStatusCallBack];
        
    }else if (type == SDPrivacyType_MediaAndAppleMusic) {   // Apple Music
        
        [self checkAndRequestAccessForAppleMusicWithAccessStatus:accessStatusCallBack];
        
    }else if (type == SDPrivacyType_MotionAndFitness) {     // Motion
        
        //        [self checkAndRequestAccessForMotionAndFitnessWtihAccessStatus:accessStatusCallBack];
    }else{
        // ECPrivacyType_None
    }
}


#pragma mark -------------------- LocationServices --------------------
#pragma mark -
- (void)checkAndRequestAccessForLocationServicesWithAccessStatus:(AccessForLocationResultBlock)accessStatusCallBack;
{
    BOOL isLocationServicesEnabled = [CLLocationManager locationServicesEnabled];
    if (!isLocationServicesEnabled) {
        NSLog(@"定位服务不可用，例如定位没有打开...");
        [SDAuthorizationTool executeCallBackForForLocationServices:accessStatusCallBack
                                                       accessStatus:SDLocationAuthorizationStatus_NotSupport
                                                               type:SDPrivacyType_LocationServices];
    }else{
        CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
        
        if (status == kCLAuthorizationStatusNotDetermined) {
            //            [SDAuthorizationTools executeCallBackForForLocationServices:accessStatusCallBack
            //                                           accessStatus:SDLocationAuthorizationStatus_NotDetermined
            //                                                   type:SDPrivacyType_LocationServices];
            self.locationManager = [[CLLocationManager alloc] init];
            self.locationManager.delegate = self;
            
            // 两种定位模式：[self.locationManager requestAlwaysAuthorization];
            [self.locationManager requestWhenInUseAuthorization];
            [self setKCLCallBackBlock:^(CLAuthorizationStatus state){
                if (status == kCLAuthorizationStatusNotDetermined) {
                    [SDAuthorizationTool executeCallBackForForLocationServices:accessStatusCallBack
                                                                   accessStatus:SDLocationAuthorizationStatus_NotDetermined
                                                                           type:SDPrivacyType_LocationServices];
                    
                }else if (status == kCLAuthorizationStatusRestricted) {
                    [SDAuthorizationTool executeCallBackForForLocationServices:accessStatusCallBack
                                                                   accessStatus:SDLocationAuthorizationStatus_Restricted
                                                                           type:SDPrivacyType_LocationServices];
                    
                }else if (status == kCLAuthorizationStatusDenied) {
                    [SDAuthorizationTool executeCallBackForForLocationServices:accessStatusCallBack
                                                                   accessStatus:SDLocationAuthorizationStatus_Restricted
                                                                           type:SDPrivacyType_LocationServices];
                    
                }else if (status == kCLAuthorizationStatusAuthorizedAlways) {
                    [SDAuthorizationTool executeCallBackForForLocationServices:accessStatusCallBack
                                                                   accessStatus:SDLocationAuthorizationStatus_AuthorizedAlways
                                                                           type:SDPrivacyType_LocationServices];
                    
                }else if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
                    [SDAuthorizationTool executeCallBackForForLocationServices:accessStatusCallBack
                                                                   accessStatus:SDLocationAuthorizationStatus_AuthorizedWhenInUse
                                                                           type:SDPrivacyType_LocationServices];
                    
                }else{
                    // kCLAuthorizationStatusAuthorized < ios8
                    [SDAuthorizationTool executeCallBackForForLocationServices:accessStatusCallBack
                                                                   accessStatus:SDLocationAuthorizationStatus_Authorized
                                                                           type:SDPrivacyType_LocationServices];
                }
            }];
        }else if (status == kCLAuthorizationStatusRestricted) {
            [SDAuthorizationTool executeCallBackForForLocationServices:accessStatusCallBack
                                                           accessStatus:SDLocationAuthorizationStatus_Restricted
                                                                   type:SDPrivacyType_LocationServices];
            
        }else if (status == kCLAuthorizationStatusDenied) {
            [SDAuthorizationTool executeCallBackForForLocationServices:accessStatusCallBack
                                                           accessStatus:SDLocationAuthorizationStatus_Restricted
                                                                   type:SDPrivacyType_LocationServices];
            
        }else if (status == kCLAuthorizationStatusAuthorizedAlways) {
            [SDAuthorizationTool executeCallBackForForLocationServices:accessStatusCallBack
                                                           accessStatus:SDLocationAuthorizationStatus_AuthorizedAlways
                                                                   type:SDPrivacyType_LocationServices];
            
        }else if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
            [SDAuthorizationTool executeCallBackForForLocationServices:accessStatusCallBack
                                                           accessStatus:SDLocationAuthorizationStatus_AuthorizedWhenInUse
                                                                   type:SDPrivacyType_LocationServices];
            
        }else{
            // kCLAuthorizationStatusAuthorized < ios8
            [SDAuthorizationTool executeCallBackForForLocationServices:accessStatusCallBack
                                                           accessStatus:SDLocationAuthorizationStatus_Authorized
                                                                   type:SDPrivacyType_LocationServices];
        }
    }
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    if (self.kCLCallBackBlock) {
        self.kCLCallBackBlock(status);
    }
}



#pragma mark -------------------- Contacts --------------------
#pragma mark -
+ (void)checkAndRequestAccessForContactsWithAccessStatus:(AccessForTypeResultBlock)accessStatusCallBack
{
    if (_isiOS9_Or_Later_) {
        CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        
        if (status == CNAuthorizationStatusNotDetermined) {
            
            CNContactStore *contactStore = [[CNContactStore alloc] init];
            if (contactStore == NULL) {
                
                [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_NotSupport type:SDPrivacyType_Contacts];
            }
            [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
                
                if (error) {
                    NSLog(@"error:%@",error);
                    [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_NotSupport type:SDPrivacyType_Contacts];
                }else{
                    if (granted) {
                        [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Authorized type:SDPrivacyType_Contacts];
                    }else{
                        [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Denied type:SDPrivacyType_Contacts];
                    }
                }
            }];
        }else if (status == CNAuthorizationStatusRestricted) {
            [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Restricted type:SDPrivacyType_Contacts];
        }else if (status == CNAuthorizationStatusDenied) {
            [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Denied type:SDPrivacyType_Contacts];
        }else{
            // CNAuthorizationStatusAuthorized
            [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Authorized type:SDPrivacyType_Contacts];
        }
    }else{
        ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
        
        if (status == kABAuthorizationStatusNotDetermined) {
            //            [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_NotDetermined type:SDPrivacyType_Contacts];
            
            __block ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, NULL);
            if (addressBookRef == NULL) {
                [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_NotSupport type:SDPrivacyType_Contacts];
            }
            
            ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error) {
                if (granted) {
                    [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Authorized type:SDPrivacyType_Contacts];
                }else{
                    [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Denied type:SDPrivacyType_Contacts];
                }
                if (addressBookRef) {
                    CFRelease(addressBookRef);
                    addressBookRef = NULL;
                }
            });
        } else if (status == kABAuthorizationStatusRestricted) {
            [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Restricted type:SDPrivacyType_Contacts];
            
        } else if (status == kABAuthorizationStatusDenied) {
            [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Denied type:SDPrivacyType_Contacts];
            
        } else {
            // kABAuthorizationStatusAuthorized
            [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Authorized type:SDPrivacyType_Contacts];
        }
    }
}



#pragma mark -------------------- Calendars --------------------
#pragma mark -
+ (void)checkAndRequestAccessForCalendarsWithAccessStatus:(AccessForTypeResultBlock)accessStatusCallBack
{
    EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
    if (status == EKAuthorizationStatusNotDetermined) {
        //        [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_NotDetermined type:SDPrivacyType_Calendars];
        
        EKEventStore *store = [[EKEventStore alloc] init];
        if (store == NULL) {
            [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_NotSupport type:SDPrivacyType_Calendars];
        }else{
            [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
                if (error) {
                    [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Denied type:SDPrivacyType_Calendars];
                    
                    NSLog(@"erro:%@",error);
                }
                if (granted) {
                    [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Authorized type:SDPrivacyType_Calendars];
                    
                }else{
                    [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Denied type:SDPrivacyType_Calendars];
                }
            }];
        }
    } else if (status == EKAuthorizationStatusRestricted) {
        [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Restricted type:SDPrivacyType_Calendars];
        
    } else if (status == EKAuthorizationStatusDenied) {
        [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Denied type:SDPrivacyType_Calendars];
        
    } else {
        // EKAuthorizationStatusAuthorized
        [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Authorized type:SDPrivacyType_Calendars];
    }
}



#pragma mark -------------------- Reminders --------------------
#pragma mark -
+ (void)checkAndRequestAccessForRemindersWithAccessStatus:(AccessForTypeResultBlock)accessStatusCallBack
{
    EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:EKEntityTypeReminder];
    
    if (status == EKAuthorizationStatusNotDetermined) {
        //        [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_NotDetermined type:SDPrivacyType_Reminders];
        
        EKEventStore *store = [[EKEventStore alloc] init];
        if (store == NULL) {
            [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_NotSupport type:SDPrivacyType_Reminders];
            
        }else{
            [store requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError * _Nullable error) {
                if (error) {
                    [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Denied type:SDPrivacyType_Reminders];
                    
                    NSLog(@"erro:%@",error);
                }
                if (granted) {
                    [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Authorized type:SDPrivacyType_Reminders];
                    
                }else{
                    [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Denied type:SDPrivacyType_Reminders];
                }
            }];
        }
        
    } else if (status == EKAuthorizationStatusRestricted) {
        [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Restricted type:SDPrivacyType_Reminders];
        
    } else if (status == EKAuthorizationStatusDenied) {
        [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Denied type:SDPrivacyType_Reminders];
        
    } else {
        // EKAuthorizationStatusAuthorized
        [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Authorized type:SDPrivacyType_Reminders];
    }
}



#pragma mark -------------------- Photos --------------------
#pragma mark -
+ (void)checkAndRequestAccessForPhotosWithAccessStatus:(AccessForTypeResultBlock)accessStatusCallBack
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        
        if (_isiOS8_Or_Later_) {
            PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
            if (status == PHAuthorizationStatusNotDetermined) {
                //                [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_NotDetermined type:SDPrivacyType_Photos];
                
                [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                    if (status == PHAuthorizationStatusNotDetermined) {
                        [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_NotDetermined type:SDPrivacyType_Photos];
                        
                    } else if (status == PHAuthorizationStatusRestricted) {
                        [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Restricted type:SDPrivacyType_Photos];
                        
                    } else if (status == PHAuthorizationStatusDenied) {
                        [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Denied type:SDPrivacyType_Photos];
                        
                    } else {
                        // PHAuthorizationStatusAuthorized
                        [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Authorized type:SDPrivacyType_Photos];
                    }
                }];
                
            } else if (status == PHAuthorizationStatusRestricted) {
                [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Restricted type:SDPrivacyType_Photos];
                
            } else if (status == PHAuthorizationStatusDenied) {
                [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Denied type:SDPrivacyType_Photos];
                
            } else {
                // PHAuthorizationStatusAuthorized
                [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Authorized type:SDPrivacyType_Photos];
                
            }
        } else {
            // iOS7 - iOS8
            ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
            if (status == ALAuthorizationStatusNotDetermined) {
                //                [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_NotDetermined type:SDPrivacyType_Photos];
                
                // 当某些情况下，ALAuthorizationStatus 为 ALAuthorizationStatusNotDetermined的时候，无法弹出系统首次使用的收取alertView，系统设置中也没有相册的设置，此时将无法使用，所以做以下操作，弹出系统首次使用的授权alertView
                __block BOOL isShow = YES;
                ALAssetsLibrary *assetLibrary = [[ALAssetsLibrary alloc] init];
                [assetLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                    if (isShow) {
                        [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Authorized type:SDPrivacyType_Photos];
                        isShow = NO;
                    }
                } failureBlock:^(NSError *error) {
                    [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Denied type:SDPrivacyType_Photos];
                }];
                
            } else if (status == ALAuthorizationStatusRestricted) {
                [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Restricted type:SDPrivacyType_Photos];
                
            } else if (status == ALAuthorizationStatusDenied) {
                [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Denied type:SDPrivacyType_Photos];
                
            } else {
                // ALAuthorizationStatusAuthorized
                [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Authorized type:SDPrivacyType_Photos];
            }
        }
        
    } else {
        NSLog(@"相册不可用！");
        [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_NotSupport type:SDPrivacyType_Photos];
    }
}




#pragma mark -------------------- BluetoothSharing --------------------
#pragma mark -
- (void)checkAndRequestAccessForBluetoothSharingWithAccessStatus:(AccessForBluetoothResultBlock)accessStatusCallBack;
{
    self.cMgr = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    [self setCBManagerStateCallBackBlock:^(CBManagerState status){
        
        if (status == CBManagerStateResetting) {
            [SDAuthorizationTool executeCallBackForForBluetoothSharing:accessStatusCallBack accessStatus:SDCBManagerStatusResetting type:SDPrivacyType_BluetoothSharing];
            
        } else if (status == CBManagerStateUnsupported) {
            [SDAuthorizationTool executeCallBackForForBluetoothSharing:accessStatusCallBack accessStatus:SDCBManagerStatusUnsupported type:SDPrivacyType_BluetoothSharing];
            
        } else if (status == CBManagerStateUnauthorized) {
            [SDAuthorizationTool executeCallBackForForBluetoothSharing:accessStatusCallBack accessStatus:SDCBManagerStatusUnauthorized type:SDPrivacyType_BluetoothSharing];
            
        } else if (status == CBManagerStatePoweredOff) {
            [SDAuthorizationTool executeCallBackForForBluetoothSharing:accessStatusCallBack accessStatus:SDCBManagerStatusPoweredOff type:SDPrivacyType_BluetoothSharing];
            
        } else if (status == CBManagerStatePoweredOn) {
            [SDAuthorizationTool executeCallBackForForBluetoothSharing:accessStatusCallBack accessStatus:SDCBManagerStatusPoweredOn type:SDPrivacyType_BluetoothSharing];
            
        } else {
            // CBManagerStateUnknown
            [SDAuthorizationTool executeCallBackForForBluetoothSharing:accessStatusCallBack accessStatus:SDCBManagerStatusUnknown type:SDPrivacyType_BluetoothSharing];
        }
    }];
}

#pragma mark - CBCentralManagerDelegate
- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    
    if (self.CBManagerStateCallBackBlock) {
        self.CBManagerStateCallBackBlock(central.state);
    }
}



#pragma mark -------------------- Microphone --------------------
#pragma mark -
+ (void)checkAndRequestAccessForMicrophoneWithAccessStatus:(AccessForTypeResultBlock)accessStatusCallBack
{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    
    if (status == AVAuthorizationStatusNotDetermined) {
        //        [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_NotDetermined type:SDPrivacyType_Microphone];
        
        [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
            if (granted) {
                [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Authorized type:SDPrivacyType_Microphone];
                
            }else{
                [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Denied type:SDPrivacyType_Microphone];
            }
        }];
        
    } else if (status == AVAuthorizationStatusRestricted) {
        [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Restricted type:SDPrivacyType_Microphone];
        
    } else if (status == AVAuthorizationStatusDenied) {
        [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Denied type:SDPrivacyType_Microphone];
        
    } else {
        // AVAuthorizationStatusAuthorized
        [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Authorized type:SDPrivacyType_Microphone];
    }
}



#pragma mark -------------------- SpeechRecognition --------------------
#pragma mark -
+ (void)checkAndRequestAccessForSpeechRecognitionWithAccessStatus:(AccessForTypeResultBlock)accessStatusCallBack
{
    if (_isiOS10_Or_Later_) {
        SFSpeechRecognizerAuthorizationStatus status = [SFSpeechRecognizer authorizationStatus];
        
        if (status == SFSpeechRecognizerAuthorizationStatusNotDetermined) {
            //            [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_NotDetermined type:SDPrivacyType_SpeechRecognition];
            
            [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
                
                if (status == SFSpeechRecognizerAuthorizationStatusNotDetermined) {
                    [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_NotDetermined type:SDPrivacyType_SpeechRecognition];
                    
                } else if (status == SFSpeechRecognizerAuthorizationStatusDenied) {
                    [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Denied type:SDPrivacyType_SpeechRecognition];
                    
                } else if (status == SFSpeechRecognizerAuthorizationStatusRestricted) {
                    [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Restricted type:SDPrivacyType_SpeechRecognition];
                    
                } else {
                    // SFSpeechRecognizerAuthorizationStatusAuthorized
                    [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Authorized type:SDPrivacyType_SpeechRecognition];
                }
            }];
            
        } else if (status == SFSpeechRecognizerAuthorizationStatusDenied) {
            [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Denied type:SDPrivacyType_SpeechRecognition];
            
        } else if (status == SFSpeechRecognizerAuthorizationStatusRestricted) {
            [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Restricted type:SDPrivacyType_SpeechRecognition];
            
        } else {
            // SFSpeechRecognizerAuthorizationStatusAuthorized
            [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Authorized type:SDPrivacyType_SpeechRecognition];
        }
    }else{
        [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_NotSupport type:SDPrivacyType_SpeechRecognition];
        
    }
}



#pragma mark -------------------- Camera --------------------
#pragma mark -
+ (void)checkAndRequestAccessForCameraWithAccessStatus:(AccessForTypeResultBlock)accessStatusCallBack
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        
        if (status == AVAuthorizationStatusNotDetermined) {
            //            [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_NotDetermined type:SDPrivacyType_Camera];
            
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Authorized type:SDPrivacyType_Camera];
                }else{
                    [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Denied type:SDPrivacyType_Camera];
                    
                }
            }];
        } else if (status == AVAuthorizationStatusRestricted) {
            [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Restricted type:SDPrivacyType_Camera];
            
        } else if (status == AVAuthorizationStatusDenied) {
            [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Denied type:SDPrivacyType_Camera];
            
        } else {
            // AVAuthorizationStatusAuthorized
            [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Authorized type:SDPrivacyType_Camera];
        }
        
    }else{
        [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_NotSupport type:SDPrivacyType_Camera];
    }
}



#pragma mark -------------------- Health --------------------
#pragma mark -
- (void)checkAndRequestAccessForHealthWtihAccessStatus:(AccessForTypeResultBlock)accessStatusCallBack
{
    if (_isiOS8_Or_Later_) {
        if ([HKHealthStore isHealthDataAvailable]) {
            if (!self.healthStore) {
                self.healthStore = [[HKHealthStore alloc] init];
            }
            
            // 以心率 HKQuantityTypeIdentifierHeartRate 为例子
            HKQuantityType *heartRateType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRate];
            HKAuthorizationStatus status = [self.healthStore authorizationStatusForType:heartRateType];
            
            if (status == HKAuthorizationStatusNotDetermined) {
                
                //                [SDAuthorizationTools executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_NotDetermined type:ECPrivacyType_Health];
                
                NSSet *typeSet = [NSSet setWithObject:heartRateType];
                
                [self.healthStore requestAuthorizationToShareTypes:typeSet readTypes:typeSet completion:^(BOOL success, NSError * _Nullable error) {
                    
                    // tips：这个block不止在用户点击允许或者不允许的时候响应，在弹出访问健康数据允许窗口后，只要界面发生变化（以及程序进入后台），都会响应该block。
                    // sucess 为YES代表用户响应了该界面，允许或者拒绝
                    if (success) {
                        // 由于用户已经响该界面（不管是允许或者拒绝）
                        // 并且这时候应该只会有两种状态：HKAuthorizationStatusSharingAuthorized 或者 HKAuthorizationStatusSharingDenied
                        HKAuthorizationStatus status = [self.healthStore authorizationStatusForType:heartRateType];
                        if (status == HKAuthorizationStatusNotDetermined) {
                            [SDAuthorizationTool executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_NotDetermined type:SDPrivacyType_Health];
                            
                        } else if (status == HKAuthorizationStatusSharingAuthorized) {
                            [SDAuthorizationTool executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Authorized type:SDPrivacyType_Health];
                            
                        } else {
                            // HKAuthorizationStatusSharingDenied
                            [SDAuthorizationTool executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Denied type:SDPrivacyType_Health];
                        }
                    }else{
                        if (error) {
                            NSLog(@"requestHealthAuthorization: error:%@",error);
                        }
                    }
                }];
            } else if (status == HKAuthorizationStatusSharingAuthorized) {
                [SDAuthorizationTool executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Authorized type:SDPrivacyType_Health];
                
            } else {
                // HKAuthorizationStatusSharingDenied
                [SDAuthorizationTool executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Denied type:SDPrivacyType_Health];
            }
        }else{
            [SDAuthorizationTool executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_NotSupport type:SDPrivacyType_Health];
            NSLog(@"unavailable");
            // Health data is not avaliable on all device.
        }
    }else{
        [SDAuthorizationTool executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_NotSupport type:SDPrivacyType_Health];
        NSLog(@"iOS8以下不支持");
    }
}



#pragma mark -------------------- HomeKit --------------------
#pragma mark -
- (void)checkAndRequestAccessForHome:(AccessForHomeResultBlock)accessForHomeCallBack
{
    if (_isiOS8_Or_Later_) {
        if (!self.homeManager) {
            self.homeManager = [[HMHomeManager alloc] init];
            self.homeManager.delegate = self;
            
            [self setHomeAccessCallBackBlock:^(BOOL isHaveAccess){
                if (accessForHomeCallBack) {
                    accessForHomeCallBack(isHaveAccess);
                }
            }];
        }
    } else {
        NSLog(@"The home is available on ios8 or later");
    }
}

#pragma mark - HMHomeManagerDelegate
- (void)homeManagerDidUpdateHomes:(HMHomeManager *)manager{
    if (manager.homes.count > 0) {
        NSLog(@"A home exists, so we have access.");
        if (self.HomeAccessCallBackBlock) {
            self.HomeAccessCallBackBlock(YES);
        }
    } else {
        
        __weak HMHomeManager *weakHomeManager = manager;
        [manager addHomeWithName:@"Test Home" completionHandler:^(HMHome * _Nullable home, NSError * _Nullable error) {
            
            if (!error) {
                NSLog(@"We have access for home.");
                if (self.HomeAccessCallBackBlock) {
                    self.HomeAccessCallBackBlock(YES);
                }
            } else {
                // tips：出现错误，错误类型参考 HMError.h
                if (error.code == HMErrorCodeHomeAccessNotAuthorized) {
                    // User denied permission.
                    NSLog(@"用户拒绝!!");
                } else {
                    NSLog(@"HOME_ERROR:%ld,%@",error.code, error.localizedDescription);
                }
                if (self.HomeAccessCallBackBlock) {
                    self.HomeAccessCallBackBlock(YES);
                }
            }
            
            if (home) {
                [weakHomeManager removeHome:home completionHandler:^(NSError * _Nullable error) {
                    // ... do something with the result of removing the home ...
                }];
            }
        }];
    }
}



#pragma mark -------------------- MediaAndAppleMusic --------------------
#pragma mark -
+ (void)checkAndRequestAccessForAppleMusicWithAccessStatus:(AccessForTypeResultBlock)accessStatusCallBack
{
    if ([UIDevice currentDevice].systemVersion.floatValue >= 9.3f) {
        
        SKCloudServiceAuthorizationStatus status = [SKCloudServiceController authorizationStatus];
        
        if (status == SKCloudServiceAuthorizationStatusNotDetermined) {
            //            [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_NotDetermined type:SDPrivacyType_MediaAndAppleMusic];
            
            [SKCloudServiceController requestAuthorization:^(SKCloudServiceAuthorizationStatus status) {
                switch (status) {
                    case SKCloudServiceAuthorizationStatusNotDetermined:
                    {
                        [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_NotDetermined type:SDPrivacyType_MediaAndAppleMusic];
                    }
                        break;
                    case SKCloudServiceAuthorizationStatusRestricted:
                    {
                        [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Restricted type:SDPrivacyType_MediaAndAppleMusic];
                    }
                        break;
                    case SKCloudServiceAuthorizationStatusDenied:
                    {
                        [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Denied type:SDPrivacyType_MediaAndAppleMusic];
                    }
                        break;
                    case SKCloudServiceAuthorizationStatusAuthorized:
                    {
                        [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Authorized type:SDPrivacyType_MediaAndAppleMusic];
                    }
                        break;
                    default:
                        break;
                }
            }];
        } else if (status == SKCloudServiceAuthorizationStatusRestricted) {
            [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Restricted type:SDPrivacyType_MediaAndAppleMusic];
            
        } else if (status == SKCloudServiceAuthorizationStatusDenied) {
            [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Denied type:SDPrivacyType_MediaAndAppleMusic];
            
        } else{
            // SKCloudServiceAuthorizationStatusAuthorized
            [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_Authorized type:SDPrivacyType_MediaAndAppleMusic];
        }
    }else{
        [self executeCallBack:accessStatusCallBack accessStatus:SDAuthorizationStatus_NotSupport type:SDPrivacyType_MediaAndAppleMusic];
        NSLog(@"AppleMusic只支持iOS9.3+");
    }
}



#pragma mark -------------------- MotionAndFitness --------------------
#pragma mark -
- (void)checkAndRequestAccessForMotionAndFitness
{
    self.cmManager = [[CMMotionActivityManager alloc] init];
    self.motionActivityQueue = [[NSOperationQueue alloc] init];
    [self.cmManager startActivityUpdatesToQueue:self.motionActivityQueue withHandler:^(CMMotionActivity *activity) {
        // Do something with the activity reported.
        [self.cmManager stopActivityUpdates];
        
        NSLog(@"We have access for MotionAndFitness.");
    }];
    
    NSLog(@"We don't have permission to MotionAndFitness.");
}




#pragma mark -------------------- accessStatus callbacks --------------------
#pragma mark -
// all CallBack
+ (void)executeCallBack:(AccessForTypeResultBlock)accessStatusCallBack accessStatus:(SDAuthorizationStatus)accessStatus type:(SDPrivacyType)type
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (accessStatusCallBack) {
            accessStatusCallBack(accessStatus, type);
            
            NSLog(@"\n//************************************************************//\n获取权限类型：%@\n权限状态：%@\n//************************************************************//\n",[SDAuthorizationTool stringForPrivacyType:type], [SDAuthorizationTool stringForAuthorizationStatus:accessStatus]);
        }
    });
}

// Location Services CallBack
+ (void)executeCallBackForForLocationServices:(AccessForLocationResultBlock)accessStatusCallBack accessStatus:(SDLocationAuthorizationStatus)accessStatus type:(SDPrivacyType)type
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (accessStatusCallBack) {
            accessStatusCallBack(accessStatus);
            
            NSLog(@"\n//************************************************************//\n获取权限类型：%@\n权限状态：%@\n//************************************************************//\n",[SDAuthorizationTool stringForPrivacyType:type], [SDAuthorizationTool stringForLocationAuthorizationStatus:accessStatus]);
        }
    });
}

// Bluetooth Sharing CallBack
+ (void)executeCallBackForForBluetoothSharing:(AccessForBluetoothResultBlock)accessStatusCallBack accessStatus:(SDCBManagerStatus)accessStatus type:(SDPrivacyType)type
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (accessStatusCallBack) {
            accessStatusCallBack(accessStatus);
        }
    });
}




#pragma mark -------------------- Public Methods --------------------
#pragma mark -
+ (NSString *)stringForPrivacyType:(SDPrivacyType)privacyType;
{
    if (privacyType == SDPrivacyType_LocationServices) {
        return @"LocationServices";
    }else if (privacyType == SDPrivacyType_Contacts) {
        return @"Contacts";
    }else if (privacyType == SDPrivacyType_Calendars) {
        return @"Calendars";
    }else if (privacyType == SDPrivacyType_Reminders) {
        return @"Reminders";
    }else if (privacyType == SDPrivacyType_Photos) {
        return @"Photos";
    }else if (privacyType == SDPrivacyType_BluetoothSharing) {
        return @"BluetoothSharing";
    }else if (privacyType == SDPrivacyType_Microphone) {
        return @"Microphone";
    }else if (privacyType == SDPrivacyType_SpeechRecognition) {
        return @"SpeechRecognition";
    }else if (privacyType == SDPrivacyType_Camera) {
        return @"Camera";
    }else if (privacyType == SDPrivacyType_Health) {
        return @"Health";
    }else if (privacyType == SDPrivacyType_HomeKit) {
        return @"Home";
    }else if (privacyType == SDPrivacyType_MediaAndAppleMusic) {
        return @"Media And AppleMusic";
    }else if (privacyType == SDPrivacyType_MotionAndFitness) {
        return @"Motion And Fitness";
    }else{
        return @"";
    }
}

+ (NSString *)stringForAuthorizationStatus:(SDAuthorizationStatus)authorizationStatus;
{
    if (authorizationStatus == SDAuthorizationStatus_Authorized) {
        return @"Authorized";
    }else if (authorizationStatus == SDAuthorizationStatus_Denied) {
        return @"Denied";
    }else if (authorizationStatus == SDAuthorizationStatus_Restricted) {
        return @"Restricted";
    }else if (authorizationStatus == SDAuthorizationStatus_NotSupport) {
        return @"NotSupport";
    }else{
        return @"NotDetermined";
    }
}

+ (NSString *)stringForLocationAuthorizationStatus:(SDLocationAuthorizationStatus)locationAuthorizationStatus;
{
    if (locationAuthorizationStatus == SDLocationAuthorizationStatus_Authorized) {
        return @"Location Authorized, < ios8";
    }else if (locationAuthorizationStatus == SDLocationAuthorizationStatus_Denied) {
        return @"Location Denied";
    }else if (locationAuthorizationStatus == SDLocationAuthorizationStatus_Restricted) {
        return @"Location Restricted";
    }else if (locationAuthorizationStatus == SDLocationAuthorizationStatus_NotSupport) {
        return @"Location NotSupport";
    }else if (locationAuthorizationStatus == SDLocationAuthorizationStatus_AuthorizedAlways) {
        return @"Location AuthorizedAlways";
    }else if (locationAuthorizationStatus == SDLocationAuthorizationStatus_AuthorizedWhenInUse) {
        return @"Location AuthorizedWhenInUse";
    }else{
        return @"Location NotDetermined";
    }
}

+ (NSString *)stringForCBManagerStatus:(SDCBManagerStatus)CBManagerStatus;
{
    if (CBManagerStatus == SDCBManagerStatusResetting) {
        return @"Bluetooth Resetting";
    }else if (CBManagerStatus == SDCBManagerStatusUnsupported) {
        return @"Bluetooth Unsupported";
    }else if (CBManagerStatus == SDCBManagerStatusUnauthorized) {
        return @"Bluetooth Unauthorized";
    }else if (CBManagerStatus == SDCBManagerStatusPoweredOff) {
        return @"Bluetooth PoweredOff";
    }else if (CBManagerStatus == SDCBManagerStatusPoweredOn) {
        return @"Bluetooth PoweredOn";
    }else{
        return @"Bluetooth Unknown";
    }
}



@end








