//
//  ViewController.m
//  ZHRuntime
//
//  Created by 李保征 on 2017/6/16.
//  Copyright © 2017年 李保征. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "Model.h"
#import "Model+TestSwizzle.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
//    [self testRuntimeIvar];
}


#pragma mark - 交换方法
- (void)testSwizzleFunction{
    [Model originClassFunction];
    [[[Model alloc] init] originInstanceFunction];
}


#pragma mark - 获取某个类的  方法
//具体的一个减号方法
- (void)testRuntimeInstanceList{
    SEL seletor = NSSelectorFromString(@"instanceFunction");
    Method method = class_getInstanceMethod([Person class], seletor);
    SEL selector = method_getName(method);
    NSString *name = NSStringFromSelector(selector);
    NSLog(@"-方法名---%@----",name);
}
//具体的一个加号方法
- (void)testRuntimeClassList{
    SEL seletor = NSSelectorFromString(@"classFunction");
    Method method = class_getClassMethod([Person class], seletor);
    SEL selector = method_getName(method);
    NSString *name = NSStringFromSelector(selector);
    NSLog(@"-方法名---%@----",name);
}
//所有减号方法
//获得的方法中  包含属性的get set方法
//包含私有的减号方法（没有在头文件暴露）
//不能获得加号方法（无论有没有在头文件暴露）
- (void)testRuntimeMethodList{
    unsigned int count;
    Method *methods = class_copyMethodList([Person class], &count);
    
    for (int i = 0; i < count; i++)
    {
        Method method = methods[i];
        SEL selector = method_getName(method);
        NSString *name = NSStringFromSelector(selector);
        NSLog(@"-方法名---%@----",name);
        
        
        //        执行方法
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        //        [self performSelector:NSSelectorFromString(name) withObject:nil];
#pragma clang diagnostic pop
        
    }
    
    free(methods);
}


#pragma mark - 获取某个类的所有成员变量
- (void)testRuntimeIvar{
    // Ivar : 成员变量
    unsigned int count = 0;
    // 获得所有的成员变量
    Ivar *ivars = class_copyIvarList([Person class], &count);
    
    for (int i = 0; i<count; i++) {
        // 取得i位置的成员变量
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        const char *type = ivar_getTypeEncoding(ivar);
        NSLog(@"%d %s %s", i, name, type);
        
        //获取的成员变量前边带有下划线  去掉
        NSString *propertyStrName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        propertyStrName = [propertyStrName substringFromIndex:1];
    }
    free(ivars);
}


#pragma mark -  为自己的属性赋值
//setValue:forKey:
- (void)test{
    Person *p = [[Person alloc] init];
    [p setValue:@"nihaohaof" forKey:@"name"];
}
//发送消息
- (void)testRunTimeSendMessage{
    Person *p = [[Person alloc] init];
    
    //runtime :
//    objc_msgSend(objc_msgSend("Person" , "alloc"), "init");
    
    
//    objc_msgSend(p,@selector(setName:),@"xiaoming");
//    objc_msgSend(p, @selector(setAge:), 20);
}


@end
