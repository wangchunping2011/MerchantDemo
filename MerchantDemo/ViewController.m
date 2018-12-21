//
//  ViewController.m
//  MerchantDemo
//
//  Created by 任长远 on 2018/12/18.
//  Copyright © 2018 王春平. All rights reserved.
//

#import "ViewController.h"
#import "DCPAPIRequest.h"
#import "DCPAPIRequestBuilder.h"
#import "DCPPayRequest.h"
#import "DCPPayResponse.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (IBAction)payAction:(UIButton *)sender {
    DCPPayRequest *payRequest = [[DCPPayRequest alloc] init];
    payRequest.amount = @"0.001";
    payRequest.attach = @"11221";
    payRequest.coinId = @"34190899187000";
    payRequest.goodsTag = @"20";
    payRequest.industry = @"qr";
    payRequest.refBizNo = @"2855656564";

    [self pay:payRequest url:[NSString stringWithFormat:@"%@%@", DCP_BASEURI, @"dcpayCore/payBills/prepay"] success:^(NSString *message, DCPPayResponse *payResponse) {
//        NSString *url = [NSString stringWithFormat:@"cospay://pay?fromScheme=merchant&orderInfo=%@", payResponse.mj_JSONString];
        NSString *url = @"cospay://pay?fromScheme=merchant";
        NSDictionary *paramDictionary = payResponse.mj_keyValues;
        for (NSString *key in paramDictionary) {
            NSString *value = paramDictionary[key];
            if (value.length > 0) {
                url = [url stringByAppendingFormat:@"&%@=%@", key, value];
            }
        }
        url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url] options:@{UIApplicationOpenURLOptionsSourceApplicationKey: @YES} completionHandler:^(BOOL success) {
            if (success) {
                NSLog(@"yes-----------");
            } else {
                NSLog(@"no----------");
            }
        }];
    } failure:^(NSString *message, NSInteger code) {
        NSLog(@"error:%@, %ld", message, (long)code);
        
    }];
}

- (void)pay:(DCPPayRequest *)payRequest url:(NSString *)url
    success:(void (^_Nonnull)(NSString* message,DCPPayResponse *payResponse))success
    failure:(void (^_Nonnull)(NSString* message,NSInteger code))failure {
    NSDictionary* parameters = [payRequest mj_keyValues];
    NSString* method = @"dcpayCore";
    
    DCPAPIRequest* request = [[DCPAPIRequestBuilder appBuilder] requestWithUrl:url withMethod:method withParameters:parameters];
    [request post:^(NSString * _Nullable message, id  _Nonnull data) {
        DCPPayResponse *respones = [DCPPayResponse mj_objectWithKeyValues:data];
        success(message,respones);
    } failure:^(NSString * _Nullable message, NSInteger code) {
        failure(message, code);
    }];
}

@end
