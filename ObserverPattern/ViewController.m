//
//  ViewController.m
//  ObserverPattern
//
//  Created by 大雄 on 2017/9/28.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "ViewController.h"
#import "SubscriptionServiceCenter.h"
#import "Model.h"

static NSString *SCIENCE = @"SCIENCE";

@interface ViewController ()<SubscriptionServiceCenterProtocol>

@property (nonatomic, strong) Model *model;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建订阅号
    [SubscriptionServiceCenter createSubscriptionNumber:SCIENCE];
    
    // 添加订阅号的用户到指定刊物
    [SubscriptionServiceCenter addCustomer:self withSubscriptionNumber:SCIENCE];
    
    // 发行机构发送消息
    [SubscriptionServiceCenter sendMessage:@"V1.0" toSubscriptionNumber:SCIENCE];
    
    /////////////////////////////// 系统的 通知中心 与 KVO /////////////////////////////////////////////////
    
    /////////////////////////////////////////////////
    // 添加客户到指定的订阅号中
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationCenterEvent:) name:SCIENCE object:nil];
    
    // 发送消息到指定的订阅号中
    [[NSNotificationCenter defaultCenter] postNotificationName:SCIENCE object:@"V2.0"];
    
    
    /////////////////////////////////////////////////
    // 创建订阅中心
    self.model = [Model new];
    
    // 客户添加了订阅中心的 "name" 服务
    [self.model addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    
    // 订阅中心发送消息（通过修改属性值）
    self.model.name = @"V3.0";

}

#pragma mark - 自定义观察者模式方法
- (void)subscriptionMessage:(id)message subscriptionNumber:(NSString *)subscriptionNumber {
    NSLog(@"%@  %@", message, subscriptionNumber);
}

#pragma mark - 通知中心方法
- (void)notificationCenterEvent:(id)sender {
    NSLog(@"%@", sender);
}

#pragma mark - KVO方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"%@", change);
}

#pragma mark - 移除 通知中心 和 kvo（自定义的不用移除，因为没有强引用,并不会持有）
- (void)dealloc {
    // 移除 KVO
    [self.model removeObserver:self forKeyPath:@"name"];
    
    // 移除 通知中心
    [[NSNotificationCenter defaultCenter] removeObserver:self forKeyPath:SCIENCE];
}
@end
