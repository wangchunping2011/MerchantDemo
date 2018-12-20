//
//  DCPI18nLocal.h
//  DCPay
//
//  Created by lfl on 2018/5/10.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCPI18nLocal : NSObject
/**
 获取 LanguageCode，如 zh-Hans
 
 @return Language-Code
 */
+ (NSString *)languageCode;

/**
 CountryCode, 如 CN
 
 @return Country Code
 */
+ (NSString *)countryCode;


/**
 Locale = LanguageCode + CounrtyCode, 如 zh-Hans-CN
 
 @return Locale
 */
+ (NSString *)languageLocale;

@end
