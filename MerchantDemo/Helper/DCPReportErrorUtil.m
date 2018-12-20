//
//  DCPReportErrorUtil.m
//  DCPay
//
//  Created by zhanbin on 2018/6/20.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import "DCPReportErrorUtil.h"
#import <Bugly/Bugly.h>

@implementation DCPReportErrorUtil


/**
 上报错误

 @param errorDescription 错误描述
 @param code 错误码
 */
+ (void)reportError:(NSString *)errorDescription errorCode:(NSInteger)code{

    NSDictionary *userInfo = @{NSLocalizedDescriptionKey:errorDescription};
    [self reportErrorWithDomain:@"NSCocoaErrorDomain" errorCode:code userInfo:userInfo];
}


/**
 上报错误

 @param domain domain
 @param code 错误描述
 @param dict 错误码
 */
+ (void)reportErrorWithDomain:(NSErrorDomain)domain errorCode:(NSInteger)code userInfo:(nullable NSDictionary<NSErrorUserInfoKey, id> *)dict{
    NSError *error = [[NSError alloc] initWithDomain:domain
                                                code:code
                                            userInfo:dict];
    [Bugly reportError:error];
}

@end
