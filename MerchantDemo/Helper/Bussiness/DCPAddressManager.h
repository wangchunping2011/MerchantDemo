//
//  DCPAddressManager.h
//  DCPay
//
//  Created by 詹斌 on 2018/4/15.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCPAddressInfo.h"

@interface DCPAddressManager : NSObject

+ (instancetype )sharedInstance;

- (NSArray<DCPAddressInfo *> *)getAllAddress;

- (BOOL)addAddress:(DCPAddressInfo *)addressInfo;

- (BOOL)delAddress:(NSInteger)addressId;

- (void)modifyAddress:(DCPAddressInfo *)address;

/**
 是否存在相同昵称的地址
 */
- (BOOL)isExistSameNickName:(NSString *)nickName;

/**
 是否存在相同地址
 */
- (BOOL)isExistSameAddress:(NSString *)address;

@end
