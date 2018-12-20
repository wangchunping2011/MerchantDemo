//
//  DCPPayServiceProtocol.h
//  DCPay
//
//  Created by zhanbin on 2018/4/13.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import "DCPBaseServiceProtocol.h"
#import "DCPPayRequest.h"
#import "DCPPayResponse.h"

@protocol DCPPayServiceProtocol <DCPBaseServiceProtocol>

/**
 支付
 
 @param payRequest 支付requestModel
 */
- (void)pay:(DCPPayRequest *)payRequest
     success:(void (^_Nonnull)(NSString* message,DCPPayResponse *payResponse))success
     failure:(void (^_Nonnull)(NSString* message,NSInteger code))failure;

@end
