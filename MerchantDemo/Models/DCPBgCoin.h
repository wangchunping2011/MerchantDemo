//
//  DCPBgCoin.h
//  DCPay
//
//  Created by sean on 2018/4/18.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCPBaseModel.h"

@interface DCPBgCoin : DCPBaseModel

@property(nonatomic, strong)NSString *coinId;

@property(nonatomic, strong)NSString *abbr;

@property(nonatomic, strong)NSString *name;

@property(nonatomic, strong)NSString *chain;

@property(nonatomic, strong)NSString *avatarUrl;

@property(nonatomic, strong)NSString *icon;

@property(nonatomic, strong)NSString *decimals;

@property(nonatomic, strong)NSString *gasLimit;

@property(nonatomic, strong)NSString *tokenAddress;

@property(nonatomic, strong)NSString *standard;

@property(nonatomic, assign)double   exchangeRate;

@property(nonatomic, strong)NSString *isForceShow;

@property(nonatomic, assign)double   amount;

@property(nonatomic, assign)BOOL     isCollected;

/**
 通过coinId在数组中查找DCPBgCoin
 
 @param coinId coinId
 @param coinArray DCPBgCoin 数组
 @return 找到的DCPBgCoin
 */
+ (DCPBgCoin *)coinInfoWithCoinId:(NSString *)coinId inCoinArray:(NSArray<DCPBgCoin *>*)coinArray;

/**
 返回界面上显示的数量
 
 @param coinInfo 币（暂时用字典，因为钱包还没映射到DCPBgCoin）
 @return 显示的数量
 */
+ (NSDecimalNumber *)getShowAmountValue:(NSDictionary *)coinInfo;

@end
