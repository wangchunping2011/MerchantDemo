//
//  DCPBgCoin.m
//  DCPay
//
//  Created by sean on 2018/4/18.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import "DCPBgCoin.h"
#import <math.h>

@implementation DCPBgCoin

/**
 通过coinId在数组中查找DCPBgCoin
 
 @param coinId coinId
 @param coinArray DCPBgCoin 数组
 @return 找到的DCPBgCoin
 */
+ (DCPBgCoin *)coinInfoWithCoinId:(NSString *)coinId inCoinArray:(NSArray<DCPBgCoin *>*)coinArray {
    
    __block DCPBgCoin *coinInfo = nil;
    [coinArray enumerateObjectsUsingBlock:^(DCPBgCoin * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.coinId isEqualToString:coinId]) {
            coinInfo = obj;
            *stop = YES;
        }
    }];
    return coinInfo;
}


/**
 返回界面上显示的数量

 @param coinInfo 币（暂时用字典，因为钱包还没映射到DCPBgCoin）
 @return 显示的数量
 */
+ (NSDecimalNumber *)getShowAmountValue:(NSDictionary *)coinInfo
{
//    NSDecimalNumber *decimals = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%lld", (long long)pow(10, [coinInfo[@"decimals"] intValue])]];
//    NSDecimalNumber *amount = [[NSDecimalNumber decimalNumberWithString:coinInfo[@"amount"]] decimalNumberByDividingBy:decimals];
    
    long long powValue = pow(10, [coinInfo[@"decimals"] intValue]);
    double amount = [coinInfo[@"amount"] doubleValue] / powValue;
    return [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%lf", amount]];
//    return amount;
}

@end
