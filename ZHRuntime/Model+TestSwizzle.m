//
//  Model+TestSwizzle.m
//  05-runtime
//
//  Created by 李保征 on 2017/6/16.
//  Copyright © 2017年 heima. All rights reserved.
//

#import "Model+TestSwizzle.h"
#import <objc/runtime.h>

@implementation Model (TestSwizzle)

//方法交换 必须写在load方法中  或者 交换的类方法写在load中，交换的实例方法写在init中
//如果写在init方法中  交换的类方法不生效 交换的实例方法生效
//如果在某个类的两个扩展类中  交换的原方法一致  后一次交换的方法会覆盖掉前一次交换的方法

- (instancetype)init{
    return [super init];
}

+(void)load{
    // 交换类方法
    Method originalClassMethod = class_getClassMethod([self class], @selector(originClassFunction));
    Method swizzledClassMethod = class_getClassMethod([self class], @selector(swizzledClassFunction));
    method_exchangeImplementations(originalClassMethod, swizzledClassMethod);
//    NSLog(@"-方法名---%@----",NSStringFromSelector(method_getName(originalClassMethod)));
//    NSLog(@"-方法名---%@----",NSStringFromSelector(method_getName(swizzledClassMethod)));
    
    // 交换实例方法
    Method originalInstanceMethod = class_getInstanceMethod([self class], @selector(originInstanceFunction));
    Method swizzledInstanceMethod = class_getInstanceMethod([self class], @selector(swizzledInstanceFunction));
    method_exchangeImplementations(originalInstanceMethod, swizzledInstanceMethod);
//    NSLog(@"-方法名---%@----",NSStringFromSelector(method_getName(originalInstanceMethod)));
//    NSLog(@"-方法名---%@----",NSStringFromSelector(method_getName(swizzledInstanceMethod)));
}


+ (void)originClassFunction{
    NSLog(@"-------originClassFunction------原方法---类方法----");
}
+ (void)swizzledClassFunction{
    NSLog(@"-------swizzledClassFunction-----交换的方法---类方法-----");
}

- (void)originInstanceFunction{
    NSLog(@"-------originInstanceFunction------原方法---实例方法----");
}

- (void)swizzledInstanceFunction{
    NSLog(@"-------swizzledInstanceFunction------交换的方法---实例方法----");
}

@end
