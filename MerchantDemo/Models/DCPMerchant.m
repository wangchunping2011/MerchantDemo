//
//  DCPMerchant.m
//  DCPay
//
//  Created by zhanbin on 2018/4/12.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import "DCPMerchant.h"

@implementation DCPMerchant

-(instancetype)init {
    self = [super init];
    if (self) {
        _merchantId = @"10000000000003";
    }
    return self;
}

+(void)initialize
{
    //模型中的属性名和字典中的key不相同(或者需要多级映射)
    [DCPMerchant mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"merchantId":@"id"
                 };
    }];
    
}

/**
 通过商户Id在数组中查找DCPMerchant
 
 @param merchantId 商户Id
 @param merchantArray DCPMerchant 数组
 @return 找到的DCPMerchant
 */
+ (DCPMerchant *)MerchantWithId:(NSString *)merchantId inMerchantArray:(NSArray<DCPMerchant *>*)merchantArray {
    
    __block DCPMerchant *merchant = nil;
    [merchantArray enumerateObjectsUsingBlock:^(DCPMerchant * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.merchantId isEqualToString:merchantId]) {
            merchant = obj;
            *stop = YES;
        }
    }];
    return merchant;
}

@end
