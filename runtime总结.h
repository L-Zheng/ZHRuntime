
/** 参考csdn收藏博客 */

"什么是runtime？
1> runtime是一套底层的C语言API（包含很多强大实用的C语言数据类型、C语言函数）
2> 实际上，平时我们编写的OC代码，底层都是基于runtime实现的
* 也就是说，平时我们编写的OC代码，最终都是转成了底层的runtime代码（C语言代码）

多数情况我们只需要编写 OC 代码即可，Runtime 系统自动在幕后搞定一切，还记得简介中如果我们调用方法，编译器会将 OC 代码转换成运行时代码，在运行时确定数据结构和函数

"runtime有啥用？
1> 能动态产生一个类、一个成员变量、一个方法
2> 能动态修改一个类、一个成员变量、一个方法
3> 能动态删除一个类、一个成员变量、一个方法

"常见的函数、头文件
#import <objc/runtime.h> : 成员变量、类、方法
Ivar * class_copyIvarList : 获得某个类内部的所有成员变量
Method * class_copyMethodList : 获得某个类内部的所有方法(只能获得减号方法  包含属性的get setter方法  不能获得加号方法)
Method class_getInstanceMethod : 获得某个实例方法（对象方法，减号-开头）
Method class_getClassMethod : 获得某个类方法（加号+开头）

method_exchangeImplementations : 交换2个方法的具体实现
/*
 //方法交换 必须写在load方法中  或者 交换的类方法写在load中，交换的实例方法写在init中
 //如果写在init方法中  交换的类方法不生效 交换的实例方法生效
 //如果在某个类的两个扩展类中  交换的原方法一致  后一次交换的方法会覆盖掉前一次交换的方法
 */


"基本介绍
1、OC中的运行时分为两个版本——Modern Runtime和Legacy Runtime。现在的运行时与遗留的运行时区别在于：遗留的运行时在改变一个类的结构时，你必须继承它并重新编译。而现在的运行时可以直接编译。
2、OC程序与运行时系统交互分为三个不同等级：
      通过OC源代码：（编译器会将 OC 代码转换成运行时代码，在运行时确定数据结构和函数）
      通过定义在Foudation框架中NSObject中的方法：（数据结构捕获类，分类和协议中声明的信息 NSArray NSDictionary respondsToSelector conformsToProtocol  isMemberOfClass）
      通过直接调用运行时的函数：Class PersonClass = object_getClass([Person class]);

"消息传递机制   消息发送链条
#import <objc/message.h> : 消息机制
objc_msgSend(receiver, selector, arg1, arg2, …)
当一个消息传递给一个对象的时候，消息函数沿着这个对象的isa指针在调度表找到它建立起方法选择器的类结构。如果它不能在这里发现选择器，obic_msgSend根据指针找到它的父类，在父类的调度表中寻找选择器。连续失败导致objc_msgSend沿着类继承结构直到寻找到NSObject类。一旦确定选择器的位置，函数调用表中的方法并且把它传给接收对象的数据结构。
"消息转发
如果你给一个不处理这个消息对象发送消息，在认识到时一个错误之前运行时会给对象发送一个带有NSInvocation对象作为唯一参数的forwardInvocation：消息。这个NSInvocation封装了原始的消息，参数通过它传递。
你可以通过实现forwardInvocation：方法来指定一个默认的响应或者通过其他方式来避免这个错误。正如它的名字按时的那样，forwardInvocation：通常用于抓发消息给另一个对象。

forwardInvocation：消息提供了第二个机会：另外一个不是那么特别的解决方案，是动态而不是静态。它是像这样工作的：当一个对象因为没有这个消息对应的方法选择器来响应这个消息。运行时系统通过发forwardInvocation：消息通知对象。每个对象都从NSObject类中继承了一个forwardInvocation：方法。然而，NSObjcet类中的方法版本只是仅仅调用了doesNotRecognizeSelector：。通过重写NSObject类实现的你自己的版本，forwardInvocation：消息提供想另一个对象转发消息的时候抓住这个机会。
forwardInvocation：转发消息时所有该做的事情是：1.确定消息要传到哪2.带着原始参数把它发送过去。
消息会随着invokeWithTarget：方法发送：
- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    if ([someOtherObject respondsToSelector:
         [anInvocation selector]])
        [anInvocation invokeWithTarget:someOtherObject];
    else
        [super forwardInvocation:anInvocation];
}
forwardInvocation：像一个为无法识别消息工作的分配中心，把他们打包到不同的接收器。也可以作为一个中转站，把所有信息发送到一个目的地。他可以转运一些消息到其他地方，也可以“吞食”一些方法，所以这里没有响应和错误。
forwardInvocation：也可以把几条消息合并到一个响应中。
forwardInvocation：做的是把上交给实现者。然而，它为在转发链上上的连接对象打开了程序设计的可能。

"编译与调用
C语言：
函数的调用在编译的时候就决定调用哪个函数，编译完成之后直接顺序执行，无任何二义性。
C语言在编译阶段调用未实现的函数就会报错

OC：
函数的调用成为消息发送。属于动态调用过程。
在编译的时候并不能决定真正调用哪个函数（事实证明，在编译阶段，OC可以调用任何函数，即使这个函数并未实现，只要声明过就不会报错）
