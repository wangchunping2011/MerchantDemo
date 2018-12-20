//
//  DCPPinCodeManager.h
//  DCPay
//
//  Created by zhanbin on 2018/4/16.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCPSecurityManager : NSObject

+ (instancetype )sharedInstance;

#pragma mark -
#pragma mark - PinCode相关
/**
 pincode是否开启
 */
- (BOOL)isPinCodeEnable;

/**
 设置pincode开启状态
 */
- (void)setPinCodeEnable:(BOOL)enable;

/**
 获取pincode
 */
- (NSString *)getPinCode;

/**
 校验pincode是否正确
 */
- (BOOL)isPinCodeTrue:(NSString *)pinCode;

/**
 是否设置过pincode
 */
- (BOOL)isSettedPinCode;

/**
 设置pincode
 */
- (void)setPinCode:(NSString *)pinCode;

#pragma mark -
#pragma mark - TouchId相关
/**
 TouchId是否开启
 */
- (BOOL)isTouchIdEnable;

/**
 设置TouchId开启状态
 */
- (void)setTouchIdEnable:(BOOL)enable;

/**
 TouchId是否可以用于解锁app
 */
- (BOOL)isTouchIdUnlockApp;

/**
 设置TouchId是否可以用于解锁app
 */
- (void)setTouchIdUnlockApp:(BOOL)enable;

/**
 TouchId是否可以用于交易验证
 */
- (BOOL)isTouchIdPaymentVerification;

/**
 设置TouchId是否可以用于交易验证
 */
- (void)setTouchIdPaymentVerification:(BOOL)enable;

#pragma mark -
#pragma mark - app锁定相关
/**
 设置app锁定
 */
- (void)setAppLock:(BOOL)isLock;

/**
 判断app是否锁定
 */
- (BOOL)isAppLock;

/**
 app解锁
 */
- (void)appUnLock;

/**
 获取app锁定时间
 */
- (NSString *)getAppLockTime;

/**
 获取app解锁剩余时间（秒）
 */
- (NSInteger)getAppUnLockRemainTime;

/**
 获取app锁定状态
 */
- (BOOL)getAppLockState;

/**
 增加app解锁失败次数
 
 @return 是否达到最大失败次数
 */
- (BOOL)addAppLockFailTime;

/**
 设置app解锁失败次数
 */
- (void)setAppUnLockFailTime:(NSInteger)time;

/**
 设置app解锁失败次数
 */
- (NSInteger)getAppUnLockFailTime;

/**
 设置app进入后台
 */
- (void)setAppEntryBackground;

/**
 获取app进入后台时间
 */
- (NSString *)getAppEntryBackgroundTime;

/**
 判断app进入前台是是否密码或者touchid验证
 */
- (BOOL)isAppEntryForegroundNeedVerify;

/*
 设置app进入待验证状态（密码验证或touchid验证）
 */
- (void)setAppInVerifyState:(BOOL)state;

/**
 app是否处于待验证状态（密码验证或touchid验证）
 */
- (BOOL)isAppInVerifyState;

@end
