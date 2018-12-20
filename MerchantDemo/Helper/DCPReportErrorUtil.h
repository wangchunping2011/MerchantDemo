//
//  DCPReportErrorUtil.h
//  DCPay
//
//  Created by zhanbin on 2018/6/20.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DCPReportErrorNoDefaultAccount              8000
#define DCPReportErrorGetCoinInfoFail               8001
#define DCPReportErrorGetMerchantInfoFail           8002
#define DCPReportErrorParseOrderStrFail             8003
#define DCPReportErrorSelectAccountNoCoinType       8004
#define DCPReportErrorPayBalanceNotEnough           8005
#define DCPReportErrorTransferBalanceNotEnough      8006
#define DCPReportErrorFeeNotEnough                  8007
#define DCPReportErrorCreateTransactionFail         8008
#define DCPReportErrorSignTransactionFail           8009
#define DCPReportErrorPayFail                       8010
#define DCPReportErrorTransferFail                  8011
#define DCPReportErrorSearchTransactionFail         8012
#define DCPReportErrorGetTransactionDetailFail      8013
#define DCPReportErrorQueryTransactionListFail      8014
#define DCPReportErrorGetInitDataFail               8015
#define DCPReportErrorSetPushFail                   8016
#define DCPReportErrorGetNotificationListFail       8017
#define DCPReportErrorSetNotificationReadFail       8018
#define DCPReportErrorGetNotificationByIdFail       8019
//#define DCPReportErrorGetInitDataFail               8020
#define DCPReportErrorGetIndustryDataFail           8021


@interface DCPReportErrorUtil : NSObject

/**
 上报错误
 
 @param errorDescription 错误描述
 @param code 错误码
 */
+ (void)reportError:(NSString *)errorDescription errorCode:(NSInteger)code;

/**
 上报错误
 
 @param domain domain
 @param code 错误描述
 @param dict 错误码
 */
+ (void)reportErrorWithDomain:(NSErrorDomain)domain errorCode:(NSInteger)code userInfo:(nullable NSDictionary<NSErrorUserInfoKey, id> *)dict;

@end
