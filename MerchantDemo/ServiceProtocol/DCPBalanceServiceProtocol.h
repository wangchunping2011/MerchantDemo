//
//  DCPBalanceServiceProtocol.h
//  DCPay
//
//  Created by zhanbin on 2018/4/12.
//  Copyright © 2018年 mbr. All rights reserved.
//  余额相关接口服务

#import "DCPBaseServiceProtocol.h"
#import "DCPBatchBalanceRequest.h"
#import "DCPBalanceResponse.h"

@protocol DCPBalanceServiceProtocol <DCPBaseServiceProtocol>

/**
 查询余额
 @param balanceRequest 查询余额requestModel
 */
- (void)batchQueryBalance:(DCPBatchBalanceRequest*)balanceRequest
              success:(void (^_Nonnull)(NSString* message,DCPBalanceResponse *response))success
              failure:(void (^_Nonnull)(NSString* message,NSInteger code))failure;

/**
 查询单个币余额
 @param account 查询的账户
 */
- (void)queryBalanceByOne:(DCPAccount*)account
              success:(void (^_Nonnull)(NSString* message,DCPBalanceResponse *response))success
              failure:(void (^_Nonnull)(NSString* message,NSInteger code))failure;

@end
