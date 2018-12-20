//
//  DCPTransaction.h
//  DCPay
//
//  Created by zhanbin on 2018/4/13.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import "DCPBaseModel.h"

@interface DCPTransaction : DCPBaseModel

// 商户图片地址
@property (nonatomic, copy) NSString* merchantImageUrl;

// 商家名称
@property (nonatomic, copy) NSString* merchantName;

// 金额,最小单位
//@property (nonatomic, copy) NSString* price;
@property (nonatomic, copy) NSString* amount;

// 货币名称
@property (nonatomic, copy) NSString* abbr;
//@property (nonatomic, copy) NSString* coinType;

// 交易接收方
//@property (nonatomic, copy) NSString* to;
@property (nonatomic, copy) NSString* addressTo;

// 支付类型 0-payment 1-transfer
@property (nonatomic, copy) NSString* type;

// 时间
//@property (nonatomic, copy) NSString* time;
@property (nonatomic, copy) NSString* date;

// 交易状态 -1-交易发送；0-交易pending;1-交易失败；2-交易确认 3-交易成功 4-支付-初始；5-支付-处理中;6-支付-成功；7-支付-支付失败
@property (nonatomic, copy) NSString* status;

// 交易支付方
//@property (nonatomic, copy) NSString* from;
@property (nonatomic, copy) NSString* addressFrom;

@property (nonatomic, copy) NSString* fee;
//@property (nonatomic, copy) NSString* gas;

// 交易hash
//@property (nonatomic, copy) NSString* transaction;
@property (nonatomic, copy) NSString* txId;

// 区块
//@property (nonatomic, copy) NSString* block;
@property (nonatomic, copy) NSString* blockId;

// 商家订单号
@property (nonatomic, copy) NSString* merchantOrderNo;

// dcpay 订单号
@property (nonatomic, copy) NSString* dcPayOrderNo;

// 货币图片地址
//@property (nonatomic, copy) NSString* coinImageUrl;
@property (nonatomic, copy) NSString* avatarUrl;

// 简介
@property (nonatomic, copy) NSString* memo;

// 转入转出 0-Received 转入 1 Sent 转出
@property (nonatomic, copy) NSString* transfer;

@property (nonatomic, copy) NSString* decimals;

- (NSString *)getStatusDescription;

@end
