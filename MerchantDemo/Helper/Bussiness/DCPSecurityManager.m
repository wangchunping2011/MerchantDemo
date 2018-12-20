//
//  DCPPinCodeManager.m
//  DCPay
//
//  Created by zhanbin on 2018/4/16.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import "DCPSecurityManager.h"
#import "NSString+mbr.h"

static NSString* pinCodeEnableKey = @"pinCodeEnable";
static NSString* pinCodekey = @"pinCode";

static NSString* touchIdEnableKey = @"touchIdEnable";
static NSString* touchIdUnlockAppKey = @"touchIdUnlockApp";
static NSString* touchIdPaymentVerificationKey = @"touchIdUPaymentVerification";

static NSString* isAppLockKey = @"isAppLock";
static NSString* appLockTimeKey = @"appLockTime";
//解锁失败次数key
static NSString* appUnLockFailTimeKey = @"appUnLockFailTime";
//进入后台时间key
static NSString* appEntryBackgroundTimeKey = @"appEntryBackgroundTime";
//app是否处于待验证状态（密码或touchid验证状态）key
static NSString* isAppInVerifyStateKey = @"isAppInVerifyState";

//解锁失败最大次数
static NSInteger appUnLockFailMaxNumber = 5;

//app锁定时间限制6小时（6*60*60）
static NSInteger appLockTimeSecond = 6*60*60;

//app进入后台时间限制，超过时间解锁
static NSInteger appEntryBackgroundTimeLimit = 60;

@interface DCPSecurityManager ()

@end

@implementation DCPSecurityManager

+ (instancetype )sharedInstance
{
    static dispatch_once_t once;
    static DCPSecurityManager* _instance;
    dispatch_once(&once, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

#pragma mark -
#pragma mark - PinCode相关
/**
 pincode是否开启
 */
- (BOOL)isPinCodeEnable {
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    BOOL isEnable = [user boolForKey:pinCodeEnableKey];
    NSLog(@"%s:%d",__func__,isEnable);
    return isEnable;
}

/**
 设置pincode开启状态
 */
- (void)setPinCodeEnable:(BOOL)enable{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setBool:enable forKey:pinCodeEnableKey];
    NSLog(@"%s:%d",__func__,enable);
}

/**
 获取pincode
 */
- (NSString *)getPinCode {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *pinCode = [user stringForKey:pinCodekey];
    NSLog(@"%s:%@",__func__,pinCode);
    return pinCode;
}

/**
 是否设置过pincode
 */
- (BOOL)isSettedPinCode {
    NSString *pinCode = [self getPinCode];
    if (pinCode!=nil && ![pinCode isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

/**
 校验pincode是否正确
 */
- (BOOL)isPinCodeTrue:(NSString *)pinCode {
    
    if ([[pinCode mbr_md5] isEqualToString:[self getPinCode]]) {
        return YES;
    }
    return NO;
}

/**
 设置pincode
 */
- (void)setPinCode:(NSString *)pinCode {
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *pinCodeMd5 = [pinCode mbr_md5];
    [user setObject:pinCodeMd5 forKey:pinCodekey];
    NSLog(@"%s:%@",__func__,pinCode);
}

#pragma mark -
#pragma mark - TouchId相关
/**
 TouchId是否开启
 */
- (BOOL)isTouchIdEnable {
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    BOOL isEnable = [user boolForKey:touchIdEnableKey];
    NSLog(@"%s:%d",__func__,isEnable);
    return isEnable;
}

/**
 设置TouchId开启状态
 */
- (void)setTouchIdEnable:(BOOL)enable{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setBool:enable forKey:touchIdEnableKey];
    NSLog(@"%s:%d",__func__,enable);
}

/**
 TouchId是否可以用于解锁app
 */
- (BOOL)isTouchIdUnlockApp {
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    BOOL isEnable = [user boolForKey:touchIdUnlockAppKey];
    NSLog(@"%s:%d",__func__,isEnable);
    return isEnable;
}

/**
 设置TouchId是否可以用于解锁app
 */
- (void)setTouchIdUnlockApp:(BOOL)enable{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setBool:enable forKey:touchIdUnlockAppKey];
    NSLog(@"%s:%d",__func__,enable);
}

/**
 TouchId是否可以用于交易验证
 */
- (BOOL)isTouchIdPaymentVerification {
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    BOOL isEnable = [user boolForKey:touchIdPaymentVerificationKey];
    NSLog(@"%s:%d",__func__,isEnable);
    return isEnable;
}

/**
 设置TouchId是否可以用于交易验证
 */
- (void)setTouchIdPaymentVerification:(BOOL)enable{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setBool:enable forKey:touchIdPaymentVerificationKey];
    NSLog(@"%s:%d",__func__,enable);
}

#pragma mark -
#pragma mark - app相关
/**
 设置app锁定
 */
- (void)setAppLock:(BOOL)isLock {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setBool:isLock forKey:isAppLockKey];
    if (isLock) {
        //设置锁定时间
        NSString *currentTime = [self getCurrentTimes];
        [user setObject:currentTime forKey:appLockTimeKey];
        NSLog(@"%s---设置锁定时间:%@",__func__,currentTime);
    } else {
        //清除锁定时间
        [user setObject:@"" forKey:appLockTimeKey];
        NSLog(@"%s---清除锁定时间",__func__);
    }
}

/**
 判断app是否锁定
 */
