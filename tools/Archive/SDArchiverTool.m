//
//  SDArchiverTool.m
//  TryToHARAM
//
//  Created by xialan on 2018/10/19.
//  Copyright © 2018 HARAM. All rights reserved.
//

#import "SDArchiverTool.h"

@implementation SDArchiverTool

+ (void)clearAll{
    
    NSString * docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager changeCurrentDirectoryPath:docPath];
    NSError *error = nil;
    [fileManager removeItemAtPath:@"SDArchiver" error:&error];
    if (error) {
        NSLog(@"删除出错");
    }
}

+ (void)clear:(NSString *)className{
    
    NSString * docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString * path = [docPath stringByAppendingPathComponent:@"SDArchiver"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager changeCurrentDirectoryPath:path];
    NSError *error = nil;
    NSArray *fileList = [fileManager contentsOfDirectoryAtPath:fileManager.currentDirectoryPath error:&error];
    if (error) {
        NSLog(@"查询出错");
    }
    for (NSString *fileName in fileList) {
        if ([fileName hasPrefix:[NSString stringWithFormat:@"SD_%@",className]]) {
            NSError *error = nil;
            [fileManager removeItemAtPath:fileName error:&error];
            if (error) {
                NSLog(@"删除出错");
            }
        }
    }
}

+ (void)clearWithName:(NSString *)name{
    
    NSString * docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString * path = [docPath stringByAppendingPathComponent:@"SDArchiver"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager changeCurrentDirectoryPath:path];
    NSError *error = nil;
    [fileManager removeItemAtPath:[NSString stringWithFormat:@"SD___%@.archiver",name] error:&error];
    
    if (error) {
        NSLog(@"删除出错");
    }
    
}


@end
