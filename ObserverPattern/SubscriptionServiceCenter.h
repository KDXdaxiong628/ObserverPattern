//
//  SubscriptionServiceCenter.h
//  ObserverPattern
//
//  Created by 大雄 on 2017/9/28.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SubscriptionServiceCenterProtocol.h"

@interface SubscriptionServiceCenter : NSObject

#pragma mark - 维护订阅信息
/**
 *   创建订阅号
 *
 *   @param subscriptionNumber 订阅号
 */
+ (void)createSubscriptionNumber:(NSString *)subscriptionNumber;

/**
 *   移除订阅号
 *
 *   @param subscriptionNumber 订阅号
 */
+ (void)removeSubscriptionNumber:(NSString *)subscriptionNumber;

#pragma mark - 维护客户信息
/**
 *   添加客户到具体的订阅号中
 *
 *   @param customer           客户
 *   @param subscriptionNumber 订阅号
 */
+ (void)addCustomer:(id <SubscriptionServiceCenterProtocol>)customer withSubscriptionNumber:(NSString *)subscriptionNumber;

/**
 *   从具体的订阅号中移除客户
 *
 *   @param customer           客户
 *   @param subscriptionNumber 订阅号
 */
+ (void)removeCustomer:(id <SubscriptionServiceCenterProtocol>)customer withSubscriptionNumber:(NSString *)subscriptionNumber;

#pragma mark - 发送消息
/**
 *   发送消息到具体的订阅号中
 *
 *   @param  message           消息
 *   @param subscriptionNumber 订阅号
 */
+ (void)sendMessage:(id)message toSubscriptionNumber:(NSString *)subscriptionNumber;
@end
