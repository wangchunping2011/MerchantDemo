//
//  DCPQueryTransactionResponse.m
//  DCPay
//
//  Created by zhanbin on 2018/4/13.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import "DCPQueryTransactionResponse.h"

@implementation DCPQueryTransactionResponse

+(void)initialize
{
    //模型中的属性名和字典中的key不相同(或者需要多级映射)
    [DCPQueryTransactionResponse mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"list":@"data"
                 };
    }];
    
    //数组里面存的模型
    [DCPQueryTransactionResponse mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"list" : @"DCPTransaction"
                 };
    }];
    
}

@end
