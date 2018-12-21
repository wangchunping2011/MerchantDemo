//
//  DCPPayResponse.h
//  DCPay
//
//  Created by zhanbin on 2018/4/18.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import "DCPBaseModel.h"

@interface DCPPayResponse : NSObject

@property (nonatomic, copy) NSString *merchantId;
@property (nonatomic, copy) NSString *refBizNo;
@property (nonatomic, copy) NSString *payBillNo;
@property (nonatomic, copy) NSString *coinId;
@property (nonatomic, copy) NSString *amount;
@property (nonatomic, copy) NSString *toAddr;
@property (nonatomic, copy) NSString *tokenAddr;
@property (nonatomic, copy) NSString *attach;
@property (nonatomic, copy) NSString *channel;
@property (nonatomic, copy) NSString *goodsTag;
@property (nonatomic, copy) NSString *goodsType;
@property (nonatomic, copy) NSString *industry;
@property (nonatomic, copy) NSString *merchantName;
@property (nonatomic, copy) NSString *orginAmount;
@property (nonatomic, copy) NSString *txData;

@end
