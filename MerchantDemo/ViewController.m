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

/**
 订单号
 */
@property (weak, nonatomic) IBOutlet UILabel *orderNumberLabel;
/**
 预支付数量
 */
@property (weak, nonatomic) IBOutlet UITextField *payNumberTextField;
/**
 备注
 */
@property (weak, nonatomic) IBOutlet UITextField *noteTextField;
/**
 币种名称
 */
@property (weak, nonatomic) IBOutlet UILabel *coinLabel;
/**
 当前币种
 */
@property (nonatomic, strong) DCPBgCoin *currentCoin;
/**
 币种数据源
 */
@property (nonatomic, strong) NSMutableArray *coinList;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //订单号取随机数仅个人测试，可根据自身需求调整
    self.orderNumberLabel.text = [NSString stringWithFormat:@"%@%d", @"289101876", arc4random() % 200];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置币种数据源
    DCPBgCoin *eth = [[DCPBgCoin alloc] init];
    eth.coinId = @"34190899187000";
    eth.name = @"ETH";
    
    DCPBgCoin *hec = [[DCPBgCoin alloc] init];
    hec.coinId = @"5773162675373";
    hec.name = @"HEC";
    self.coinList = [NSMutableArray arrayWithObjects:eth, hec, nil];
    
    self.currentCoin = eth;
    self.coinLabel.text = eth.name;
}

//选择币种
- (IBAction)selectCoinType:(UITapGestureRecognizer *)sender {
    [self showCoinListView];
}

//选择币种
- (IBAction)changeCoinType:(UIButton *)sender {
    [self showCoinListView];
}

//显示币种列表视图
- (void)showCoinListView {
    __weak typeof(self) weakSelf = self;
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"ETH" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        weakSelf.currentCoin = (DCPBgCoin *)self.coinList.firstObject;
        weakSelf.coinLabel.text = weakSelf.currentCoin.name;
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"HEC" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        weakSelf.currentCoin = (DCPBgCoin *)self.coinList.lastObject;
        weakSelf.coinLabel.text = weakSelf.currentCoin.name;
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:alertVC animated:YES completion:nil];
}

//修改订单号
- (IBAction)changeOrderNumber:(UITapGestureRecognizer *)sender {
    self.orderNumberLabel.text = [NSString stringWithFormat:@"%@%d", @"289101876", arc4random() % 200 + 15];
}

//修改订单号
- (IBAction)resetOrderNumber:(UIButton *)sender {
    self.orderNumberLabel.text = [NSString stringWithFormat:@"%@%d", @"289101876", arc4random() % 200 + 15];
}

//限制备注不得超过10个字（仅个人测试，限制字数可根据自身需求调整）
- (IBAction)textFieldDidChange:(UITextField *)sender {
    if (sender.text.length > 10) {
        sender.text = [sender.text substringToIndex:10];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

//支付按钮响应事件
- (IBAction)payAction:(UIButton *)sender {
    if (self.payNumberTextField.text.length == 0) {
        [self showHUDMessage:@"请输入预支付数量"];
        return;
    }
    if (!self.currentCoin) {
        [self showHUDMessage:@"请选择币种"];
    }
    DCPPayRequest *payRequest = [[DCPPayRequest alloc] init];
    //    payRequest.goodsTag = @"20";
    //    payRequest.industry = @"qr";
    payRequest.amount = self.payNumberTextField.text;
    payRequest.coinId = self.currentCoin.coinId;
    payRequest.refBizNo = self.orderNumberLabel.text;
    if (self.noteTextField.text.length == 0) {
        payRequest.attach = @"";
    } else {
        payRequest.attach = self.noteTextField.text;
    }

    [self pay:payRequest url:[NSString stringWithFormat:@"%@%@", DCP_BASEURI, DCP_PREPAY] success:^(NSString *message, DCPPayResponse *payResponse) {
        //跳转钱包App的url
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
//            if (success) {
//                NSLog(@"yes-----------");
//            } else {
//                NSLog(@"no----------");
//            }
        }];
    } failure:^(NSString *message, NSInteger code) {
//        NSLog(@"error:%@, %ld", message, (long)code);
    }];
}

#pragma mark - 网络请求

//调用预支付接口
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
