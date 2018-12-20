//
//  DCPPayResultUtil.m
//  DCPay
//
//  Created by zhanbin on 2018/5/16.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import "DCPPayResultUtil.h"
#import "DCPResource.h"

//环境地址
//#ifdef COSPAY_TARGET
//const NSString* appScheme = @"cospay";
//#elif defined  HEROPAY_TARGET
//const NSString* appScheme = @"heropay";
//#endif

@implementation DCPPayResultUtil

//获取错误message
+ (NSString *)getErrorMessage:(DCPPayResultType)resultType{
    switch (resultType) {
        case DCPPayResultTypeSuccess:
            return DCPString(@"pay_success");
            break;
        case DCPPayResultTypeCancel:
            return DCPString(@"pay_cancel");
        default:
            break;
    }
    return @"";
}

/**
 跳转回商户app
 @param resultType 支付结果
 @param fromScheme 商户app scheme
 @param orderInfo 商户传进来的orderInfo
 */
+ (void)gotoMerchantApp:(DCPPayResultType)resultType fromScheme:(NSString *)fromScheme orderInfo:(NSString *)orderInfo {
    
    NSString *message = [self getErrorMessage:resultType];
    NSString *urlString = [NSString stringWithFormat:@"%@://%@/payresult?resultStatus=%@&message=%@&orderInfo=%@",fromScheme,@"cospay",@(resultType),[message stringByURLEncode],[orderInfo stringByURLEncode]];
    
    NSURL *merchantAppUrl = [NSURL URLWithString:urlString];
    [[UIApplication sharedApplication] openURL:merchantAppUrl options: @{UIApplicationOpenURLOptionsSourceApplicationKey: @YES} completionHandler:^(BOOL success) {
    }];
}

@end
