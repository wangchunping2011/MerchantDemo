//
//  DCPBalanceResponse.h
//  DCPay
//
//  Created by zhanbin on 2018/4/13.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCPBaseModel.h"
#import "DCPAccount.h"

@interface DCPBalanceResponse : DCPBaseModel

@property (nonatomic, copy) NSString* defaultEth;

@property (nonatomic, copy) NSString* maxEth;

@property (nonatomic, copy) NSString* minEth;

@property (nonatomic, strong) NSArray<DCPAccount *>* balanceList;

@end
