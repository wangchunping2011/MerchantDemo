//
//  DCPAddressGroup.h
//  DCPay
//
//  Created by 詹斌 on 2018/4/15.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCPAddressGroup : NSObject

//首字母
@property (nonatomic, copy) NSString *firstLeter;

//首字母=firstLeter的地址数组
@property (nonatomic, strong) NSMutableArray *addressArray;


@end
