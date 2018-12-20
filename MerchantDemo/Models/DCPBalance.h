//
//  DCPBalance.h
//  DCPay
//
//  Created by zhanbin on 2018/4/12.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCPBaseModel.h"
#import "DCPAccount.h"

@interface DCPBalance : DCPBaseModel

@property (nonatomic, strong) NSArray<DCPAccount *>* accountList;

@property (nonatomic, copy) NSString* minEth;

@property (nonatomic, copy) NSString* defaultEth;

@property (nonatomic, copy) NSString* maxEth;

@end
