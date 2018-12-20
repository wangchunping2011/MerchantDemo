//
//  DCPResourceURI.h
//  DCPay
//
//  Created by zhanbin on 2018/4/12.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef DCPResourceURI_h
#define DCPResourceURI_h

//环境地址
FOUNDATION_EXTERN const NSString* const DCP_BASEURI;

//预支付
FOUNDATION_EXTERN const NSString* const DCP_PREPAY;

//交易查询
FOUNDATION_EXTERN const NSString* const DCP_QUERY_TRANSACTION;

//通过订单id查询交易
FOUNDATION_EXTERN const NSString* const DCP_QUERY_TRANSACTION_BY_BILLID;

//通过交易id查询交易
FOUNDATION_EXTERN const NSString* const DCP_QUERY_TRANSACTION_BY_ID;

//创建交易
FOUNDATION_EXTERN const NSString* const DCP_CREATE_TRANSACTION;

//发送交易
FOUNDATION_EXTERN const NSString* const DCP_SEND_TRANSACTION;

//查询余额
FOUNDATION_EXTERN const NSString* const DCP_QUERY_BALANCE;

//查询单个余额
FOUNDATION_EXTERN const NSString* const DCP_QUERY_BALANCE_BY_ONE;

//初始化接口
FOUNDATION_EXTERN const NSString* const DCP_INIT;

//推送设置
FOUNDATION_EXTERN const NSString* const DCP_PUSH_SET;

//隐私协议
FOUNDATION_EXTERN const NSString* const DCP_PRIVACY_POLICY_URL;

//关于我们
FOUNDATION_EXTERN const NSString* const DCP_ABOUT_URL;

//notificaiton列表
FOUNDATION_EXTERN const NSString* const DCP_NOTIFICATION_LIST;

//notificaiton设置已读
FOUNDATION_EXTERN const NSString* const DCP_NOTIFICATION_SET_READ;

//通过id查询notificaiton
FOUNDATION_EXTERN const NSString* const DCP_NOTIFICATION_BY_ID;

//支付
FOUNDATION_EXTERN const NSString* const DCP_PAY;

//查询商户
FOUNDATION_EXTERN const NSString* const DCP_QUERY_MERCHANT;

//根据商家ID查询商家信息
FOUNDATION_EXTERN const NSString* const DCP_QUERY_MERCHANT_BY_ID;

//查询行业接口
FOUNDATION_EXTERN const NSString* const DCP_QUERY_INDUSTRY;

//矿工费说明
FOUNDATION_EXTERN const NSString* const DCP_FEE_QUESTION_URL;

#endif
