//
//  DCPMerchantListResponse.h
//  DCPay
//
//  Created by zhanbin on 2018/4/19.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCPMerchant.h"

@interface DCPMerchantListResponse : NSObject

@property (nonatomic, assign) NSInteger total;

@property (nonatomic, strong) NSArray<DCPMerchant *>* list;

@end
