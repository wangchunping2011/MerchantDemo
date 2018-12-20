//
//  DCPNotificationServiceProtocol.h
//  DCPay
//
//  Created by zhanbin on 2018/4/12.
//  Copyright © 2018年 mbr. All rights reserved.
//  通知相关接口服务

#import "DCPBaseServiceProtocol.h"
#import "DCPNotification.h"
#import "DCPNotificationListResponse.h"

@protocol DCPNotificationServiceProtocol <DCPBaseServiceProtocol>

/**
 获取通知列表
 
 @param pageNo 第几页（从第0页开始）
 @param pageSize 每页多少行
 */
- (void)getNotificationList:(NSInteger)pageNo
                   pageSize:(NSInteger)pageSize
                    success:(void (^_Nonnull)(NSString* message, DCPNotificationListResponse *notificationList))success
                    failure:(void (^_Nonnull)(NSString* message,NSInteger code))failure;

/**
 设置通知已读
 */
- (void)setNotificationRead:(long long)notificationId
                    success:(void (^_Nonnull)(NSString* message, id data))success
                    failure:(void (^_Nonnull)(NSString* message,NSInteger code))failure;

/**
 通过id查询通知
 
 @param notificationId 通知id
 */
- (void)getNotificationById:(long long)notificationId
                    success:(void (^_Nonnull)(NSString* message, DCPNotification* notification))success
                    failure:(void (^_Nonnull)(NSString* message,NSInteger code))failure;

@end
