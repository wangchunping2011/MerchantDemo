//
//  DCPBasicDataManager.h
//  DCPay
//
//  Created by zhanbin on 2018/4/11.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCPBanner.h"
#import "DCPBgCoin.h"
#import "DCPMerchant.h"
#import "DCPInitData.h"

typedef void(^DCPGetBasicDataBlock)(DCPInitData * initData);

@interface DCPBasicDataManager : NSObject

+(instancetype )sharedInstance;

- (void)loadBasicData;

- (void)getInitData:(DCPGetBasicDataBlock)block;

/**
 获取行业数据
 
 @param success DCPIndustry数组
 */
- (void)getIndustryData:(void (^)(NSArray *datas))success;

@end
