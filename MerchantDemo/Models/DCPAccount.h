//
//  DCPAccount.h
//  DCPay
//
//  Created by zhanbin on 2018/4/10.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCPBaseModel.h"
#import "DCPBgCoin.h"

@interface DCPAccount : DCPBaseModel

//@property (nonatomic, copy) NSString* abbr;//币名简称
//@property (nonatomic, copy) NSString* accountId;//账户ID
//@property (nonatomic, copy) NSString* amount;
//@property (nonatomic, copy) NSString* chain;//链类型
//@property (nonatomic, copy) NSString* coinId;// 币ID
//@property (nonatomic, copy) NSString* decimals; //代币小数位数
//@property (nonatomic, strong) NSArray<DCPAccountTocken *>* ercTokenList;
//@property (nonatomic, copy) NSString* gasLimit;
//@property (nonatomic, copy) NSString* icon;//币图标URL
//@property (nonatomic, copy) NSString* isForceShow;
//@property (nonatomic, copy) NSString* name;//币名全称
//@property (nonatomic, copy) NSString* nickName;//账户昵称

@property (nonatomic, copy) NSString* accountId;//账户ID
@property (nonatomic, strong) NSMutableArray<DCPBgCoin *>* ercTokenList;
@property (nonatomic, copy) NSString* nickName;//账户昵称

@end
