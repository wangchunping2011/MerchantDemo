//
//  DCPResourceURI.m
//  DCPay
//
//  Created by zhanbin on 2018/4/12.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import <Foundation/Foundation.h>

//环境地址
const NSString * const DCP_BASEURI = @"http://192.168.1.223:8101/";//测试环境
//const NSString * const DCP_BASEURI = @"http://47.52.175.22/";//正式环境域名

//预支付
const NSString* const DCP_PREPAY = @"dcpayCore/payBills/prepay";

//交易查询
const NSString* const DCP_QUERY_TRANSACTION = @"client/tx/queryTx";

//通过订单id查询交易
const NSString* const DCP_QUERY_TRANSACTION_BY_BILLID = @"client/tx/queryByPayBillId";

//通过交易id查询交易
const NSString* const DCP_QUERY_TRANSACTION_BY_ID = @"client/tx/queryByTransactionId";

//创建交易
const NSString* const DCP_CREATE_TRANSACTION = @"client/tx/txCreate";

//发送交易
const NSString* const DCP_SEND_TRANSACTION = @"client/tx/txSend";

//查询余额
const NSString* const DCP_QUERY_BALANCE = @"client/balance/queryBalance";

//查询单个余额
const NSString* const DCP_QUERY_BALANCE_BY_ONE = @"client/balance/queryBalanceByOne";

//初始化接口
const NSString* const DCP_INIT = @"client/init/load";

//推送设置
const NSString* const DCP_PUSH_SET = @"client/push/setPush";

//隐私协议
const NSString* const DCP_PRIVACY_POLICY_URL = @"client/about/queryPrivacyPolicy";

//关于我们
const NSString* const DCP_ABOUT_URL = @"client/about/queryAbout";

//notificaiton列表
const NSString* const DCP_NOTIFICATION_LIST = @"client/notification/queryNotification";

//notificaiton设置已读
const NSString* const DCP_NOTIFICATION_SET_READ = @"client/notification/setRead";

//通过id查询notificaiton
const NSString* const DCP_NOTIFICATION_BY_ID = @"client/notification/queryById";

//支付
const NSString* const DCP_PAY = @"dcpayCore/payBills/pay";

//查询商户
const NSString* const DCP_QUERY_MERCHANT = @"client/merchant/queryAll";

//根据商家ID查询商家信息
const NSString* const DCP_QUERY_MERCHANT_BY_ID = @"client/merchant/queryById";

//查询行业接口
const NSString* const DCP_QUERY_INDUSTRY = @"client/merchant/queryIndustry";

//矿工费说明
const NSString* const DCP_FEE_QUESTION_URL = @"client/help/content?id=30582357769400";


