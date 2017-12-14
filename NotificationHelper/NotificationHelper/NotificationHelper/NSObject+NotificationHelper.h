//
//  NSObject+NotificationHelper.h
//  NotificationHelper
//
//  Created by 0o on 2017/12/14.
//  Copyright © 2017年 Benight. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (NotificationHelper)

/** 发通知 */
- (void)postNotificationName:(nonnull NSString *)aName object:(nullable id)anObject userInfo:(nullable NSDictionary *)aUserInfo;

/** 注册通知 */
- (nullable id <NSObject>)addObserverForName:(nonnull NSString *)name block:(nullable void (^)( NSNotification * _Nullable note))block;

@end