- (BOOL)isAppLock{
    BOOL isLock = [self getAppLockState];
    if (isLock) {
        
        if ([self getAppUnLockRemainTime] < 0) {
            //时间超过了最大锁定时间，解锁
            [self appUnLock];
            return NO;
        } else {
            return YES;
        }
    } else {
        //未锁定
        return NO;
    }
}

/**
 app解锁
 */
- (void)appUnLock {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setBool:NO forKey:isAppLockKey];
    [user setObject:@"" forKey:appLockTimeKey];
    [user setInteger:0 forKey:appUnLockFailTimeKey];
    
}

/**
 获取app锁定时间
 */
- (NSString *)getAppLockTime {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *lockTime = [user stringForKey:appLockTimeKey];
    NSLog(@"%s:%@",__func__,lockTime);
    return lockTime;
}

/**
 获取app解锁剩余时间（秒）
 */
- (NSInteger)getAppUnLockRemainTime {
    
    NSString *lockTimeString = [self getAppLockTime];
    NSString *nowTimeString = [self getCurrentTimes];
    NSInteger timeInterval = [self getTimeInterval:lockTimeString to:nowTimeString];
    return appLockTimeSecond - timeInterval;
}


/**
 获取app锁定状态
 */
- (BOOL)getAppLockState{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    BOOL isLock = [user boolForKey:isAppLockKey];
    NSLog(@"%s:%d",__func__,isLock);
    return isLock;
}


/**
 增加app解锁失败次数

 @return 是否达到最大失败次数
 */
- (BOOL)addAppLockFailTime {
    NSInteger oldLockTime = [self getAppUnLockFailTime];
    NSInteger newLockTime = oldLockTime + 1;
    [self setAppUnLockFailTime:newLockTime];
    NSLog(@"%s:oldTime:%ld,newTime:%ld",__func__,(long)oldLockTime,(long)newLockTime);
    return newLockTime >= appUnLockFailMaxNumber ? YES : NO;
}

/**
 设置app解锁失败次数
 */
- (void)setAppUnLockFailTime:(NSInteger)time {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setInteger:time forKey:appUnLockFailTimeKey];
    NSLog(@"%s:%ld",__func__,(long)time);
}

/**
 获取app解锁失败次数
 */
- (NSInteger)getAppUnLockFailTime {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSInteger time = [user integerForKey:appUnLockFailTimeKey];
    NSLog(@"%s:%ld",__func__,(long)time);
    return time;
}

/**
 设置app进入后台
 */
- (void)setAppEntryBackground {
    //先判断当前app是否处于待验证状态
    if ([self isAppInVerifyState]) {
        //待验证状态进入后台，不更新时间
//        NSLog(@"%s---待验证状态进入后台，不更新时间",__func__);
    } else {
        //普通状态进入后台，更新时间
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *currentTime = [self getCurrentTimes];
        [user setObject:currentTime forKey:appEntryBackgroundTimeKey];
//        NSLog(@"%s---设置进入后台时间:%@",__func__,currentTime);
    }
}

/**
 获取app进入后台时间
 */
- (NSString *)getAppEntryBackgroundTime {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *entryBackgroundTime = [user stringForKey:appEntryBackgroundTimeKey];
    NSLog(@"%s:%@",__func__,entryBackgroundTime);
    return entryBackgroundTime;
}

/**
 判断app进入前台是是否密码或者touchid验证
 */
- (BOOL)isAppEntryForegroundNeedVerify{
    NSString *entryBackgroundTimeString = [self getAppEntryBackgroundTime];
    NSString *nowTimeString = [self getCurrentTimes];
    NSInteger timeInterval = [self getTimeInterval:entryBackgroundTimeString to:nowTimeString];
    if (timeInterval > appEntryBackgroundTimeLimit) {
        //超过时间限制，需要验证
        NSLog(@"%s:%d",__func__,YES);
        return YES;
    }
    NSLog(@"%s:%d",__func__,NO);
    return NO;
}

/*
设置app进入待验证状态（密码验证或touchid验证）
*/
- (void)setAppInVerifyState:(BOOL)state{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setBool:state forKey:isAppInVerifyStateKey];
    NSLog(@"%s:%d",__func__,state);
    if (state == NO) {
        //验证通过后，需要更新进入后台时间
        [self setAppEntryBackground];
    }
}

/**
 app是否处于待验证状态（密码验证或touchid验证）
 */
- (BOOL)isAppInVerifyState {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    BOOL isInVerifyState  = [user boolForKey:isAppInVerifyStateKey];
    NSLog(@"%s:%d",__func__,isInVerifyState);
    return isInVerifyState;
}

#pragma mark -
#pragma mark - 辅助方法
/**
 获取当前时间
 */
- (NSString*)getCurrentTimes{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSDate *datenow = [NSDate date];
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSLog(@"currentTimeString =  %@",currentTimeString);
    
    return currentTimeString;
    
}

/**
 计算时间间隔
 @return to-from的秒数
 */
- (NSInteger)getTimeInterval:(NSString *)from to:(NSString *)to{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH-mm-sss"];
    NSDate *fromDate = [formatter dateFromString:from];
    NSDate *toDate = [formatter dateFromString:to];
    NSTimeInterval timeInterval = [toDate timeIntervalSinceDate:fromDate];
    NSLog(@"%s:from:%@,to:%@,interval:%f",__func__,from,to,timeInterval);
    return timeInterval;
}

@end
