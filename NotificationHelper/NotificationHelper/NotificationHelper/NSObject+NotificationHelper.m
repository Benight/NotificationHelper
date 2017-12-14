//
//  NSObject+NotificationHelper.m
//  NotificationHelper
//
//  Created by 0o on 2017/12/14.
//  Copyright © 2017年 Benight. All rights reserved.
//

#import "NSObject+NotificationHelper.h"
#import <objc/runtime.h>

@interface NSObject ()

@property (nonatomic , strong) NSMutableArray *aryObservers;

@end

@implementation NSObject (NotificationHelper)

+ (void)load {
    NSString *className = NSStringFromClass(self.class);
    NSLog(@"classname %@", className);
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL originalSelector = NSSelectorFromString(@"dealloc");
        SEL swizzledSelector = @selector(notifyMessage_dealloc);
        
        // When swizzling a class method, use the following:
        // Class class = object_getClass((id)self);
        // Method originalMethod = class_getClassMethod(class, originalSelector);
        // Method swizzledMethod = class_getClassMethod(class, swizzledSelector);
        
        Class class = [self class];
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}


- (void)notifyMessage_dealloc
{
    
    if (self.aryObservers) {
        
        [self.aryObservers enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [[NSNotificationCenter defaultCenter] removeObserver:obj];
        }];
        
        [self.aryObservers removeAllObjects];
        self.aryObservers = nil;
    }
    
    [self notifyMessage_dealloc];
}

#pragma mark - seeter getter
static void *aryObservers_key = &aryObservers_key;
- (void)setAryObservers:(NSMutableArray *)aryObservers
{
    objc_setAssociatedObject(self, &aryObservers_key, aryObservers, OBJC_ASSOCIATION_RETAIN);
}

- (NSMutableArray *)aryObservers
{
    return objc_getAssociatedObject(self, &aryObservers_key);
}

#pragma mark - apis


- (void)postNotificationName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo
{
    [[NSNotificationCenter defaultCenter] postNotificationName:aName object:anObject userInfo:aUserInfo];
}

- (id<NSObject>)addObserverForName:(NSString *)name block:(void (^)(NSNotification * _Nullable))block
{
    if (!self.aryObservers) {
        self.aryObservers = [NSMutableArray new];
    }
    
    id observe = [[NSNotificationCenter defaultCenter] addObserverForName:name object:nil queue:[NSOperationQueue mainQueue] usingBlock:block];
    
    [self.aryObservers addObject:observe];
    
    return observe;
}

@end
