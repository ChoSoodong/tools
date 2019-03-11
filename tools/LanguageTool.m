






#import "LanguageTool.h"

@implementation LanguageTool

static NSBundle *bundle = nil;

NSString *const LanguageIndentifier = @"LanguageIndentifier";

#pragma mark 外部调用方法

// 当且仅当程序启动时调用此方法来加载bundle。
+ (void)setupBundle{
    
    NSString *language = [self currentLanguageCode];
    [self loadBundleWithLanguage:language];
}

+ (BOOL)selectLanguage:(NSString *)language{
    
    if ([language length] <= 0){
        
        return NO;
    }
    
    // 是否和此前相同，若相同直接返回。
    NSString *previousLanguage = [[NSUserDefaults standardUserDefaults] objectForKey:LanguageIndentifier];
    
    if ([previousLanguage isEqualToString:language]){
        
        return NO;
    }else{
        
        // 有变更，先持久化到userDefault.
        [[NSUserDefaults standardUserDefaults] setObject:language forKey:LanguageIndentifier];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        // 切换到新的bundle
        [self loadBundleWithLanguage:language];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:LanguageChangedNotification
                                                            object:nil];
        return YES;
    }
}

+ (NSString *)globalString:(NSString *)key alter:(NSString *)alternate{
    
    return [bundle localizedStringForKey:key value:alternate table:nil];
}

+ (NSUInteger)currentLanguageIndex{
    
    __block NSUInteger currentIndex = 0;
    NSString *currentLanguage = [self currentLanguageCode];
    NSArray *languages = LanguageCodes;
    [languages enumerateObjectsUsingBlock:^(NSString *language, NSUInteger index, BOOL * stop) {
        if ([currentLanguage isEqualToString:language]){
            
            currentIndex = index;
        }
    }];
    
    return currentIndex;
}

#pragma mark 内部方法
// 加载指定语言的bundle.
+ (void)loadBundleWithLanguage:(NSString *)language{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj"];
    bundle = [NSBundle bundleWithPath:path];
}

+ (NSString *)currentLanguageCode{
    
    NSString *userSelectedLanguage = [[NSUserDefaults standardUserDefaults] objectForKey:LanguageIndentifier];
    
    if ([userSelectedLanguage length] > 0){
        
        return userSelectedLanguage;
        
    }else{
        
        NSString *defaultLanguage = @"zh-Hans";
        [[NSUserDefaults standardUserDefaults] setObject:defaultLanguage
                                                  forKey:LanguageIndentifier];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return defaultLanguage;
    }
}


@end
