//
//  DCPushServiceProtocol.h
//  DCPay
//
//  Created by zhanbin on 2018/4/12.
//  Copyright © 2018年 mbr. All rights reserved.
//  推送相关接口服务

#import "DCPBaseServiceProtocol.h"

@protocol DCPPushServiceProtocol <DCPBaseServiceProtocol>

/**
 push设置
 */
- (void)setPush:(BOOL)isOpen
        success:(void (^_Nonnull)(NSString* message,id data))success
        failure:(void (^_Nonnull)(NSString* message,NSInteger code))failure;

@end
