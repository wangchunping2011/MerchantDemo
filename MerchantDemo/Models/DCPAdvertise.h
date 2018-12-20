//
//  DCPBannerList.h
//  DCPay
//
//  Created by zhanbin on 2018/4/12.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCPBaseModel.h"
#import "DCPBanner.h"

@interface DCPAdvertise : DCPBaseModel

@property (nonatomic, strong) NSArray<DCPBanner *>* balanceBannerList;

@property (nonatomic, strong) NSArray<DCPBanner *>* paymentBannerList;

@property (nonatomic, strong) NSArray<DCPBanner *>* merchantBannerList;

@end
