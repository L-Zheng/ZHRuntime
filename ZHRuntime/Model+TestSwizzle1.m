//
//  Model+TestSwizzle1.m
//  05-runtime
//
//  Created by 李保征 on 2017/6/16.
//  Copyright © 2017年 heima. All rights reserved.
//

#import "Model+TestSwizzle1.h"
#import <objc/runtime.h>

@implementation Model (TestSwizzle1)

//+(void)load{
//
//    Method originalClassMethod = class_getClassMethod([self class], @selector(originClassFunction));
//    Method swizzledClassMethod = class_getClassMethod([self class], @selector(swizzledClassFunctionNew));
//    method_exchangeImplementations(originalClassMethod, swizzledClassMethod);
//}
//
//+ (void)swizzledClassFunctionNew{
//    NSLog(@"-------swizzledClassFunctionNew-----交换的方法---类方法-----");
//}

@end
