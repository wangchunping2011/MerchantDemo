//
//  DCPCreateTransactionRequest.h
//  DCPay
//
//  Created by zhanbin on 2018/4/13.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCPBaseModel.h"

@interface DCPTransactionRequest : DCPBaseModel

@property (nonatomic, copy) NSString* addressFrom;
@property (nonatomic, copy) NSString* addressTo;
@property (nonatomic, copy) NSString* amount;
@property (nonatomic, copy) NSString* decimals;
@property (nonatomic, copy) NSString* coinId;
@property (nonatomic, copy) NSString* fee;
@property (nonatomic, copy) NSString* gasLimit;
@property (nonatomic, copy) NSString* gasPrice;
@property (nonatomic, copy) NSString* memo;
@property (nonatomic, copy) NSString* standard;
@property (nonatomic, copy) NSString* signedTx;//签名（创建交易时不需要，发送交易时才需要）
@property (nonatomic, copy) NSString* tokenAddress;

@end
