//
//  DCPPayResultUtil.h
//  DCPay
//
//  Created by zhanbin on 2018/5/16.
//  Copyright © 2018年 mbr. All rights reserved.
//
#import <Foundation/Foundation.h>

typedef  NS_ENUM(NSInteger, DCPPayResultType){
    DCPPayResultTypeSuccess = 1,
    DCPPayResultTypeCancel = 2,
    DCPPayResultTypeFailInvalidParams = 3
};

@interface DCPPayResultUtil : NSObject

//获取错误message
+ (NSString *)getErrorMessage:(DCPPayResultType)resultType;


/**
 跳转回商户appp

 @param resultType 支付结果
 @param fromScheme 商户app scheme
 @param orderInfo 商户传进来的orderInfo
 */
+ (void)gotoMerchantApp:(DCPPayResultType)resultType fromScheme:(NSString *)fromScheme orderInfo:(NSString *)orderInfo;

@end
