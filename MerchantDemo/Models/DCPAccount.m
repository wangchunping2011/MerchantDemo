//
//  DCPAccount.m
//  DCPay
//
//  Created by zhanbin on 2018/4/10.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import "DCPAccount.h"

@implementation DCPAccount

+(void)initialize
{
    
    //数组里面存的模型
    [DCPAccount mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"ercTokenList" : @"DCPBgCoin"
                 };
    }];
    
}

- (NSMutableArray<DCPBgCoin *> *)ercTokenList {
    if (!_ercTokenList) {
        _ercTokenList = [NSMutableArray array];
    }
    return _ercTokenList;
}

@end
