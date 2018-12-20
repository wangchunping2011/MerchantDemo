//
//  DCPFileManager.h
//  DCPay
//
//  Created by autoround-032 on 2018/4/19.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCPFileManager : NSObject

+(instancetype )sharedInstance;

@property(nonatomic, copy, readonly)NSString *accountListFile;
@property(nonatomic, copy, readonly)NSString *erc20ForceListFile;
@property(nonatomic, copy, readonly)NSString *erc20NormalListFile;
@property(nonatomic, copy, readonly)NSString *allCoinListFile;
@end
