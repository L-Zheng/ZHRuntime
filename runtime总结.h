什么是runtime？
1> runtime是一套底层的C语言API（包含很多强大实用的C语言数据类型、C语言函数）
2> 实际上，平时我们编写的OC代码，底层都是基于runtime实现的
* 也就是说，平时我们编写的OC代码，最终都是转成了底层的runtime代码（C语言代码）

runtime有啥用？
1> 能动态产生一个类、一个成员变量、一个方法
2> 能动态修改一个类、一个成员变量、一个方法
3> 能动态删除一个类、一个成员变量、一个方法

常见的函数、头文件
#import <objc/runtime.h> : 成员变量、类、方法
Ivar * class_copyIvarList : 获得某个类内部的所有成员变量
Method * class_copyMethodList : 获得某个类内部的所有方法
Method class_getInstanceMethod : 获得某个实例方法（对象方法，减号-开头）
Method class_getClassMethod : 获得某个类方法（加号+开头）
method_exchangeImplementations : 交换2个方法的具体实现

#import <objc/message.h> : 消息机制
objc_msgSend(....)
