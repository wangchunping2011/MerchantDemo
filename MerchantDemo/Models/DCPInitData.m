//
//  DCPInitData.m
//  DCPay
//
//  Created by zhanbin on 2018/4/12.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import "DCPInitData.h"

@implementation DCPInitData

+(void)initialize
{
    //模型中的属性名和字典中的key不相同(或者需要多级映射)
    [DCPInitData mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                    @"advertise":@"advs",
                    @"merchantList":@"merchant",
                 };
    }];

    //数组里面存的模型
    [DCPInitData mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"coinList" : @"DCPBgCoin",
                 @"merchantList" : @"DCPMerchant"
                 };
    }];
    
}

- (void)setPush:(NSString *)push {
    _push = push;
    if ([push isEqualToString:@"OPEN"]) {
        _pushOn = YES;
    }else {
        _pushOn = NO;
    }
}

-(void)setPushOn:(BOOL)pushOn {
    _pushOn = pushOn;
    if (pushOn) {
        _push = @"OPEN";
    }else {
        _push = @"OFF";
    }
}

@end
