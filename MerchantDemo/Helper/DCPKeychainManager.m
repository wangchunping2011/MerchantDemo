//
//  DCPKeychainManager.m
//  DCPay
//
//  Created by sean on 2018/5/16.
//  Copyright © 2018 mbr. All rights reserved.
//

#import "DCPKeychainManager.h"

@implementation DCPKeychainManager

+(instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static id _instance;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc]init];
    });
    
    return _instance;
}

-(void)manager
{
    if ([GVUserDefaults standardUserDefaults].isNewInstall == nil) {
        //如果是重新安装并且未设置密码，就删掉keychain项目
        UICKeyChainStore *keychainStore = [UICKeyChainStore keyChainStore];
        [keychainStore setAccessibility:UICKeyChainStoreAccessibilityAlwaysThisDeviceOnly];
        [keychainStore removeAllItems];
    }
}
@end
