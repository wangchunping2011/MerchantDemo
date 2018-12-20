//
//  DCPMerchant.h
//  DCPay
//
//  Created by zhanbin on 2018/4/12.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCPBaseModel.h"

@interface DCPMerchant : DCPBaseModel

@property (nonatomic, copy) NSString* merchantId;
@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* image;
@property (nonatomic, copy) NSString* website;//商家官方网站

/**
 通过merchantId在数组中查找DCPMerchant
 
 @param merchantId 商户Id
 @param merchantArray DCPMerchant 数组
 @return 找到的DCPMerchant
 */
+ (DCPMerchant *)MerchantWithId:(NSString *)merchantId inMerchantArray:(NSArray<DCPMerchant *>*)merchantArray;

@end
