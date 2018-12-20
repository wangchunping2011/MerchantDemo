//
//  DCPI18nLocal.m
//  DCPay
//
//  Created by lfl on 2018/5/10.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import "DCPI18nLocal.h"
#import <UIKit/UIDevice.h>

@implementation DCPI18nLocal

+ (NSString *)languageCode {
    NSString *currentLocale = [self systemLocale];
    if ([[UIDevice currentDevice].systemVersion floatValue] < 9.0) {
        return currentLocale;
    } else {
        NSInteger length = [currentLocale length] - [[self countryCode] length] - 1;
        if (length < 0) {
            // 兼容：iOS 10 模拟器返回没有地区码，真机不会出现。
            return currentLocale;
        }
        return [currentLocale substringToIndex:length];
    }
}

+ (NSString *)countryCode {
    return [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode];
}

+ (NSString *)languageLocale {
    NSString *currentLocale = [self systemLocale];
    if ([[UIDevice currentDevice].systemVersion floatValue] < 9.0) {
        NSString *countryCodeAppend = [NSString stringWithFormat:@"-%@", [self countryCode]];
        return [currentLocale stringByAppendingString:countryCodeAppend];
    } else {
        return currentLocale;
    }
}

+ (NSString *)systemLocale {
    NSString *currentLocale = [[NSLocale preferredLanguages] firstObject];
    
    if ([currentLocale isEqualToString:@"zh-HK"]) {
        if ([[UIDevice currentDevice].systemVersion floatValue] < 9.0) {
            return @"zh-Hant";
        } else {
            return @"zh-Hant-HK";
        }
    }
    return currentLocale;
}

@end
