//
//  DCPNotification.h
//  DCPay
//
//  Created by zhanbin on 2018/4/8.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCPBaseModel.h"

typedef NS_ENUM(NSInteger, DCPNotificationType) {
    DCPNotificationTypeTRANSFER,
    DCPNotificationTypePAYMENT,
    DCPNotificationTypeNOTIFY
};

@interface DCPNotification : DCPBaseModel

//id
@property (nonatomic, assign) long long notificationId;
//deviceId
@property (nonatomic, assign) long long deviceId;
//通知内容
@property (nonatomic, copy) NSString *content;
//通知类型['TRANSFER', 'PAYMENT', 'NOTIFY']
@property (nonatomic, copy) NSString *type;
//通知类型枚举
@property (nonatomic, assign) DCPNotificationType typeEnum;
//是否已读
@property (nonatomic, assign) NSInteger isRead;
//时间
@property (nonatomic, copy) NSString *createTime;
//账单id
@property (nonatomic, copy) NSString *payBillId;
//通知标题
@property (nonatomic, copy) NSString *title;
//交易id
@property (nonatomic, copy) NSString *transactionId;

@end
