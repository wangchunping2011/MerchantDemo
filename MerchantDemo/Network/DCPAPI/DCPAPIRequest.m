//
//  DCPAPIRequest.m
//  DCPaySDKDemo
//
//  Created by vken on 2018/4/3.
//  Copyright © 2018年 vken. All rights reserved.
//

#import "DCPAPIRequest.h"

static NSString* keyRequestHeaderMerchantId = @"merchantId";
static NSString* keyRequestHeaderSign = @"signature";
static NSString* keyRequestHeaderSignType = @"signType";
static NSString* keyRequestHeaderCharset = @"charset";
static NSString* keyRequestHeaderTimestamp = @"timestamp";

static NSString* defaultValueSignType = @"RSA2";
static NSString* defaultValueCharset = @"UTF-8";

static NSString* keyRequestBodyApiVersion = @"apiVersion";
static NSString* keyRequestBodyMethod = @"method";
static NSString* keyRequestBodyParameters = @"parameters";
static NSString* keyRequestBodyDevice = @"device";

static NSString* keyPostBodyKey = @"key";
static NSString* keyPostBodyIV = @"iv";
static NSString* keyPostBodyCipher = @"cipher";


NSString* const DCPAPIRequestHeaderFiledName = @"token";

@implementation DCPAPIRequestHeader

-(void)updateTimestamp
{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval time=[date timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
    _timestamp = [NSString stringWithFormat:@"%.0f", time];
}

-(void)serialize
{
    //1. 转JSON
    NSMutableDictionary* paramters = [NSMutableDictionary new];
    paramters[keyRequestHeaderSignType]= _signType==nil?defaultValueSignType:_signType;
    paramters[keyRequestHeaderCharset]=_charset==nil?defaultValueCharset:_charset;
    paramters[keyRequestHeaderMerchantId]=_merchantId;
    paramters[keyRequestHeaderSign]=_signature;
    paramters[keyRequestHeaderTimestamp]=_timestamp;
    
    paramters[keyRequestBodyDevice]=_device;
    paramters[keyRequestBodyApiVersion]=_apiVersion;
    paramters[keyRequestBodyMethod]=_method;
    
    NSString* json = [paramters jsonStringEncoded];
    //2.BASE64
    _serializition = [json base64EncodedString];
}

@end


@implementation DCPAPIRequestBody

-(void)serialize
{
    //1. 转JSON
//    NSMutableDictionary* paramters = [NSMutableDictionary new];
//
//    paramters[keyRequestBodyParameters]=_parameters;
//
//    NSString* json = [paramters jsonStringEncoded];
    
    NSString* json = [_parameters jsonStringEncoded];
    
    _serializition = json;
}

@end


@implementation DCPAPIRequest

- (instancetype _Nonnull)initWithUrl:(NSString* _Nonnull)url withHeader:(DCPAPIRequestHeader* _Nonnull)header withBody:(DCPAPIRequestBody* _Nonnull)body withExecutor:(id<DCPAPIRequestExecutor> _Nonnull) executor withEncryptor:(id<DCPAPIEncryptor> _Nonnull) encryptor {
    self = [super init];
    if(self) {
        _url = url;
        _header = header;
        _body = body;
        _executor = executor;
        _encryptor = encryptor;
    }
    return self;
}


-(void)serialize
{
    //1. encrypt the body
    [_body serialize];
    
//    NSLog(@"\rSTEP>>1:BODY：\r%@\r",_body.serializition);

    NSData* bodyData = [_body.serializition dataUsingEncoding:NSUTF8StringEncoding];
    //加密http请求参数, 获取签名
    _encryptedResult = [_encryptor encrypt:bodyData];
    
//    NSLog(@"\nSTEP>>2:body加密之后：\n\nkey：%@\n\niv：%@\n\ncipher：%@\n\nsignature：%@\n",_encryptedResult.key,_encryptedResult.iv,_encryptedResult.cipher,_encryptedResult.signature);
    
    //2. set the header
    _header.signature = _encryptedResult.signature;
    [_header updateTimestamp];
    [_header serialize];
//    NSLog(@"\rSTEP>>3:Header BASE64 \r%@\r",_header.serializition);
    
    //3. construct the post body
    _postBody = [NSMutableDictionary new];
    _postBody[keyPostBodyKey] = _encryptedResult.key;
    _postBody[keyPostBodyIV] = _encryptedResult.iv;
    _postBody[keyPostBodyCipher] = _encryptedResult.cipher;
}

-(void)post:(void (^_Nonnull)(NSString* message,id data))success
    failure:(void (^_Nonnull)(NSString* message,NSInteger code))failure
{
    //先序列化参数
    [self serialize];
    
    if(_executor == nil)
    {
        failure(@"invalid post excutor",-3);
        return;
    }
    
    [_executor post:self success:^(NSURLSessionDataTask * _Nonnull task,id _Nullable responseData) {
        
        NSDictionary* dic = responseData;
        NSString* code =  dic[@"code"];
        if(![code isEqualToString:@"200"])
        {
            NSString *errorMessage = dic[@"msg"];
            if (errorMessage!=nil) {
                failure(errorMessage,[code integerValue]);
            } else {
                failure(@"unknown error",[code integerValue]);
            }
        }else
        {
            NSString* dataString = responseData[@"data"];
            NSDictionary* dataJson = [dataString jsonValueDecoded];
            DCPAPIEncryptedResponse* encryptedResponse = [[DCPAPIEncryptedResponse alloc]initWithJSON:dataJson];
            if(encryptedResponse!=nil)
            {
                DCPAPIResponse* response = [encryptedResponse decrypt:self->_encryptor];
                if(response!=nil)
                {
                    if(response.code == 200){
                        success(response.message,response.data);
                    }
                    else {
                        failure(response.message,response.code);
                    }
                }else{
                    failure(@"response decrypt fail",-2);
                }
            }else{
                failure(@"unknown response object",-1);
            }
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error.localizedDescription,error.code);
    }];
}

@end

