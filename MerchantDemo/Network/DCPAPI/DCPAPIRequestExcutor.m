//
//  DCPAPIRequestExcutor.m
//  DCPaySDKDemo
//
//  Created by vken on 2018/4/3.
//  Copyright © 2018年 vken. All rights reserved.
//

#import "DCPAPIRequestExcutor.h"
#import "AFNetworking.h"
#import "DCPAPIRequest.h"

@interface DCPAPIRequestAFExecutor()

@property(nonatomic,strong) NSURLSessionConfiguration*  configuration;
@property(nonatomic,strong) AFHTTPSessionManager*    sessionManager;

@end

@implementation DCPAPIRequestAFExecutor

+(instancetype )defaultPoster
{
    static dispatch_once_t once;
    static id _instance;
    dispatch_once(&once, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

-(id)init
{
    self = [super init];
    if(self)
    {
        _configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _sessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:_configuration];
        
        AFJSONRequestSerializer* serlizer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
        [serlizer setTimeoutInterval:30];
        _sessionManager.requestSerializer = serlizer;
    }
    return self;
}

-(void)post:(DCPAPIRequest*)request success:(void (^_Nonnull)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
     failure:(void (^_Nonnull)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
{
    //设置header
    [_sessionManager.requestSerializer setValue:request.header.serializition forHTTPHeaderField:DCPAPIRequestHeaderFiledName];
    
//    NSLog(@"请求地址:%@, 请求参数:%@, header:%@",[request url],request.postBody, request.header.serializition);
    NSURLSessionDataTask* task = [_sessionManager POST:[request url] parameters:request.postBody progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if(responseObject==nil || [responseObject isKindOfClass:[NSNull class]])
        {
            NSError * error = [NSError errorWithDomain:@"dcpay.error.domain.network" code:0xFF userInfo:nil];
            failure(task,error);
        }else
        {
//            NSLog(@"接口返回:%@, %@", [request url], responseObject);
            success(task,responseObject);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
    
    [task resume];
}


@end
