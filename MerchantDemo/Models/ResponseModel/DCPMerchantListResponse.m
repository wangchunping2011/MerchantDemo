//
//  DCPMerchantListResponse.m
//  DCPay
//
//  Created by zhanbin on 2018/4/19.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import "DCPMerchantListResponse.h"

@implementation DCPMerchantListResponse

+(void)initialize
{
    
    //数组里面存的模型
    [DCPMerchantListResponse mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"list" : @"DCPMerchant"
                 };
    }];
    
}

@end
