





#import <Foundation/Foundation.h>

#define GLOBAL_STR(key) [LanguageTool globalString:key alter:nil]

#define LanguageCodes @[@"zh-Hans", @"en"] // 输入的语言key列表

@interface LanguageTool : NSObject

// 此方法在外部当且仅当程序启动时被调用；加载语言对应的bundle。
+ (void)setupBundle;

// 已封装成宏。不应该被直接调用，而是调用GLOBAL_STR(key)。
+ (NSString *)globalString:(NSString *)key alter:(NSString *)alternate;

// 手动切换语言时调用此方法。
// 返回NO表示无变更，返回YES表示变更了语言。
+ (BOOL)selectLanguage:(NSString *)language;

+ (NSUInteger)currentLanguageIndex;

@end


