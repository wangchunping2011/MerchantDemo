//
//  DCPMerchantServiceProtol.h
//  DCPay
//
//  Created by zhanbin on 2018/4/18.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import "DCPBaseServiceProtocol.h"
#import "DCPMerchant.h"
#import "DCPMerchantListResponse.h"

@protocol DCPMerchantServiceProtocol <DCPBaseServiceProtocol>

/**
 获取商家列表
 
 @param pageNo 第几页（从0开始）
 @param pageSize 一页多少条
 */
- (void)getMerchantList:(NSInteger)pageNo
               pageSize:(NSInteger)pageSize
                success:(void (^_Nonnull)(NSString* message, DCPMerchantListResponse *response))success
                failure:(void (^_Nonnull)(NSString* message,NSInteger code))failure;

/**
 通过商家id查询商家
 
 @param merchantId 商户id
 */
- (void)getMerchantById:(NSString *)merchantId
                success:(void (^_Nonnull)(NSString* message, DCPMerchant *merchant))success
                failure:(void (^_Nonnull)(NSString* message,NSInteger code))failure;

@end
