//
//  Person.m
//  ZHRuntime
//
//  Created by 李保征 on 2017/6/16.
//  Copyright © 2017年 李保征. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>

@implementation Person
- (void)instanceFunction{
    NSLog(@"--instanceFunction---减号方法-");
}
+ (void)classFunction{
    NSLog(@"--classFunction---加号方法-");
}

- (void)privateInstanceFunction{
    NSLog(@"--privateInstanceFunction---私有减号方法-");
}

+ (void)privateClassFunction{
    NSLog(@"--privateInstanceFunction---私有加号方法-");
}




#pragma mark - 用运行时进行 归档 解归档
//- (void)encodeWithCoder:(NSCoder *)encoder
//{
//    unsigned int count = 0;
//    Ivar *ivars = class_copyIvarList([HMPerson class], &count);
//    for (int i = 0; i<count; i++) {
//        // 取得i位置的成员变量
//        Ivar ivar = ivars[i];
//        const char *name = ivar_getName(ivar);
//        NSString *key = [NSString stringWithUTF8String:name];
//        [encoder encodeObject:[self valueForKeyPath:key] forKey:key];
//    }
//}
@end
