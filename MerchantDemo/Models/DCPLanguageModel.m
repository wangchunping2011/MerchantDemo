//
//  DCPLanguageModel.m
//  DCPay
//
//  Created by lfl on 2018/5/9.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import "DCPLanguageModel.h"

@implementation DCPLanguageModel

+ (instancetype)modelWithCode:(NSString*)code displayName:(NSString*)name dirPrefix:(NSString*)prefix {
    DCPLanguageModel* model = [[DCPLanguageModel alloc] init];
    model.code = code;
    model.displayName = name;
    model.dirPrefix = prefix;
    return model;
}

@end
