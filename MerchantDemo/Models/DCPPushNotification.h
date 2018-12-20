//
//  DCPPushNotification.h
//  DCPay
//
//  Created by zhanbin on 2018/5/22.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import "DCPBaseModel.h"

@interface DCPPushNotification : DCPBaseModel

@property (nonatomic, copy) NSString* action;

@property (nonatomic, copy) NSString* notificationId;

@property (nonatomic, copy) NSString* payBillId;

@property (nonatomic, copy) NSString* transactionId;

@property (nonatomic, copy) NSString* type;

@end
