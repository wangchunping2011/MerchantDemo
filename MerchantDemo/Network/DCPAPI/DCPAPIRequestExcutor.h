//
//  DCPAPIRequestExcutor.h
//  DCPaySDKDemo
//
//  Created by vken on 2018/4/3.
//  Copyright © 2018年 vken. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DCPAPIRequest;
@protocol DCPAPIRequestExecutor

-(void) post:(DCPAPIRequest* _Nonnull)request success:(void (^_Nonnull)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
     failure:(void (^_Nonnull)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure;

@end

@interface DCPAPIRequestAFExecutor : NSObject<DCPAPIRequestExecutor>

@end
