//
//  Foundation+Extension.m
//  ZHRuntime
//
//  Created by 李保征 on 2017/6/16.
//  Copyright © 2017年 李保征. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@implementation NSObject(Extension)

// 交换类方法的实现
+ (void)swizzleClassMethod:(Class)class originSelector:(SEL)originSelector otherSelector:(SEL)otherSelector{
//    class_getInstanceMethod(<#__unsafe_unretained Class cls#>, <#SEL name#>)
    Method otherMehtod = class_getClassMethod(class, otherSelector);
    Method originMehtod = class_getClassMethod(class, originSelector);
    method_exchangeImplementations(otherMehtod, originMehtod);
//    
//    class_addIvar(<#__unsafe_unretained Class cls#>, <#const char *name#>, <#size_t size#>, <#uint8_t alignment#>, <#const char *types#>)
//    class_addMethod(<#__unsafe_unretained Class cls#>, <#SEL name#>, <#IMP imp#>, <#const char *types#>)
//    class_addProperty(<#__unsafe_unretained Class cls#>, <#const char *name#>, <#const objc_property_attribute_t *attributes#>, <#unsigned int attributeCount#>)
//    class_addProtocol(<#__unsafe_unretained Class cls#>, <#Protocol *protocol#>)
}

// 交换实例方法的实现
+ (void)swizzleInstanceMethod:(Class)class originSelector:(SEL)originSelector otherSelector:(SEL)otherSelector{
    Method otherMehtod = class_getInstanceMethod(class, otherSelector);
    Method originMehtod = class_getInstanceMethod(class, originSelector);

    method_exchangeImplementations(otherMehtod, originMehtod);
}
@end

@implementation NSArray(Extension)
+ (void)load{
    [self swizzleInstanceMethod:NSClassFromString(@"__NSArrayI") originSelector:@selector(objectAtIndex:) otherSelector:@selector(zh_objectAtIndex:)];
}

- (id)zh_objectAtIndex:(NSUInteger)index{
    if (index < self.count) {
        return [self zh_objectAtIndex:index];
    } else {
        return nil;
    }
}

@end

@implementation NSMutableArray(Extension)
+ (void)load{
    [self swizzleInstanceMethod:NSClassFromString(@"__NSArrayM") originSelector:@selector(addObject:) otherSelector:@selector(zh_addObject:)];
    [self swizzleInstanceMethod:NSClassFromString(@"__NSArrayM") originSelector:@selector(objectAtIndex:) otherSelector:@selector(zh_objectAtIndex:)];
}

- (void)zh_addObject:(id)object{
    if (object != nil) {
        [self zh_addObject:object];
    }
}

- (id)zh_objectAtIndex:(NSUInteger)index{
    if (index < self.count) {
        return [self zh_objectAtIndex:index];
    } else {
        return nil;
    }
}
@end

@implementation NSMutableDictionary(Extension)
+ (void)load{
    [self swizzleInstanceMethod:NSClassFromString(@"__NSDictionaryM") originSelector:@selector(setValue:forKey:) otherSelector:@selector(zh_setValue:forKey:)];
    [self swizzleInstanceMethod:NSClassFromString(@"__NSDictionaryM") originSelector:@selector(setObject:forKey:) otherSelector:@selector(zh_setObject:forKey:)];
}

- (void)zh_setValue:(nullable id)value forKey:(NSString *)key{
    if (value&&key) {
        [self zh_setValue:value forKey:key];
    }
}

//系统启动  内部会调用  很多次 setObject:forKey:  方法
- (void)zh_setObject:(nullable id)anObject forKey:(NSString *)aKey{
    if (anObject&&aKey) {
        [self zh_setObject:anObject forKey:aKey];
    }
}

@end
