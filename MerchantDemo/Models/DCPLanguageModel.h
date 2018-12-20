//
//  DCPLanguageModel.h
//  DCPay
//
//  Created by lfl on 2018/5/9.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCPLanguageModel : NSObject

/**
 语言代码，如：zh_CN
 */
@property (nonatomic, copy) NSString* code;

/**
 语言显示名称，如：简体中文
 */
@property (nonatomic, copy) NSString* displayName;

/**
 语言本地化目录前缀，如：zh-Hans.lproj中的zh-Hans
 */
@property (nonatomic, copy) NSString* dirPrefix;

+ (instancetype)modelWithCode:(NSString*)code displayName:(NSString*)name dirPrefix:(NSString*)prefix;

@end
