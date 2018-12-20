//
//  DCPQueryBalanceRequest.h
//  DCPay
//
//  Created by zhanbin on 2018/4/13.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCPBaseModel.h"
#import "DCPAccount.h"

@interface DCPBatchBalanceRequest : DCPBaseModel

@property (nonatomic, strong) NSMutableArray<DCPAccount *>* list;

@end
