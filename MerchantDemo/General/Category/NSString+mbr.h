//
//  NSString+mbr.h
//  DCPay
//
//  Created by 詹斌 on 2018/4/15.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (mbr)

//获取首字母(传入字符串(包括汉字), 返回大写拼音首字母)
-(NSString *)mbr_firstCharactor;
//md5加密
- (NSString *)mbr_md5;

/**
 *  截取URL字符串中的参数
 *
 *  @return NSMutableDictionary parameters
 */
- (NSMutableDictionary *)mbr_getURLParameters;

/**
 解析参数
 
 @return NSMutableDictionary parameters
 */
- (NSMutableDictionary *)mbr_parseParameters;

+ (NSString*)stringFromJSONData:(id)infoDict;

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

@end
