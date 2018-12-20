//
//  DCPTransactionServiceProtocol.h
//  DCPay
//
//  Created by zhanbin on 2018/4/12.
//  Copyright © 2018年 mbr. All rights reserved.
//  交易相关接口服务

#import "DCPBaseServiceProtocol.h"
#import "DCPTransactionRequest.h"
#import "DCPQueryTransactionResponse.h"
#import "DCPQueryTransactionRequest.h"
#import "DCPTransactionResponse.h"

@protocol DCPTransactionServiceProtocol <DCPBaseServiceProtocol>

/**
 创建交易
 
 @param transactionRequest 交易requestModel
 */
- (void)createTransaction:(DCPTransactionRequest *)transactionRequest
                   success:(void (^_Nonnull)(NSString* message,DCPTransactionResponse *response))success
                   failure:(void (^_Nonnull)(NSString* message,NSInteger code))failure;

/**
 发送交易
 
 @param transactionRequest 交易requestModel
 */
- (void)sendTransaction:(DCPTransactionRequest *)transactionRequest
                 success:(void (^_Nonnull)(NSString* message,DCPTransactionResponse *response))success
                 failure:(void (^_Nonnull)(NSString* message,NSInteger code))failure;

/**
 查询交易
 
 @param transactionRequest 交易requestModel
 */
- (void)queryTransaction:(DCPQueryTransactionRequest *)transactionRequest
                  success:(void (^_Nonnull)(NSString* message,DCPQueryTransactionResponse *response))success
                  failure:(void (^_Nonnull)(NSString* message,NSInteger code))failure;

/**
 通过billId查询交易
 
 @param billId 订单id
 @param notificationId 通知id
 */
- (void)queryTransactionByBillId:(NSString *)billId
                   notificationId:(long)notificationId
                          success:(void (^_Nonnull)(NSString* message,DCPTransaction *transaction))success
                          failure:(void (^_Nonnull)(NSString* message,NSInteger code))failure;

/**
 通过transactionId查询交易
 
 @param transactionId 交易id
 @param notificationId 通知id
 */
- (void)queryTransactionByTransactionId:(NSString *)transactionId
                          notificationId:(long)notificationId
                                 success:(void (^_Nonnull)(NSString* message,DCPTransaction *transaction))success
                                 failure:(void (^_Nonnull)(NSString* message,NSInteger code))failure;

@end
