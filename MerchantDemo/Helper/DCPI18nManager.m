//
//  DCPI18nManager.m
//  DCPay
//
//  Created by lfl on 2018/5/9.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import "DCPI18nManager.h"
#import "DCPI18nLocal.h"


NSString * const DCPLanguageCodeKey = @"CurrentLanguageCode";
NSString * DCPLanguageDirectory = @"";

@interface DCPI18nManager ()

// 支持的语言列表
@property (nonatomic, strong) NSArray<DCPLanguageModel *> *languageList;
// 当前语言
@property (nonatomic, strong) DCPLanguageModel *currentLanguageModel;

@end

@implementation DCPI18nManager

#pragma mark - 初始化
/**
 *  获取 DCPI18nManager 单例
 *
 *  @return DCPI18nManager 单例
 */
+ (instancetype)sharedManager {
    static DCPI18nManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DCPI18nManager alloc] init];
    });
    
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        [self configAllLanguage];
        [self configCurLanguage];
    }
    return self;
}

/**
 设置支持的语言列表
 */
- (void)configAllLanguage {
    NSMutableArray* array = [NSMutableArray new];
    [array addObject:[DCPLanguageModel modelWithCode:@"en_US" displayName:@"English" dirPrefix:@"en"]];
    [array addObject:[DCPLanguageModel modelWithCode:@"zh_CN" displayName:@"简体中文" dirPrefix:@"zh-Hans"]];
    [array addObject:[DCPLanguageModel modelWithCode:@"zh_TW" displayName:@"繁體中文" dirPrefix:@"zh-Hant"]];
    [array addObject:[DCPLanguageModel modelWithCode:@"ja_JP" displayName:@"日本語" dirPrefix:@"ja"]];
    [array addObject:[DCPLanguageModel modelWithCode:@"ko_KR" displayName:@"한국어" dirPrefix:@"ko"]];
    self.languageList = array;
}

/**
 设置当前语言
 */
- (void)configCurLanguage {
    // 读取存储的语言设置
    NSUserDefaults *languageDefaults = [NSUserDefaults standardUserDefaults];
    NSString *code = [languageDefaults stringForKey:DCPLanguageCodeKey];
    if (code == nil || code.length < 1) { // 第一次使用没有设置过语言，获取系统语言
        code = [self languageCodeFromSystem];
    }
    self.currentLanguageModel = [self languageModelWithCode:code];
    if (self.currentLanguageModel == nil) {
        self.currentLanguageModel = [self.languageList firstObject];
    }
    DCPLanguageDirectory = [self languageDirectory];
}

- (NSString*)languageCodeFromSystem {
    
    NSString *languageLocale = [DCPI18nLocal languageLocale];
    for (DCPLanguageModel *model in self.languageList) {
        if ([languageLocale containsString:model.dirPrefix]) {
            return model.code;
        }
    }
    return nil;
}

/**
 语言code查找对应的model
 */
- (DCPLanguageModel*)languageModelWithCode:(NSString*)code {
    for (DCPLanguageModel* model in self.languageList) {
        if ([model.code isEqualToString:code]) {
            return model;
        }
    }
    return nil;
}

#pragma mark - 语言模型获取
/**
 *  获取当前使用的语言code
 *  @return 当前使用的语言。
 */
- (NSString *)languageCode {
    return self.currentLanguageModel.code;
}

/**
 *  获取当前使用的语言
 *  @return 当前使用的语言。
 */
- (DCPLanguageModel *)languageModel {
    return self.currentLanguageModel;
}

/**
 *  设定当前的语言类型。
 *
 *  @param languageCode 需要切换至的语言类型。
 */
- (void)setLanguageCode:(NSString *)languageCode {
    if (!languageCode) {
        NSLog(@"Language Code 为空。不进行设置");
        return;
    }
    
    if ([self.currentLanguageModel.code isEqualToString:languageCode]) {
        NSLog(@"已经是 %@, 不进行设置", languageCode);
        return;
    }
    
    NSLog(@"应用内语言类型切换至: %@", languageCode);
    
    NSUserDefaults *languageDefaults =[NSUserDefaults standardUserDefaults];
    [languageDefaults setObject:languageCode forKey:DCPLanguageCodeKey];
    [languageDefaults synchronize];
    
    self.currentLanguageModel = [self languageModelWithCode:languageCode];
    DCPLanguageDirectory = [self languageDirectory];
    
    // 发送语言改变通知
    [[NSNotificationCenter defaultCenter] postNotificationName:DCPI18n_LanguageChanged_Noti object:languageCode];
}

/**
 *  获取当前支持的语言列表。
 *
 *  @return 当前支持的语言列表。DCPLanguageModel数组。
 */
- (NSArray *)supportedLanguage {
    return self.languageList;
}

/**
 *  获取当前应用使用的语言目录，以 lproj 结尾。
 *
 *  @return 当前使用的语言目录
 */
- (NSString *)languageDirectory {
    NSString *directoryName = self.currentLanguageModel.dirPrefix;
    return [directoryName stringByAppendingString:@".lproj"];
}

#pragma mark - 文本国际化

/**
 本地化语言,mainbundle中获取
 
 @param key key
 @return value
 */
+ (NSString *)localizedStringWithKey:(NSString *)key {
    return [self localizedStringWithKey:key inBundle:nil];
}

/**
 指定bundle中获取本地化语言
 
 @param key key
 @param bundle bundle
 @return value
 */
+ (NSString *)localizedStringWithKey:(NSString *)key inBundle:(NSBundle *)bundle {
    NSBundle *bundleTemp = bundle ?: [NSBundle mainBundle];
    bundleTemp = [NSBundle bundleWithPath:[bundleTemp pathForResource:DCPLanguageDirectory ofType:nil]];
    NSBundle *curBunddle = bundleTemp ?: [NSBundle mainBundle];
    NSString *text = [curBunddle localizedStringForKey:key value:@"" table:nil];
    return text;
}

@end

