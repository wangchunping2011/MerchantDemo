//
//  DCPQueryBalanceRequest.m
//  DCPay
//
//  Created by zhanbin on 2018/4/13.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import "DCPBatchBalanceRequest.h"

@implementation DCPBatchBalanceRequest

-(NSMutableArray<DCPAccount *> *)list {
    if (!_list) {
        _list = [NSMutableArray array];
    }
    return _list;
}

@end
