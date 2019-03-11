//
//  NSObject+Archiver.m
//  TryToHARAM
//
//  Created by xialan on 2018/10/19.
//  Copyright © 2018 HARAM. All rights reserved.
//

#import "NSObject+Archiver.h"
#import "NSObject+AllProperties.h"
#import <objc/runtime.h>

@interface NSObject()

@property(nonatomic,copy) NSString *SD_Archiver_Name;

@end

static const void *SD_Archiver_Name_Key = "SD_Archiver_Name_Key";

@implementation NSObject (Archiver)

//分类的属性只生成set和get方法，并不生成实例变量(_xxx)
- (void)setSD_Archiver_Name:(NSString *)SD_Archiver_Name{
    
    objc_setAssociatedObject(self, SD_Archiver_Name_Key, SD_Archiver_Name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)SD_Archiver_Name{
    
    return objc_getAssociatedObject(self, SD_Archiver_Name_Key);
}

- (BOOL)sd_archiveToName:(NSString *)name{
    
    return [self sd_archiveToName:name isChildObject:NO];
}

- (BOOL)sd_archiveToName:(NSString *)name isChildObject:(BOOL)isChildObject{
    
    //是对象中的子对象
    if (isChildObject) {
        return [NSKeyedArchiver archiveRootObject:self toFile:[[self class] getChildObjectPath:name]];
    }else{
        self.SD_Archiver_Name = name;
        NSString *path = [[self class] getPath:name];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if (![fileManager fileExistsAtPath:path]) {
            [fileManager createDirectoryAtPath:[NSString stringWithFormat:@"%@/%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject],@"SDArchiver"] withIntermediateDirectories:YES attributes:nil error:nil];
        }
        return [NSKeyedArchiver archiveRootObject:self toFile:path];
    }
}

+ (id)sd_unArchive:(NSString *)name{
    
    return [self sd_unArchive:name isChildObject:NO];
}

+ (id)sd_unArchive:(NSString *)name isChildObject:(BOOL)isChildObject{
    
    //这个时候的self是类对象
    //self.GX_Archiver_Name = name;
    objc_setAssociatedObject(self, SD_Archiver_Name_Key, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
    if (isChildObject) {
        NSLog(@"%@---%@",[self class],[[self class] getChildObjectPath:name]);
        return [NSKeyedUnarchiver unarchiveObjectWithFile:[[self class] getChildObjectPath:name]];
    }else{
        
        return [NSKeyedUnarchiver unarchiveObjectWithFile:[[self class] getPath:name]];
    }
}

+ (NSString *)getChildObjectPath:(NSString *)name {
    NSString * docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString * path = [docPath stringByAppendingPathComponent:[NSString stringWithFormat:@"SDArchiver/SD_%@.archiver",name]];
    return path;
}

+ (NSString *)getPath:(NSString *)name{
    NSString * docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString * path = [docPath stringByAppendingPathComponent:[NSString stringWithFormat:@"SDArchiver/SD___%@.archiver",name]];
    
    NSLog(@"path:====%@",path);
    return path;
}

#pragma mark -- NSCoding --
- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    NSArray *propertyArr = [self sd_allProperty];
    for (NSDictionary *propertyDic in propertyArr) {
        [self encodeWithType:propertyDic[@"type"] name:propertyDic[@"name"] coder:aCoder];
    }
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    NSArray * propertyArr = [self sd_allProperty];
    for (NSDictionary * propertyDic in propertyArr) {
        if ([self decodeWithType:propertyDic[@"type"] Name:propertyDic[@"name"] Coder:aDecoder]) {
            [self setValue:[self decodeWithType:propertyDic[@"type"] Name:propertyDic[@"name"] Coder:aDecoder] forKey:propertyDic[@"name"]];
        }
    }
    return self;
}
#pragma clang diagnostic pop
- (id)decodeWithType:(NSString *)type Name:(NSString *)name Coder:(NSCoder *)aDecoder {
    //由于gx_unArchiveToName是类方法所以self是类对象，所以GX_unArchiveToName是绑定到了类对象，并不是实例对象
    NSString *sd_Archiver_Name =  objc_getAssociatedObject([self class], SD_Archiver_Name_Key);
    if ([self isObject:type]) {
        return [aDecoder decodeObjectOfClass:NSClassFromString(type) forKey:name];
    } else if([type isEqualToString:@"int"]||
              [type isEqualToString:@"short"]){
        return @([aDecoder decodeIntegerForKey:name]);
    } else if([type isEqualToString:@"BOOL"]){
        return @([aDecoder decodeBoolForKey:name]);
    } else if([type isEqualToString:@"float"]){
        return @([aDecoder decodeFloatForKey:name]);
    } else if([type isEqualToString:@"double"]){
        return @([aDecoder decodeDoubleForKey:name]);
    } else if([type isEqualToString:@"NSInteger"]||
              [type isEqualToString:@"NSUInteger"]){
        return @([aDecoder decodeIntegerForKey:name]);
    }
    if ([type hasPrefix:@"__Model__:"]) {
        NSString * className = [type componentsSeparatedByString:@"__Model__:"][1];
        NSString * path = [NSString stringWithFormat:@"%@_%@_%@_%@",NSStringFromClass(self.class),sd_Archiver_Name,className,name];
        [self setValue:[NSClassFromString(className) sd_unArchive:path isChildObject:YES]forKey:name];
    }
    return nil;
}
- (void)encodeWithType:(NSString *)type name:(NSString *)name coder:(NSCoder *)aCoder{
    
    if ([self isObject:type]) {//foundation类型
        [aCoder encodeObject:[self valueForKey:name] forKey:name];
    } else if([type isEqualToString:@"BOOL"]){
        
        [aCoder encodeBool:[[self valueForKey:name] boolValue] forKey:name];
    } else if([type isEqualToString:@"float"]){
        
        [aCoder encodeFloat:[[self valueForKey:name] floatValue] forKey:name];
    } else if([type isEqualToString:@"double"]){
        
        [aCoder encodeFloat:[[self valueForKey:name] doubleValue] forKey:name];
    } else if([type isEqualToString:@"int"]||
              [type isEqualToString:@"short"]){
        
        [aCoder encodeInt:[[self valueForKey:name] intValue] forKey:name];
    } else if([type isEqualToString:@"NSInteger"]||
              [type isEqualToString:@"NSUInteger"]){
        
        [aCoder encodeInteger:[[self valueForKey:name] integerValue] forKey:name];
    }
    if ([type hasPrefix:@"__Model__:"]) {
        NSString * className = [type componentsSeparatedByString:@"__Model__:"][1];
        NSString * path = [NSString stringWithFormat:@"%@_%@_%@_%@",NSStringFromClass(self.class),self.SD_Archiver_Name,className,name];
        [[self valueForKey:name] sd_archiveToName:path isChildObject:YES];
    }
}

- (BOOL)isObject:(NSString *)type {
    NSArray * objectTypeArr = @[@"NSString",
                                @"NSMutableString",
                                @"NSArray",
                                @"NSMutableArray",
                                @"NSDictionary",
                                @"NSMutableDictionary",
                                @"NSData",
                                @"NSMutableData",
                                @"NSSet",
                                @"NSMutableSet",
                                @"NSNumber"];
    return [objectTypeArr containsObject:type];
}


@end
