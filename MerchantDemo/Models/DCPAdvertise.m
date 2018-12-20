//
//  DCPBannerList.m
//  DCPay
//
//  Created by zhanbin on 2018/4/12.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import "DCPAdvertise.h"

@implementation DCPAdvertise

+(void)initialize
{
    //模型中的属性名和字典中的key不相同(或者需要多级映射)
    [DCPAdvertise mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"balanceBannerList":@"balance",
                 @"merchantBannerList":@"merchant",
                 @"paymentBannerList":@"payment"
                 };
    }];
    //数组里面存的模型
    [DCPAdvertise mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"balanceBannerList" : @"DCPBanner",
                 @"merchantBannerList" : @"DCPBanner",
                 @"paymentBannerList" : @"DCPBanner"
                 };
    }];
}

@end
