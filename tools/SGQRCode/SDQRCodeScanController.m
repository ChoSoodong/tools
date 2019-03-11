//
//  SDQRCodeScanController.m
//  AlphaPay
//
//  Created by xialan on 2019/2/18.
//  Copyright © 2019 HARAM. All rights reserved.
//

#import "SDQRCodeScanController.h"
#import "SGQRCode.h"
#import "MBProgressHUD+SGQRCode.h"

@interface SDQRCodeScanController (){
    SGQRCodeObtain *obtain;
}
@property (nonatomic, strong) SGQRCodeScanView *scanView;
@property (nonatomic, strong) UILabel *promptLabel;
@property (nonatomic, assign) BOOL stop;


@end

@implementation SDQRCodeScanController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (_stop) {
        [obtain startRunningWithBefore:nil completion:nil];
    }
    [self.view bringSubviewToFront:self.naviView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.scanView addTimer];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.scanView removeTimer];
    
}

- (void)dealloc {
    NSLog(@"WBQRCodeVC - dealloc");
    [self removeScanningView];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    obtain = [SGQRCodeObtain QRCodeObtain];
    
    [self setupQRCodeScan];
    [self setupNavigationBar];
    [self.view addSubview:self.scanView];
    [self.view addSubview:self.promptLabel];
    
    
}

- (void)setupQRCodeScan {
    __weak typeof(self) weakSelf = self;
    
    SGQRCodeObtainConfigure *configure = [SGQRCodeObtainConfigure QRCodeObtainConfigure];
    configure.openLog = YES;
    configure.rectOfInterest = CGRectMake(0.05, 0.2, 0.7, 0.6);
    // 这里只是提供了几种作为参考（共：13）；需什么类型添加什么类型即可
    NSArray *arr = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    configure.metadataObjectTypes = arr;
    
    [obtain establishQRCodeObtainScanWithController:self configure:configure];
    [obtain startRunningWithBefore:^{
        //正在加载中
        [MBProgressHUD SG_showMBProgressHUDWithModifyStyleMessage:@"로드 중" toView:weakSelf.view];
    } completion:^{
        [MBProgressHUD SG_hideHUDForView:weakSelf.view];
    }];
    [obtain setBlockWithQRCodeObtainScanResult:^(SGQRCodeObtain *obtain, NSString *result) {
        if (result) {
            [obtain stopRunning];
            weakSelf.stop = YES;
            [obtain playSoundName:@"SGQRCode.bundle/sound.caf"];
            
            if ([result hasPrefix:@"http"]) {
                [[UIApplication sharedApplication].keyWindow makeToast:result duration:2 position:CSToastPositionCenter];
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else{
                
                //                if (weakSelf.isDismiss) {
                //                    [[NSNotificationCenter defaultCenter] postNotificationName:ScanSuccessNotification object:nil userInfo:@{@"scanResult" : result}];
                //
                //                    [weakSelf.navigationController popViewControllerAnimated:YES];
                //                }else{
                
                NSLog(@"扫描结果------------");
                //                }
                
                
                
            }
            
            
            
            
            //
            //
            //
            //
            //            ScanSuccessJumpVC *jumpVC = [[ScanSuccessJumpVC alloc] init];
            //            jumpVC.comeFromVC = ScanSuccessJumpComeFromWB;
            //            jumpVC.jump_URL = result;
            //            [weakSelf.navigationController pushViewController:jumpVC animated:YES];
        }
    }];
}

- (void)setupNavigationBar {
    
    self.naviRightButtonHide = YES;
     //扫描二维码
    [self addBackButtonAndMiddleTitle:@"QR 코드 스캔" addBackBtn:YES];
    

    
    UIButton *rightBtn = [[UIButton alloc] init];
    //相册
    [rightBtn setTitle:@"앨범" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBarButtonItenAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.naviView.rightBarButtonItem = rightBtn;
    
}

- (void)rightBarButtonItenAction {
    __weak typeof(self) weakSelf = self;
    
    [obtain establishAuthorizationQRCodeObtainAlbumWithController:nil];
    if (obtain.isPHAuthorization == YES) {
        [self.scanView removeTimer];
    }
    [obtain setBlockWithQRCodeObtainAlbumDidCancelImagePickerController:^(SGQRCodeObtain *obtain) {
        [weakSelf.view addSubview:weakSelf.scanView];
    }];
    [obtain setBlockWithQRCodeObtainAlbumResult:^(SGQRCodeObtain *obtain, NSString *result) {
        if (result == nil) {
            NSLog(@"暂未识别出二维码");
        } else {
            if ([result hasPrefix:@"http"]) {
                //                ScanSuccessJumpVC *jumpVC = [[ScanSuccessJumpVC alloc] init];
                //                jumpVC.comeFromVC = ScanSuccessJumpComeFromWB;
                //                jumpVC.jump_URL = result;
                //                [weakSelf.navigationController pushViewController:jumpVC animated:YES];
                
                
                [[UIApplication sharedApplication].keyWindow makeToast:result duration:2 position:CSToastPositionCenter];
                
                
            } else {
                //                ScanSuccessJumpVC *jumpVC = [[ScanSuccessJumpVC alloc] init];
                //                jumpVC.comeFromVC = ScanSuccessJumpComeFromWB;
                //                jumpVC.jump_bar_code = result;
                //                [weakSelf.navigationController pushViewController:jumpVC animated:YES];
                
                //                if (weakSelf.isDismiss) {
                //
                //                    [[NSNotificationCenter defaultCenter] postNotificationName:ScanSuccessNotification object:nil userInfo:@{@"scanResult" : result}];
                //
                //
                //                    [weakSelf.navigationController popViewControllerAnimated:YES];
                //                }else{
                
                NSLog(@"扫描结果------------");
                
                //                }
            }
        }
    }];
}

- (SGQRCodeScanView *)scanView {
    if (!_scanView) {
        _scanView = [[SGQRCodeScanView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, SCREEN_HEIGHT)];
        // 静态库加载 bundle 里面的资源使用 SGQRCode.bundle/QRCodeScanLineGrid
        // 动态库加载直接使用 QRCodeScanLineGrid
        _scanView.scanImageName = @"scanLine";
        _scanView.scanAnimationStyle = ScanAnimationStyleDefault;
        _scanView.cornerLocation = CornerLoactionNoCorner;
        _scanView.borderColor = [UIColor colorWithHex:0x00C1DE];
        _scanView.borderLineWidth = 2;
        
    }
    return _scanView;
}
- (void)removeScanningView {
    [self.scanView removeTimer];
    [self.scanView removeFromSuperview];
    self.scanView = nil;
}

- (UILabel *)promptLabel {
    if (!_promptLabel) {
        _promptLabel = [[UILabel alloc] init];
        _promptLabel.backgroundColor = [UIColor clearColor];
        CGFloat promptLabelX = 0;
        CGFloat promptLabelY = 0.73 * self.view.frame.size.height;
        CGFloat promptLabelW = self.view.frame.size.width;
        CGFloat promptLabelH = 25;
        _promptLabel.frame = CGRectMake(promptLabelX, promptLabelY, promptLabelW, promptLabelH);
        _promptLabel.textAlignment = NSTextAlignmentCenter;
        _promptLabel.font = [UIFont boldSystemFontOfSize:13.0];
        _promptLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
        //请将二维码放入框内
        _promptLabel.text = @"QR 코드를 상자에 넣으십시오.";
    }
    return _promptLabel;
}





@end
