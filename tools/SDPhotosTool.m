//
//  SDPhotosTool.m
//  
//
//  Created by ZHAO on 2018/9/28.
//
//

#import "SDPhotosTool.h"
#import <Photos/Photos.h>


@implementation SDPhotosTool

#pragma mark ---------------------  保存图片到 相机胶卷  -------------------
+(void)saveImageIntoAlbumWithImage:(UIImage *)image{
    
    
    //获取之前的访问权限
    PHAuthorizationStatus oldStatus = [PHPhotoLibrary authorizationStatus];
    
    // 请求\检查访问权限 :
    // 如果用户还没有做出选择，会自动弹框，用户对弹框做出选择后，才会调用block
    // 如果之前已经做过选择，会直接执行block
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (status == PHAuthorizationStatusDenied) { // 用户拒绝当前App访问相册
                if (oldStatus != PHAuthorizationStatusNotDetermined) {

                    [SVProgressHUD showInfoWithStatus:@"提示用户打开相册权限"];
                }
            } else if (status == PHAuthorizationStatusAuthorized) { // 用户允许当前App访问相册
                
                [SDPhotosTool saveToCameraRollWith:image];
                
                
            } else if (status == PHAuthorizationStatusRestricted) { // 无法访问相册
                [SVProgressHUD showErrorWithStatus:@"因系统原因，无法访问相册！"];
            }
        });
    }];
    
    
    
    
}


+(void)saveToCameraRollWith:(UIImage *)image{
    
    NSError *error = nil;
    
    // 保存图片到【相机胶卷】
    //        __block PHObjectPlaceholder *placeholder = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        [PHAssetChangeRequest creationRequestForAssetFromImage:image];
    } error:&error];
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存图片失败！"];
        
    }else{
        [SVProgressHUD showSuccessWithStatus:@"保存成功！"];
    }
    
}






#pragma mark ---------------------  保存图片到 自定义相册 (外部调用)  -------------------
+(void)saveImageIntoCustomAlbumWithImage:(UIImage *)image{
    
    //获取之前的访问权限
    PHAuthorizationStatus oldStatus = [PHPhotoLibrary authorizationStatus];
    
    // 请求\检查访问权限 :
    // 如果用户还没有做出选择，会自动弹框，用户对弹框做出选择后，才会调用block
    // 如果之前已经做过选择，会直接执行block
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (status == PHAuthorizationStatusDenied) { // 用户拒绝当前App访问相册
                if (oldStatus != PHAuthorizationStatusNotDetermined) {
                    [SVProgressHUD showWithStatus:@"提示用户打开相册权限"];
                }
            } else if (status == PHAuthorizationStatusAuthorized) { // 用户允许当前App访问相册
                
                [SDPhotosTool saveImage:image];
                
                
                
            } else if (status == PHAuthorizationStatusRestricted) { // 无法访问相册
                [SVProgressHUD showErrorWithStatus:@"因系统原因，无法访问相册！"];
            }
        });
    }];
    

    
}



#pragma mark ---------------  保存图片到 自定义相册 (内部调用) --------------
#pragma mark - 保存图片到自定义相册
+(void)saveImage:(UIImage *)image{
    
    // 获取刚才保存的相片
    PHFetchResult<PHAsset *> *createdAssets = [SDPhotosTool createdAssetsWithImage:image];
    
    
    if (createdAssets == nil) {
        [SVProgressHUD showErrorWithStatus:@"保存图片失败！"];
        return;
    }
    
    // 获得相册
    PHAssetCollection *createdCollection = [SDPhotosTool createdCollection];
    if (createdCollection == nil) {
        [SVProgressHUD showErrorWithStatus:@"创建或者获取相册失败！"];
        return;
    }
    
    // 添加刚才保存的图片到【自定义相册】
    NSError *error = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:createdCollection];
        [request insertAssets:createdAssets atIndexes:[NSIndexSet indexSetWithIndex:0]];
    } error:&error];
    
    // 最后的判断
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存图片失败！"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存图片成功！"];
    }
    
    
}

#pragma mark - 保存图片到相册 并返回保存的图片
+ (PHFetchResult<PHAsset *> *)createdAssetsWithImage:(UIImage *)image{
    
    NSError *error = nil;
    __block NSString *assetID = nil;
    
    // 保存图片到【相机胶卷】
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        assetID = [PHAssetChangeRequest creationRequestForAssetFromImage:image].placeholderForCreatedAsset.localIdentifier;
    } error:&error];
    
    if (error) return nil;
    
    // 获取刚才保存的相片
    return [PHAsset fetchAssetsWithLocalIdentifiers:@[assetID] options:nil];
}




#pragma mark - 获得当前App对应的自定义相册
+ (PHAssetCollection *)createdCollection{
    
    // 获得软件名字
    NSString *title = [NSBundle mainBundle].infoDictionary[(__bridge NSString *)kCFBundleNameKey];
    
    // 抓取所有的自定义相册
    PHFetchResult<PHAssetCollection *> *collections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    // 查找当前App对应的自定义相册
    for (PHAssetCollection *collection in collections) {
        if ([collection.localizedTitle isEqualToString:title]) {
            return collection;
        }
    }
    
    /** 当前App对应的自定义相册没有被创建过 **/
    // 创建一个【自定义相册】
    NSError *error = nil;
    __block NSString *createdCollectionID = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        createdCollectionID = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title].placeholderForCreatedAssetCollection.localIdentifier;
    } error:&error];
    
    if (error) return nil;
    
    // 根据唯一标识获得刚才创建的相册
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[createdCollectionID] options:nil].firstObject;
}


@end
