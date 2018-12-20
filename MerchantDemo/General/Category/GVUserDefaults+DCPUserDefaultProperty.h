//
//  GVUserDefaults+DCPUserDefaultProperty.h
//  DCPay
//
//  Created by sean on 26/04/2018.
//  Copyright © 2018 mbr. All rights reserved.
//

#import "GVUserDefaults.h"

@interface GVUserDefaults (DCPUserDefaultProperty)

/**
 * @brief 密码
 */
@property(nonatomic, copy) NSString *passWord;
@property(nonatomic, copy) NSString *hintMessage;
@property(nonatomic, copy) NSString *defaultEth;
@property(nonatomic, copy) NSString *maxEth;
@property(nonatomic, copy) NSString *minEth;
@property(nonatomic, strong) NSArray *addressBackUpList;
@property(nonatomic, copy) NSString *isNewInstall;

@end
