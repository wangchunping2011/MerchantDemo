# MerchantDemo
商户App(Demo)，可跳转至钱包App进行支付操作
注意事项：
1.点击按钮”支付“，调用预支付接口（dcpayCore/payBills/prepay），并通过URLScheme传递预支付参数。
2.预支付接口调用成功，由此商户Demo跳转至钱包App 支付页面。接收预支付参数及处理，详见AppDelegate.m中方法-handlerOpenUrl:。
3.在钱包App 支付页面（即DCPPayViewController），调用根据商家ID查询商家信息接口（client/merchant/queryById），点击按钮”立即支付“跳转确认支付页面。
4.在钱包App 确认支付页面（即DCPPayConfirmViewController），点击按钮”确定“，调用创建交易接口（client/tx/txCreate），确定交易密码，调用支付接口（dcpayCore/payBills/pay），支付流程完成。

