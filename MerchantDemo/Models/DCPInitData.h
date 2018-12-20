//
//  DCPInitData.h
//  DCPay
//
//  Created by zhanbin on 2018/4/12.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import "DCPBaseModel.h"
#import "DCPAdvertise.h"
#import "DCPMerchant.h"
#import "DCPBgCoin.h"
#import "DCPUpdate.h"

@interface DCPInitData : DCPBaseModel

@property (nonatomic, strong) DCPAdvertise* advertise;

@property (nonatomic, strong) NSArray<DCPBgCoin *>* coinList;

@property (nonatomic, strong) DCPUpdate* appUpdate;

@property (nonatomic, copy) NSString* push;   //推送开关 1:关 0:开 （有点怪异）

@property (nonatomic, assign) BOOL pushOn;

@end
