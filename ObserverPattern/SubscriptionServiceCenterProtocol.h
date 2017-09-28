//
//  SubscriptionServiceCenterProtocol.h
//  ObserverPattern
//
//  Created by 大雄 on 2017/9/28.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SubscriptionServiceCenterProtocol <NSObject>

- (void)subscriptionMessage:(id)message subscriptionNumber:(NSString *)subscriptionNumber;
@end
