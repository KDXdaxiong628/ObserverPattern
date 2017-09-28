//
//  SubscriptionServiceCenter.m
//  ObserverPattern
//
//  Created by 大雄 on 2017/9/28.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "SubscriptionServiceCenter.h"

static NSMutableDictionary *_subscripitonDictionary = nil;

@implementation SubscriptionServiceCenter

// 书刊发行机构由这个单例生成，initialize每次初始化的时候只调用一次
+ (void)initialize {
    if (self == [SubscriptionServiceCenter class]) {
        _subscripitonDictionary = [NSMutableDictionary dictionary];
    }
}

+ (void)createSubscriptionNumber:(NSString *)subscriptionNumber {
    // 验证这个参数是否合法 如果为 nil 程序直接崩溃
    NSParameterAssert(subscriptionNumber);
    
    NSHashTable *hashTable = [self existSubscriptionNumber:subscriptionNumber];
    if (hashTable == nil) {
        hashTable = [NSHashTable weakObjectsHashTable];
        [_subscripitonDictionary setObject:hashTable forKey:subscriptionNumber];
    }
}

+ (void)removeSubscriptionNumber:(NSString *)subscriptionNumber {
    NSParameterAssert(subscriptionNumber);
    NSHashTable *hashTable = [self existSubscriptionNumber:subscriptionNumber];
    if (hashTable) {
        [_subscripitonDictionary removeObjectForKey:subscriptionNumber];
    }
}

+ (void)addCustomer:(id<SubscriptionServiceCenterProtocol>)customer withSubscriptionNumber:(NSString *)subscriptionNumber {
    NSParameterAssert(customer);
    NSParameterAssert(subscriptionNumber);
    
    NSHashTable *hashTable = [self existSubscriptionNumber:subscriptionNumber];
    [hashTable addObject:customer];
}

+ (void)removeCustomer:(id<SubscriptionServiceCenterProtocol>)customer withSubscriptionNumber:(NSString *)subscriptionNumber {
    NSParameterAssert(subscriptionNumber);
    
    NSHashTable *hashTable = [self existSubscriptionNumber:subscriptionNumber];
    [hashTable removeObject:customer];
}

+ (void)sendMessage:(id)message toSubscriptionNumber:(NSString *)subscriptionNumber {
    NSParameterAssert(subscriptionNumber);
    
    NSHashTable *hashTable = [self existSubscriptionNumber:subscriptionNumber];
    if (hashTable) {
        // 如果存在这个书刊，就用迭代器来遍历这个书刊
        NSEnumerator *enumerator = [hashTable objectEnumerator];
        id <SubscriptionServiceCenterProtocol> object = nil;
        while (object = [enumerator nextObject]) {
            if ([object respondsToSelector:@selector(subscriptionMessage:subscriptionNumber:)]) {
                [object subscriptionMessage:message subscriptionNumber:subscriptionNumber];
            }
        }
    }
}

// 所有的操作都和订阅号有关，所以开始的时候要判断订阅号存不存在
#pragma mark - 私有方法
+ (NSHashTable *)existSubscriptionNumber:(NSString *)subscriptionNumber {
    return [_subscripitonDictionary objectForKey:subscriptionNumber];
}
@end
