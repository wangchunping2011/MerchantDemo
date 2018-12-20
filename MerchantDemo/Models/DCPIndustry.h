//
//  DCPIndustry.h
//  DCPay
//
//  Created by netdragon-lfl on 2018/4/24.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import "DCPBaseModel.h"

/**
 行业数据
 */
@interface DCPIndustry : DCPBaseModel

/**
 key
 */
@property (nonatomic, copy) NSString *key;


/**
 名称
 */
@property (nonatomic, copy) NSString *value;

@end
