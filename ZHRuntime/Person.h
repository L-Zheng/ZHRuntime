//
//  Person.h
//  ZHRuntime
//
//  Created by 李保征 on 2017/6/16.
//  Copyright © 2017年 李保征. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
@property (nonatomic, assign) int age;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) double height;
- (void)instanceFunction;
+ (void)classFunction;

@end
