//
//  DCPAPIResponse.m
//  DCPaySDKDemo
//
//  Created by vken on 2018/4/3.
//  Copyright © 2018年 vken. All rights reserved.
//

#import "DCPAPIResponse.h"
#import "DCPAPIEncryptor.h"
#import "YYCategories.h"

static NSString* keyPostBodyKey = @"key";
static NSString* keyPostBodyIV = @"iv";
static NSString* keyPostBodyCipher = @"cipher";
static NSString* keyPostBodySignature = @"signature";

static NSString* keyResponseData = @"data";
static NSString* keyResponseMethod = @"method";
static NSString* keyResponseMessage = @"message";
static NSString* keyResponseCode = @"code";

@implementation DCPAPIResponse

@end


@implementation DCPAPIEncryptedResponse

-(id)initWithJSON:(NSDictionary*)json
{
    self = [super init];
    if(self)
    {
        _key = json[keyPostBodyKey];
        _iv = json[keyPostBodyIV];
        _cipher = json[keyPostBodyCipher];
        _signature= json[keyPostBodySignature];
    }
    return self;
}

-(DCPAPIResponse*_Nullable)decrypt:(id<DCPAPIEncryptor>)encryptor
{
    NSData* json = [encryptor decrypt:self];
    if (json==nil) {
        return nil;
    }
//    NSString* jsonString = [[NSString alloc]initWithData:json encoding:NSUTF8StringEncoding];
    NSDictionary* jsonDic = [json jsonValueDecoded];
    
    DCPAPIResponse* response = [DCPAPIResponse new];
    response.data = jsonDic[keyResponseData];
    response.method = jsonDic[keyResponseMethod];
    response.message = jsonDic[keyResponseMessage];
    response.code = [jsonDic[keyResponseCode] integerValue];
    
    return response;
}

@end
