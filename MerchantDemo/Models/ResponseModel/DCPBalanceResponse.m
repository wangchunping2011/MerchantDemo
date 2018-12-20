//
//  DCPBalanceResponse.m
//  DCPay
//
//  Created by zhanbin on 2018/4/13.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import "DCPBalanceResponse.h"


@implementation DCPBalanceResponse

+(void)initialize
{
    
    //数组里面存的模型
    [DCPBalanceResponse mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"balanceList" : @"DCPAccount"
                 };
    }];
    
}

@end
