//
//  DCPI18nManager.h
//  DCPay
//
//  Created by lfl on 2018/5/9.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCPLanguageModel.h"

// 语言改变通知：object:languageCode
#define DCPI18n_LanguageChanged_Noti  @"DCPI18n_LanguageChanged_Noti"

@interface DCPI18nManager : NSObject

/**
 *  获取 DCPI18nManager 单例
 *
 *  @return DCPI18nManager 单例
 */
+ (instancetype)sharedManager;

/**
 *  获取当前使用的语言code
 *  @return 当前使用的语言。
 */
- (NSString *)languageCode;

/**
 *  获取当前使用的语言
 *  @return 当前使用的语言。
 */
- (DCPLanguageModel *)languageModel;

/**
 *  设定当前的语言类型。
 *
 *  @param languageCode 需要切换至的语言类型。
 */
- (void)setLanguageCode:(NSString *)languageCode;

/**
 *  获取当前支持的语言列表。
 *
 *  @return 当前支持的语言列表。DCPLanguageModel数组。
 */
- (NSArray *)supportedLanguage;


#pragma mark - 文本国际化

/**
 本地化语言,mainbundle中获取
 
 @param key key
 @return value
 */
+ (NSString *)localizedStringWithKey:(NSString *)key;

/**
 指定bundle中获取本地化语言
 
 @param key key
 @param bundle bundle
 @return value
 */
+ (NSString *)localizedStringWithKey:(NSString *)key inBundle:(NSBundle *)bundle;

@end
