//
//  DCPBasicDataServiceProtocol.h
//  DCPay
//
//  Created by zhanbin on 2018/4/12.
//  Copyright © 2018年 mbr. All rights reserved.
//  基础数据接口服务

#import "DCPBaseServiceProtocol.h"
#import "DCPInitData.h"
#import "DCPIndustry.h"

@protocol DCPBasicDataServiceProtocol <DCPBaseServiceProtocol>

/**
 获取初始化数据
 */
- (void)getInitDatasuccess:(void (^_Nonnull)(NSString* message,DCPInitData *data))success
                   failure:(void (^_Nonnull)(NSString* message,NSInteger code))failure;

/**
 获取行业数据
 */
- (void)getIndustryDatasuccess:(void (^_Nonnull)(NSString* message,NSArray *datas))success
                       failure:(void (^_Nonnull)(NSString* message,NSInteger code))failure;

/**
 隐私协议地址
 */
- (NSString *)getPrivacyPolicyUrl;

/**
 关于我们地址
 */
- (NSString *)getAboutUrl;

/**
 矿工费说明地址
 */
- (NSString *)getFeeQuestionUrl;

@end
