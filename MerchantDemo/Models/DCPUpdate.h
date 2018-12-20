//
//  DCPUpdate.h
//  DCPay
//
//  Created by zhanbin on 2018/5/21.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import "DCPBaseModel.h"

@interface DCPUpdate : DCPBaseModel

/**
 版本说明
 */
@property (nonatomic, copy) NSString* releaseNote;

/**
 是否更新
 */
@property (nonatomic, copy) NSString* update; //0-不更新；1-普通更新；2-强制更新

/**
 更新的plist文件地址
 */
@property (nonatomic, copy) NSString* url;

/**
 版本号
 */
@property (nonatomic, copy) NSString* version;

@end
