//
//  DCPPay.h
//  DCPay
//
//  Created by zhanbin on 2018/4/13.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCPBaseModel.h"

@interface DCPPayRequest : DCPBaseModel

@property (nonatomic, copy) NSString* merchantId;
@property (nonatomic, copy) NSString* refBizNo;
@property (nonatomic, copy) NSString* payBillNo;
@property (nonatomic, copy) NSString* coinId;
@property (nonatomic, copy) NSString* toAddr;
@property (nonatomic, copy) NSString* fromAddr;
@property (nonatomic, copy) NSString* signedTx;
@property (nonatomic, copy) NSString* amount;
@property (nonatomic, copy) NSString* tokenAddr;
@property (nonatomic, copy) NSString* goodsType;
@property (nonatomic, copy) NSString* goodsTag;
@property (nonatomic, copy) NSString* attach;
@property (nonatomic, copy) NSString* industry;
@property (nonatomic, copy) NSString* orderInfo;

@end
