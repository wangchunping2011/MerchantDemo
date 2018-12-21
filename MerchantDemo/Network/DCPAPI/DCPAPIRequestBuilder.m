//
//  DCPAPIRequestBuilder.m
//  DCPay
//
//  Created by vken on 2018/4/5.
//  Copyright © 2018年 mbr. All rights reserved.
//

#import "DCPAPIRequestBuilder.h"
#import "DCPDeviceIdUtil.h"
#import "DCPI18nManager.h"

@interface DCPAPIRequestBuilder()

@property(nonatomic,strong) NSMutableDictionary* _Nonnull device;
@property(nonatomic,copy)   NSString* _Nonnull   merchantId;
@property(nonatomic,copy)   NSString* _Nonnull  apiVersion;

@property(nonatomic,strong) DCPAPIRequestAFExecutor *_Nonnull afExcutor;
@property(nonatomic,assign) id<DCPAPIEncryptor> _Nonnull    encryptor;

@end

@implementation DCPAPIRequestBuilder

+(instancetype )appBuilder;
{
    static dispatch_once_t once;
    static id _instance;
    static DCPAPIDefaultEncryptor* appEncryptor;
    dispatch_once(&once, ^{
        
        NSError* error = nil;
        //TODO 如果考虑到安全问题，密钥文件不能存放到文本文件
        NSString* appPrivateKeyFile = [[NSBundle mainBundle]pathForResource:@"app_ras_private_key" ofType:@"pem"];
        NSString* appPrivateKeyPEM = [NSString stringWithContentsOfFile:appPrivateKeyFile encoding:NSUTF8StringEncoding error:&error];
        
        NSString* serverPublicKeyFile = [[NSBundle mainBundle]pathForResource:@"server_ras_public_key" ofType:@"pem"];
        NSString* serverPublicKeyPEM = [NSString stringWithContentsOfFile:serverPublicKeyFile encoding:NSUTF8StringEncoding error:&error];
//        NSLog(@"私钥：%@", appPrivateKeyPEM);
//        NSLog(@"公钥：%@", serverPublicKeyPEM);
        appEncryptor = [[DCPAPIDefaultEncryptor alloc]initWithPrivateKey:appPrivateKeyPEM andServerPublicKey:serverPublicKeyPEM];
        
        _instance = [[self alloc] initWithMerchantId:defaultValueAppMechantId WithApiVerison:defaultValueApiVersion withEncryptor:appEncryptor];
    });
    return _instance;
}

-(id)initWithMerchantId:(NSString* _Nonnull)merchantId WithApiVerison:(NSString* _Nonnull)apiVersion withEncryptor:(id<DCPAPIEncryptor>)encryptor
{
    self = [super init];
    
    if(self)
    {
        _apiVersion = apiVersion;
        _merchantId = merchantId;
        //[self loadDeviceInfo];
        
        _afExcutor = [[DCPAPIRequestAFExecutor alloc] init];
        
        _encryptor = encryptor;
    }
    
    return self;
}

//-(void)loadDeviceInfo
//{
//    _device = [NSMutableDictionary new];
//    _device[@"deviceId"] = [DCPDeviceIdUtil getDeviceIDInKeychain]; //@"123434";
//    _device[@"pushId"] = JPUSHService.registrationID;//@"1.0.0";
//}

- (NSMutableDictionary *)device {
    if (_device == nil) {
        _device = [NSMutableDictionary new];
    }
    _device[@"deviceId"] = [DCPDeviceIdUtil getDeviceIDInKeychain]; //@"1234";
//    _device[@"pushId"] = JPUSHService.registrationID;//@"1.0.0";
    _device[@"system"] = @"IOS";
    _device[@"language"] = [[DCPI18nManager sharedManager] languageCode];
    _device[@"appVersion"] = [[UIApplication sharedApplication] appVersion];
    _device[@"packageName"] = [[UIApplication sharedApplication] appBundleID];
    _device[@"channel"] = defaultChannel;//渠道
    return _device;
}

-(DCPAPIRequest* _Nonnull)requestWithUrl:(NSString* _Nonnull)url withMethod:(NSString* _Nonnull)method withParameters:(NSDictionary* _Nonnull)parameters {
    DCPAPIRequestHeader *header = [DCPAPIRequestHeader new];
    header.device = [self.device copy];
    header.method = method;
    header.apiVersion = _apiVersion;
    header.merchantId = _merchantId;
    
    DCPAPIRequestBody *body = [DCPAPIRequestBody new];
    body.parameters = [parameters copy];
    
    return [[DCPAPIRequest alloc] initWithUrl:url withHeader:header withBody:body withExecutor:_afExcutor withEncryptor:_encryptor];
}

@end
